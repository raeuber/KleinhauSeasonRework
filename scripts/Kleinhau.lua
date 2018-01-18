Kleinhau = {};

local Kleinhau_mt = Class(Kleinhau, Mission00);

function Kleinhau:new(baseDirectory, customMt)
    local Kleinhau = customMt;
		
	if Kleinhau == nil then
        Kleinhau = Kleinhau_mt;
    end;
    
	local self = Kleinhau:superClass():new(baseDirectory, Kleinhau);
	local numAdditionalAngleChannels = 4;
	self.terrainDetailAngleNumChannels = self.terrainDetailAngleNumChannels + numAdditionalAngleChannels;
    self.terrainDetailAngleMaxValue = (2^self.terrainDetailAngleNumChannels) - 1;
	self.sprayLevelFirstChannel = self.sprayLevelFirstChannel + numAdditionalAngleChannels;
	self.ploughCounterFirstChannel = self.ploughCounterFirstChannel + numAdditionalAngleChannels;
	
	return self;
end;

function Kleinhau:loadHotspots(xmlFile)
	local count = 0;
	
    while true do
        local hotspotKey = string.format("map.hotspots.hotspot(%d)", count);
        
		if not hasXMLProperty(xmlFile, hotspotKey) then
            break;
        end;

        local name = Utils.getNoNil(getXMLString(xmlFile, hotspotKey .. "#name"), "");
        local fullName = Utils.getNoNil(getXMLString(xmlFile, hotspotKey .. "#fullName"), "");
        
		if fullName:sub(1, 6) == "$l10n_" then
            fullName = g_i18n:getText(fullName:sub(7));
        end;
        
		local imageFilename = getXMLString(xmlFile, hotspotKey .. "#imageFilename");
		
		if imageFilename ~= nil then
			imageFilename = Utils.getFilename(imageFilename, self.baseDirectory);
		end;
		
		local imageUVs = getNormalizedUVs(Utils.getVectorNFromString(getXMLString(xmlFile, hotspotKey .. "#imageUVs"), 4));
        local baseColor = Utils.getVectorNFromString(getXMLString(xmlFile, hotspotKey .. "#baseColor"), 4);
        local xMapPos = getXMLFloat(xmlFile, hotspotKey .. "#xMapPos");
        local zMapPos = getXMLFloat(xmlFile, hotspotKey .. "#zMapPos");
        local blinking = Utils.getNoNil(getXMLBool(xmlFile, hotspotKey .. "#blinking"), false);
        local persistent = Utils.getNoNil(getXMLBool(xmlFile, hotspotKey .. "#persistent"), false);
        local showName = Utils.getNoNil(getXMLBool(xmlFile, hotspotKey .. "#showName"), true);
        local renderLast = Utils.getNoNil(getXMLBool(xmlFile, hotspotKey .. "#renderLast"), false);
        local category = Utils.getNoNil(getXMLString(xmlFile, hotspotKey .. "#category"), "CATEGORY_TRIGGER");
		
		local width, height = getNormalizedScreenValues(Utils.getNoNil(getXMLFloat(xmlFile, hotspotKey .. "#width"), 12), Utils.getNoNil(getXMLFloat(xmlFile, hotspotKey .. "#height"), 12))
        
		if MapHotspot[category] ~= nil then
            category = MapHotspot[category];
        else
            category = MapHotspot.CATEGORY_DEFAULT;
        end;
		
        local textSize = getXMLInt(xmlFile, hotspotKey .. "#textSize");
        
		if textSize ~= nil then
            _, textSize = getNormalizedScreenValues(0, textSize);
        end;
		
        local textOffsetY = getXMLInt(xmlFile, hotspotKey .. "#textOffsetY");
        
		if textOffsetY ~= nil then
            _, textOffsetY = getNormalizedScreenValues(0, textOffsetY);
        end;
		
        local textColor = Utils.getVectorNFromString(getXMLString(xmlFile, hotspotKey .. "#textColor"), 4);

        self.ingameMap:createMapHotspot(name, fullName, imageFilename, imageUVs, baseColor, xMapPos, zMapPos, width, height, blinking, persistent, showName, nil, renderLast, category, textSize, textOffsetY, textColor);

        count = count + 1;
    end;
end;

function Kleinhau:onStartMission()
    Kleinhau:superClass().onStartMission(self);
	if g_currentMission:getIsServer() and not g_currentMission.missionInfo.isValid then		
		if self.missionInfo.difficulty == 1 then
			g_currentMission.missionStats.money = 200000;		
			g_currentMission.missionStats.loan = 0;        
		elseif self.missionInfo.difficulty == 2 then
			g_currentMission.missionStats.money = 80000;		
			g_currentMission.missionStats.loan = 25000;        
		elseif self.missionInfo.difficulty == 3 then
			g_currentMission.missionStats.money = 50000;		
			g_currentMission.missionStats.loan = 50000; 
        end;
    end;
end;

Mission00.loadHotspots = Utils.overwrittenFunction(Mission00.loadHotspots, Kleinhau.loadHotspots);
