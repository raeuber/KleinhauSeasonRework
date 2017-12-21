-- 
-- mCompanyGraphicsElement_text
-- 
-- @Interface: 1.4.4.0 1.4.4RC8
-- @Author: kevink98 
-- @Date: 03.06.2017
-- @Version: 1.0.0
-- 
-- @Support: http://ls-modcompany.com
-- @mCompanyInfo: http://mcompany-info.de/
-- 

mCompanyGraphicsElement_text = {};

local mCompanyGraphicsElement_text_mt = Class(mCompanyGraphicsElement_text, mCompanyGraphicsElement);

function mCompanyGraphicsElement_text:new(target, custom_mt) 
	if custom_mt == nil then
		custom_mt = mCompanyGraphicsElement_text_mt;
	end;
	local self = mCompanyGraphicsElement:new(target, custom_mt);
	self.nameElement = "text";
	
	self.text = "";
	self.target = target;
	self.textHeight = 0.025;
	self.useParentHeightWidth = false;
	self.size[2] = self.textHeight;
	self.bold = false;
	self.center = false;
	return self;	
end;

function mCompanyGraphicsElement_text:loadElementFromXML(xmlFile, key, path)
	mCompanyGraphicsElement_text:superClass().loadElementFromXML(self, xmlFile, key, path)	
	local text = getXMLString(xmlFile, key .. "#text");
	self.bold = Utils.getNoNil(getXMLBool(xmlFile, key .. "#bold"), self.bold);
	self.center = Utils.getNoNil(getXMLBool(xmlFile, key .. "#center"), self.center);
	if text ~= nil then
		if text:sub(1, 6) == "$l10n_" then
			self.text = g_i18n:getText(text:sub(7));
		elseif g_i18n:hasText(text) then
			self.text = g_i18n:getText(text);
		else
			self.text = text;
		end;
	end;
	
	self.textHeight = Utils.getNoNil(getXMLFloat(xmlFile, key .. "#textHeight"), self.textHeight);
	self.useParentHeightWidth = Utils.getNoNil(getXMLBool(xmlFile, key .. "#useParentHeightWidth"), self.useParentHeightWidth);
	self:setCallback("onSet", getXMLString(xmlFile, key .. "#onSet"));	
	self:setTextColor();
end;

function mCompanyGraphicsElement_text:setTextColor(r,g,b, alpha)
	self.r = Utils.getNoNil(r, self.r);
	self.g = Utils.getNoNil(g, self.g);	
	self.b = Utils.getNoNil(b, self.b);
	self.alpha = Utils.getNoNil(alpha, self.alpha);
end;

function mCompanyGraphicsElement_text:setSize(x,y)
	self.size[1] = Utils.getNoNil(x, self.size[1])
	self.size[2] = Utils.getNoNil(y, self.size[2])
end;

function mCompanyGraphicsElement_text:setPos(x,y)
	self.pos[1] = Utils.getNoNil(x, self.pos[1])
	self.pos[2] = Utils.getNoNil(y, self.pos[2])
end;

function mCompanyGraphicsElement_text:getHeight()
	local height = self.size[2] + self.margin[3] + self.margin[4] 
	for _,v in pairs(self.graphics) do
		height = height + v:getHeight();
	end;
	return height;
end;

function mCompanyGraphicsElement_text:setValue(text)
	self.text = text or self.text;
end;

function mCompanyGraphicsElement_text:setCallback(name, nameFunction)
	if name ~= nil and nameFunction ~= nil then
		self[name] = function(...) return self.target[nameFunction](...) end;
	end;
end;

function mCompanyGraphicsElement_text:sendCallback(name, ...)
	if self[name] ~= nil then
		local values = self[name](self.target, self);
		if values ~= nil then
			self:setValue(values);
		end;
	end;
end;

function mCompanyGraphicsElement_text:delete()

end;

function mCompanyGraphicsElement_text:mouseEvent(posX, posY, isDown, isUp, button)


end;

function mCompanyGraphicsElement_text:keyEvent(unicode, sym, modifier, isDown)

end;

function mCompanyGraphicsElement_text:update(dt)
	mCompanyGraphicsElement_text:superClass().update(self, dt)
	self:sendCallback("onSet");
	
	for k,v in pairs(self.graphics) do
		v:update(dt);
	end;
end;

function mCompanyGraphicsElement_text:draw()
	mCompanyGraphicsElement_text:superClass().draw(self)
	setTextBold(self.bold);
	setTextColor(self.r, self.g, self.b, self.alpha)
	renderText(self.pos[1] + self.margin[1], self.pos[2] + self.margin[4], self.textHeight, tostring(self.text));
	setTextBold(false);
	setTextColor(0,0,0,1);
	for k,v in pairs(self.graphics) do
		if v.useParentHeightWidth then
			local x = self.pos[1] + self.margin[1] + getTextWidth(self.textHeight, tostring(self.text)) + self.margin[2];
			v:setPos(x, self.pos[2]);
		end;
		v:draw();
	end;
end;

mCompanyGraphics.ELEMENTS["text"] = function(...) return mCompanyGraphicsElement_text:new(...) end;

