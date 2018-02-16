local metadata = {
"## Interface: 1.3.0.0 1.3RC4",
"## Title: AdditionalMapTypes",
"## Notes: FS2017 Script for registering Fruit and FillTypes, via modDesc.xml",
"## Author: Blacksheep - RC-Devil",
"## Version: 1.0.0.7",
"## Date: 07.01.2017",
"## Web: "
}
--
-- AdditionalMapTypes
--
-- @author: Blacksheep - RC-Devil
-- @version: 1.0.0.7
-- @date: 07 Januar 2017
--
-- Copyright (C) 2016 - 2017 Blacksheep - RC-Devil
--
-- @Informations:
--[[
-- ############################################################################################################################################# --
	This Entrys is only used for Fruitpreparing for Earthfruits eg. Potato, Sugarbeet, etc.
	  minPreparingGrowthState="4" maxPreparingGrowthState="6" preparedGrowthState="9"
	  
	  For Spreader added new Entries: 
	  useForSpray="false" let it to false to use it not for spreader or sprayer, it is set to true, to use it for.
	  sprayerCategorys="manureSpreader spreader sprayer" Possible entries: manureSpreader spreader sprayer
	  
	  FruitGroups: grainHeader maizeHeader maizeCutter directCutter pickup sowingMachine planter weeder
	  FillTypeCaregorys: bulk liquid windrow piece combine forageHarvester forageWagon slurryTank manureSpreader spreader sprayer fork trainWagon augerWagon
	
	This is an example part for set in the modDesc.xml
	
	<AdditionalMapTypes hudsDirectory="fruitHuds/" groundTipDirectory="tipOnGround/">
	  <!--<newFruitCategory name="food" />  Examples for Register New FruitType Categorys -->
	  <!--<newFillCategory name="industry" />  Examples for Register New FillType Categorys -->
	  <!--<newAnimalfoodgroup animalname="sheep" groupname="bulk" weight="0.50" filltypename="silage"/>  Examples for Register New Animal FoodGroup with Fruit as Food -->
	  
	  <!-- massPerLiter bei klee_windrow 350 strawName="klee_windrow" fillTypeConversion="true" convertType="klee_windrow"
	       massPerLiter bei luzerne_windrow 350 strawName="luzerne_windrow" fillTypeConversion="true" convertType="luzerne_windrow"-->
		
		<!-- Example for Carrot   
		   <fruitType name="carrot" needsSeeding="true" allowsSeeding="true" useSeedingWidth="false" directionSnapAngle="0" alignsToSun="false" minHarvestingGrowthState="5" maxHarvestingGrowthState="7" cutState="8" allowsPartialGrowthState="false" pricePerLiter="0.41" literPerSqm="1.3" seedUsagePerSqm="0.05" showOnPriceTable="true" shownOnMap="true" massPerLiter="400" maxPhysicalSurfaceAngle="22.5" useForFieldJob="true" minForageGrowthState="3" witheringNumGrowthStates="8" numGrowthStates="7" growthStateTime="28800000" resetsSpray="true" groundTypeChangeGrowthState="-1" groundTypeChanged="0" isEarthfruit="true" preparedHaulm="carrot_haulm" minPreparingGrowthState="1" maxPreparingGrowthState="7" preparedGrowthState="6" hasWindrow="false" windrowPricePerLiter="0.04" windrowLiterPerSqm="5" windrowShowOnPriceTable="true" windrowMassPerLiter="0.0003" windrowMaxPhysicalSurfaceAngle="50" hasStraw="false" strawName="straw" strawFactor="7.0" hasFill="true" hasMaterials="true" hasParticles="true" useHeap="true" toFillCategorys="true" fillTypeCategorys="bulk combine forageHarvester forageWagon fork trainWagon augerWagon" toFruitGroups="true" fruitTypeGroups="planter grainHeader directCutter" useAsCowBasefeed="false" useAsCowGrass="false" useAsCowPower="false" useAsSheepGrass="false" useAsPigBasefeed="false" useAsPigGrain="false" useAsPigProtein="false" useAsPigEarthfruit="false" />
	 -->	  

	  <fruitType name="oat" needsSeeding="true" allowsSeeding="true" useSeedingWidth="false" directionSnapAngle="0" alignsToSun="false" minHarvestingGrowthState="5" maxHarvestingGrowthState="7" cutState="8" allowsPartialGrowthState="false" pricePerLiter="0.31" literPerSqm="1.2" seedUsagePerSqm="0.05" showOnPriceTable="true" shownOnMap="true" massPerLiter="640" maxPhysicalSurfaceAngle="22.5" useForFieldJob="true" minForageGrowthState="3" witheringNumGrowthStates="8" numGrowthStates="7" growthStateTime="28800000" resetsSpray="true" groundTypeChangeGrowthState="-1" groundTypeChanged="0" isEarthfruit="false" minPreparingGrowthState="1" maxPreparingGrowthState="7" preparedGrowthState="6" hasWindrow="true" windrowPricePerLiter="0.04" windrowLiterPerSqm="5" windrowShowOnPriceTable="false" windrowMassPerLiter="250" windrowMaxPhysicalSurfaceAngle="50" hasStraw="true" strawName="straw" strawFactor="7.0" hasFill="true" hasMaterials="true" hasParticles="true" useHeap="true" toFillCategorys="true" fillTypeCategorys="bulk combine forageHarvester forageWagon fork trainWagon augerWagon" toFruitGroups="true" fruitTypeGroups="sowingmachine grainHeader directCutter" useAsCowBasefeed="false" useAsCowGrass="false" useAsCowPower="false" useAsSheepGrass="false" useAsPigBasefeed="false" useAsPigGrain="false" useAsPigProtein="false" useAsPigEarthfruit="false" fillTypeConversion="true" convertType="chaff" conversionFactor="4" windrowConversionFactor="1" forageWagonConversion="wheat" />
	  <fruitType name="rye" needsSeeding="true" allowsSeeding="true" useSeedingWidth="false" directionSnapAngle="0" alignsToSun="false" minHarvestingGrowthState="5" maxHarvestingGrowthState="7" cutState="8" allowsPartialGrowthState="false" pricePerLiter="0.31" literPerSqm="1.2" seedUsagePerSqm="0.05" showOnPriceTable="true" shownOnMap="true" massPerLiter="720" maxPhysicalSurfaceAngle="22.5" useForFieldJob="true" minForageGrowthState="3" witheringNumGrowthStates="8" numGrowthStates="7" growthStateTime="28800000" resetsSpray="true" groundTypeChangeGrowthState="-1" groundTypeChanged="0" isEarthfruit="false" minPreparingGrowthState="1" maxPreparingGrowthState="7" preparedGrowthState="6" hasWindrow="true" windrowPricePerLiter="0.04" windrowLiterPerSqm="5" windrowShowOnPriceTable="false" windrowMassPerLiter="250" windrowMaxPhysicalSurfaceAngle="50" hasStraw="true" strawName="straw" strawFactor="7.0" hasFill="true" hasMaterials="true" hasParticles="true" useHeap="true" toFillCategorys="true" fillTypeCategorys="bulk combine forageHarvester forageWagon fork trainWagon augerWagon" toFruitGroups="true" fruitTypeGroups="sowingmachine grainHeader directCutter" useAsCowBasefeed="false" useAsCowGrass="false" useAsCowPower="false" useAsSheepGrass="false" useAsPigBasefeed="false" useAsPigGrain="false" useAsPigProtein="false" useAsPigEarthfruit="false" fillTypeConversion="true" convertType="chaff" conversionFactor="4" windrowConversionFactor="1" forageWagonConversion="wheat" />
	  <fruitType name="spelt" needsSeeding="true" allowsSeeding="true" useSeedingWidth="false" directionSnapAngle="0" alignsToSun="false" minHarvestingGrowthState="5" maxHarvestingGrowthState="7" cutState="8" allowsPartialGrowthState="false" pricePerLiter="0.31" literPerSqm="1.2" seedUsagePerSqm="0.05" showOnPriceTable="true" shownOnMap="true" massPerLiter="640" maxPhysicalSurfaceAngle="22.5" useForFieldJob="true" minForageGrowthState="3" witheringNumGrowthStates="8" numGrowthStates="7" growthStateTime="28800000" resetsSpray="true" groundTypeChangeGrowthState="-1" groundTypeChanged="0" isEarthfruit="false" minPreparingGrowthState="1" maxPreparingGrowthState="7" preparedGrowthState="6" hasWindrow="true" windrowPricePerLiter="0.04" windrowLiterPerSqm="5" windrowShowOnPriceTable="false" windrowMassPerLiter="250" windrowMaxPhysicalSurfaceAngle="50" hasStraw="true" strawName="straw" strawFactor="7.0" hasFill="true" hasMaterials="true" hasParticles="true" useHeap="true" toFillCategorys="true" fillTypeCategorys="bulk combine forageHarvester forageWagon fork trainWagon augerWagon" toFruitGroups="true" fruitTypeGroups="sowingmachine grainHeader directCutter" useAsCowBasefeed="false" useAsCowGrass="false" useAsCowPower="false" useAsSheepGrass="false" useAsPigBasefeed="false" useAsPigGrain="false" useAsPigProtein="false" useAsPigEarthfruit="false" fillTypeConversion="true" convertType="chaff" conversionFactor="4" windrowConversionFactor="1" forageWagonConversion="wheat" />
	  <fruitType name="triticale" needsSeeding="true" allowsSeeding="true" useSeedingWidth="false" directionSnapAngle="0" alignsToSun="false" minHarvestingGrowthState="5" maxHarvestingGrowthState="7" cutState="8" allowsPartialGrowthState="false" pricePerLiter="0.31" literPerSqm="1.2" seedUsagePerSqm="0.05" showOnPriceTable="true" shownOnMap="true" massPerLiter="720" maxPhysicalSurfaceAngle="22.5" useForFieldJob="true" minForageGrowthState="3" witheringNumGrowthStates="8" numGrowthStates="7" growthStateTime="28800000" resetsSpray="true" groundTypeChangeGrowthState="-1" groundTypeChanged="0" isEarthfruit="false" minPreparingGrowthState="1" maxPreparingGrowthState="7" preparedGrowthState="6" hasWindrow="true" windrowPricePerLiter="0.04" windrowLiterPerSqm="5" windrowShowOnPriceTable="false" windrowMassPerLiter="250" windrowMaxPhysicalSurfaceAngle="50" hasStraw="true" strawName="straw" strawFactor="7.0" hasFill="true" hasMaterials="true" hasParticles="true" useHeap="true" toFillCategorys="true" fillTypeCategorys="bulk combine forageHarvester forageWagon fork trainWagon augerWagon" toFruitGroups="true" fruitTypeGroups="sowingmachine grainHeader directCutter" useAsCowBasefeed="false" useAsCowGrass="false" useAsCowPower="false" useAsSheepGrass="false" useAsPigBasefeed="false" useAsPigGrain="false" useAsPigProtein="false" useAsPigEarthfruit="false" fillTypeConversion="true" convertType="chaff" conversionFactor="4" windrowConversionFactor="1" forageWagonConversion="wheat" />
	  <fruitType name="millet" needsSeeding="true" allowsSeeding="true" useSeedingWidth="false" directionSnapAngle="0" alignsToSun="false" minHarvestingGrowthState="5" maxHarvestingGrowthState="7" cutState="8" allowsPartialGrowthState="false" pricePerLiter="0.31" literPerSqm="1.2" seedUsagePerSqm="0.05" showOnPriceTable="true" shownOnMap="true" massPerLiter="640" maxPhysicalSurfaceAngle="22.5" useForFieldJob="true" minForageGrowthState="3" witheringNumGrowthStates="8" numGrowthStates="7" growthStateTime="28800000" resetsSpray="true" groundTypeChangeGrowthState="-1" groundTypeChanged="0" isEarthfruit="false" minPreparingGrowthState="1" maxPreparingGrowthState="7" preparedGrowthState="6" hasWindrow="true" windrowPricePerLiter="0.04" windrowLiterPerSqm="5" windrowShowOnPriceTable="false" windrowMassPerLiter="250" windrowMaxPhysicalSurfaceAngle="50" hasStraw="true" strawName="straw" strawFactor="7.0" hasFill="true" hasMaterials="true" hasParticles="true" useHeap="true" toFillCategorys="true" fillTypeCategorys="bulk combine forageHarvester forageWagon fork trainWagon augerWagon" toFruitGroups="true" fruitTypeGroups="sowingmachine grainHeader directCutter" useAsCowBasefeed="false" useAsCowGrass="false" useAsCowPower="false" useAsSheepGrass="false" useAsPigBasefeed="false" useAsPigGrain="false" useAsPigProtein="false" useAsPigEarthfruit="false" fillTypeConversion="true" convertType="chaff" conversionFactor="4" windrowConversionFactor="1" forageWagonConversion="wheat" />
	  	  
	  <fillType name="seeds2" pricePerLiter="0.8" showOnPriceTable="true" litersPerSecond="0.0060" massPerLiter="350" useForSpray="false" sprayerCategorys="spreader manureSpreader" toCategorys="true" fillTypeCategorys="bulk" hasMaterials="true" hasParticles="true" useHeap="true" isCowBasefeed="false" isCowGrass="false" isCowPower="false" isCowWindrow="false" isCowLiquid="false" isSheepGrass="false" isSheepLiquid="false" isPigBasefeed="false" isPigGrain="false" isPigProtein="false" isPigEarthfruit="false" />
	  <fillType name="lime" pricePerLiter="0.8" showOnPriceTable="true" litersPerSecond="0.0060" massPerLiter="1000" useForSpray="true" sprayerCategorys="spreader manureSpreader" toCategorys="true" fillTypeCategorys="bulk liquid windrow piece combine forageHarvester forageWagon slurryTank fork trainWagon augerWagon" hasMaterials="true" hasParticles="true" useHeap="true" isCowBasefeed="false" isCowGrass="false" isCowPower="false" isCowWindrow="false" isCowLiquid="false" isSheepGrass="false" isSheepLiquid="false" isPigBasefeed="false" isPigGrain="false" isPigProtein="false" isPigEarthfruit="false" />
	  <fillType name="compost" pricePerLiter="0.8" showOnPriceTable="true" litersPerSecond="0.3244" massPerLiter="800" useForSpray="true" sprayerCategorys="manureSpreader" toCategorys="true" fillTypeCategorys="bulk liquid windrow piece combine forageHarvester forageWagon slurryTank fork trainWagon augerWagon" hasMaterials="true" hasParticles="true" useHeap="true" isCowBasefeed="false" isCowGrass="false" isCowPower="false" isCowWindrow="false" isCowLiquid="false" isSheepGrass="false" isSheepLiquid="false" isPigBasefeed="false" isPigGrain="false" isPigProtein="false" isPigEarthfruit="false" />
	  <fillType name="sand" pricePerLiter="0.8" showOnPriceTable="true" litersPerSecond="0.0060" massPerLiter="1000" useForSpray="false" sprayerCategorys="spreader" hasGroupUnknown="true" hasGroupBulk="true" hasGroupLiquid="false" hasGroupWindrow="false" hasGroupPiece="false" hasGroupCombine="false" hasGroupForageHarvester="false" hasGroupForageWagon="false" hasGroupSlurryTank="false" hasGroupFork="false" hasGroupTrainWagon="false" hasGroupAugerWagon="true" hasMaterials="true" hasParticles="true" useHeap="true" isCowBasefeed="false" isCowGrass="false" isCowPower="false" isCowWindrow="false" isCowLiquid="false" isSheepGrass="false" isSheepLiquid="false" isPigBasefeed="false" isPigGrain="false" isPigProtein="false" isPigEarthfruit="false" />

	  <!--<addFruitcategory name="wheat" toCategory="maizeheader" />  Examples for add Giants Fruits to new FruitType Categorys -->
	  <!--<addFillcategory name="fertilizer" toCategory="trainWagon" />  Examples for add Giants Fruits to new FillType Categorys -->
	</AdditionalMapTypes>
	
	Informations about the Texture Filenames
	Hud Texture Format: DTX5 256x256px and small DTX5 64x64px
	Hud Textures Filename-Format: 
    for FruitTypehuds: hud_fruit_rye.dds and hud_fruit_rye_small.dds 
	for FillTypehuds: hud_fill_sand.dds and hud_fill_sand_small.dds
	for Windrow Types: hud_oat_windrow.dds and hud_oat_windrow_small.dds
	
	GroundTip Texture Formats: 
	diffuse DTX5 use MipMap 512x512px
	normal DTX1 use MipMap 512x512px
	distance DTX1 use MipMap 256x256ps
	
	GroundTip Textures Filename-Format:
	for diffuse Textures: lime_diffuse.dds
	for normal Textures: lime_normal.dds
	for distance Textures: limeDistance_diffuse.dds
	
	Includes Samples for Fillplanes Materialholders and ParticleSystem

-- ############################################################################################################################################# --
--]]

