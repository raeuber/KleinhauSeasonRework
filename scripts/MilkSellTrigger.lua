--[[
##Version: 1.1.0
##Author: kevink98
##Date: 29.11.2016
##ModName: MilkTrigger
##Desc: Milchverkauf

##Changelog: 	V 1.0.0
					- Release
				V 1.1.0
					- Fix zum Einbau mit dem GiantsEditor
					- Fix Verkaufspreis (Preis wird jetzt vom Spiel bestimmt)

]]--

 
MilkSellTrigger = {};
MilkSellTrigger.ModDir = g_currentModDirectory
MilkSellTrigger_mt = nil


local nBeginn, nEnde = string.find(MilkSellTrigger.ModDir,"placeable");
if nBeginn then
	MilkSellTrigger_mt = Class(MilkSellTrigger, Placeable);
else
	MilkSellTrigger.RunAsGE = true;
	MilkSellTrigger_mt = Class(MilkSellTrigger, Object);
end

InitObjectClass(MilkSellTrigger, "MilkSellTrigger");

function MilkSellTrigger.onCreate(id)
    local trigger = MilkSellTrigger:new(g_server ~= nil, g_client ~= nil);
	g_currentMission:addOnCreateLoadedObject(trigger);
    if trigger:load(id) then
		g_currentMission:addOnCreateLoadedObjectToSave(trigger);
        trigger:register(true);
    else
        trigger:delete();
    end
end;

function MilkSellTrigger:new(isServer, isClient, costomMt)
 local mt = customMt;
    if mt == nil then
        mt = MilkSellTrigger_mt;
    end;
	local self = {};
	if MilkSellTrigger.RunAsGE then
		self = Object:new(isServer, isClient, mt)
	else
		self = Placeable:new(isServer, isClient, mt);
		registerObjectClassName(self, "MilkSellTrigger");
	end;
	self.milkTrailers = {};
	self.MilkActivable = MilkActivable:new(self)
	self.isFilling = false;
	self.nodeId = 0;
    return self;
end;

function MilkSellTrigger:load(xmlFilename, x,y,z, rx,ry,rz, initRandom)
	self.trailerTipTrigger = {}
	
	if MilkSellTrigger.RunAsGE then
		self.saveId = getUserAttribute(xmlFilename,"saveId");
		if self.saveId == nil then
			self.saveId = "MilkSellTrigger_"..getName(xmlFilename)
		end
	end;
	
	if not self.RunAsGE then
		if not MilkSellTrigger:superClass().load(self, xmlFilename, x,y,z, rx,ry,rz, initRandom) then
			return false;
		end;
		return true;
	else
		self.nodeId = xmlFilename;
		if not self:finalizePlacement() then return false; end;
	end;
	
	return true;
end;

function MilkSellTrigger:finalizePlacement(x, y, z, rx, ry, rz, initRandom)
	if not self.RunAsGE then
		MilkSellTrigger:superClass().finalizePlacement(self)
	end
	
	self.trigger = getChild(self.nodeId,"MilkTrigger")
	if self.trigger and self.trigger ~= 0 then
		self.fillType = FillUtil.fillTypeNameToInt[getUserAttribute(self.nodeId,"fillType")];
		if self.fillType ~= nil then
			addTrigger(self.trigger,"triggerCallback",self);
			self.priceMult = Utils.getNoNil(getUserAttribute(self.nodeId,"priceMult"),1.2)
			self.moneyChangeId = getMoneyTypeId()
			self.lastMoneyChange = 0;
			self.MilkActivable.textStart = Utils.getNoNil(g_i18n:getText("MilkSellTrigger_startFill"),"Verkaufen starte")
			self.MilkActivable.textEnd = Utils.getNoNil(g_i18n:getText("MilkSellTrigger_stopFill"),"Verkaufen stoppen")
		else
			return false;
		end;
	else
		return false;
	end;
	if not self.RunAsGE then
		
	else
		g_currentMission:addNodeObject(self.nodeId, self)
	end;
	self.MilkSellTriggerDirtyFlag = self:getNextDirtyFlag();
	return true;
end;

