--author: igor29381

TrafficManager = {};
TrafficManager.curModDir = g_currentModDirectory;

function TrafficManager:loadData()
	local xmlPath = TrafficManager.curModDir.."maps/scripts/traffic.xml";
	if fileExists(xmlPath) then
		local xmlFile = loadXMLFile("traffic", xmlPath);
		local i = 0;
		self.airplane = {};
		while true do
			local airplaneIndex = string.format("traffic.airplane(%d)", i);
			if not hasXMLProperty(xmlFile, airplaneIndex) then break; end;
			local i3dFilename = getXMLString(xmlFile, airplaneIndex .. "#i3dFilename");
			if i3dFilename then i3dFilename = TrafficManager.curModDir..i3dFilename; end;
			if fileExists(i3dFilename) then
				local airplane={};
				local airplaneRoot = Utils.loadSharedI3DFile(i3dFilename);
				airplane.Id = getChildAt(airplaneRoot, 0);
				link(getRootNode(), airplane.Id);
				setTranslation(airplane.Id, 0, 5000, 0);
				setVisibility(airplane.Id, false);
				delete(airplaneRoot);
				local speed = Utils.getNoNil(getXMLInt(xmlFile, airplaneIndex .. "#speed"), 200);
				airplane.speed = speed;
				airplane.times = {};
				local ii = 0;
				while true do
					local timeIndex = string.format(airplaneIndex .. ".time(%d)", ii);
					if not hasXMLProperty(xmlFile, timeIndex) then break; end;
					local timetable = {};
					timetable.hour = Utils.getNoNil(getXMLInt(xmlFile, timeIndex.."#hour"), 0);
					timetable.splineIndex = Utils.getNoNil(getXMLInt(xmlFile, timeIndex .. "#splineIndex"), 1);
					table.insert(airplane.times, timetable);
					ii = ii + 1;
				end;
				table.insert(self.airplane, airplane);
			end;
			i = i + 1;
		end;
		i = 0;
		self.ships = {};
		while true do
			local shipIndex = string.format("traffic.ship(%d)", i);
			if not hasXMLProperty(xmlFile, shipIndex) then break; end;
			local i3dFilename = getXMLString(xmlFile, shipIndex .. "#i3dFilename");
			if i3dFilename then i3dFilename = TrafficManager.curModDir..i3dFilename; end;
			if fileExists(i3dFilename) then
				local ship={};
				local shipRoot = Utils.loadSharedI3DFile(i3dFilename);
				ship.Id = getChildAt(shipRoot, 0);
				link(getRootNode(), ship.Id);
				setTranslation(ship.Id, 0, 4900, 0);
				setVisibility(ship.Id, false);
				delete(shipRoot);
				local cargoBlocks = getChild(ship.Id, "cargoBlocks");
				if cargoBlocks > 0 then
					local numCargoBlocks = getNumOfChildren(cargoBlocks);
					if numCargoBlocks > 0 then
						ship.cargoBlocks = cargoBlocks;
						ship.numCargoBlocks = numCargoBlocks;
						for cb=1, numCargoBlocks do
							setVisibility(getChildAt(cargoBlocks, cb-1), false);
						end;
					end;
				end;
				local nightLights = getChild(ship.Id, "lightOn");
				if nightLights and nightLights > 0 then
					local nightLight = Nightlight2:new(nightLights);
					g_currentMission:addNonUpdateable(nightLight);
				end;
				local ii = 0;
				ship.waterParticles = {};
				while true do
					local baseString = string.format(shipIndex .. ".particleSystem(%d)", ii);
					if not hasXMLProperty(xmlFile, baseString) then break; end;
					local ps = {};
					ParticleUtil.loadParticleSystem(xmlFile, ps, baseString, ship.Id, false, nil, g_currentMission.baseDirectory);
					table.insert(ship.waterParticles, ps);
					ii = ii + 1;
				end;
				table.insert(self.ships, ship);
				ship.speed = Utils.getNoNil(getXMLInt(xmlFile, shipIndex .. "#speed"), 20);
				ship.capacity = Utils.getNoNil(getXMLInt(xmlFile, shipIndex .. "#capacity"), 0);
				ship.draught = Utils.getNoNil(getXMLInt(xmlFile, shipIndex .. "#draught"), 2);
				local soundFile = TrafficManager.curModDir..getXMLString(xmlFile, shipIndex.."#hornSound");
				if soundFile then
					ship.hornSound = createAudioSource("hornSound", soundFile, 800, 600, 1, 10000);
					link(getRootNode(), ship.hornSound);
					setVisibility(ship.hornSound, false);
				end;
				local cargoFillTypes = getXMLString(xmlFile, shipIndex.."#cargoFillTypes");
				if cargoFillTypes then
					cargoFillTypes = Utils.splitString(" ", cargoFillTypes);
					local fillTypes = {};
					for _,ft in pairs(cargoFillTypes) do
						local fillType = FillUtil.fillTypeNameToInt[ft];
						if fillType then fillTypes[fillType] = true; end;
					end;
					ship.cargoFillTypes = fillTypes;
				end;
				ship.times = {};
				ii = 0;
				while true do
					local timeIndex = string.format(shipIndex .. ".time(%d)", ii);
					if not hasXMLProperty(xmlFile, timeIndex) then break; end;
					local timetable = {};
					timetable.hour = Utils.getNoNil(getXMLInt(xmlFile, timeIndex.."#hour"), 0);
					timetable.splineIndex = Utils.getNoNil(getXMLInt(xmlFile, timeIndex .. "#splineIndex"), 1);
					table.insert(ship.times, timetable);
					ii = ii + 1;
				end;
				table.insert(self.ships, ship);
			end;
			i = i + 1;
		end;
		i = 0;
		local i3dFilename = getXMLString(xmlFile, "traffic.train#i3dFilename");
		if i3dFilename then i3dFilename = TrafficManager.curModDir..i3dFilename; end;
		if fileExists(i3dFilename) then
			TrafficManager.trainsI3dFilename = i3dFilename;
			i3dFilename = TrafficManager.curModDir.."maps/traffic/trains/materialHolder.i3d";
			self.materials = {};
			if fileExists(i3dFilename) then
				local materialsRoot = Utils.loadSharedI3DFile(i3dFilename);
				local numChildren = getNumOfChildren(materialsRoot);
				if numChildren > 0 then
					for m=1, numChildren do
						local materialRootNode = getChildAt(materialsRoot, m-1);
						local name = getName(materialRootNode);
						local numChild = getNumOfChildren(materialRootNode);
						self.materials[name] = {};
						local materials = {};
						for ms=1, numChild do
							local holder = getChildAt(materialRootNode, ms-1);
							local material = getMaterial(holder, 0);
							table.insert(materials, material);
						end;
						self.materials[name] = materials;
					end;
				end;
			end;
			if g_server ~= nil then
				self.trainsTimetable = {};
				while true do
					local timeKey = string.format("traffic.train.time(%d)", i);
					if not hasXMLProperty(xmlFile, timeKey) then break; end;
					local timetable = {};
					timetable.train = getXMLString(xmlFile, timeKey .. "#train");
					timetable.speed = Utils.getNoNil(getXMLInt(xmlFile, timeKey.."#speed"), 30);
					timetable.hour = Utils.getNoNil(getXMLInt(xmlFile, timeKey.."#hour"), 0);
					timetable.splineIndex = Utils.getNoNil(getXMLInt(xmlFile, timeKey .. "#splineIndex"), 1);
					timetable.onStation = Utils.getNoNil(getXMLBool(xmlFile, timeKey .. "#onStation"), false);
					timetable.onWoodStage = Utils.getNoNil(getXMLBool(xmlFile, timeKey .. "#onWoodStage"), false);
					local cars = getXMLString(xmlFile, timeKey .. "#cars");
					if cars then
						cars = Utils.splitString(" ", cars);
						for ii=1, #cars do
							cars[ii] = RailRoad.trainNameToInt[cars[ii]];
						end;
						timetable.cars = cars;
					end;
					table.insert(self.trainsTimetable, timetable);
					i = i + 1;
				end;
			end;
			local soundFile = TrafficManager.curModDir..getXMLString(xmlFile, "traffic.train#brakeSound");
			if soundFile then
				self.brakeSound = createAudioSource("brakeSound", soundFile, 100, 75, 1, 0);
				link(getRootNode(), self.brakeSound);
				setVisibility(self.brakeSound, false);
			end;
			soundFile = TrafficManager.curModDir..getXMLString(xmlFile, "traffic.train#brakeEndSound");
			if soundFile then
				self.brakeEndSound = createAudioSource("brakeEndSound", soundFile, 100, 75, 1, 10000);
				link(getRootNode(), self.brakeEndSound);
				setVisibility(self.brakeEndSound, false);
			end;
			soundFile = TrafficManager.curModDir..getXMLString(xmlFile, "traffic.train#hornSound");
			if soundFile then
				self.hornSound = createAudioSource("hornSound", soundFile, 300, 150, 1, 10000);
				link(getRootNode(), self.hornSound);
				setVisibility(self.hornSound, false);
			end;
			soundFile = TrafficManager.curModDir..getXMLString(xmlFile, "traffic.train#whistleSound");
			if soundFile then
				self.whistleSound = createAudioSource("whistleSound", soundFile, 300, 150, 1, 10000);
				link(getRootNode(), self.whistleSound);
				setVisibility(self.whistleSound, false);
			end;
			soundFile = TrafficManager.curModDir..getXMLString(xmlFile, "traffic.train#clatterSound");
			if soundFile then
				self.clatterSound = createAudioSource("clatterSound", soundFile, 200, 100, 1, 0);
				link(getRootNode(), self.clatterSound);
				setVisibility(self.clatterSound, false);
			end;
			soundFile = TrafficManager.curModDir..getXMLString(xmlFile, "traffic.train#clatterHardSound");
			if soundFile then
				self.clatterHardSound = createAudioSource("clatterHardSound", soundFile, 200, 100, 1, 0);
				link(getRootNode(), self.clatterHardSound);
				setVisibility(self.clatterHardSound, false);
			end;
		end;
		delete(xmlFile);
	end;