--[[
For Debugging: 
set DebugEbene: 1; for Debug Lines from FruitTypes, 
set DebugEbene: 2; for Debug Lines from FillTypes, 
set DebugEbene: 3; for Debug Lines from New Categorys,
set DebugEbene: 4; for Debug Lines from Add Giants Fruit or FillTypes to Category,
set DebugEbene: 5; for Debug Lines from Register Animal FoodGroup with Fruit as Food,
set DebugEbene: 6; for Debug Lines from Animal Data Set,
set DebugEbene: 10; for Debug Lines from All.
--]]

local DebugEbene = 0;
local function getmdata(v) v="## "..v..": "; for i=1,table.getn(metadata) do local _,n=string.find(metadata[i],v);if n then return (string.sub (metadata[i], n+1)); end;end;end;
local function Debug(e,s,...) if e <= DebugEbene then print((getmdata("Title")).." v"..(getmdata("Version"))..": "..string.format(s,...)); end; end;
local function L(name) local t = getmdata("Title"); return g_i18n:hasText(t.."_"..name) and g_i18n:getText(t.."_"..name) or name; end


AdditionalMapTypes = {};

AdditionalMapTypes.version = '1.0.0.7';
AdditionalMapTypes.author = 'Blacksheep - RC-Devil';
AdditionalMapTypes.date = '07 Januar 2017';
local amtDir = g_currentModDirectory;