function MilkSellTrigger:getSaveAttributesAndNodes(nodeIdent) 
	local attributes, nodes = "","";
	if not self.RunAsGE then
		attributes, nodes = MilkSellTrigger:superClass().getSaveAttributesAndNodes(self, nodeIdent);
	end;
	return attributes,nodes;
end

function MilkSellTrigger:loadFromAttributesAndNodes(xmlFile, key, resetVehicles) 
	if not self.RunAsGE and not MilkSellTrigger:superClass().loadFromAttributesAndNodes(self, xmlFile, key, resetVehicles) then
		return false
	end
	return true
end

function MilkSellTrigger:writeAllStream(streamId, connection)

end;
function MilkSellTrigger:readAllStream(streamId, connection) 

end; 
function MilkSellTrigger:writeStream(streamId, connection)
	MilkSellTrigger:superClass().writeStream(self, streamId, connection)
	self:writeAllStream(streamId, connection)
end
function MilkSellTrigger:readStream(streamId, connection)
	MilkSellTrigger:superClass().readStream(self, streamId, connection)
	self:readAllStream(streamId, connection)
end;
function MilkSellTrigger:writeUpdateStream(streamId, connection, dirtyMask)
	MilkSellTrigger:superClass().writeUpdateStream(self, streamId, connection, dirtyMask);
	self:writeAllStream(streamId, connection)
end;
function MilkSellTrigger:readUpdateStream(streamId, timestamp, connection)
	MilkSellTrigger:superClass().readUpdateStream(self, streamId, timestamp, connection);
	self:readAllStream(streamId, connection)
end;

function MilkSellTrigger:delete()
	unregisterObjectClassName(self);
	g_currentMission:removeOnCreateLoadedObjectToSave(self)
	
	if self.trigger ~= nil then
		removeTrigger(self.trigger)
	end;
	if not self.RunAsGE then MilkSellTrigger:superClass().delete(self) end;
end;

function MilkSellTrigger:update(dt) 
	if self.isFilling then
		local disableFilling = true;
		if self.MilkFillTrailer then
			if self.isServer then
				local fillLvl = self.MilkFillTrailer:getFillLevel(self.fillType)
				local fillLitersPerSecond = self.MilkFillTrailer.fillLitersPerSecond or self.MilkFillTrailer.fuelFillLitersPerSecond or self.fillLitersPerSecond;
				local delta = math.min(fillLitersPerSecond*dt*0.001,fillLvl);
				
				if delta > 0 then
					disableFilling = false;
					self.MilkFillTrailer:setFillLevel(fillLvl-delta, self.fillType, true)
					
					local desc = FillUtil.fillTypeIndexToDesc[self.fillType]
					desc.totalAmount = desc.totalAmount + delta
					local price = delta * g_currentMission.economyManager:getCostPerLiter(self.fillType);
					g_currentMission:addSharedMoney(price, "soldMilk")
					g_currentMission:addMoneyChange(price, self.moneyChangeId)
					self.lastMoneyChange = 30;
				end;
			end;
		end;
		if self.isServer and disableFilling then
			self:setIsMilkTankFilling(false)
		end;
	end;
	
	if self.lastMoneyChange > 0 then
		self.lastMoneyChange = self.lastMoneyChange - 1
        if self.lastMoneyChange == 0 then
            g_currentMission:showMoneyChange(self.moneyChangeId, g_i18n:getText("finance_soldMilk"))
        end
	end
end;

function MilkSellTrigger:setIsMilkTankFilling(isFilling, trailer,noEventSend)
	MilkSellTriggerEvent.sendEvent(self, self.triggerId, isFilling, trailer, noEventSend)
	if self.isFilling ~= isFilling then
		self.isFilling = isFilling
		self.MilkFillTrailer = trailer;
	end;
end;

