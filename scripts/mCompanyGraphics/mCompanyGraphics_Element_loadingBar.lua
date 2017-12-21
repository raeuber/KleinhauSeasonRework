-- 
-- mCompanyGraphicsElement_loadingBar
-- 
-- @Interface: 1.4.4.0 1.4.4RC8
-- @Author: kevink98 
-- @Date: 03.06.2017
-- @Version: 1.0.0
-- 
-- @Support: http://ls-modcompany.com
-- @mCompanyInfo: http://mcompany-info.de/
-- 

mCompanyGraphicsElement_loadingBar = {};

local mCompanyGraphicsElement_loadingBar_mt = Class(mCompanyGraphicsElement_loadingBar, mCompanyGraphicsElement);

function mCompanyGraphicsElement_loadingBar:new(target, custom_mt) 
	if custom_mt == nil then
		custom_mt = mCompanyGraphicsElement_loadingBar_mt;
	end;
	local self = mCompanyGraphicsElement:new(target, custom_mt);
	self.nameElement = "loadingBar";
	
	self.target = target;
	self.level = 0;
	self.capacity = 100;
	self.modus = "value";
	self.showPercentsRight = false;
	self.Background_r = 1;
	self.Background_g = 1;
	self.Background_b = 1;
	self.Text_r = 1;
	self.Text_g = 1;
	self.Text_b = 1;
	self.uv = {0,0,0,1,1,0,1,1};
	self.backgroundUv = {0,0,0,1,1,0,1,1};
	self.imageFront = createImageOverlay("dataS2/menu/hud/ui_elements_1080p.png");
	self.imageBack = createImageOverlay("dataS2/menu/hud/ui_elements_1080p.png");
	self.loadingWhenOpen = false;
	self.activeLevel = self.level;
	
	return self;	
end;

function mCompanyGraphicsElement_loadingBar:loadElementFromXML(xmlFile, key, path)	
	mCompanyGraphicsElement_loadingBar:superClass().loadElementFromXML(self, xmlFile, key, path)	
	local r2 = getXMLFloat(xmlFile, key .. "#Background_r");
	local g2 = getXMLFloat(xmlFile, key .. "#Background_g");
	local b2 = getXMLFloat(xmlFile, key .. "#Background_b");
	local Text_r = getXMLFloat(xmlFile, key .. "#Text_r");
	local Text_g = getXMLFloat(xmlFile, key .. "#Text_g");
	local Text_b = getXMLFloat(xmlFile, key .. "#Text_b");
	local uv = getXMLString(xmlFile, key .. "#uv");
	local uvName = getXMLString(xmlFile, key .. "#uvName");
	local uvNameBackground = getXMLString(xmlFile, key .. "#uvNameBackground");
	self.showPercentsRight = Utils.getNoNil(getXMLBool(xmlFile, key .. "#showPercentsRight"), self.showPercentsRight);

	if uv~= nil then
		self:setUV(Utils.splitString(" ", uv));
	else
		if uvName == "g_colorBgUVs" then
			self:setUV(g_colorBgUVs);
		else
			self:setUV(self.uv);
		end;
		if uvNameBackground == "g_colorBgUVs" then
			self:setBackgroundUV(g_colorBgUVs);
		else
			self:setBackgroundUV(self.backgroundUv);
		end;
	end;
	
	self:setBackgroundBarColor(r2,g2,b2);
	self:setColor();	
	self:setTextColor(Text_r, Text_g, Text_b);	
	
	
	self:setCallback("onSet", getXMLString(xmlFile, key .. "#onSet"));	
end;

function mCompanyGraphicsElement_loadingBar:setColor(r,g,b, alpha)
	self.r = Utils.getNoNil(r, self.r);
	self.g = Utils.getNoNil(g, self.g);	
	self.b = Utils.getNoNil(b, self.b);
	self.alpha = Utils.getNoNil(alpha, self.alpha);
	setOverlayColor(self.imageFront, self.r, self.g, self.b, self.alpha);
end;

function mCompanyGraphicsElement_loadingBar:setTextColor(r,g,b, alpha)
	self.Text_r = Utils.getNoNil(r, self.Text_r);
	self.Text_g = Utils.getNoNil(g, self.Text_g);	
	self.Text_b = Utils.getNoNil(b, self.Text_b);
	self.alpha = Utils.getNoNil(alpha, self.alpha);
end;

