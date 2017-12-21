-- 
-- Digital Storage Amount Mover
-- supports remaining capacity display like fruitmaster
-- by Blacky_BPG
-- 
-- Version 1.4.2.0      13.02.2017    add functionality for GasStationExtended
-- Version 1.4.0.0      12.02.2017    add functionality for BGP
-- Version 1.3.1.0 A    28.01.2017    add functionality for BuyOnSiloTriggers, add number of animals functionality
-- Version 1.3.1.0      03.01.2017    add husbandry functionality
-- Version 1.2.1.0      08.11.2016    initial Version for FS17
-- 

DigitalAmountMover = {};
DigitalAmountMover.version = "1.4.2.0  -  13.02.2017";
local DigitalAmountMover_mt = Class(DigitalAmountMover);
function DigitalAmountMover.onCreate(id)
	g_currentMission:addUpdateable(DigitalAmountMover:new(id));
end;
function DigitalAmountMover:new(id)
	local instance = {};
	setmetatable(instance, DigitalAmountMover_mt);

	instance.id = id;
	instance.nodeId = id;
	instance.storageSaveId = getUserAttribute(id, "storageSaveId");
	local siloStationName = getUserAttribute(id, "siloStationName");
	instance.siloLiquidPriceSize = Utils.getNoNil(getUserAttribute(id, "siloLiquidPriceSize"),1000);
	instance.isBGA = Utils.getNoNil(getUserAttribute(id, "isBGA"),false);
	instance.animalType = getUserAttribute(id, "animalType");

	local fillType = getUserAttribute(id, "fillType");
	if fillType ~= nil then
		instance.fillType = FillUtil.fillTypeNameToInt[fillType];
	end;
	if instance.isBGA and fillType == "bunker" then
		instance.fillType = FillUtil.FILLTYPE_UNKNOWN;
	end;
	local foodGroup = false;
	if instance.animalType ~= nil then
		if AnimalUtil["ANIMAL_"..string.upper(instance.animalType)] ~= nil then
			instance.storageSaveId = nil;
			siloStationName = nil;
		end;
		foodGroup = Utils.getNoNil(getUserAttribute(id, "foodGroup"),instance.foodGroup);
	end;
	if foodGroup then
		instance.foodGroup = FillUtil.fillTypeToFoodGroup[AnimalUtil["ANIMAL_"..string.upper(instance.animalType)]][Utils.getNoNil(instance.fillType,0)]
	end;
	instance.name = getUserAttribute(id, "name");
	instance.defaultOff = Utils.getNoNil(getUserAttribute(id, "defaultOff"),"11");

	local digitStorageId = getUserAttribute(instance.id, "digitStorageId");
	if digitStorageId ~= nil then
		local digitGroup = instance.id;
		if digitStorageId ~= "-1" and digitStorageId ~= -1 then
			digitGroup = Utils.indexToObject(id,digitStorageId);
		end;
		local num = getNumOfChildren(digitGroup);
		instance.digitStorage = {};
		for i=1, num do
			local child = getChildAt(digitGroup, i-1);
			if child ~= nil and child ~= 0 then
				instance.digitStorage[i] = {};
				instance.digitStorage[i].id = child;
				local numDot = getNumOfChildren(child);
				if numDot ~= 0 then
					instance.digitStorage[i].dot = getChildAt(child, 0);
				end;
			end;
		end;
	end;

	instance.showFreeSpace = Utils.getNoNil(getUserAttribute(instance.id, "showFreeSpace"),false);
	instance.maxSpace = 0;
	local digitSpaceId = getUserAttribute(instance.id, "digitSpaceId");
	if digitSpaceId ~= nil then
		local digitGroup2 = instance.id;
		if digitSpaceId ~= "-1" and digitSpaceId ~= -1 then
			digitGroup2 = Utils.indexToObject(id,digitSpaceId);
		end;
		local num2 = getNumOfChildren(digitGroup2);
		instance.digitSpace = {};
		for i=1, num2 do
			local child2 = getChildAt(digitGroup2, i-1)
			if child2 ~= nil and child2 ~= 0 then
				instance.digitSpace[i] = {};
				instance.digitSpace[i].id = child2;
				local numDot2 = getNumOfChildren(child2);
				if numDot2 ~= 0 then
					instance.digitSpace[i].dot = getChildAt(child2, 0);
				end;
			end;
		end;
	end;

	instance.firstStart = true;
	instance.isAnimal = false;

	instance.isEnabled = false;
	instance.oldAmount = -1;
	if siloStationName ~= nil then
		instance.showFreeSpace = false;
		instance.siloStationName = siloStationName;
	end;
	if (instance.storageSaveId == nil and instance.animalType == nil and instance.siloStationName == nil and not instance.isBGA) then
		print("ERROR [DigitalAmountMover]: No storage saveId, silo station name, animal type or BGP assigned. "..tostring(Utils.getNoNil(self.name,getName(id))).." is now disabled.");
		return instance;
	end;
	if instance.fillType == nil then
		print("ERROR [DigitalAmountMover]: No fillType assigned. "..tostring(Utils.getNoNil(self.name,getName(id))).." is now disabled.");
		return instance;
	end;
	if instance.digitStorage == nil or (instance.digitStorage ~= nil and #instance.digitStorage == 0) then
		print("ERROR [DigitalAmountMover]: No display digits available. "..tostring(Utils.getNoNil(self.name,getName(id))).." is now disabled.");
		return instance;
	end;

	instance.isEnabled = true;
	return instance;
end;
function DigitalAmountMover:update(dt)
	if self.isEnabled then
		if self.storage ~= nil then
			if self.fillType ~= FillUtil.fillTypeNameToInt[self.animalType] then
				if self.isBGA then
					if self.fillType == FillUtil.FILLTYPE_DIGESTATE then
						local amount = self.storage.fillLevel;
						if amount ~= self.oldAmount then
							self.maxSpace = self.storage.capacity;
							self:setDisplay(amount);
						end;
					else
						local amount = self.storage:getFillLevel(self.fillType);
						if amount ~= self.oldAmount then
							self.maxSpace = self.storage:getFreeCapacity(self.fillType) + amount;
							self:setDisplay(amount);
						end;
					end;
				elseif self.fillType == FillUtil.FILLTYPE_FUEL and self.storage.maxFuel ~= nil and self.storage.maxFuel > 0 then
					local amount = Utils.getNoNil(self.storage.fillLevel,0) * self.siloLiquidPriceSize;
					if amount ~= self.oldAmount then
						self.maxSpace = self.storage.maxFuel * self.siloLiquidPriceSize;
						self:setDisplay(amount);
					end;
				elseif self.fillType ~= nil and self.siloStationName ~= nil then
					local price = math.floor(Utils.getNoNil(self.storage.priceMultipliers[self.fillType],1) * self.storage.highestPrice[self.fillType] * self.siloLiquidPriceSize);
					if price ~= self.oldAmount then
						self:setDisplay(price);
					end;
				elseif self.fillType ~= nil and self.foodGroup == nil and (self.isAnimal == false or (self.isAnimal and (self.fillType ~= FillUtil.FILLTYPE_MILK and self.fillType ~= FillUtil.FILLTYPE_MANURE and self.fillType ~= FillUtil.FILLTYPE_LIQUIDMANURE))) then
					local amount = self.storage:getFillLevel(self.fillType);
					if amount ~= self.oldAmount then
						if self.isAnimal then
							self.maxSpace = self.storage:getCapacity(self.fillType);
						end;
						self:setDisplay(amount);
					end;
				else
					if self.fillType ~= nil and self.foodGroup == nil and self.isAnimal then
						if self.fillType == FillUtil.FILLTYPE_MANURE then
							local amount = self.storage.manureFillLevel;
							if amount ~= self.oldAmount then
								self:setDisplay(amount);
							end;
						elseif self.fillType == FillUtil.FILLTYPE_LIQUIDMANURE then
							local amount = self.storage.fillLevel;
							if amount ~= self.oldAmount then
								self:setDisplay(amount);
							end;
						elseif self.fillType == FillUtil.FILLTYPE_MILK then
							local amount = self.storage.fillLevelMilk;
							if amount ~= self.oldAmount then
								self:setDisplay(amount);
							end;
						end;
					elseif self.foodGroup ~= nil and self.isAnimal then
						local amount = self.storage:getAvailableAmountOfFillTypes(self.foodGroup.fillTypes);
						if amount ~= self.oldAmount or self.maxSpace ~= self.storage:getCapacity(nil,self.foodGroup) then
							self.maxSpace = self.storage:getCapacity(nil,self.foodGroup);
							self:setDisplay(amount);
						end;
					end;
				end;
			else
				local amount = 0;
				for i=1, self.storage.numSubTypes do
					amount = amount + self.storage:getNumAnimals(i-1);
				end;
				if amount ~= self.oldAmount then
					self:setDisplay(amount);
				end;
			end;
		end;
	end;
	if self.firstStart and self.isEnabled then
		for k,v in pairs(g_currentMission.onCreateLoadedObjectsToSave) do
			if k ~= nil and v ~= nil then
				if self.storageSaveId ~= nil and k == self.storageSaveId then
					if v.fillTypes ~= nil and v.fillTypes[self.fillType] ~= nil then
						self.maxSpace = v.capacity;
						if v.fillLevels ~= nil and v.fillLevels[self.fillType] ~= nil then
							self.storage = v;
						end;
					end;
					if self.fillType == FillUtil.FILLTYPE_FUEL and v.maxFuel ~= nil and v.maxFuel > 0 then
						self.maxSpace = v.maxFuel * self.siloLiquidPriceSize;
						self.storage = v;
					end;
				end;
			end;
		end;
		if self.animalType ~= nil and g_currentMission.husbandries ~= nil and g_currentMission.husbandries[self.animalType] ~= nil then
			local v = g_currentMission.husbandries[self.animalType];
			self.isAnimal = true;
			if self.fillType ~= nil and self.foodGroup == nil and self.fillType ~= FillUtil.fillTypeNameToInt[self.animalType] then
				if self.fillType == FillUtil.FILLTYPE_LIQUIDMANURE and v.liquidManureTrigger ~= nil then
					self.maxSpace = v.liquidManureTrigger.capacity;
					self.storage = v.liquidManureTrigger;
				elseif v.tipTriggersFillLevels ~= nil or (self.fillType == FillUtil.FILLTYPE_MILK and v.fillLevelMilk ~= nil) then
					self.storage = v;
					self.maxSpace = 0;
					if self.fillType == FillUtil.FILLTYPE_MILK or self.fillType == FillUtil.FILLTYPE_MANURE then
						self.showFreeSpace = false;
					end;
				end;
			elseif self.fillType ~= nil and self.foodGroup ~= nil and self.fillType ~= FillUtil.fillTypeNameToInt[self.animalType] then
				self.storage = v;
				self.maxSpace = v:getCapacity(nil,self.foodGroup);
			elseif self.fillType == FillUtil.fillTypeNameToInt[self.animalType] then
				self.storage = v;
				self.maxSpace = 0;
				self.showFreeSpace = false;
			end;
		end;
		if self.siloStationName ~= nil then
			for k,v in pairs(g_currentMission.siloTriggers) do
				if v ~= nil and v.saveId ~= nil and v.saveId == self.siloStationName and v.priceMultipliers ~= nil and v.fillTypes[self.fillType] ~= nil then
					self.maxSpace = 0;
					self.storage = v;
				end;
			end;
		end;
		if self.isBGA then
			if g_currentMission.onCreateLoadedObjectsToSave.Bga ~= nil then
				self.storage = g_currentMission.onCreateLoadedObjectsToSave.Bga;
				if self.fillType == FillUtil.FILLTYPE_DIGESTATE then
					if self.storage.digestateSiloTrigger ~= nil then
						self.storage = self.storage.digestateSiloTrigger;
					end;
				end;
			end;
		end;
		self.firstStart = false;
		if self.storage == nil then
			self.isEnabled = false
			print("ERROR [DigitalAmountMover]: No storage found for "..tostring(Utils.getNoNil(self.name,getName(self.nodeId)))..". Storage should be: "..tostring(self.storageSaveId).." or "..tostring(self.siloStationName).." or "..tostring(self.animalType)..". Display now disabled.")
		end;
	end;
end;
function DigitalAmountMover:delete()
end;

function DigitalAmountMover:setDisplay(amount)
	if not self.isEnabled then return end;
	if self.maxSpace <= 0 then
		self.showFreeSpace = false;
	end;
	local left = self.maxSpace;
	if self.showFreeSpace then
		left = left - amount;
	end;
	if left < 0 then
		left = 0;
	end;
	self.oldAmount = amount;
	for i=1, table.getn(self.digitStorage) do
		local number = math.floor(amount - (math.floor(amount / 10) * 10));
		amount = math.floor(amount / 10);
		if number <= 0 and amount <= 0 then
			setShaderParameter(self.digitStorage[i].id, "number", tonumber(self.defaultOff), 0, 0, 0, false);
			if self.digitStorage[i].dot ~= nil then
				setVisibility(self.digitStorage[i].dot,false);
			end;
		else
			setShaderParameter(self.digitStorage[i].id, "number", number, 0, 0, 0, false);
			if self.digitStorage[i].dot ~= nil then
				setVisibility(self.digitStorage[i].dot,true);
			end;
		end;
	end;

	if self.showFreeSpace then
		for i=1, table.getn(self.digitSpace) do
			local number = math.floor(left - (math.floor(left / 10) * 10));
			left = math.floor(left / 10);
			if number <= 0 and left <= 0 then
				setShaderParameter(self.digitSpace[i].id, "number", tonumber(self.defaultOff), 0, 0, 0, false);
				if self.digitSpace[i].dot ~= nil then
					setVisibility(self.digitSpace[i].dot,false);
				end;
			else
				setShaderParameter(self.digitSpace[i].id, "number", number, 0, 0, 0, false);
				if self.digitSpace[i].dot ~= nil then
					setVisibility(self.digitSpace[i].dot,true);
				end;
			end;
		end;
	else
		if self.digitSpace ~= nil and type(self.digitSpace) == "table" and table.getn(self.digitSpace) > 0 then
			for i=1, table.getn(self.digitSpace) do
				setVisibility(self.digitSpace[i].id,false);
				if self.digitSpace[i].dot ~= nil then
					setVisibility(self.digitSpace[i].dot,false);
				end;
			end;
			self.digitSpace = nil;
		end;
	end;
end;

g_onCreateUtil.addOnCreateFunction("DigitalAmountMoverOnCreate", DigitalAmountMover.onCreate);

print(" ++ loading Digital Storage Amount Mover V "..tostring(DigitalAmountMover.version).." (by Blacky_BPG)");