function AdditionalMapTypes:start(amtDir)

	 if self.initialized then 
	    return 
	 end;

	local amtDir = g_currentModDirectory;
	local xmlFilePath =  Utils.getFilename('modDesc.xml', amtDir);
	if fileExists(xmlFilePath) then
		local xmlFile = loadXMLFile('modDescXML', xmlFilePath);
		local key = 'modDesc.AdditionalMapTypes';
		if hasXMLProperty(xmlFile, key) then
			local hudsDirectory = getXMLString(xmlFile, key..'#hudsDirectory');
			local groundTipDirectory = getXMLString(xmlFile, key..'#groundTipDirectory');
			local hasHolders = Utils.getNoNil(getXMLBool(xmlFile, key..'#hasHolders'), false);
			if hudsDirectory ~= nil and groundTipDirectory ~= nil then
            if hudsDirectory:sub(-1) ~= '/' then
               hudsDirectory = hudsDirectory .. '/';
            end;
               hudsDirectory = amtDir .. hudsDirectory;
            if groundTipDirectory:sub(-1) ~= '/' then
            groundTipDirectory = groundTipDirectory .. '/';
         end;
            groundTipDirectory = amtDir .. groundTipDirectory;
		    self:registerFruitTypes(xmlFile, key, hudsDirectory, groundTipDirectory);
      else
         if hudsDirectory == nil then print('\\__ Error: AdditionalMapTypes could not find Huds Directory.');end;
         if groundTipDirectory == nil then print('\\__ Error: AdditionalMapTypes could not find GroundTip Directory.');end;
      end;
			Debug(-1,('\\__ AdditionalMapTypes V%s by %s from %s was loaded successful'):format(AdditionalMapTypes.version, AdditionalMapTypes.author, AdditionalMapTypes.date));
		end; 
		delete(xmlFile);
	end; 
	 self.initialized = true;
end;

function AdditionalMapTypes:registerFruitTypes(xmlFile, key, hudsDirectory, groundTipDirectory)
local amtDir = g_currentModDirectory;
Debug(-1,('\\__ AdditionalMapTypes V%s by %s from %s is loading'):format(AdditionalMapTypes.version, AdditionalMapTypes.author, AdditionalMapTypes.date));

-- Register New FruitType Categorys --
    local a = 0
	  while true do
		  local categoryKey = key .. ('.addNewFruitcategory(%d)'):format(a);
		  if not hasXMLProperty(xmlFile, categoryKey) then
			  break;
		  end;		 
		 local name = getXMLString(xmlFile, categoryKey..'#name');
		  if name == nil then
			  print(('\\__ Error: missing "name" attribute for newFruitcategory #%d in "AdditionalMapTypes". Adding FruitType eategory aborted.'):format(a));
			  break;
		  end;
		  local gameKey = 'FRUITTYPE_CATEGORY_' .. name:upper();
		  if FruitUtil[gameKey] == nil then
			 local newFruitcategory = {
				  name = name
				  };
			  local localName = newFruitcategory.name;
			  if g_i18n:hasText(newFruitcategory.name) then
				  localName = g_i18n:getText(newFruitcategory.name);
				  g_i18n.globalI18N.texts[newFruitcategory.name] = localName;
			  end;
			  local key = FruitUtil.registerFruitTypeCategory(newFruitcategory.name)
			  Debug(3,('\\_ FruitType Group %s Debug Start'):format(newFruitcategory.name));
			  Debug(3,('\\_ Adding FruitType Group %s (%s) Group Key[%s] '):format(localName, newFruitcategory.name, key));
			Debug(3,'\\___________________________________________________________________________________________'); 
			  a = a + 1
		  else
			  a = a + 1
			  print(('\\__ Error: FruitType Group %q already exists. "AdditionalMapTypes" will skip its registration.'):format(name));
		  end;
	 end;
	 
	-- Register New FillType Categorys -- 
    local b = 0
	  while true do
		  local categoryKey = key .. ('.addNewFillcategory(%d)'):format(b);
		  if not hasXMLProperty(xmlFile, categoryKey) then
			  break;
		  end;		 
		 local name = getXMLString(xmlFile, categoryKey..'#name');
		  if name == nil then
			  print(('\\__ Error: missing "name" attribute for newFillcategory #%d in "AdditionalMapTypes". Adding FillType Category aborted.'):format(b));
			  break;
		  end;
		  local gameKey = 'FILLTYPE_CATEGORY_' .. name:upper();
		  if FillUtil[gameKey] == nil then
			 local newFillcategory = {
				  name = name
				  };
			  local localName = newFillcategory.name;
			  if g_i18n:hasText(newFillcategory.name) then
				  localName = g_i18n:getText(newFillcategory.name);
				  g_i18n.globalI18N.texts[newFillcategory.name] = localName;
			  end;
			  local key = FillUtil.registerFillTypeCategory(newFillcategory.name)
			  Debug(3,('\\_ FillType Category %s Debug Start'):format(newFillcategory.name));
			  Debug(3,('\\_ Adding FillType Category %s (%s) Category Key [%s] '):format(localName, newFillcategory.name, key));
			Debug(3,'\\___________________________________________________________________________________________'); 
			  b = b + 1
		  else
			  b = b + 1
			  print(('\\__ Error: FillType Category %q already exists. "AdditionalMapTypes" will skip its registration.'):format(name));
		  end;
	 end;
	 
