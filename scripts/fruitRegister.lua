FruitRegister = {};

function FruitRegister:load()
	--angles
	local wheatAngle = FillUtil.fillTypeNameToDesc.wheat.maxPhysicalSurfaceAngle;
	local woolAngle = FillUtil.fillTypeNameToDesc.wool.maxPhysicalSurfaceAngle;
	--categories
	local sacksNboxesCategory = FillUtil.registerFillTypeCategory("sacksNboxes");
	local liquidFoodsCategory = FillUtil.registerFillTypeCategory("liquidFoods");
	--insert default filltypes to new categories
	FillUtil.addFillTypeToCategory(sacksNboxesCategory, FillUtil.FILLTYPE_WOOL);
	FillUtil.addFillTypeToCategory(sacksNboxesCategory, FillUtil.FILLTYPE_SEEDS);
	FillUtil.addFillTypeToCategory(sacksNboxesCategory, FillUtil.FILLTYPE_FERTILIZER);
	FillUtil.addFillTypeToCategory(sacksNboxesCategory, FillUtil.FILLTYPE_LIQUIDFERTILIZER);
	FillUtil.addFillTypeToCategory(liquidFoodsCategory, FillUtil.FILLTYPE_WATER);
	FillUtil.addFillTypeToCategory(liquidFoodsCategory, FillUtil.FILLTYPE_MILK);
	local uiScale = g_gameSettings:getValue("uiScale");
	local levelIconWidth, levelIconHeight = getNormalizedScreenValues(16*uiScale, 20*uiScale);

	--barley
    local barleyTip = TipUtil.heightTypeIndexToHeightType[FillUtil.FILLTYPE_BARLEY];
	barleyTip.diffuseMapFilename = Utils.getFilename("maps/fillPlanes/barley_diffuse.dds", TrafficManager.curModDir);
	barleyTip.normalMapFilename = Utils.getFilename("maps/fillPlanes/barley_normal.dds", TrafficManager.curModDir);
	barleyTip.distanceFilename = Utils.getFilename("maps/fillPlanes/distance/barleyDistance_diffuse.dds", TrafficManager.curModDir);

	FruitUtil.registerFruitTypeGrowth("rye", 8, 7, 24000000, true, -1, 0);
    FruitUtil.registerFruitTypeGrowth("onion", 8, 7, 24000000, true, -1, 0);
    FruitUtil.registerFruitTypeGrowth("carrot", 8, 7, 24000000, true, -1, 0);
	-- rye
	local hudFile = Utils.getFilename("maps/scripts/huds/hud_fill_rye.dds", TrafficManager.curModDir);
	local hudFileSmall = Utils.getFilename("maps/scripts/huds/hud_fill_rye_sml.dds", TrafficManager.curModDir);
	local diffuseMap = Utils.getFilename("maps/fillPlanes/rye_diffuse.dds", TrafficManager.curModDir);
	local normalMap = Utils.getFilename("maps/fillPlanes/rye_normal.dds", TrafficManager.curModDir);
	local distanceMap = Utils.getFilename("maps/fillPlanes/distance/ryeDistance_diffuse.dds", TrafficManager.curModDir);
	local index = FruitUtil.registerFruitType("rye", g_i18n:getText("rye"), FillUtil.FILLTYPE_CATEGORY_BULK, true, true, false, 0, false, 4, 6, 8, false, 1, 0.88, 0.051, true, hudFile, hudFileSmall, true, 0.00041, wheatAngle, true, 3);
	FruitUtil.setFruitTypeWindrow(index, FillUtil.FILLTYPE_STRAW, 7);
	FruitUtil.addFruitTypeToCategory(FruitUtil.FRUITTYPE_CATEGORY_GRAINHEADER, index);
	FruitUtil.addFruitTypeToCategory(FruitUtil.FRUITTYPE_CATEGORY_DIRECTCUTTER, index);
	FruitUtil.addFruitTypeToCategory(FruitUtil.FRUITTYPE_CATEGORY_SOWINGMACHINE, index);
	FillUtil.addFillTypeToCategory(FillUtil.FILLTYPE_CATEGORY_COMBINE, FillUtil.FILLTYPE_RYE);
	FillUtil.addFillTypeToCategory(FillUtil.FILLTYPE_CATEGORY_AUGERWAGON, FillUtil.FILLTYPE_RYE);
	TipUtil.registerDensityMapHeightType(FillUtil.FILLTYPE_RYE, math.rad(26),  1.0, 0.08, 0.00, 0.08,  1, false, diffuseMap, normalMap, distanceMap);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_RYE, hudFileSmall, levelIconWidth, levelIconHeight);

	-- onion
	hudFile = Utils.getFilename("maps/scripts/huds/onionHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/onionHud.dds", TrafficManager.curModDir);
	diffuseMap = Utils.getFilename("maps/fillPlanes/onion_diffuse.dds", TrafficManager.curModDir);
	normalMap = Utils.getFilename("maps/fillPlanes/onion_normal.dds", TrafficManager.curModDir);
	distanceMap = Utils.getFilename("maps/fillPlanes/distance/onionDistance_diffuse.dds", TrafficManager.curModDir);
	index = FruitUtil.registerFruitType("onion", g_i18n:getText("onion"), FillUtil.FILLTYPE_CATEGORY_BULK, true, true, false, 0, false, 9, 9, 8, false, 1, 3.5, 0.032, true, hudFile, hudFileSmall, true, 0.00036, wheatAngle, false, 9);
	FruitUtil.registerFruitTypePreparing(index,"onion_haulm", 4, 6, 9);
	FruitUtil.addFruitTypeToCategory(FruitUtil.FRUITTYPE_CATEGORY_PLANTER, index);
	TipUtil.registerDensityMapHeightType(FillUtil.FILLTYPE_ONION, math.rad(34), 1.0, 0.08, 0.00, 0.08, 1, false, diffuseMap, normalMap, distanceMap);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_ONION, hudFileSmall, levelIconWidth, levelIconHeight);

	-- carrot
	hudFile = Utils.getFilename("maps/scripts/huds/carrotHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/carrotHud.dds", TrafficManager.curModDir);
	diffuseMap = Utils.getFilename("maps/fillPlanes/carrot_diffuse.dds", TrafficManager.curModDir);
	normalMap = Utils.getFilename("maps/fillPlanes/carrot_normal.dds", TrafficManager.curModDir);
	distanceMap = Utils.getFilename("maps/fillPlanes/distance/carrotDistance_diffuse.dds", TrafficManager.curModDir);
	index = FruitUtil.registerFruitType("carrot", g_i18n:getText("carrot"), FillUtil.FILLTYPE_CATEGORY_BULK, true, true, false, 0, false, 9, 9, 8, false, 1, 2.9, 0.026, true, hudFile, hudFileSmall, true, 0.00036, wheatAngle, false, 9);
	FruitUtil.registerFruitTypePreparing(index,"carrot_haulm", 4, 6, 9);
	FruitUtil.addFruitTypeToCategory(FruitUtil.FRUITTYPE_CATEGORY_PLANTER, index);
	TipUtil.registerDensityMapHeightType(FillUtil.FILLTYPE_CARROT, math.rad(34), 1.0, 0.08, 0.00, 0.08, 1, false, diffuseMap, normalMap, distanceMap);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_CARROT, hudFileSmall, levelIconWidth, levelIconHeight);
	FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_PIG, 4, FillUtil.FILLTYPE_CARROT);
	FillUtil.foodGroups[AnimalUtil.ANIMAL_PIG][4].fillTypes[FillUtil.FILLTYPE_SUGARBEET] = nil;

	-- Wheatflour
	hudFile = Utils.getFilename("maps/scripts/huds/wheatflourHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/wheatflourHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("wheatflour", g_i18n:getText("wheatflour"), sacksNboxesCategory, 1, true, hudFile, hudFileSmall, 0.0006, woolAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_WHEATFLOUR, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Ryeflour
	hudFile = Utils.getFilename("maps/scripts/huds/ryeflourHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/ryeflourHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("ryeflour", g_i18n:getText("ryeflour"), sacksNboxesCategory, 1, true, hudFile, hudFileSmall, 0.0006, woolAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_RYEFLOUR, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Maizeflour
	hudFile = Utils.getFilename("maps/scripts/huds/maizeflourHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/maizeflourHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("maizeflour", g_i18n:getText("maizeflour"), sacksNboxesCategory, 1, true, hudFile, hudFileSmall, 0.0006, woolAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_MAIZEFLOUR, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Bread
	hudFile = Utils.getFilename("maps/scripts/huds/breadHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/breadHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("bread", g_i18n:getText("bread"), sacksNboxesCategory, 1, true, hudFile, hudFileSmall, 0.0003, woolAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_BREAD, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Hops
	hudFile = Utils.getFilename("maps/scripts/huds/hopsHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/hopsHud.dds", TrafficManager.curModDir);
	diffuseMap = Utils.getFilename("maps/fillPlanes/hops_diffuse.dds", TrafficManager.curModDir);
	normalMap = Utils.getFilename("maps/fillPlanes/hops_normal.dds", TrafficManager.curModDir);
	distanceMap = Utils.getFilename("maps/fillPlanes/distance/hopsDistance_diffuse.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("hops", g_i18n:getText("hops"), FillUtil.FILLTYPE_CATEGORY_BULK, 1, true, hudFile, hudFileSmall, 0.00018, wheatAngle);
	TipUtil.registerDensityMapHeightType(FillUtil.FILLTYPE_HOPS, math.rad(40),  0.7, 0.10, 0.20, 0.60,  1, false, diffuseMap, normalMap, distanceMap);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_HOPS, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Beer
	hudFile = Utils.getFilename("maps/scripts/huds/beerHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/beerHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("beer", g_i18n:getText("beer"), sacksNboxesCategory, 1, true, hudFile, hudFileSmall, 0.0005, woolAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_BEER, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Canning
	hudFile = Utils.getFilename("maps/scripts/huds/canningHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/canningHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("canning", g_i18n:getText("canning"), sacksNboxesCategory, 1, true, hudFile, hudFileSmall, 0.0006, woolAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_CANNING, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Sugar
	hudFile = Utils.getFilename("maps/scripts/huds/sugarHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/sugarHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("sugar", g_i18n:getText("sugar"), sacksNboxesCategory, 1, true, hudFile, hudFileSmall, 0.00047, woolAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_SUGAR, hudFileSmall, levelIconWidth, levelIconHeight);

	-- packed_milk
	hudFile = Utils.getFilename("maps/scripts/huds/milkHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/milkHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("packed_milk", g_i18n:getText("packed_milk"), sacksNboxesCategory, 1, true, hudFile, hudFileSmall, 0.0005, woolAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_PACKED_MILK, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Sweetmilk
	hudFile = Utils.getFilename("maps/scripts/huds/sweetmilkHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/sweetmilkHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("sweetmilk", g_i18n:getText("sweetmilk"), sacksNboxesCategory, 1, true, hudFile, hudFileSmall, 0.0006, woolAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_SWEETMILK, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Sand
	hudFile = Utils.getFilename("maps/scripts/huds/sandHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/sandHud.dds", TrafficManager.curModDir);
	diffuseMap = Utils.getFilename("maps/fillPlanes/sand_diffuse.dds", TrafficManager.curModDir);
	normalMap = Utils.getFilename("maps/fillPlanes/sand_normal.dds", TrafficManager.curModDir);
	distanceMap = Utils.getFilename("maps/fillPlanes/distance/sandDistance_diffuse.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("sand", g_i18n:getText("sand"), FillUtil.FILLTYPE_CATEGORY_BULK, 0.1, false, hudFile, hudFileSmall, 0.00075, wheatAngle);
	TipUtil.registerDensityMapHeightType(FillUtil.FILLTYPE_SAND, math.rad(20),  1.0, 0.05, 0.00, 0.05,  1, false, diffuseMap, normalMap, distanceMap);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_SAND, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Gravel
	hudFile = Utils.getFilename("maps/scripts/huds/gravelHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/gravelHud.dds", TrafficManager.curModDir);
	diffuseMap = Utils.getFilename("maps/fillPlanes/gravel_diffuse.dds", TrafficManager.curModDir);
	normalMap = Utils.getFilename("maps/fillPlanes/gravel_normal.dds", TrafficManager.curModDir);
	distanceMap = Utils.getFilename("maps/fillPlanes/distance/gravelDistance_diffuse.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("gravel", g_i18n:getText("gravel"), FillUtil.FILLTYPE_CATEGORY_BULK, 0.1, false, hudFile, hudFileSmall, 0.0008, wheatAngle);
	TipUtil.registerDensityMapHeightType(FillUtil.FILLTYPE_GRAVEL, math.rad(20),  1.0, 0.05, 0.00, 0.05,  1, false, diffuseMap, normalMap, distanceMap);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_GRAVEL, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Concrete
	hudFile = Utils.getFilename("maps/scripts/huds/concreteHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/concreteHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("concrete", g_i18n:getText("concrete"), 0, 1, false, hudFile, hudFileSmall, 0.001, wheatAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_CONCRETE, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Cement
	hudFile = Utils.getFilename("maps/scripts/huds/cementHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/cementHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("cement", g_i18n:getText("cement"), sacksNboxesCategory, 1, false, hudFile, hudFileSmall, 0.00068, woolAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_CEMENT, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Bran
	hudFile = Utils.getFilename("maps/scripts/huds/branHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/branHud.dds", TrafficManager.curModDir);
	diffuseMap = Utils.getFilename("maps/fillPlanes/bran_diffuse.dds", TrafficManager.curModDir);
	normalMap = Utils.getFilename("maps/fillPlanes/bran_normal.dds", TrafficManager.curModDir);
	distanceMap = Utils.getFilename("maps/fillPlanes/distance/branDistance_diffuse.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("bran", g_i18n:getText("bran"), FillUtil.FILLTYPE_CATEGORY_BULK, 1, false, hudFile, hudFileSmall, 0.00026, wheatAngle);
	TipUtil.registerDensityMapHeightType(FillUtil.FILLTYPE_BRAN, math.rad(30), 0.8, 0.20, 0.10, 0.30,  1, false, diffuseMap, normalMap, distanceMap);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_BRAN, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Husk
	hudFile = Utils.getFilename("maps/scripts/huds/huskHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/huskHud.dds", TrafficManager.curModDir);
	diffuseMap = Utils.getFilename("maps/fillPlanes/husk_diffuse.dds", TrafficManager.curModDir);
	normalMap = Utils.getFilename("maps/fillPlanes/husk_normal.dds", TrafficManager.curModDir);
	distanceMap = Utils.getFilename("maps/fillPlanes/distance/huskDistance_diffuse.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("husk", g_i18n:getText("husk"), FillUtil.FILLTYPE_CATEGORY_BULK, 1, false, hudFile, hudFileSmall, 0.0002, wheatAngle);
	TipUtil.registerDensityMapHeightType(FillUtil.FILLTYPE_HUSK, math.rad(30), 0.8, 0.20, 0.10, 0.30,  1, false, diffuseMap, normalMap, distanceMap);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_HUSK, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Seed_oil
	hudFile = Utils.getFilename("maps/scripts/huds/seed_oilHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/seed_oilHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("seed_oil", g_i18n:getText("seed_oil"), liquidFoodsCategory, 1, true, hudFile, hudFileSmall, 0.00047, 0);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_SEED_OIL, hudFileSmall, levelIconWidth, levelIconHeight);

	-- oilcake
	hudFile = Utils.getFilename("maps/scripts/huds/oilcakeHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/oilcakeHud.dds", TrafficManager.curModDir);
	diffuseMap = Utils.getFilename("maps/fillPlanes/oilcake_diffuse.dds", TrafficManager.curModDir);
	normalMap = Utils.getFilename("maps/fillPlanes/oilcake_normal.dds", TrafficManager.curModDir);
	distanceMap = Utils.getFilename("maps/fillPlanes/distance/oilcakeDistance_diffuse.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("oilcake", g_i18n:getText("oilcake"), FillUtil.FILLTYPE_CATEGORY_BULK, 1, false, hudFile, hudFileSmall, 0.0004, wheatAngle);
	TipUtil.registerDensityMapHeightType(FillUtil.FILLTYPE_OILCAKE, math.rad(30), 0.8, 0.20, 0.10, 0.30,  1, false, diffuseMap, normalMap, distanceMap);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_OILCAKE, hudFileSmall, levelIconWidth, levelIconHeight);
	FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_COW, 3, FillUtil.FILLTYPE_OILCAKE);
	FillUtil.registerFillTypeInFoodGroup(AnimalUtil.ANIMAL_PIG, 3, FillUtil.FILLTYPE_OILCAKE);
	FillUtil.foodGroups[AnimalUtil.ANIMAL_PIG][3].fillTypes[FillUtil.FILLTYPE_SUNFLOWER] = nil;

	-- packed_seed_oil
	hudFile = Utils.getFilename("maps/scripts/huds/packed_seed_oilHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/packed_seed_oilHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("packed_seed_oil", g_i18n:getText("packed_seed_oil"), sacksNboxesCategory, 1, true, hudFile, hudFileSmall, 0.00047, woolAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_PACKED_SEED_OIL, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Konditer
	hudFile = Utils.getFilename("maps/scripts/huds/konditerHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/konditerHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("konditer", g_i18n:getText("konditer"), sacksNboxesCategory, 1, true, hudFile, hudFileSmall, 0.0003, woolAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_KONDITER, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Furniture
	hudFile = Utils.getFilename("maps/scripts/huds/furnitureHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/furnitureHud.dds", TrafficManager.curModDir);
	index = FillUtil.registerFillType("furniture", g_i18n:getText("furniture"), sacksNboxesCategory, 1, true, hudFile, hudFileSmall, 0.0002, woolAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_FURNITURE, hudFileSmall, levelIconWidth, levelIconHeight);

	-- Plank
	hudFile = Utils.getFilename("maps/scripts/huds/plankHud.dds", TrafficManager.curModDir);
	hudFileSmall = Utils.getFilename("maps/scripts/huds/plankHud.dds", TrafficManager.curModDir);
	FillUtil.registerFillType("plank", g_i18n:getText("plank"), sacksNboxesCategory, 1, true, hudFile, hudFileSmall, 0.00028, woolAngle);
	g_currentMission:addFillTypeOverlay(FillUtil.FILLTYPE_PLANK, hudFileSmall, levelIconWidth, levelIconHeight);

	FillUtil.registerFillType("wood", g_i18n:getText("wood"), 0, 1, false, hudFile, hudFileSmall, 0.00028, 0);
	FillUtil.registerFillType("chipboard", g_i18n:getText("chipboard"), 0, 1, true, hudFile, hudFileSmall, 0.0004, 0);

	PalletBase = {};
	PalletBase[FillUtil.FILLTYPE_BREAD] = TrafficManager.curModDir.."maps/scripts/pallet/boxPallet.i3d";
	PalletBase[FillUtil.FILLTYPE_BEER] = TrafficManager.curModDir.."maps/scripts/pallet/PalletBeer.i3d";
	PalletBase[FillUtil.FILLTYPE_CANNING] = TrafficManager.curModDir.."maps/scripts/pallet/PalletCanning.i3d";
	PalletBase[FillUtil.FILLTYPE_CEMENT] = TrafficManager.curModDir.."maps/scripts/pallet/PalletCement.i3d";
	PalletBase[FillUtil.FILLTYPE_WHEATFLOUR] = TrafficManager.curModDir.."maps/scripts/pallet/PalletFlour.i3d";
	PalletBase[FillUtil.FILLTYPE_RYEFLOUR] = TrafficManager.curModDir.."maps/scripts/pallet/PalletRyeFlour.i3d";
	PalletBase[FillUtil.FILLTYPE_MAIZEFLOUR] = TrafficManager.curModDir.."maps/scripts/pallet/PalletMaizeFlour.i3d";
	PalletBase[FillUtil.FILLTYPE_KONDITER] = TrafficManager.curModDir.."maps/scripts/pallet/PalletKonditer.i3d";
	PalletBase[FillUtil.FILLTYPE_PACKED_MILK] = TrafficManager.curModDir.."maps/scripts/pallet/PalletMilk.i3d";
	PalletBase[FillUtil.FILLTYPE_PACKED_SEED_OIL] = TrafficManager.curModDir.."maps/scripts/pallet/PalletOil.i3d";
	PalletBase[FillUtil.FILLTYPE_SEEDS] = TrafficManager.curModDir.."maps/scripts/pallet/PalletSeeds.i3d";
	PalletBase[FillUtil.FILLTYPE_SUGAR] = TrafficManager.curModDir.."maps/scripts/pallet/PalletSugar.i3d";
	PalletBase[FillUtil.FILLTYPE_SWEETMILK] = TrafficManager.curModDir.."maps/scripts/pallet/PalletSweetMilk.i3d";
	PalletBase[FillUtil.FILLTYPE_WOOL] = TrafficManager.curModDir.."maps/scripts/pallet/woolPallet.i3d";
	PalletBase[FillUtil.FILLTYPE_FERTILIZER] = TrafficManager.curModDir.."maps/scripts/pallet/PalletFertilizer.i3d";
	PalletBase[FillUtil.FILLTYPE_LIQUIDFERTILIZER] = "$data/objects/pallets/fertilizerTank.i3d";


	NPCUtil.registerNPC("Lucoshkina Mariya", "female", TrafficManager.curModDir.."maps/scripts/huds/npc/npc1_diffuse.png");
	NPCUtil.npcs["Lucoshkina Mariya"].name = g_i18n:getText("Lucoshkina_Mariya");
	NPCUtil.startPosition = NPCUtil.NUM_NPCS;
	NPCUtil.registerNPC("Miroshnikova Darya", "female", TrafficManager.curModDir.."maps/scripts/huds/npc/npc2_diffuse.png");
	NPCUtil.npcs["Miroshnikova Darya"].name = g_i18n:getText("Miroshnikova_Darya");
	NPCUtil.registerNPC("Boyko Aleksandra", "female", TrafficManager.curModDir.."maps/scripts/huds/npc/npc3_diffuse.png");
	NPCUtil.npcs["Boyko Aleksandra"].name = g_i18n:getText("Boyko_Aleksandra");
	NPCUtil.registerNPC("Anastasov Stanislav", "young", TrafficManager.curModDir.."maps/scripts/huds/npc/npc4_diffuse.png");
	NPCUtil.npcs["Anastasov Stanislav"].name = g_i18n:getText("Anastasov_Stanislav");
	NPCUtil.registerNPC("Filin Vovan", "young", TrafficManager.curModDir.."maps/scripts/huds/npc/npc5_diffuse.png");
	NPCUtil.npcs["Filin Vovan"].name = g_i18n:getText("Filin_Vovan");
	NPCUtil.registerNPC("Chugunok Anton", "young", TrafficManager.curModDir.."maps/scripts/huds/npc/npc6_diffuse.png");
	NPCUtil.npcs["Chugunok Anton"].name = g_i18n:getText("Chugunok_Anton");
	NPCUtil.registerNPC("Mamaevskiy Dmitriy", "young", TrafficManager.curModDir.."maps/scripts/huds/npc/npc7_diffuse.png");
	NPCUtil.npcs["Mamaevskiy Dmitriy"].name = g_i18n:getText("Mamaevskiy_Dmitriy");
	NPCUtil.registerNPC("Glushkov Ilya", "young", TrafficManager.curModDir.."maps/scripts/huds/npc/npc8_diffuse.png");
	NPCUtil.npcs["Glushkov Ilya"].name = g_i18n:getText("Glushkov_Ilya");
	NPCUtil.registerNPC("Ahmadullov Vjacheslav", "middle", TrafficManager.curModDir.."maps/scripts/huds/npc/npc9_diffuse.png");
	NPCUtil.npcs["Ahmadullov Vjacheslav"].name = g_i18n:getText("Ahmadullov_Vjacheslav");
	NPCUtil.registerNPC("Loganov Vadim", "old", TrafficManager.curModDir.."maps/scripts/huds/npc/npc10_diffuse.png");
	NPCUtil.npcs["Loganov Vadim"].name = g_i18n:getText("Loganov_Vadim");
	local chickenDesc = AnimalUtil.animals.chicken;
	chickenDesc.price = 50;
	chickenDesc.canBeBought = true;
	chickenDesc.dailyUpkeep = 2;
	chickenDesc.imageFilename = TrafficManager.curModDir.."maps/scripts/huds/store_chicken.png";
end;

function FruitRegister:addMaterials()
	FillUtil.fillTypeNameToDesc.sunflower.nameI18N = g_i18n:getText("sunflower");
	FillUtil.fillTypeNameToDesc.soybean.nameI18N = g_i18n:getText("soybean");
	g_i18n.globalI18N.texts.StrawSell = g_i18n:getText("StrawSell");
	g_i18n.globalI18N.texts.StationShippingOffice = g_i18n:getText("StationShippingOffice");

	if MaterialUtil.materials[FillUtil.FILLTYPE_RYE] then
		MaterialUtil.materials[FillUtil.FILLTYPE_RYE][4] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][4];
		MaterialUtil.materials[FillUtil.FILLTYPE_RYE][5] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][5];
		MaterialUtil.materials[FillUtil.FILLTYPE_RYE][6] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][6];
		MaterialUtil.materials[FillUtil.FILLTYPE_RYE][10] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][10];
		MaterialUtil.materials[FillUtil.FILLTYPE_RYE][12] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][12];
		MaterialUtil.cutterEffects[FruitUtil.FRUITTYPE_RYE] = MaterialUtil.cutterEffects[FruitUtil.FRUITTYPE_WHEAT];
		MaterialUtil.particleSystems[FillUtil.FILLTYPE_RYE] = MaterialUtil.particleSystems[FillUtil.FILLTYPE_WHEAT];
	end;
	if MaterialUtil.materials[FillUtil.FILLTYPE_HOPS] then
		MaterialUtil.materials[FillUtil.FILLTYPE_HOPS][4] = MaterialUtil.materials[FillUtil.FILLTYPE_CHAFF][4];
		MaterialUtil.materials[FillUtil.FILLTYPE_HOPS][12] = MaterialUtil.materials[FillUtil.FILLTYPE_CHAFF][12];
	end;
	if MaterialUtil.materials[FillUtil.FILLTYPE_SAND] then
		MaterialUtil.materials[FillUtil.FILLTYPE_SAND][4] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][4];
		MaterialUtil.materials[FillUtil.FILLTYPE_SAND][12] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][12];
	end;
	if MaterialUtil.materials[FillUtil.FILLTYPE_GRAVEL] then
		MaterialUtil.materials[FillUtil.FILLTYPE_GRAVEL][4] = MaterialUtil.materials[FillUtil.FILLTYPE_RAPE][4];
		MaterialUtil.materials[FillUtil.FILLTYPE_GRAVEL][12] = MaterialUtil.materials[FillUtil.FILLTYPE_RAPE][12];
	end;
	if MaterialUtil.materials[FillUtil.FILLTYPE_BRAN] then
		MaterialUtil.materials[FillUtil.FILLTYPE_BRAN][3] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][3];
		MaterialUtil.materials[FillUtil.FILLTYPE_BRAN][4] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][4];
		MaterialUtil.materials[FillUtil.FILLTYPE_BRAN][10] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][10];
		MaterialUtil.materials[FillUtil.FILLTYPE_BRAN][12] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][12];
	end;
	if MaterialUtil.materials[FillUtil.FILLTYPE_MAIZEFLOUR] then
		MaterialUtil.materials[FillUtil.FILLTYPE_MAIZEFLOUR][1] = MaterialUtil.materials[FillUtil.FILLTYPE_BRAN][1];
		MaterialUtil.materials[FillUtil.FILLTYPE_MAIZEFLOUR][3] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][3];
		MaterialUtil.materials[FillUtil.FILLTYPE_MAIZEFLOUR][10] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][10];
		MaterialUtil.materials[FillUtil.FILLTYPE_MAIZEFLOUR][12] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][12];
	end;
	if MaterialUtil.materials[FillUtil.FILLTYPE_RYEFLOUR] then
		MaterialUtil.materials[FillUtil.FILLTYPE_RYEFLOUR][12] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][12];
	end;
	if MaterialUtil.materials[FillUtil.FILLTYPE_HUSK] then
		MaterialUtil.materials[FillUtil.FILLTYPE_HUSK][3] = MaterialUtil.materials[FillUtil.FILLTYPE_SUNFLOWER][3];
		MaterialUtil.materials[FillUtil.FILLTYPE_HUSK][4] = MaterialUtil.materials[FillUtil.FILLTYPE_SUNFLOWER][4];
		MaterialUtil.materials[FillUtil.FILLTYPE_HUSK][10] = MaterialUtil.materials[FillUtil.FILLTYPE_SUNFLOWER][10];
		MaterialUtil.materials[FillUtil.FILLTYPE_HUSK][12] = MaterialUtil.materials[FillUtil.FILLTYPE_SUNFLOWER][12];
	end;
	if MaterialUtil.materials[FillUtil.FILLTYPE_OILCAKE] then
		MaterialUtil.materials[FillUtil.FILLTYPE_OILCAKE][4] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][4];
		MaterialUtil.materials[FillUtil.FILLTYPE_OILCAKE][12] = MaterialUtil.materials[FillUtil.FILLTYPE_WHEAT][12];
	end;
end;
