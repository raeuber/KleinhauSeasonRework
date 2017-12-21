-- 
-- mCompanyGraphics
-- 
-- @Interface: 1.4.4.0 1.4.4RC8
-- @Author: kevink98 
-- @Date: 03.06.2017
-- @Version: 1.0.0
-- 
-- @Support: http://ls-modcompany.com
-- @mCompanyInfo: http://mcompany-info.de/
-- 
mCompanyGraphics = {};
mCompanyGraphics.ELEMENTS = {};
mCompanyGraphics.ModDir = g_currentModDirectory

source(mCompanyGraphics.ModDir .. "scripts/mCompanyGraphics/mCompanyGraphics_Element.lua");

local mCompanyGraphics_mt = Class(mCompanyGraphics);

function mCompanyGraphics:new(target) 
	local self =  setmetatable({}, mCompanyGraphics_mt);
	
	self.graphics = {};
	self.target = target;
	self.isOpen = false;
	
	addModEventListener(self);
	
	return self;
end;

function mCompanyGraphics:loadGraphicsFromXML(path, xmlFilename, defaultXML)
	if xmlFilename ~= nil and xmlFilename ~= "" then
		self.path = path;
		self.xmlFilename = self.path .. xmlFilename;
	elseif defaultXML ~= nil then
		self.path = mCompanyGraphics.ModDir;
		self.xmlFilename = self.path .. defaultXML;
	else
		print("ERROR: mCompanyGraphics - xmlFilename is nil!");
		return false;
	end;
	
	local xmlFile = loadXMLFile("Temp", self.xmlFilename);
	if xmlFile ~= nil and xmlFile ~= 0 then
		
		self:setCallback("onOpen", getXMLString(xmlFile, "mCompanyGraphics" .. "#onOpen"));
		self:setCallback("onClose", getXMLString(xmlFile, "mCompanyGraphics" .. "#onClose"));
		
		self.graphics = self:loadElementsFromXML(xmlFile, "mCompanyGraphics");			
	else
		print(string.format("ERROR: Can't load %s", self.xmlFilename))
	end;
end;

function mCompanyGraphics:loadElementsFromXML(xmlFile, key)
	local i = 0;
	local graphics = {};
	while true do
		local key_element = key .. string.format(".mCompanyGraphics_Element(%d)", i);
		local typ = getXMLString(xmlFile, key_element .. "#type");
		if typ == nil then
			break;
		end;
		if mCompanyGraphics.ELEMENTS[typ] ~= nil then
			newElement = mCompanyGraphics.ELEMENTS[typ](self.target);
			newElement:loadElementFromXML(xmlFile, key_element, self.path);
			
			table.insert(graphics, newElement);
			graphics[i+1].graphics = self:loadElementsFromXML(xmlFile, key_element);
			
		else
			print(string.format("ERROR: mCompanyGraphics - can't find element %s", typ));
			break;
		end;
		i = i + 1;
	end;
	return graphics;
end;

function mCompanyGraphics:deleteMap()
end;

function mCompanyGraphics:delete()
end;

function mCompanyGraphics:mouseEvent(posX, posY, isDown, isUp, button)
	if self.isOpen then
		for k,v in pairs(self.graphics) do
			v:mouseEvent(posX, posY, isDown, isUp, button);
		end;
	end;	
end;

function mCompanyGraphics:keyEvent(unicode, sym, modifier, isDown)
	if self.isOpen then
		for k,v in pairs(self.graphics) do
			v:keyEvent(unicode, sym, modifier, isDown);
		end;
	end;	
end;

function mCompanyGraphics:update(dt)
	if self.isOpen then
		for k,v in pairs(self.graphics) do
			v:update();
		end;
	end;	
end;

function mCompanyGraphics:draw()
	if self.isOpen then
		for k,v in pairs(self.graphics) do
			v:draw();
		end;
	end;
end;

function mCompanyGraphics:setGraphicShow(v)
	self.isOpen = v;
	
	if self.isOpen then 
		self:sendCallback("onOpen");
	else
		self:sendCallback("onClose");
		
	end;
end;

function mCompanyGraphics:setCallback(name, nameFunction)
	if name ~= nil and nameFunction ~= nil then
		self[name] = self.target[nameFunction];
	end;
end;

function mCompanyGraphics:sendCallback(name, ...)
	if self[name] ~= nil then
		self[name](self.target, ...);
	end;
end;

mCompanyGraphicsLoadMap = {};
addModEventListener(mCompanyGraphicsLoadMap)
function mCompanyGraphicsLoadMap:loadMap()
	g_currentMission.new_mCompanyGraphics = function(...) return mCompanyGraphics:new(...) end;
end;
function mCompanyGraphicsLoadMap:keyEvent() end;
function mCompanyGraphicsLoadMap:mouseEvent() end;
function mCompanyGraphicsLoadMap:draw() end;
function mCompanyGraphicsLoadMap:update() end;
function mCompanyGraphicsLoadMap:delete() end;
function mCompanyGraphicsLoadMap:deleteMap() end;