-- FRUITTYPES --
local c = 0
	while true do
		local fruitTypeKey = key .. ('.fruitType(%d)'):format(c);
		if not hasXMLProperty(xmlFile, fruitTypeKey) then
			break;
		end;
		local name = getXMLString(xmlFile, fruitTypeKey..'#name');
		if name == nil then
			print(('\\__ Error: missing "name" attribute for fruitType #%d in "AdditionalMapTypes". Adding fruitTypes aborted.'):format(c));
			break;
		end;
		local gameKey = 'FRUITTYPE_' .. name:upper();
		if FruitUtil[gameKey] == nil then
			local fruitType = {		
				name = name,
				needsSeeding =                   Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#needsSeeding'), true),
				allowsSeeding =                  Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#allowsSeeding'), true),
				useSeedingWidth =                Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#useSeedingWidth'), false),
				directionSnapAngle =             Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#directionSnapAngle'), 0),
				alignsToSun =                    Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#alignsToSun'), false),
				minHarvestingGrowthState =       Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#minHarvestingGrowthState'), 4),
				maxHarvestingGrowthState =       Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#maxHarvestingGrowthState'), 6),
				cutState =                       Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#cutState'), 8),
				allowsPartialGrowthState =       Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#allowsPartialGrowthState'), false),
				pricePerLiter =                  Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#pricePerLiter'), 0.31),
				literPerSqm =                    Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#literPerSqm'), 1.2),
				seedUsagePerSqm =                Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#seedUsagePerSqm'), 0.05),
				showOnPriceTable =               Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#showOnPriceTable'), true),
				shownOnMap =                     Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#shownOnMap'), true),
				massPerLiter = 			         Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#massPerLiter'), 550),
				maxPhysicalSurfaceAngle =        Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#maxPhysicalSurfaceAngle'), 15),
				useForFieldJob =                 Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#useForFieldJob'), false),
				minForageGrowthState =           Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#minForageGrowthState'), 3),
				witheringNumGrowthStates =       Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#witheringNumGrowthStates'), 8),
				numGrowthStates =                Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#numGrowthStates'), 7),
				growthStateTime =                Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#growthStateTime'), 7*3600000),
				resetsSpray =                    Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#resetsSpray'), true),
				groundTypeChangeGrowthState =    Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#groundTypeChangeGrowthState'), -1),
				groundTypeChanged =              Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#groundTypeChanged'), 0),
				isEarthfruit =                   Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#isEarthfruit'), false),
				minPreparingGrowthState =        Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#minPreparingGrowthState'), 5),
				maxPreparingGrowthState =        Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#maxPreparingGrowthState'), 5),
				preparedGrowthState =            Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#preparedGrowthState'), 9),				
				preparedHaulm =                  Utils.getNoNil(getXMLString(xmlFile, fruitTypeKey..'#preparedHaulm'), 'haulm'),				
				hasWindrow = 			         Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#hasWindrow'), false),
				windrowPricePerLiter =           Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#windrowPricePerLiter'), 0.048),
				windrowLiterPerSqm =             Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#windrowLiterPerSqm'), 4.37),
				windrowShowOnPriceTable =        Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#windrowShowOnPriceTable'), false),
				windrowMassPerLiter =            Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#windrowMassPerLiter'), 250),
				windrowMaxPhysicalSurfaceAngle = Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#windrowMaxPhysicalSurfaceAngle'), 50),
				hasFill = 			             Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#hasFill'), false),
				hasStraw = 			             Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#hasStraw'), false),
				strawName =                      Utils.getNoNil(getXMLString(xmlFile, fruitTypeKey..'#strawName'), 'straw'),
				strawFactor =                    Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#strawFactor'), 7.0),
				toFillCategorys =                Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#toFillCategorys'), false),
				fillTypeCategorys =              Utils.getNoNil(getXMLString(xmlFile, fruitTypeKey..'#fillTypeCategorys'), 'bulk'),
				hasMaterials = 			         Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#hasMaterials'), false),
				hasParticles = 			         Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#hasParticles'), false),
				useHeap = 			             Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#useHeap'), false),
				toFruitGroups =                  Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#toFruitGroups'), false),
				fruitTypeGroups =                Utils.getNoNil(getXMLString(xmlFile, fruitTypeKey..'#fruitTypeGroups'), 'grainHeader'),
				useAsCowBasefeed = 			     Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#useAsCowBasefeed'), false),
				useAsCowGrass = 			     Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#useAsCowGrass'), false),
				useAsCowPower = 			     Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#useAsCowPower'), false),
				useAsSheepGrass = 			     Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#useAsSheepGrass'), false),
				useAsPigBasefeed = 			     Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#useAsPigBasefeed'), false),
				useAsPigGrain = 			     Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#useAsPigGrain'), false),
				useAsPigProtein = 			     Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#useAsPigProtein'), false),
				useAsPigEarthfruit = 		     Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#useAsPigEarthfruit'), false),
				fillTypeConversion =             Utils.getNoNil(getXMLBool(xmlFile, fruitTypeKey..'#fillTypeConversion'), false),
				convertType =                    Utils.getNoNil(getXMLString(xmlFile, fruitTypeKey..'#convertType'), 'chaff'),
				conversionFactor =               Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#conversionFactor'), 4),
				windrowConversionFactor =        Utils.getNoNil(getXMLFloat(xmlFile, fruitTypeKey..'#windrowConversionFactor'), 1),				
				forageWagonConversion =          getXMLString(xmlFile, fruitTypeKey..'#forageWagonConversion')
				};	  
			local localName = fruitType.name;
			if g_i18n:hasText(fruitType.name) then
				localName = g_i18n:getText(fruitType.name);
				g_i18n.globalI18N.texts[fruitType.name] = localName;
			end;
			Debug(1,('\\_ FruitType %s Debug Start'):format(fruitType.name));
			local hudFile = ('%shud_fruit_%s.dds'):format(hudsDirectory, fruitType.name);
			local hudFile_small = ('%shud_fruit_%s_small.dds'):format(hudsDirectory, fruitType.name);			
			if not fileExists(Utils.getFilename(hudFile_small, self.amtDir)) then				
				print("\\__ "..hudFile_small.." These are *not* 100%, please check your huds directory or your hud file")
				hudFile_small = hudFile;
			end;
			local key = FruitUtil.registerFruitType(fruitType.name, localName, nil, fruitType.needsSeeding, fruitType.allowsSeeding, fruitType.useSeedingWidth, fruitType.directionSnapAngle, fruitType.alignsToSun, fruitType.minHarvestingGrowthState, fruitType.maxHarvestingGrowthState, fruitType.cutState, fruitType.allowsPartialGrowthState, fruitType.pricePerLiter, fruitType.literPerSqm, fruitType.seedUsagePerSqm, fruitType.showOnPriceTable, hudFile, hudFile_small, fruitType.shownOnMap, fruitType.massPerLiter * 0.000001* 0.5, math.rad(fruitType.maxPhysicalSurfaceAngle), fruitType.useForFieldJob, fruitType.minForageGrowthState);
			if key ~= nil then
			Debug(1,('\\__ Register FruitType: %s (%s) [key %s]'):format(localName, fruitType.name, tostring(key)));
			local frInKey = 'FRUITTYPE_' .. name:upper();
			FruitUtil.fruitIndexToDesc[FruitUtil[frInKey]].pricePerLiter = fruitType.pricePerLiter;
			Debug(1,('\\_______ FruitType %s (%s) [Base-Price %s]'):format(localName, fruitType.name, fruitType.pricePerLiter));
			end;			
			local key = FruitUtil.registerFruitTypeGrowth(fruitType.name, fruitType.witheringNumGrowthStates, fruitType.numGrowthStates, fruitType.growthStateTime, fruitType.resetsSpray, fruitType.groundTypeChangeGrowthState, fruitType.groundTypeChanged);
			if key ~= nil then
			Debug(1,('\\__ Register Growth: %s (%s) [key %s]'):format(localName, fruitType.name, tostring(key)));
			end;
			if fruitType.isEarthfruit ~= false then
			local prepKey = 'FRUITTYPE_' .. name:upper();
			FruitUtil.registerFruitTypePreparing(FruitUtil[prepKey], fruitType.preparedHaulm, fruitType.minPreparingGrowthState, fruitType.maxPreparingGrowthState, fruitType.preparedGrowthState);
			Debug(1,('\\__ Register Preparing: %s (%s) to %s [key %s]'):format(localName, fruitType.name, fruitType.preparedHaulm, tostring(key)));
			end		
			if fruitType.fillTypeConversion ~= false then
				local frPrKey = 'FRUITTYPE_' .. name:upper();
				local frDsKey = 'FILLTYPE_' .. string.upper(fruitType.convertType);
				FruitUtil.addFruitToFillTypeConversion(FruitUtil.FRUITTYPE_CONVERTER_FORAGEHARVESTER, FruitUtil[frPrKey], FillUtil[frDsKey], fruitType.conversionFactor, fruitType.windrowConversionFactor);
				Debug(1,('\\_______ Added FruitType: %s (%s) to ForageHarvester Conversion'):format(localName, fruitType.name));
			end
			if fruitType.hasWindrow ~= false then
				local windrowName = fruitType.name.."_windrow";
				local localName = windrowName;
				-- if g_i18n:hasText(g_i18n:hasText(windrowName)) then
					-- localName = g_i18n:hasText(windrowName);
				-- end;
				if g_i18n:hasText(windrowName) then
				localName = g_i18n:getText(windrowName);
				g_i18n.globalI18N.texts[windrowName] = localName;
			end;
				
				local whudFile = ('%shud_%s.dds'):format(hudsDirectory, windrowName);
				local whudFile_small = ('%shud_%s_small.dds'):format(hudsDirectory, windrowName);
				if not fileExists(Utils.getFilename(whudFile_small, self.amtDir)) then
					print("\\__ "..whudFile_small.." These are *not* 100%, please check your huds directory or your hud file")
					whudFile_small = whudFile;
				end;
				local prepKey = 'FRUITTYPE_' .. name:upper();								
				FruitUtil.registerFruitTypeWindrow(FruitUtil[prepKey], windrowName, localName, nil, fruitType.windrowPricePerLiter, fruitType.windrowLiterPerSqm, fruitType.windrowShowOnPriceTable, whudFile, whudFile_small, fruitType.windrowMassPerLiter * 0.000001* 0.5, math.rad(fruitType.windrowMaxPhysicalSurfaceAngle));
					if key ~= nil then
					Debug(1,('\\_____ Register windrowType: %s (%s)'):format(localName, windrowName));
					end;					
					local windKey = 'FILLTYPE_' .. name:upper() .. '_WINDROW';
					FillUtil.addFillTypeToCategory(FillUtil.FILLTYPE_CATEGORY_WINDROW, FillUtil[windKey]);
					Debug(1,('\\_____ Added windrowType: %s (%s) to Windrow Category'):format(localName, windrowName));
					if fruitType.strawName ~= "straw" then
					local tpWindKey = 'FILLTYPE_' .. string.upper(fruitType.name) .. '_WINDROW';
					local fillsKey = 'FILLTYPE_' .. name:upper();
					local wnFtfKey = FillUtil.registerFillType(FillUtil[tpWindKey], localName, nil, fruitType.windrowPricePerLiter, fruitType.windrowShowOnPriceTable, whudFile, whudFile_small, fruitType.windrowMassPerLiter * 0.000001* 0.5, math.rad(fruitType.windrowMaxPhysicalSurfaceAngle));
					if wnFtfKey ~= nil then
					Debug(1,('\\_____ Register windrowType: %s (%s) as FillType'):format(localName, windrowName));
					end;					
					local tipgDiff = ('%s%s_diffuse.dds'):format(groundTipDirectory, windrowName);
					local tipgNorm = ('%s%s_normal.dds'):format(groundTipDirectory, windrowName);
					local tipgDist = ('%s%sDistance_diffuse.dds'):format(groundTipDirectory, windrowName);
					if not fileExists(Utils.getFilename(tipgDiff, self.amtDir)) then
					print("\\__ "..tipgDiff.." not found. Please Check the Directory and File");
					end;
					if not fileExists(Utils.getFilename(tipgNorm, self.amtDir)) then
					print("\\__ "..tipgNorm.." not found. Please Check the Directory and File");
					end;
					if not fileExists(Utils.getFilename(tipgDist, self.amtDir)) then
					print("\\__ "..tipgDist.." not found. Please Check the Directory and File");
					end;
					TipUtil.registerDensityMapHeightType(FillUtil[tpWindKey], math.rad(35), 0.35, 0.10, 0.10, 1.20, 6, false, tipgDiff, tipgNorm, tipgDist);
					Debug(1,('\\_____ Register TipOnGround DensityMapHeightType: %s (%s)'):format(localName, windrowName));
					end;
					if fruitType.hasStraw ~= false then
					local strawKey = 'FRUITTYPE_' .. name:upper();
					local strawType = 'FILLTYPE_' .. string.upper(fruitType.strawName);
					FruitUtil.setFruitTypeWindrow(FruitUtil[strawKey], FillUtil[strawType], fruitType.strawFactor);
					Debug(1,('\\_____ Register windrowType: %s (%s) as Straw'):format(localName, windrowName));
					Debug(1,('\\_______ Set Fruit to StrawType: %s (%s) %s with Factor %s'):format(localName, windrowName, string.upper(fruitType.strawName), fruitType.strawFactor));
					end;
					if fruitType.forageWagonConversion ~= nil then
				        local prepKey = 'FRUITTYPE_' .. name:upper();
						local target = 'FRUITTYPE_' .. string.upper(fruitType.forageWagonConversion);
					if fruitType.forageWagonConversion ~= nil then						
							FruitUtil.registerFruitTypeWindrowForageWagonConversion(FruitUtil[prepKey], FruitUtil[target]);
							Debug(1,('\\_______ Register ForageWagonConversion: %s -> %s'):format(windrowName, fruitType.forageWagonConversion));
							local fillsKey = 'FILLTYPE_' .. name:upper();
							FillUtil.addFillTypeToCategory(FillUtil.FILLTYPE_CATEGORY_FORAGEWAGON, FillUtil[fillsKey]);
							Debug(1,('\\_______ Added windrowType: %s (%s) to ForageWagons Category'):format(localName, windrowName));							
					else
							print("Error: incorrect target for ForageWagonConversion: "..target);
					end
				end
			end;
			
		--Register FruitTypes to FillTypes-- 
		if fruitType.hasFill ~= false then			    
			local fhudFile = ('%shud_fruit_%s.dds'):format(hudsDirectory, fruitType.name);
			local fhudFile_small = ('%shud_fruit_%s_small.dds'):format(hudsDirectory, fruitType.name);			
			if not fileExists(Utils.getFilename(fhudFile_small, self.amtDir)) then				
				print("\\__ "..fhudFile_small.." These are *not* 100%, please check your huds directory or your hud file");
				fhudFile_small = fhudFile;
			end;				
				local fillsKey = 'FILLTYPE_' .. name:upper();
			    local ftfKey = FillUtil.registerFillType(fruitType.name, localName, nil, fruitType.pricePerLiter, fruitType.showOnPriceTable, fhudFile, fhudFile_small, fruitType.massPerLiter * 0.000001* 0.5, math.rad(fruitType.maxPhysicalSurfaceAngle));
				Debug(1,('\\____ Register FillType: %s (%s) [key %s] for FruitType %s'):format(localName, fruitType.name, tostring(ftfKey), fruitType.name));
				
				--Add FillTypes to Categorys--
			if fruitType.toFillCategorys then
			     local fillTypeCategorys = Utils.splitString(" ", fruitType.fillTypeCategorys);
				 for _, fillTypeCategory in pairs(fillTypeCategorys) do
				    typeCat = "FILLTYPE_CATEGORY_" .. string.upper(fillTypeCategory);
				 if FillUtil[typeCat] then
				 FillUtil.addFillTypeToCategory(FillUtil[typeCat], FillUtil[fillsKey]);
				 Debug(1,('\\_______ Added FillType: %s (%s) to %s Category'):format(localName, fruitType.name, fillTypeCategory));
				 else
				 print('\\_______ ERROR: The FillType Category: %s are not exists!. "AdditionalMapTypes" will Aborting adding the FillType to the specified Category!'):format(fillTypeCategory);
				 end;
				 end;
			  end;
			  
			 -- Register MaterialType --
			  if fruitType.hasMaterials ~= false then
			     MaterialUtil.registerMaterialType(FillUtil[fillsKey]);
				 Debug(1,('\\_____ Register Materials for FillType: %s (%s)'):format(localName, fruitType.name));
			  end;	
			  
			  -- Register Particles --
			  if fruitType.hasParticles ~= false then
			     MaterialUtil.registerParticleType(FillUtil[fillsKey]);
				 Debug(1,('\\_____ Register Particles for FillType: %s (%s)'):format(localName, fruitType.name));
			  end;	
			  
			--Register FruitTypes at Food Groups for Animals			
			--Cow Groups  
			if fruitType.useAsCowBasefeed ~= false then
				FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_COW, 2, FillUtil[fillsKey]);
				Debug(1,('\\_____ Register FillType: %s (%s) as BaseFood for Cows'):format(localName, fruitType.name));
            end;
			if fruitType.useAsCowGrass ~= false then
				FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_COW, 1, FillUtil[fillsKey]);
				Debug(1,('\\_____ Register FillType: %s (%s) to Grass for Cows'):format(localName, fruitType.name));
            end;
			if fruitType.useAsCowPower ~= false then
				FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_COW, 3, FillUtil[fillsKey]);
				Debug(1,('\\_____ Register FillType: %s (%s) as PowerFood for Cows'):format(localName, fruitType.name));
            end;			
			-- Sheep Groups
			if fruitType.useAsSheepGrass ~= false then
				FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_SHEEP, 1, FillUtil[fillsKey]);
				Debug(1,('\\_____ Register FillType: %s (%s) as Grass for Sheeps'):format(localName, fruitType.name));
            end;						
			-- Pig Groups
			if fruitType.useAsPigBasefeed ~= false then
				FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_PIG, 1, FillUtil[fillsKey]);
				Debug(1,('\\_____ Register FillType: %s (%s) as BaseFood for Pigs'):format(localName, fruitType.name));
            end;
			if fruitType.useAsPigGrain ~= false then
				FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_PIG, 2, FillUtil[fillsKey]);
				Debug(1,('\\_____ Register FillType: %s (%s) as GrainFood for Pigs'):format(localName, fruitType.name));
            end;
			if fruitType.useAsPigProtein ~= false then
				FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_PIG, 3, FillUtil[fillsKey]);
				Debug(1,('\\_____ Register FillType: %s (%s) as ProteinFood for Pigs'):format(localName, fruitType.name));
            end;
			if fruitType.useAsPigEarthfruit ~= false then
				FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_PIG, 4, FillUtil[fillsKey]);
				Debug(1,('\\_____ Register FillType: %s (%s) as EarthfruitFood for Pigs'):format(localName, fruitType.name));
            end;
			-- If Register any Type vor Chickens, then is the Index AnimalUtil.ANIMAL_CHICKEN
			-- Register fruitTypes at Food Groups for Animals End			
		end;	
		
			 -- Register Tip to Ground DensityMap for Fruit to FillTypes --
			if fruitType.useHeap ~= false then			
			local tipgDiff = ('%s%s_diffuse.dds'):format(groundTipDirectory, fruitType.name);
			local tipgNorm = ('%s%s_normal.dds'):format(groundTipDirectory, fruitType.name);
			local tipgDist = ('%s%sDistance_diffuse.dds'):format(groundTipDirectory, fruitType.name);			
			if not fileExists(Utils.getFilename(tipgDiff, self.amtDir)) then				
				print("\\__ "..tipgDiff.." not found. Please Check the Directory and File");
			end;
			if not fileExists(Utils.getFilename(tipgNorm, self.amtDir)) then				
				print("\\__ "..tipgNorm.." not found. Please Check the Directory and File");
			end;
			if not fileExists(Utils.getFilename(tipgDist, self.amtDir)) then				
				print("\\__ "..tipgDist.." not found. Please Check the Directory and File");
			end;			
    			local fillsKey = 'FILLTYPE_' .. name:upper();
			    TipUtil.registerDensityMapHeightType(FillUtil[fillsKey], math.rad(30), 1.0, 0.08, 0.00, 0.08, 1, false, tipgDiff, tipgNorm, tipgDist);
				Debug(1,('\\_____ Register TipOnGround DensityMapHeightType: %s (%s)'):format(localName, fruitType.name));
			end;
			
			 -- Add FruitType to Category--			 
			if fruitType.toFruitGroups then
			     local fruitTypeGroups = Utils.splitString(" ", fruitType.fruitTypeGroups);
				 for _, fruitTypeGroup in pairs(fruitTypeGroups) do
				    fruitGroup = "FRUITTYPE_CATEGORY_" .. string.upper(fruitTypeGroup);
				 if FruitUtil[fruitGroup] then
				 FruitUtil.addFruitTypeToCategory(FruitUtil[fruitGroup], FruitUtil[gameKey]);
				 Debug(1,('\\_______ Added FruitType: %s (%s) to %s FruitType Category'):format(localName, fruitType.name, fruitTypeGroup));
				 else
				 print('\\_______ ERROR: The FruitType Category: %s are not exists!. "AdditionalMapTypes" will Aborting adding the FruitType to the specified Category!'):format(fruitTypeGroup);
				 end;
				 end;
			  end;			
			Debug(1,('\\_ FruitType %s Debug Ende'):format(fruitType.name));
			Debug(1,'\\__________________________________________________________________________________');
			c = c + 1
		else
			c = c + 1
			print(('fruit type %q already exists. "AdditionalMapTypes" will skip its registration.'):format(name));
		end;
	end;
	
