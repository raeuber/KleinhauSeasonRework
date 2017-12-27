--authors: igor29381, Giants (some changed functions)

ChangedFunctions = {};
OriginalFunctions = {};
BaseMission.loadMapOriginal = BaseMission.loadMap;
Mission00.loadMission00FinishedOriginal = Mission00.loadMission00Finished;
IngameMap.newOriginal = IngameMap.new;

function ChangedFunctions:load()
	SpecializationUtil.registerSpecialization('terrainControl', 'terrainControl', TrafficManager.curModDir..'scripts/terrainControl.lua');
	for k,v in pairs(VehicleTypeUtil.vehicleTypes) do 
		if v ~= nil then
			table.insert(v.specializations, SpecializationUtil.getSpecialization("terrainControl"));
			if SpecializationUtil.hasSpecialization(SowingMachine, v.specializations) or
			SpecializationUtil.hasSpecialization(Sprayer, v.specializations) then
			end;

		end;

	end;
	OriginalFunctions.washableUpdateTick = Washable.updateTick;
	Washable.updateTick = ChangedFunctions.washableUpdateTick;

end;


function BaseMission:loadMap(filename, addPhysics, asyncCallbackFunction, asyncCallbackObject, asyncCallbackArguments)
	ChangedFunctions:load();
	self:loadMapOriginal(filename, addPhysics, asyncCallbackFunction, asyncCallbackObject, asyncCallbackArguments);
end;


function Mission00:loadMission00Finished(node, arguments)
	self:loadMission00FinishedOriginal(node, arguments);
	local densities = {	"dirty", "dirty_sand", "dirty_gravel", "lightStraw", "darkStraw", "maizeStraw",
						"sunflowerStraw", "townDecoGrass", "bushes", "Schilf", "Unkraut"};
	for i=1, #densities do
		local key = string.format("%sDensityId", densities[i]);
		if not terrainControl[key] then
			terrainControl[key] = Utils.getNoNil(getChild(g_currentMission.terrainRootNode, densities[i]), 0);
		end;
	end;

	if g_currentMission.environment.isSunOn and g_currentMission.environment.currentRain == nil then
	end;
end;

function ChangedFunctions:washableUpdateTick(dt)
	if self.washableNodes ~= nil then
		if self.isServer then
			if not self.underRoof then
				if self.carWashTrigger then
					self.carWashTrigger.timer = self.carWashTrigger.timer + dt;
					if self.carWashTrigger.timer > 7000 then
						local amount = self:getDirtAmount();
						if amount > 0.01 then
							amount = math.max(self:getDirtAmount() - (dt/self.washDuration)*4, 0);
							self:setDirtAmount(amount);
							if not self.carWashTrigger.isOwned then
								local money = self.carWashTrigger.pricePerSecond*0.001*dt;
								g_currentMission:addSharedMoney(-money, "vehicleRunningCost");
							end;
							if not self.carWashTrigger.washing then
								if self.carWashTrigger.waterStreams then
									setVisibility(self.carWashTrigger.waterStreams, true);
									for _,ps in pairs(self.carWashTrigger.wps) do
										Utils.setEmittingState(ps, true);
									end;
								end;
								self.carWashTrigger.washing = true;
								self.carWashTrigger:raiseDirtyFlags(self.carWashTrigger.washingDirtyFlag);
							end;
						else
							if self.carWashTrigger.waterStreams then
								setVisibility(self.carWashTrigger.waterStreams, false);
								for _,ps in pairs(self.carWashTrigger.wps) do
									Utils.setEmittingState(ps, false);
								end;
							end;
							self.carWashTrigger.timer = 0;
							self.carWashTrigger.washing = false;
							self.carWashTrigger:raiseDirtyFlags(self.carWashTrigger.washingDirtyFlag);
							self.carWashTrigger = nil;
						end;
					end;
				elseif g_currentMission.environment.lastRainScale > 0.1 and g_currentMission.environment.timeSinceLastRain < 30 then
					local amount = self:getDirtAmount();
					if amount > 0.5 then
						amount = self:getDirtAmount() - (dt/self.washDuration);
					end;
					self:setDirtAmount(amount);
				else
					if self:getIsActive() or self.isActive then
						self:setDirtAmount(self:getDirtAmount() + (dt * self.dirtDuration)*self:getDirtMultiplier()*Washable.getIntervalMultiplier());
					end;
				end;
			end;
		end;
	end;
end;

-------------------------------------------------------------------------------------------------
