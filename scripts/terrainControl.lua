--author: igor29381, edit: Decker_MMIV

terrainControl = {};

function terrainControl.prerequisitesPresent(specializations)
	return true;
end;

function terrainControl:load(savegame)

	if #self.wheels>0 then
		for c,wheel in pairs(self.wheels) do
			if wheel.tireType ~= 4 then
				local psData = {};
				psData.psFile = "maps/pSystem/dirtPS/dirt2.i3d";
				psData.posX = wheel.positionX;
				psData.posY = wheel.positionY-wheel.radius;
				psData.posZ = wheel.positionZ;
				psData.worldSpace = false;
				wheel.dirt2ParticleSystems = {};
				ParticleUtil.loadParticleSystemFromData(psData, wheel.dirt2ParticleSystems, nil, false, nil, g_currentMission.baseDirectory, wheel.node);
				setScale(wheel.dirt2ParticleSystems.shape, wheel.radius, wheel.radius, wheel.radius);
				wheel.dirt3ParticleSystems = {};
				ParticleUtil.loadParticleSystemFromData(psData, wheel.dirt3ParticleSystems, nil, false, nil, g_currentMission.baseDirectory, wheel.node);
				setScale(wheel.dirt3ParticleSystems.shape, wheel.radius, wheel.radius, wheel.radius);
				wheel.enableDrift = false;
				wheel.driftCoeff = 1;
			end;
			wheel.wasInDirtS = false;
			wheel.wasInDirtC = false;
			wheel.inDirt = false;
			wheel.lastRot,_,_ = getRotation(wheel.driveNode);
			wheel.realRadius = wheel.radius;
			wheel.newRadius = wheel.radius;
			local additionalWheelsWidth = 0;
			if wheel.additionalWheels and #wheel.additionalWheels > 0 then
				for _,additionalWheel in pairs (wheel.additionalWheels) do
					additionalWheelsWidth = additionalWheelsWidth + additionalWheel.width;
				end;
			end;
			wheel.totalWidth = wheel.width + additionalWheelsWidth;
			wheel.widthFactor = math.max(1, wheel.totalWidth*2);
			wheel.minRadius = math.max(wheel.radius/3, math.min(wheel.radius*wheel.totalWidth, wheel.radius*0.8));
		end;
		self.movedDistance = 0;
		self.distanceToChange = math.random(2, 10)/10;
		self.lineDamp = 0;
	end;
	if self.cameras and #self.cameras > 0 then
		self.allowTransCameras = {};
		self.allowRotCameras = {};
		for i=1, #self.cameras do
			if self.cameras[i].allowTranslation then
				self.allowTransCameras[i] = true;
			end;
			if self.cameras[i].isRotatable then
				self.allowRotCameras[i] = true;
			end;
		end;
	end;
	self.underRoof = false;
	--[[if SpecializationUtil.hasSpecialization(TreePlanter, self.specializations) then
		local function createTree()
			local x,_,z = getWorldTranslation(self.treePlanterNode);
			if not Economica:getOwnedTerritory(x,z) then
				g_currentMission:addSharedMoney(15, "other");
			end;
		end;
		self.createTree = Utils.prependedFunction(self.createTree, createTree);
	end;--]] 
	if SpecializationUtil.hasSpecialization(Combine, self.specializations) then
		local workArea = self.workAreas[1];
		if workArea and workArea.type == WorkArea.AREATYPE_COMBINE then
			local _,_,z = getTranslation(workArea.start);
			local _,_,z2 = getTranslation(workArea.width);
			local _,_,z3 = getTranslation(workArea.height);
			local start = createTransformGroup("start");
			link(self.rootNode, start);
			setTranslation(start, 2.5, 0, z);
			local width = createTransformGroup("width");
			link(self.rootNode, width);
			setTranslation(width, -2.5, 0, z2);
			local height = createTransformGroup("height");
			link(self.rootNode, height);
			setTranslation(height, 2.5, 0, z3-2.5);
			self.strawArea = {start = start, width = width, height = height};
		end;
		
	end;
end;

function terrainControl:delete()
end;