-- FILLTYPES --
	  local e = 0
	  while true do
		  local fillTypeKey = key .. ('.fillType(%d)'):format(e);
		  if not hasXMLProperty(xmlFile, fillTypeKey) then
			  break;
		  end;		 
		 local name = getXMLString(xmlFile, fillTypeKey..'#name');
		  if name == nil then
			  print(('\\__ Error: missing "name" attribute for fillType #%d in "AdditionalMapTypes". Adding fillTypes aborted.'):format(e));
			  break;
		  end;
		  local gameKey = 'FILLTYPE_' .. name:upper();
		  if FillUtil[gameKey] == nil then
			 local fillType = {
				  name = name,
				  pricePerLiter =            Utils.getNoNil(getXMLFloat(xmlFile, fillTypeKey..'#pricePerLiter'), 0.8),
				  showOnPriceTable =         Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#showOnPriceTable'), false),
				  litersPerSecond =          Utils.round(Utils.getNoNil(getXMLFloat(xmlFile, fillTypeKey..'#litersPerSecond'), 0.0081), 3),
				  massPerLiter = 			 Utils.getNoNil(getXMLFloat(xmlFile, fillTypeKey..'#massPerLiter'), 350),
				  maxPhysicalSurfaceAngle =  Utils.getNoNil(getXMLFloat(xmlFile, fillTypeKey..'#maxPhysicalSurfaceAngle'), math.rad(20)),				  
				  useForSpray =              Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#useForSpray'), false),
				  sprayerCategorys =         Utils.getNoNil(getXMLString(xmlFile, fillTypeKey..'#sprayerCategorys'), 'spreader'),
				  toCategorys =              Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#toCategorys'), false),
				  fillTypeCategorys =        Utils.getNoNil(getXMLString(xmlFile, fillTypeKey..'#fillTypeCategorys'), 'bulk'),
				  hasMaterials =             Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#hasMaterials'), false),
				  hasParticles =             Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#hasParticles'), false),
				  useHeap =            	     Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#useHeap'), false),
				  isCowBasefeed =            Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#isCowBasefeed'), false),
				  isCowGrass =            	 Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#isCowGrass'), false),
				  isCowPower =            	 Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#isCowPower'), false),
				  isCowWindrow =             Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#isCowWindrow'), false),
				  isCowLiquid =            	 Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#isCowLiquid'), false),
				  isSheepGrass =             Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#isSheepGrass'), false),
				  isSheepLiquid =            Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#isSheepLiquid'), false),
				  isPigBasefeed =            Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#isPigBasefeed'), false),
				  isPigGrain =            	 Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#isPigGrain'), false),
				  isPigProtein =             Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#isPigProtein'), false),
				  isPigEarthfruit =          Utils.getNoNil(getXMLBool(xmlFile, fillTypeKey..'#isPigEarthfruit'), false)
				  };
			  local localName = fillType.name;
			  if g_i18n:hasText(fillType.name) then
				  localName = g_i18n:getText(fillType.name);
				  g_i18n.globalI18N.texts[fillType.name] = localName;
			  end;
			  Debug(2,('\\_ FillType %s Debug Start'):format(fillType.name));
			  local fhudFile = ('%shud_fill_%s.dds'):format(hudsDirectory, fillType.name);
			  local fhudFile_small = ('%shud_fill_%s_small.dds'):format(hudsDirectory, fillType.name);
			  if not fileExists(Utils.getFilename(fhudFile_small, self.amtDir)) then
			  	  print("\\__ "..fhudFile_small.." These are *not* 100%, please check your huds directory or your hud file");
			  fhudFile_small = fhudFile;
			  end;			 
			  local key = FillUtil.registerFillType(fillType.name, localName, 0, fillType.pricePerLiter, fillType.showOnPriceTable, ('%shud_fill_%s.dds'):format(hudsDirectory, fillType.name), ('%shud_fill_%s_small.dds'):format(hudsDirectory, fillType.name), fillType.massPerLiter * 0.000001* 0.5, fillType.maxPhysicalSurfaceAngle);
			  if key ~= nil then
			  Debug(2,('\\__ Register FillType: %s (%s) [key %s]'):format(localName, fillType.name, tostring(key)));
			  local fillInKey = 'FILLTYPE_' .. string.upper(fillType.name);
			  FillUtil.fillTypeIndexToDesc[FillUtil[fillInKey]].pricePerLiter = fillType.pricePerLiter;
			  Debug(2,('\\_______ FillType %s (%s) [Base-Price %s]'):format(localName, fillType.name, fillType.pricePerLiter));
			  end;
			  
			  -- Add FillTypes to FillType Category --			  
			  if fillType.useForSpray then
			    local spTypeKey = "SPRAYTYPE_" .. string.upper(fillType.name);
				 if Sprayer[spTypeKey] == nil then
				 Sprayer.registerSprayType(fillType.name, localName, nil, fillType.pricePerLiter, fillType.litersPerSecond, fillType.showOnPriceTable, ('%shud_fill_%s.dds'):format(hudsDirectory, fillType.name), ('%shud_fill_%s_small.dds'):format(hudsDirectory, fillType.name), fillType.massPerLiter);
				 Debug(2,('\\__ Register SprayType: %s (%s)'):format(localName, fillType.name));
				else
					print('\\__ Error: SprayType %s (%s), already exists. "AdditionalMapTypes", will skip this registration.'):format(localName, fillType.name);
				end;
				local sprayerCategorys = Utils.splitString(" ", fillType.sprayerCategorys);				
				for _, sprayerCategory in pairs(sprayerCategorys) do
				    sprayCat = "FILLTYPE_CATEGORY_" .. string.upper(sprayerCategory);				
				    if FillUtil[sprayCat] then
					    FillUtil.addFillTypeToCategory(FillUtil[sprayCat], FillUtil[gameKey]);
					    Debug(2,('\\_______ Added SprayType: %s (%s) to %s Category'):format(localName, fillType.name, sprayerCategory));
				    else
					    print('\\_______ ERROR: The Sprayercategory: %s are not exists!. "AdditionalMapTypes" will Aborting adding the Spraytype to the specified category!'):format(sprayerCategory);
			        end;
				end;
			  end;			  
			  if fillType.toCategorys then
			     local fillTypeCategorys = Utils.splitString(" ", fillType.fillTypeCategorys);
				 for _, fillTypeCategory in pairs(fillTypeCategorys) do
				    typeCat = "FILLTYPE_CATEGORY_" .. string.upper(fillTypeCategory);
				 if FillUtil[typeCat] then
				 FillUtil.addFillTypeToCategory(FillUtil[typeCat], FillUtil[gameKey]);
				 Debug(2,('\\_______ Added FillType: %s (%s) to %s Category'):format(localName, fillType.name, fillTypeCategory));
				 else
				 print('\\_______ ERROR: The FillTypecategory: %s are not exists!. "AdditionalMapTypes" will Aborting adding the FillType to the specified category!'):format(fillTypeCategory);
				 end;
				 end;
			  end;
			  
			 -- Register MaterialType --
			  local ftmt = "FILLTYPE_"..string.upper(fillType.name);
			  if fillType.hasMaterials and key ~= nil then
			  local key = MaterialUtil.registerMaterialType(FillUtil[ftmt]);
			  Debug(2,('\\_____ Register Materials for FillType: %s (%s)'):format(localName, fillType.name));
			  end;	
			  
			  -- Register Particles --
			  if fillType.hasParticles and key ~= nil then
			  local key = MaterialUtil.registerParticleType(FillUtil[ftmt]);
			  Debug(2,('\\_____ Register Particles for FillType: %s (%s)'):format(localName, fillType.name));
			  end;	
			  
			  -- Tip to Ground DensityMap for FillTypes--
			  if fillType.useHeap and key ~= nil then			 
			  local tipgDiff = ('%s%s_diffuse.dds'):format(groundTipDirectory, fillType.name);
			  local tipgNorm = ('%s%s_normal.dds'):format(groundTipDirectory, fillType.name);
			  local tipgDist = ('%s%sDistance_diffuse.dds'):format(groundTipDirectory, fillType.name);
			  if not fileExists(Utils.getFilename(tipgDiff, self.amtDir)) then
			  	  print("\\__ "..tipgDiff.." not found. Please Check the Directory and File");
			  end;
			  if not fileExists(Utils.getFilename(tipgNorm, self.amtDir)) then
			      Debug(-1,"\\__ "..tipgNorm.." not found. Please Check the Directory and File");
			  end;
			  if not fileExists(Utils.getFilename(tipgDist, self.amtDir)) then
			      print("\\__ "..tipgDist.." not found. Please Check the Directory and File");
			  end;			
    			local fillsKey = 'FILLTYPE_' .. name:upper();			 
			    TipUtil.registerDensityMapHeightType(FillUtil[fillsKey], math.rad(30), 1.0, 0.08, 0.00, 0.08, 1, false, tipgDiff, tipgNorm, tipgDist);
				Debug(2,('\\_____ Register TipOnGround DensityMapHeightType: %s (%s)'):format(localName, fillType.name));
			end;	
			
			 --Register FillTypes at Food Groups for Animals			
			 --Cow Groups Index 1
			if fillType.isCowBasefeed ~= false and key ~= nil then
				 local key = FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_COW, 2, key);
				 Debug(2,('\\_____ Register FillType: %s (%s) to Basefood for Cows'):format(localName, fillType.name));
            end;
			if fillType.isCowGrass ~= false and key ~= nil then
				 local key = FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_COW, 1, key);
				 Debug(2,('\\_____ Register FillType: %s (%s) as Grass for Cows'):format(localName, fillType.name));
            end;
			if fillType.isCowPower ~= false and key ~= nil then
				 local key = FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_COW, 3, key);
				 Debug(2,('\\_____ Register FillType: %s (%s) to Powerfood for Cows'):format(localName, fillType.name));
            end;						
			 -- Sheep Groups Index 2
			if fillType.isSheepGrass ~= false and key ~= nil then
				 local key = FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_SHEEP, 1, key);
				 Debug(2,('\\_____ Register FillType: %s (%s) as Grass for Sheeps'):format(localName, fillType.name));
            end;						
			 -- Pig Groups Index 3
			if fillType.isPigBasefeed ~= false and key ~= nil then
				 local key = FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_PIG, 1, key);
				 Debug(2,('\\_____ Register FillType: %s (%s) to Basefood for Pigs'):format(localName, fillType.name));
            end;
			if fillType.isPigGrain ~= false and key ~= nil then
				 local key = FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_PIG, 2, key);
				 Debug(2,('\\_____ Register FillType: %s (%s) to Grainfood for Pigs'):format(localName, fillType.name));
            end;
			if fillType.isPigProtein ~= false and key ~= nil then
				 local key = FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_PIG, 3, key);
				 Debug(2,('\\_____ Register FillType: %s (%s) to Proteinfood for Pigs'):format(localName, fillType.name));
            end;
			if fillType.isPigEarthfruit ~= false and key ~= nil then
				 local key = FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_PIG, 4, key);
				 Debug(2,('\\_____ Register FillType: %s (%s) as Earthfruit for Pigs'):format(localName, fillType.name));
            end;			
			 -- If Register any Type for Chickens, then is the Index AnimalUtil.ANIMAL_CHICKEN
			 -- Register FillTypes at Food Groups for Animals End
			Debug(2,('\\_ FillType %s Debug Ende'):format(fillType.name));
			Debug(2,'\\___________________________________________________________________________________________'); 
			  e = e + 1
		  else
			  e = e + 1
			  print(('\\__ Error: fill type %q already exists. "AdditionalMapTypes" will skip its registration.'):format(name));
		  end;
	 end;
	 
    -- Add Existing Giants FruitTypes to FruitCategorys --
    local f = 0
	  while true do
		  local toGroupKey = key .. ('.addToFruitcategory(%d)'):format(f);
		  if not hasXMLProperty(xmlFile, toGroupKey) then
			  break;
		  end;		 
		 local name = getXMLString(xmlFile, toGroupKey..'#name');
		 local toCategory = getXMLString(xmlFile, toGroupKey..'#toCategory');
		  if name == nil then
			  print(('\\__ Error: missing "name" attribute for addFruitcategory #%d in "AdditionalMapTypes". Adding FruitType Category aborted.'):format(f));
			  break;
		  end;
		  if toCategory == nil then
			  print(('\\__ Error: missing "toCategory" attribute for addFruitcategory #%d in "AdditionalMapTypes". Adding FruitType Category aborted.'):format(f));
			  break;
		  end;
			 local addFruitcategory = {
				  name = name,
				  toCategory = getXMLString(xmlFile, toGroupKey..'#toCategory')
				  };
			  local localName = addFruitcategory.name;
			  if g_i18n:hasText(addFruitcategory.name) then
				  localName = g_i18n:getText(addFruitcategory.name);
				  g_i18n.globalI18N.texts[addFruitcategory.name] = localName;
			  end;			  
			  local localNameCat = addFruitcategory.toCategory;
			  if g_i18n:hasText(addFruitcategory.toCategory) then
				  localNameCat = g_i18n:getText(addFruitcategory.toCategory);
				  g_i18n.globalI18N.texts[addFruitcategory.toCategory] = localNameCat;
			  end;
			  local frFruit = 'FRUITTYPE_' .. name:upper();
			  local frCat = 'FRUITTYPE_CATEGORY_' .. string.upper(addFruitcategory.toCategory);			  
			  FruitUtil.addFruitTypeToCategory(FruitUtil[frCat], FruitUtil[frFruit]);
			  Debug(4,('\\_ FruitType to Category %s Debug Start'):format(addFruitcategory.toCategory));
			  Debug(4,('\\_ Adding FruitType %s to Category (%s) '):format(localName, localNameCat));
			  Debug(4,'\\___________________________________________________________________________________________'); 
			  f = f + 1
	 end;
	 
    -- Add Existing Giants FillTypes to FillCategorys --
    local g = 0
	  while true do
		  local toGroupKey = key .. ('.addToFillcategory(%d)'):format(g);
		  if not hasXMLProperty(xmlFile, toGroupKey) then
			  break;
		  end;		 
		 local name = getXMLString(xmlFile, toGroupKey..'#name');
		 local toCategory = getXMLString(xmlFile, toGroupKey..'#toCategory');
		  if name == nil then
			  print(('\\__ Error: missing "name" attribute for addFillcategory #%d in "AdditionalMapTypes". Adding FillType Category aborted.'):format(g));
			  break;
		  end;
		  if toCategory == nil then
			  print(('\\__ Error: missing "toCategory" attribute for addFillcategory #%d in "AdditionalMapTypes". Adding FillType Category aborted.'):format(g));
			  break;
		  end;
			 local addFillcategory = {
				  name = name,
				  toCategory = getXMLString(xmlFile, toGroupKey..'#toCategory')
				  };
			  local localName = addFillcategory.name;
			  if g_i18n:hasText(addFillcategory.name) then
				  localName = g_i18n:getText(addFillcategory.name);
				  g_i18n.globalI18N.texts[addFillcategory.name] = localName;
			  end;
			  local localNameCat = addFillcategory.toCategory;
			  if g_i18n:hasText(addFillcategory.toCategory) then
				  localNameCat = g_i18n:getText(addFillcategory.toCategory);
				  g_i18n.globalI18N.texts[addFillcategory.toCategory] = localNameCat;
			  end;
			  local fiFill = 'FILLTYPE_' .. name:upper();
			  local fiCat = 'FILLTYPE_CATEGORY_' .. string.upper(addFillcategory.toCategory);
			  FillUtil.addFillTypeToCategory(FillUtil[fiCat], FillUtil[fiFill]);
			  Debug(4,('\\_ FillType to Category %s Debug Start'):format(addFillcategory.toCategory));
			  Debug(4,('\\_ Adding FillType %s to Category (%s) '):format(localName, localNameCat));
			  Debug(4,'\\___________________________________________________________________________________________'); 
			  g = g + 1
	 end;
	 
	 -- FoodGroups for Animals --
	  local h = 0
	  while true do
		  local animalFoodGroupKey = key .. ('.newAnimalfoodgroup(%d)'):format(h);
		  if not hasXMLProperty(xmlFile, animalFoodGroupKey) then
			  break;
		  end;		 
		 local animalname = getXMLString(xmlFile, animalFoodGroupKey..'#animalname');
		  if animalname == nil then
			  print(('\\__ Error: missing "animalname" attribute for animalfoodgroup #%d in "AdditionalMapTypes". Adding FoodGroup aborted.'):format(h));
			  break;
		  end;
		  local animalSet = "ANIMAL_"..string.upper(animalname);
		  	 local groupType = {
				  animalname = animalname,
				  groupname =  Utils.getNoNil(getXMLString(xmlFile, animalFoodGroupKey..'#groupname'), bulk),
				  weight =     Utils.getNoNil(getXMLFloat(xmlFile, animalFoodGroupKey..'#weight'), 0.50),
				  filltypenames =  Utils.getNoNil(getXMLString(xmlFile, animalFoodGroupKey..'#filltypenames'), wheat)
				  };
				  local localName = groupType.groupname;
				  if g_i18n:hasText(groupType.groupname) then
				  localName = g_i18n:getText(groupType.groupname);
				  g_i18n.globalI18N.texts[groupType.groupname] = localName;
				  end;
				  local foodGroupIndex = FillUtil.registerFoodGroup(AnimalUtil[animalSet], groupType.groupname, localName, groupType.weight)
				  local filltypename = Utils.splitString(" ", groupType.filltypenames);
				  for _, filltypename in pairs(filltypename) do				  
				  local foFill = 'FILLTYPE_'..string.upper(filltypename);				  
				  if AnimalUtil[animalSet] then
				  FillUtil.registerFillTypeInFoodGroup(AnimalUtil[animalSet], foodGroupIndex, FillUtil[foFill]);
				  end;
				  end;
				  Debug(5,('\\__ Register FoodGroup: %s for (%s)'):format(localName, groupType.animalname));
				  Debug(5,('\\_____ Added FillType: %s for (%s) at Group %s'):format(groupType.filltypenames, groupType.animalname, localName));
				  Debug(5,'\\___________________________________________________________________________________________'); 
			  h = h + 1
	 end;
end;

AdditionalMapTypes:start(amtDir);
