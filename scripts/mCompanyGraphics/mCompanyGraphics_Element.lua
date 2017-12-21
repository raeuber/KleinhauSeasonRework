-- 
-- mCompanyGraphicsElement
-- 
-- @Interface: 1.4.4.0 1.4.4RC8
-- @Author: kevink98 
-- @Date: 03.06.2017
-- @Version: 1.0.0
-- 
-- @Support: http://ls-modcompany.com
-- @mCompanyInfo: http://mcompany-info.de/
-- 

mCompanyGraphicsElement = {};

-- ALL ELEMENTS LOAD
source(mCompanyGraphics.ModDir .. "scripts/mCompanyGraphics/mCompanyGraphics_Element_background.lua");
source(mCompanyGraphics.ModDir .. "scripts/mCompanyGraphics/mCompanyGraphics_Element_text.lua");
source(mCompanyGraphics.ModDir .. "scripts/mCompanyGraphics/mCompanyGraphics_Element_loadingBar.lua");

local mCompanyGraphicsElement_mt = Class(mCompanyGraphicsElement);

function mCompanyGraphicsElement:new(graphic, custom_mt) 
	if custom_mt == nil then
		custom_mt = mCompanyGraphicsElement_mt;
	end;
	local self =  setmetatable({}, custom_mt);
	
	self.name = nil;
	self.target = target;
	self.size = {1,1}; --x,y scale
	self.pos = {0,0}; -- x,y position
	self.margin = {0,0,0,0} -- left, right, top, bottom
	self.visible = true;
	self.alpha = 1;
	self.toolTip = nil;
	self.graphics = {};
	self.r = 1;
	self.g = 1;
	self.b = 1;
	self.alpha = 1;
	
	return self;	
end;

function mCompanyGraphicsElement:loadElementFromXML(xmlFile, key, path)
	self.name = getXMLString(xmlFile, key .. "#name") or self.name;
	local size = getXMLString(xmlFile, key .. "#size");
	local pos = getXMLString(xmlFile, key .. "#pos");
	local margin = getXMLString(xmlFile, key .. "#margin");
	self.r = Utils.getNoNil(getXMLFloat(xmlFile, key .. "#r"), self.r);
	self.g = Utils.getNoNil(getXMLFloat(xmlFile, key .. "#g"), self.g);
	self.b = Utils.getNoNil(getXMLFloat(xmlFile, key .. "#b"), self.b);
	
	self.alpha = Utils.getNoNil(getXMLFloat(xmlFile, key .. "#alpha"), self.alpha);
	
	if size ~= nil then
		size = Utils.splitString(" ", size);
		self.size[1] = tonumber(size[1])
		self.size[2] = tonumber(size[2])
	end;
	
	if pos ~= nil then
		pos = Utils.splitString(" ", pos);
		self.pos[1] = tonumber(pos[1])
		self.pos[2] = tonumber(pos[2])
	end;
	if margin ~= nil then
		margin = Utils.splitString(" ", margin);
		self.margin[1] = tonumber(margin[1])
		self.margin[2] = tonumber(margin[2])
		self.margin[3] = tonumber(margin[3])
		self.margin[4] = tonumber(margin[4])
	end;
end;

function mCompanyGraphicsElement:copyAttributes(source)
	self.name = source.name;
	self.size = source.size;
	self.pos = source.pos;
	self.margin = source.margin;
	self.visible = source.visible;
	self.alpha = source.alpha;
	self.toolTip = source.toolTip;
	self.r = source.r;
	self.g = source.g;
	self.b = source.b;
	self.alpha = source.alpha;
end;

function mCompanyGraphicsElement:delete()

end;

function mCompanyGraphicsElement:mouseEvent(posX, posY, isDown, isUp, button)


end;

function mCompanyGraphicsElement:keyEvent(unicode, sym, modifier, isDown)

end;

function mCompanyGraphicsElement:update(dt)
end;

function mCompanyGraphicsElement:draw()

end;