function terrainControl:mouseEvent(posX, posY, isDown, isUp, button)
end;

function terrainControl:keyEvent(unicode, sym, modifier, isDown)
end;

function terrainControl:update(dt)
	if #self.wheels > 0 then
		local speed = self:getLastSpeed(true);
		local enableChanges = false;
		if self.movedDistance then
			self.movedDistance = self.movedDistance + self.lastMovedDistance;
			if self.movedDistance > self.distanceToChange and speed > 0.5 then
				enableChanges = true;
				self.movedDistance = 0;
				self.distanceToChange = math.random(2, 10)/10;
			end;
		end;
		if self.isServer then
			local LineDamp = 0;
			local dirtAmount = 0;
			local mass = self:getTotalMass();
			mass = mass/#self.wheels;
			for c=1, #self.wheels do
				local wheel = self.wheels[c];
				if wheel.inDirt then
					wheel.wasInDirtS = true;
					if wheel.tireTrackIndex then
						g_currentMission.tireTrackSystem:cutTrack(wheel.tireTrackIndex);
					end;
					local AxleSpeed = math.abs(getWheelShapeAxleSpeed(wheel.node, wheel.wheelShape));
					dirtAmount = dirtAmount + (AxleSpeed/10000)/#self.wheels;
					if self.motor then
						local damp = (speed/200)/#self.wheels;
						LineDamp = Utils.clamp(LineDamp + damp, 0.3, 0.8)/wheel.widthFactor;
					end;
					if enableChanges then
						if wheel.tireType ~= 4 then
							local frictionCoeff;
							if wheel.onDirtyBorder then
								wheel.newRadius = math.max(wheel.realRadius-math.random(10, 20+mass)/300, wheel.minRadius);
								wheel.driftCoeff = math.random(1, 6)/wheel.widthFactor;
								frictionCoeff = (math.random(20, 40)/70)*wheel.widthFactor;
							else
								wheel.newRadius = math.max(wheel.realRadius-math.random(20, 45+mass)/300, wheel.minRadius);
								wheel.driftCoeff = math.random(1, 15)/wheel.widthFactor;
								frictionCoeff = (math.random(15, 32)/80)*wheel.widthFactor;
							end;
							local wx,wy,wz = getTranslation(wheel.driveNode);
							addForce(self.rootNode,wx*frictionCoeff*20,0,0,wx,wy,wz,true);
							setWheelShapeTireFriction(wheel.node, wheel.wheelShape, wheel.maxLongStiffness, wheel.maxLatStiffness, wheel.maxLatStiffnessLoad, frictionCoeff);
						else
							wheel.newRadius = wheel.realRadius-math.random(10, 20)/300;
						end;
					end;
					if wheel.tireType ~= 4 then
						wheel.enableDrift = (AxleSpeed > speed and AxleSpeed > 5);
						if wheel.enableDrift then
							wheel.newRadius = math.max(wheel.newRadius - 0.00001*wheel.driftCoeff*dt, wheel.minRadius);
						end;
					end;
					if AxleSpeed > 2 then
						if wheel.radius < wheel.newRadius then
							wheel.radius = math.min(wheel.radius + 0.0003*dt, wheel.newRadius);
							self:updateWheelBase(wheel, true);
						else
							wheel.radius = math.max(wheel.radius - 0.0003*dt, wheel.newRadius);
							self:updateWheelBase(wheel, true);
						end;
					end;
				end;
				if wheel.wasInDirtS and not wheel.inDirt then
					local AxleSpeed = math.abs(getWheelShapeAxleSpeed(wheel.node, wheel.wheelShape));
					if AxleSpeed > 2 then
						wheel.radius = math.min(wheel.radius + 0.001*dt, wheel.realRadius);
						self:updateWheelBase(wheel, true);
						if wheel.radius >= wheel.realRadius then
							wheel.wasInDirtS = false;
							if wheel.tireType ~= 4 then
								setWheelShapeTireFriction(wheel.node, wheel.wheelShape, wheel.maxLongStiffness, wheel.maxLatStiffness, wheel.maxLatStiffnessLoad, wheel.tireGroundFrictionCoeff);
							end;
						end;
					end;
				end;
				if wheel.realRadius and not wheel.inDirt and not wheel.wasInDirtS then
					if enableChanges then
						local x, y, z = getWorldTranslation(wheel.driveNode);
						local bits = getDensityAtWorldPos(g_currentMission.terrainDetailId, x,y,z);
						local _,bits2 = math.modf((bits-2)/4);
						if bits == 0 and wheel.lastColor[4] < 0.8 then
							wheel.newRadius = wheel.realRadius;
						end;
						if wheel.tireType ~= 4 then
							if wheel.lastColor[4] > 0.8 then
								if wheel.contact > 1 then
									local delta = 0.01-math.random(0, 2)/100;
									wheel.newRadius = wheel.realRadius - delta;
									if self.motor then LineDamp = LineDamp + (0.1/#self.wheels)/wheel.widthFactor; end;
								else
									wheel.newRadius = wheel.realRadius;
								end;
							end;
							if bits > 0 then
								wheel.newRadius = wheel.realRadius-(math.random(5, 9)/100)/wheel.widthFactor;
								if self.motor then LineDamp = LineDamp + (0.05/#self.wheels)/wheel.widthFactor; end;
							end;
							if bits2 == 0 and not SpecializationUtil.hasSpecialization(Plough, self.specializations) then
								wheel.newRadius = Utils.clamp(wheel.realRadius-(math.random(15, 30)/100)/wheel.widthFactor, wheel.realRadius/3, wheel.realRadius);
								if self.motor then LineDamp = LineDamp + (0.1/#self.wheels)/wheel.widthFactor; end;
							end;
						else
							wheel.newRadius = wheel.realRadius;
							if bits > 0 then
								wheel.newRadius = wheel.realRadius-math.random(3, 6)/100;
								LineDamp = LineDamp + 0.05/#self.wheels;
							end;
							if bits2 == 0 then
								wheel.newRadius = Utils.clamp(wheel.realRadius-math.random(5, 10)/100, wheel.realRadius/2, wheel.realRadius);
								LineDamp = LineDamp + 0.075/#self.wheels;
							end;
						end;
					end;
					if wheel.radius > wheel.newRadius then
						wheel.radius = math.max(wheel.radius - 0.00075*dt, wheel.newRadius);
						self:updateWheelBase(wheel, true);
					elseif wheel.radius < wheel.newRadius then
						wheel.radius = math.min(wheel.radius + 0.00075*dt, wheel.newRadius);
						self:updateWheelBase(wheel, true);
					end;
				end;
			end;
			if enableChanges and self.lineDamp ~= LineDamp then
				setLinearDamping(self.rootNode, LineDamp);
				self.lineDamp = LineDamp;
			end;
			if dirtAmount > 0 and self.dirtAmount then
				self.dirtAmount = math.min(self.dirtAmount + dirtAmount, 1);
				if self.attachedImplements ~= nil then
					for i=1, #self.attachedImplements do
						local object = self.attachedImplements[i].object;
						if object.dirtAmount then object.dirtAmount = math.min(object.dirtAmount + dirtAmount, 1); end;
					end;
				end;
			end;
		end;

		for c=1, #self.wheels do
			local wheel = self.wheels[c];
			if wheel.tireType ~= 4 then
				if wheel.inDirt then
					wheel.wasInDirtC = true;
					local x,y,_ = getRotation(wheel.driveNode);
					local forwardDirection = x < wheel.lastRot;
					wheel.lastRot = x;
					if (wheel.enableDrift and self.isMotorStarted) or speed > 15 then
						Utils.setEmittingState(wheel.dirt2ParticleSystems, not forwardDirection);
						Utils.setEmittingState(wheel.dirt3ParticleSystems, forwardDirection);
					else
						Utils.setEmittingState(wheel.dirt2ParticleSystems, false);
						Utils.setEmittingState(wheel.dirt3ParticleSystems, false);
					end;
					setRotation(wheel.dirt2ParticleSystems.shape, math.rad(45),y,0);
					setRotation(wheel.dirt3ParticleSystems.shape, math.rad(45),y-math.rad(180),0);
				end;
				if wheel.wasInDirtC and not wheel.inDirt then
					Utils.setEmittingState(wheel.dirt2ParticleSystems, false);
					Utils.setEmittingState(wheel.dirt3ParticleSystems, false);
					wheel.wasInDirtC = false;
				end;
			end;
		end;
	end;
	if self.cameras and #self.cameras > 0 then
		for i=1, #self.cameras do
			local camera = self.cameras[i];
			if self.allowTransCameras[i] then
				if camera.allowTranslation and terrainControl.lockCameras then
					camera.allowTranslation = false;
				end;
				if not camera.allowTranslation and not terrainControl.lockCameras then
					camera.allowTranslation = true;
				end;
			end;
			if self.allowRotCameras[i] then
				if camera.isRotatable and terrainControl.lockCameras then
					camera.isRotatable = false;
				end;
				if not camera.isRotatable and not terrainControl.lockCameras then
					camera.isRotatable = true;
				end;
			end;
		end;
	end;
end;

function terrainControl:updateTick(dt)
	if self:getLastSpeed(true) > 0 or self:getIsActive() then
		if #self.wheels > 0 then
			local enableCutting = terrainControl.cutFruitsByWheels;
			if enableCutting then
				if self.isHired or (g_currentMission.fieldJobManager.currentFieldJob and self.propertyState == 0) then
					enableCutting = false;
				end;
				if enableCutting then
					local rootAttacherVehicle = self:getRootAttacherVehicle();
					if rootAttacherVehicle then
						if self.cp and rootAttacherVehicle.cp.isDriving then
							enableCutting = false;
						end;
						if rootAttacherVehicle.modFM and rootAttacherVehicle.modFM.FollowState == 2 then
							enableCutting = false;
						end;
					end;
				end;
			end;
			for c=1, #self.wheels do
				local wheel = self.wheels[c];
				local wx,wy,wz = getWorldTranslation(wheel.driveNode);
				local terrainHeight = getTerrainHeightAtWorldPos(g_currentMission.terrainRootNode, wx, 0, wz);
				local cx1 = wx+wheel.totalWidth/3;
				local cz1 = wz+wheel.totalWidth/3;
				local cx2 = wx-wheel.totalWidth/3;
				local cz2 = wz-wheel.totalWidth/3;
				if self.isServer then
					wheel.inDirt = false;
					wheel.onDirtyBorder = false;
					if wheel.realRadius and wheel.contact == Vehicle.WHEEL_GROUND_CONTACT and wy-wheel.radius-terrainHeight < 1 then
						local onDirtyBorder, inDirt = terrainControl.getDirtyArea(cx1, cz1, cx2, cz1, cx2, cz2);
						if onDirtyBorder or inDirt then
							wheel.inDirt = inDirt;
							wheel.onDirtyBorder = onDirtyBorder;
							g_currentMission.tireTrackSystem:eraseParallelogram(cx1, cz1, cx2, cz1, cx2, cz2);
						end;
					end;
				end;
				if enableCutting then
					if wheel.contact == 0 and wheel.inDirt or wheel.wasInDirtS then
						enableCutting = false;
					end;
					if enableCutting then
						for f=1, #terrainControl.fruitTypes do
							local fruitType = terrainControl.fruitTypes[f];
							local growing, readyToHarvest, withered = Utils.getFruitGrowingStates(fruitType, cx1, cz1, cx2, cz1, cx2, cz2);
							if growing > 0 or readyToHarvest > 0 or withered > 0 then
								if fruitType ~= FruitUtil.FRUITTYPE_GRASS then
									if growing > 0 and wheel.width < 0.3 then
										break;
									end;
									Utils.updateDestroyCommonArea(cx1, cz1, cx2, cz1, cx2, cz2);
									if growing then
										Utils.updateHaulmArea(terrainControl.darkStrawDensityId, cx1, cz1, cx2, cz1, cx2, cz2);
									end;
									if readyToHarvest then
										local straw = terrainControl.fruitTypesToStraw[fruitType];
										if straw then
											Utils.updateHaulmArea(straw, cx1, cz1, cx2, cz1, cx2, cz2);
										end;
									end;
									if not g_currentMission:getIsFieldOwnedAtWorldPos(cx1, cz1) then
										local penalty = growing + readyToHarvest + withered;
										if g_server then
											g_currentMission:addSharedMoney(-penalty, "other");
										end;
										g_currentMission:showBlinkingWarning(g_i18n:getText("noDriveOnUnownedFields"), 3000);
									end;
									break;
								else
									Utils.cutFruitArea(FruitUtil.FRUITTYPE_GRASS, cx1, cz1, cx2, cz1, cx2, cz2, false, false);
								end;
							end;
						end;
					end;
				end;
			end;
		end;
	end;
end;

function terrainControl:readUpdateStream(streamId, timestamp, connection)
	if connection.isServer then
		for c=1, #self.wheels do
			local wheel = self.wheels[c];
			wheel.inDirt = streamReadBool(streamId);
			wheel.enableDrift = streamReadBool(streamId);
		end;
	end;
end;

function terrainControl:writeUpdateStream(streamId, connection, dirtyMask)
	if not connection.isServer then
		for c=1, #self.wheels do
			local wheel = self.wheels[c];
			streamWriteBool(streamId, Utils.getNoNil(wheel.inDirt, false));
			streamWriteBool(streamId, Utils.getNoNil(wheel.enableDrift, false));
		end;
	end;
end;

function terrainControl:draw()
end;

function Utils.getFruitGrowingStates(fruitId, startWorldX, startWorldZ, widthWorldX, widthWorldZ, heightWorldX, heightWorldZ)
	local ids = g_currentMission.fruits[fruitId];
	if ids == nil or ids.id == 0 then
		return 0, 0, 0;
	end;
	local id = ids.id;
	local desc = FruitUtil.fruitIndexToDesc[fruitId];
	local x,z, widthX,widthZ, heightX,heightZ = Utils.getXZWidthAndHeight(id, startWorldX, startWorldZ, widthWorldX, widthWorldZ, heightWorldX, heightWorldZ);
	setDensityReturnValueShift(id, -1);
	setDensityCompareParams(id, "between", desc.minHarvestingGrowthState, desc.minHarvestingGrowthState);
	local ret1,_ = getDensityParallelogram(id, x, z, widthX, widthZ, heightX, heightZ, 0, g_currentMission.numFruitStateChannels);
	setDensityCompareParams(id, "between", desc.minHarvestingGrowthState+1, desc.maxHarvestingGrowthState+1);
	local ret2,_ = getDensityParallelogram(id, x, z, widthX, widthZ, heightX, heightZ, 0, g_currentMission.numFruitStateChannels);
	setDensityCompareParams(id, "between", desc.maxHarvestingGrowthState+1, desc.maxHarvestingGrowthState+2);
	local ret3,_ = getDensityParallelogram(id, x, z, widthX, widthZ, heightX, heightZ, 0, g_currentMission.numFruitStateChannels);
	setDensityCompareParams(id, "greater", -1);
	setDensityReturnValueShift(id, 0);
	return ret1, ret2, ret3;
end;

function terrainControl.getDirtyArea(startWorldX, startWorldZ, widthWorldX, widthWorldZ, heightWorldX, heightWorldZ)
    if terrainControl.dirtyDensityId == 0 then
        return false,false
    end
    local x,z, widthX,widthZ, heightX,heightZ = Utils.getXZWidthAndHeight(terrainControl.dirtyDensityId, startWorldX, startWorldZ, widthWorldX, widthWorldZ, heightWorldX, heightWorldZ);
    local sumPixels,numPixels,totPixels = getDensityParallelogram(terrainControl.dirtyDensityId, x, z, widthX, widthZ, heightX, heightZ, 0, g_currentMission.numFruitStateChannels);
    if sumPixels <= 0 or totPixels <= 0 then
        return false, false
    end
    local ret = totPixels / sumPixels   -- Calculate a percentage of the 'density'.
    --print(string.format("%.2f %d %d %d", ret, sumPixels, numPixels, totPixels))
    return (ret <= 0.5), (ret > 0.5)
end;