function MilkSellTrigger:triggerCallback(triggerId, otherActorId, onEnter, onLeave, onStay, otherShapeId)
	local trailer = Utils.getNoNil(g_currentMission.objectToTrailer[otherShapeId], g_currentMission.objectToTrailer[otherActorId]);
	if trailer ~= nil then
		if onEnter then
			if table.getn(self.milkTrailers) == 0 then
				g_currentMission:addActivatableObject(self.MilkActivable)
			end
			table.insert(self.milkTrailers, trailer)
		else
			for i = 1, table.getn(self.milkTrailers), 1 do
				if self.milkTrailers[i] == trailer then
					table.remove(self.milkTrailers, i)
					break
				end
			end

			if table.getn(self.milkTrailers) == 0 then
				g_currentMission:removeActivatableObject(self.MilkActivable)
			end
			
			if self.isServer and self.MilkFillTrailer == trailer then
				self:setIsMilkTankFilling(false)
			end;
		end
	end
end;


MilkActivable = {};
local MilkActivable_mt = Class(MilkActivable);
function MilkActivable:new(trigger)
	local self = {};
	
	setmetatable(self, MilkActivable_mt)

	self.MilkTrigger = trigger
	self.activateText = "unknown"
	self.currentTrailer = nil

	return self
end;

function MilkActivable:getIsActivatable()
	self.currentTrailer = nil
	
	for _, trailer in pairs(self.MilkTrigger.milkTrailers) do
		if trailer.getIsActiveForInput(trailer) then
			if trailer:allowFillType(self.MilkTrigger.fillType, false) then
				self.currentTrailer = trailer
				self.updateActivateText(self)	
				return true
			end
		end
	end
	return false
end
function MilkActivable:onActivateObject()
	self.MilkTrigger:setIsMilkTankFilling(not self.MilkTrigger.isFilling, self.currentTrailer)
	self.updateActivateText(self)
	g_currentMission:addActivatableObject(self)
end
function MilkActivable:drawActivate()
end
function MilkActivable:updateActivateText()
	if self.MilkTrigger.isFilling then
		self.activateText = self.textEnd;
	else
		self.activateText = self.textStart;
	end
end

if MilkSellTrigger.RunAsGE then
	g_onCreateUtil.addOnCreateFunction("MilkSellTrigger", MilkSellTrigger.onCreate);
else
	registerPlaceableType("MilkSellTrigger", MilkSellTrigger);
end;

MilkSellTriggerEvent = {}
MilkSellTriggerEvent_mt = Class(MilkSellTriggerEvent, Event)
InitEventClass(MilkSellTriggerEvent, "MilkSellTriggerEvent")
function MilkSellTriggerEvent:emptyNew()
	local self = Event:new(MilkSellTriggerEvent_mt)
	return self
end
function MilkSellTriggerEvent:new(object, triggerId, isFilling, trailer)
	local self = MilkSellTriggerEvent:emptyNew()
	self.object = object
	self.triggerId = triggerId;
	self.isFilling = isFilling
	self.trailer = trailer
	return self
end
function MilkSellTriggerEvent:readStream(streamId, connection)
	self.object = readNetworkNodeObject(streamId)
	self.triggerId = streamReadInt32(streamId);
	self.isFilling = streamReadBool(streamId)
	if self.isFilling then
		self.trailer = readNetworkNodeObject(streamId)
	end

	self:run(connection)
end
function MilkSellTriggerEvent:writeStream(streamId, connection)
	writeNetworkNodeObject(streamId, self.object)
	streamWriteInt32(streamId, self.triggerId)
	streamWriteBool(streamId, self.isFilling)
	if self.isFilling then
		writeNetworkNodeObject(streamId, self.trailer)
	end
end
function MilkSellTriggerEvent:run(connection)
	if not connection:getIsServer() then
		g_server:broadcastEvent(self, false, connection, self.object)
	end
	if self.object ~= nil then
		self.object:setIsMilkTankFilling(self.isFilling, self.trailer, true)
	end;
end
function MilkSellTriggerEvent.sendEvent(object, triggerId, isFilling, trailer, noEventSend)
	if (noEventSend == nil or noEventSend == false) then
		if g_server ~= nil then
			g_server:broadcastEvent(MilkSellTriggerEvent:new(object, triggerId, isFilling, trailer), nil, nil, object)
		else
			g_client:getServerConnection():sendEvent(MilkSellTriggerEvent:new(object, triggerId, isFilling, trailer))
		end
	end
end