function mCompanyGraphicsElement_loadingBar:setBackgroundBarColor(r,g,b)
	self.Background_r = Utils.getNoNil(r, self.Background_r);
	self.Background_g = Utils.getNoNil(g, self.Background_g);	
	self.Background_b = Utils.getNoNil(b, self.Background_b);
	setOverlayColor(self.imageBack, self.Background_r, self.Background_g, self.Background_b, self.alpha);
end;

function mCompanyGraphicsElement_loadingBar:setUV(values)
	self.uv = values;
	setOverlayUVs(self.imageFront, unpack(values));
end;

function mCompanyGraphicsElement_loadingBar:setBackgroundUV(values)
	self.backgroundUv = values;
	setOverlayUVs(self.imageBack, unpack(values));
end;

function mCompanyGraphicsElement_loadingBar:setSize(x,y)
	self.size[1] = Utils.getNoNil(x, self.size[1])
	self.size[2] = Utils.getNoNil(y, self.size[2])
end;

function mCompanyGraphicsElement_loadingBar:setPos(x,y)
	self.pos[1] = Utils.getNoNil(x, self.pos[1])
	self.pos[2] = Utils.getNoNil(y, self.pos[2])
end;

function mCompanyGraphicsElement_loadingBar:setValue(values)
	self.level = Utils.getNoNil(values[1], self.level);
	self.capacity = Utils.getNoNil(values[2], self.capacity);
end;

function mCompanyGraphicsElement_loadingBar:setCallback(name, nameFunction)
	if name ~= nil and nameFunction ~= nil then
		self[name] = function(...) return self.target[nameFunction](...) end;
	end;
end;

function mCompanyGraphicsElement_loadingBar:sendCallback(name, ...)
	if self[name] ~= nil then
		local values = self[name](self.target, self);
		if values ~= nil then
			self:setValue(values);
		end;
	end;
end;

function mCompanyGraphicsElement_loadingBar:getHeight()
	local height = self.size[2] + self.margin[3] + self.margin[4] 
	for _,v in pairs(self.graphics) do
		height = height + v:getHeight();
	end;
	return height;
end;

function mCompanyGraphicsElement_loadingBar:delete()

end;

function mCompanyGraphicsElement_loadingBar:mouseEvent(posX, posY, isDown, isUp, button)


end;

function mCompanyGraphicsElement_loadingBar:keyEvent(unicode, sym, modifier, isDown)

end;

function mCompanyGraphicsElement_loadingBar:copyAttributes(source)
	mCompanyGraphicsElement_loadingBar:superClass().copyAttributes(self, source)
	self.level = source.level;
	self.capacity = source.capacity;
	self.modus = source.modus;
	self.showPercentsRight = source.showPercentsRight;
	self.Background_r = source.Background_r;
	self.Background_g = source.Background_g;
	self.Background_b = source.Background_b;
	self.uv = source.uv;
	self.backgroundUv = source.backgroundUv;
	self.imageFront = source.imageFront;
	self.imageBack = source.imageBack;
	self.loadingWhenOpen = source.loadingWhenOpen;
	self.activeLevel = source.level;
	
end;

function mCompanyGraphicsElement_loadingBar:update(dt)
	mCompanyGraphicsElement_loadingBar:superClass().update(self, dt)
	self:sendCallback("onSet");
	for k,v in pairs(self.graphics) do
		v:update(dt);
	end;
end;

function mCompanyGraphicsElement_loadingBar:draw()
	mCompanyGraphicsElement_loadingBar:superClass().draw(self)
	
	local sizeX = self.size[1] / self.capacity * self.level;
	local sizeY = self.size[2] * 0.8;
	local posY = self.pos[2] + ((self.size[2] - sizeY) / 2);
	
	if self.imageBack ~= nil then
		renderOverlay(self.imageBack, self.pos[1], posY, self.size[1], sizeY);
	end;
	if self.imageFront ~= nil then
		renderOverlay(self.imageFront, self.pos[1], self.pos[2], sizeX, self.size[2]);
	end;
	setTextColor(self.Text_r, self.Text_g, self.Text_b, self.alpha);
	if self.showPercentsRight then
		renderText(self.pos[1] + self.size[1] + 0.01, self.pos[2], self.size[2], string.format("%.f %%",100/ self.capacity * self.level));
	end;
	
	for k,v in pairs(self.graphics) do
		v:draw();
	end;
end;

mCompanyGraphics.ELEMENTS["loadingBar"] = function(...) return mCompanyGraphicsElement_loadingBar:new(...) end;