end;



function TrafficManager:delete()
	for i=1, #self.airplane do
		delete(self.airplane[i].Id);
	end;
	for i=1, #self.ships do
		local ship = self.ships[i];
		if ship.hornSound then
			delete(ship.hornSound);
		end;
		delete(ship.Id);
	end;
	if self.brakeSound ~= nil then
		delete(self.brakeSound);
	end;
	if self.brakeEndSound ~= nil then
		delete(self.brakeEndSound);
	end;
	if self.hornSound ~= nil then
		delete(self.hornSound);
	end;
	if self.whistleSound ~= nil then
		delete(self.whistleSound);
	end;
	if self.clatterSound ~= nil then
		delete(self.clatterSound);
	end;
	if self.clatterHardSound ~= nil then
		delete(self.clatterHardSound);
	end;
end;

function TrafficManager:save()
	local xmlFile = createXMLFile("trafficSaves", string.format("%s/trafficSaves.xml", g_currentMission.missionInfo.savegameDirectory), "traffic");
	if TrafficManager.shipTraffic then
		setXMLBool(xmlFile, "traffic.shipTraffic#shipOnSpline", self.shipTraffic.shipOnSpline);
		setXMLBool(xmlFile, "traffic.shipTraffic#shipIsStopped", self.shipTraffic.shipIsStopped);
		setXMLFloat(xmlFile, "traffic.shipTraffic#splinePosition", self.shipTraffic.splinePosition);
		setXMLFloat(xmlFile, "traffic.shipTraffic#draught", self.shipTraffic.draught);
		setXMLFloat(xmlFile, "traffic.shipTraffic#level", self.shipTraffic.level);
		setXMLFloat(xmlFile, "traffic.shipTraffic#limitedSpeed", self.shipTraffic.limitedSpeed);
		setXMLFloat(xmlFile, "traffic.shipTraffic#stopTimer", self.shipTraffic.stopTimer);
		setXMLInt(xmlFile, "traffic.shipTraffic#curShip", self.shipTraffic.curShip);
		setXMLInt(xmlFile, "traffic.shipTraffic#curSpline", self.shipTraffic.curSpline);
		setXMLInt(xmlFile, "traffic.shipTraffic#curMark", self.shipTraffic.curMark);
		setXMLInt(xmlFile, "traffic.shipTraffic#cruiseSpeed", self.shipTraffic.cruiseSpeed);
	end;
	if TrafficManager.AirSprayer then
		TrafficManager.AirSprayer:save(xmlFile);
	end;
	saveXMLFile(xmlFile);
	delete(xmlFile);
end;
