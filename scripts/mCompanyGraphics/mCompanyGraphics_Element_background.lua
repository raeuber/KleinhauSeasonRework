-- 
-- mCompanyGraphicsElement_background
-- 
-- @Interface: 1.4.4.0 1.4.4RC8
-- @Author: kevink98 
-- @Date: 03.06.2017
-- @Version: 1.0.0
-- 
-- @Support: http://ls-modcompany.com
-- @mCompanyInfo: http://mcompany-info.de/
-- 

mCompanyGraphicsElement_background = {};

local mCompanyGraphicsElement_background_mt = Class(mCompanyGraphicsElement_background, mCompanyGraphicsElement);

function mCompanyGraphicsElement_background:new(target, custom_mt) 
	if custom_mt == nil then
		custom_mt = mCompanyGraphicsElement_background_mt;
	end;
	local self = mCompanyGraphicsElement:new(target, custom_mt);
	self.nameElement = "background";
	
	self.image = nil;
	self.backgroundId = 0;
	self.uv = {0,0,0,1,1,0,1,1};
	self.defaultimage = "dataS2/menu/hud/ui_elements_1080p.png";
	self.drawPost = false;
	self.autoHeight = false;
	self.autoHeightTop = false;
	
	return self;	
end;

function mCompanyGraphicsElement_background:loadElementFromXML(xmlFile, key, path)
	mCompanyGraphicsElement_background:superClass().loadElementFromXML(self, xmlFile, key, path)	
	self.path = path;
	
	local filename = getXMLString(xmlFile, key .. "#filename");
	self.autoHeight = Utils.getNoNil(getXMLString(xmlFile, key .. "#autoHeight"), self.autoHeight);
	self.autoHeightTop = Utils.getNoNil(getXMLString(xmlFile, key .. "#autoHeightTop"), self.autoHeightTop);
	self.drawPost = Utils.getNoNil(getXMLBool(xmlFile, key .. "drawPost"), self.drawPost);
		
	if self.drawPost then
		BaseMission.draw = mCompanyGraphicsElement_background:setFunction(BaseMission.draw, self.drawPost)
	end;
	
	local uv = getXMLString(xmlFile, key .. "#uv")
	local uvName = getXMLString(xmlFile, key .. "#uvName");
	
	if filename ~= nil then
		self.image = createImageOverlay(self.path .. filename);
	else
		self.image = createImageOverlay(self.defaultimage);
	end;
	
	if uv~= nil then
		local values = Utils.splitString(" ", uv);
		self:setUV({tonumber(values[1]),tonumber(values[1]),tonumber(values[2]),tonumber(values[3]),tonumber(values[4]),tonumber(values[5]),tonumber(values[6]),tonumber(values[7]),tonumber(values[8])});
	else
		if uvName == "g_colorBgUVs" then
			self:setUV(g_colorBgUVs);
		else
			self:setUV(self.uv);
		end;
	end;	
	
	self:setColor();	
	
end;

function mCompanyGraphicsElement_background:setColor(r,g,b, alpha)
	self.r = Utils.getNoNil(r, self.r);
	self.g = Utils.getNoNil(g, self.g);	
	self.b = Utils.getNoNil(b, self.b);
	self.alpha = Utils.getNoNil(alpha, self.alpha);
	setOverlayColor(self.image, self.r, self.g, self.b, self.alpha);
end;

function mCompanyGraphicsElement_background:setBackground(filename)
	self.image = Utils.getNoNil(createImageOverlay(self.path .. filename), self.image);
end;

function mCompanyGraphicsElement_background:setSize(x,y)
	self.size[1] = Utils.getNoNil(x, self.size[1])
	self.size[2] = Utils.getNoNil(x, self.size[2])
end;

function mCompanyGraphicsElement_background:setPos(x,y)
	self.pos[1] = Utils.getNoNil(x, self.pos[1])
	self.pos[2] = Utils.getNoNil(x, self.pos[2])
end;

function mCompanyGraphicsElement_background:setUV(values)
	self.uv = values;
	setOverlayUVs(self.image, unpack(values));
end;

function mCompanyGraphicsElement_background:delete()

end;

function mCompanyGraphicsElement_background:mouseEvent(posX, posY, isDown, isUp, button)


end;

function mCompanyGraphicsElement_background:keyEvent(unicode, sym, modifier, isDown)

end;

function mCompanyGraphicsElement_background:update(dt)
	mCompanyGraphicsElement_background:superClass().update(self, dt)
	for k,v in pairs(self.graphics) do
		v:update(dt);
	end;
end;

function mCompanyGraphicsElement_background:draw()
	if self.drawPost then
		return
	end;
	mCompanyGraphicsElement_background:superClass().draw(self)	
	
	if self.autoHeight then
		self.size[2] = 0;
		for _, element in pairs(self.graphics) do
			self.size[2] = self.size[2] + element:getHeight();
		end;
	end;
	
	if self.image ~= nil then
		renderOverlay(self.image, tonumber(self.pos[1]), tonumber(self.pos[2]), tonumber(self.size[1]), tonumber(self.size[2]));
	end;
	
	if self.autoHeight then	
		if self.autoHeightTop then
			local lastHeight = self.pos[2] + self.size[2];
			for i = 1, table.getn(self.graphics) do
				local graphic = self.graphics[i]
				lastHeight = lastHeight - graphic.margin[3] - graphic.size[2];
				local x = graphic.pos[1];
				if graphic.center then
					x = (self.pos[1] + (self.size[1] / 2)) - (getTextWidth(graphic.textHeight, tostring(graphic.text)) / 2)
				end;
				graphic:setPos(x, lastHeight);
				graphic:draw();
				lastHeight = lastHeight - graphic.margin[4];
			end;
		else
			local lastHeight = self.pos[2];
			for i = table.getn(self.graphics), 1, -1 do
				local graphic = self.graphics[i]
				lastHeight = lastHeight + graphic.margin[4];
				graphic:setPos(nil, lastHeight);
				graphic:draw();
				lastHeight = lastHeight + graphic.size[2] + graphic.margin[3];
			end;
		end;
	else
		for k,v in pairs(self.graphics) do
			v:draw();
		end;
	end;
end;

function mCompanyGraphicsElement_background:drawPost()
	if not self.drawPost then
		return
	end;
	mCompanyGraphicsElement_background:superClass().draw(self)		
	if self.image ~= nil then
		renderOverlay(self.image, tonumber(self.pos[1]), tonumber(self.pos[2]), tonumber(self.size[1]), tonumber(self.size[2]));
	end;
	for k,v in pairs(self.graphics) do
		v:draw();
	end;
end;

function mCompanyGraphicsElement_background:setFunction(old, new)
	return function(...)
	old(...)
	new(...)
	end;
end;

mCompanyGraphics.ELEMENTS["background"] = function(...) return mCompanyGraphicsElement_background:new(...) end;

