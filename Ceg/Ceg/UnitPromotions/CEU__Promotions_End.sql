-- Insert SQL Rules Here 

-- 
-- Promotion Updates
-- 

/*
OpenAttack and OpenDefense only affect MELEE combat,
but incorrectly show on the UnitPanel for ranged attacks (with no actual effect).
*/

--/*
UPDATE UnitPromotions
SET OpenRangedAttackMod = 15
WHERE Type IN (
	'PROMOTION_SHOCK_1'	,
	'PROMOTION_SHOCK_2'	,
	'PROMOTION_SHOCK_3'	
);

UPDATE UnitPromotions
SET RoughRangedAttackMod = 15
WHERE Type IN (
	'PROMOTION_DRILL_1'	,
	'PROMOTION_DRILL_2'	,
	'PROMOTION_DRILL_3'	
);
--*/

UPDATE UnitPromotions
SET OpenAttack = 15, OpenDefense = 15
WHERE Type IN (
	'PROMOTION_ACCURACY_1'	,
	'PROMOTION_ACCURACY_2'	,
	'PROMOTION_ACCURACY_3'	
);

UPDATE UnitPromotions
SET RoughAttack = 15, RoughDefense = 15
WHERE Type IN (
	'PROMOTION_BARRAGE_1'	,
	'PROMOTION_BARRAGE_2'	,
	'PROMOTION_BARRAGE_3'	
);

--
-- Free Land Promotions
--

UPDATE Unit_FreePromotions
SET PromotionType = 'PROMOTION_CITY_ASSAULT'
WHERE PromotionType = 'PROMOTION_CITY_SIEGE';

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_CITY_SIEGE'
FROM Units WHERE Class IN (
	'UNITCLASS_SWORDSMAN',
	'UNITCLASS_LONGSWORDSMAN'
);


INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_DEFENSE_1'
FROM Units WHERE Class IN (
	'UNITCLASS_SCOUT'				,
	'UNITCLASS_SPEARMAN'			,
	'UNITCLASS_PIKEMAN'				,
	'UNITCLASS_ANTI_AIRCRAFT_GUN'	,
	'UNITCLASS_MOBILE_SAM'			
);

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_RANGED_DEFENSE_I'
FROM Units WHERE Class IN (	
	'UNITCLASS_GATLINGGUN'	,
	'UNITCLASS_MACHINE_GUN'	,
	'UNITCLASS_BAZOOKA'	
);

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_RIVAL_TERRITORY'
FROM Units WHERE Class IN (
	'UNITCLASS_SUBMARINE'			,
	'UNITCLASS_NUCLEAR_SUBMARINE'	
);


INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_RANGED_DEFENSE_II'
FROM Units WHERE CombatClass IN (
	'UNITCOMBAT_NAVALRANGED'	,
	'UNITCOMBAT_SUBMARINE'
);

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_CAN_MOVE_AFTER_ATTACKING'
FROM Units WHERE Class IN (
	'UNITCLASS_CHARIOT_ARCHER'	,
	'UNITCLASS_HELICOPTER_GUNSHIP'
) AND NOT Type = 'UNIT_BARBARIAN_CHARIOT_ARCHER';



DELETE FROM Unit_FreePromotions
WHERE PromotionType = 'PROMOTION_FORMATION_1' AND UnitType IN
(SELECT DISTINCT Type
FROM Units WHERE Class IN (
	'UNITCLASS_LANCER'
));

/*
INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_ANTI_CAVALRY'
FROM Units WHERE Class IN (
	'UNITCLASS_LANCER'
);
*/

DELETE FROM Unit_FreePromotions
WHERE PromotionType = 'PROMOTION_DEFENSIVE_EMBARKATION';

UPDATE Unit_FreePromotions
SET PromotionType = 'PROMOTION_CITY_ATTACK_II'
WHERE PromotionType IN ('PROMOTION_CITY_ASSAULT', 'PROMOTION_CITY_SIEGE')
AND UnitType IN (
	SELECT DISTINCT Type
	FROM Units WHERE CombatClass = 'UNITCOMBAT_SIEGE'
);

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_LAND_PENALTY_II'
FROM Units WHERE CombatClass = 'UNITCOMBAT_SIEGE';

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_RANGED_DEFENSE_II'
FROM Units WHERE CombatClass = 'UNITCOMBAT_SIEGE';

UPDATE Unit_FreePromotions
SET PromotionType = 'PROMOTION_ANTI_MOUNTED_NOUPGRADE_I'
WHERE PromotionType = 'PROMOTION_ANTI_MOUNTED_I'
AND UnitType IN (
	SELECT DISTINCT Type
	FROM Units WHERE Class IN (
		'UNITCLASS_SPEARMAN',
		'UNITCLASS_PIKEMAN'
	)
);


DELETE FROM Unit_FreePromotions
WHERE PromotionType = 'PROMOTION_CITY_PENALTY'
AND UnitType IN (
	SELECT DISTINCT Type
	FROM Units WHERE Class IN (
		'UNITCLASS_MECH'		,
		'UNITCLASS_HORSEMAN'	,
		'UNITCLASS_KNIGHT'		,
		'UNITCLASS_LANCER'		,
		'UNITCLASS_CAVALRY'
	)
);

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_SMALL_CITY_PENALTY'
FROM Units WHERE CombatClass IN (
	'UNITCOMBAT_ARCHER'		,
	'UNITCOMBAT_MOUNTED'	,
	'UNITCOMBAT_GUN'		,
	'UNITCOMBAT_ARMOR'		
) AND NOT Type = 'UNIT_MONGOLIAN_KESHIK';



INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_CITY_SIEGE'
FROM Units WHERE Class IN (
	'UNITCLASS_MECH'
);


--
-- Free Sea Promotions
--

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_LAND_BONUS_I'
FROM Units WHERE CombatClass IN (
	'UNITCOMBAT_NAVALMELEE'
);

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_SEA_BONUS_I'
FROM Units WHERE CombatClass IN (
	'UNITCOMBAT_NAVALMELEE'
);

DELETE FROM Unit_FreePromotions
WHERE PromotionType = 'PROMOTION_PRIZE_SHIPS'
AND UnitType = 'UNIT_PRIVATEER';

DELETE FROM Unit_FreePromotions
WHERE PromotionType = 'PROMOTION_FIRE_SUPPORT'
AND UnitType IN (
	'UNIT_IRONCLAD'		
);

DELETE FROM Unit_FreePromotions
WHERE PromotionType = 'PROMOTION_CITY_BONUS_II'
AND UnitType IN (
	'UNIT_IRONCLAD'		
);

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_CITY_ATTACK_II'
FROM Units WHERE Class IN (
	'UNITCLASS_FRIGATE'			    ,
	'UNITCLASS_IRONCLAD'			,
	'UNITCLASS_BATTLESHIP'			,
	'UNITCLASS_MISSILE_CRUISER'		
);


/*
INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_ANTI_SUBMARINE_I'
FROM Units WHERE Class IN (
	'UNITCLASS_DESTROYER'			,
	'UNITCLASS_MISSILE_DESTROYER'	
);
*/

DELETE FROM Unit_FreePromotions
WHERE PromotionType = 'PROMOTION_ANTI_SUBMARINE_II'
AND UnitType IN (SELECT DISTINCT Type FROM Units WHERE Class IN (
	'UNITCLASS_MISSILE_CRUISER'	
));

DELETE FROM Unit_FreePromotions
WHERE PromotionType = 'PROMOTION_ATTACK_BONUS_II'
AND UnitType IN (
	'UNIT_SUBMARINE'				,
	'UNIT_NUCLEAR_SUBMARINE'		
);

DELETE FROM Unit_FreePromotions
WHERE PromotionType = 'PROMOTION_EXTRA_SIGHT_I'
AND UnitType IN (
	'UNIT_SUBMARINE'				,
	'UNIT_NUCLEAR_SUBMARINE'		
);

DELETE FROM Unit_FreePromotions
WHERE PromotionType = 'PROMOTION_SILENT_HUNTER';

DELETE FROM Unit_FreePromotions
WHERE PromotionType = 'PROMOTION_ONLY_DEFENSIVE'
AND UnitType IN (SELECT Type FROM Units WHERE Domain = 'DOMAIN_SEA');

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_ONLY_DEFENSIVE'
FROM Units WHERE CombatClass IN ('UNITCOMBAT_NAVALRANGED', 'UNITCOMBAT_SUBMARINE');

DELETE FROM Unit_FreePromotions
WHERE PromotionType = 'PROMOTION_ANTI_SUBMARINE_I' AND UnitType IN
(SELECT DISTINCT Type
FROM Units WHERE Class IN (
	'UNITCLASS_NUCLEAR_SUBMARINE'
));

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_CARGO_II'
FROM Units WHERE Class IN (
	'UNITCLASS_MISSILE_DESTROYER'
);

DELETE FROM Unit_FreePromotions
WHERE PromotionType IN ('PROMOTION_OCEAN_IMPASSABLE', 'PROMOTION_OCEAN_IMPASSABLE_UNTIL_ASTRONOMY');

INSERT OR REPLACE INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_OCEAN_IMPASSABLE_UNTIL_ASTRONOMY'
FROM Units WHERE Class IN (
	'UNITCLASS_WORKBOAT'	,
	'UNITCLASS_GALLEY'		,
	'UNITCLASS_BIREME'		,
	'UNITCLASS_TRIREME'		,
	'UNITCLASS_GALLEASS'	,
	'UNITCLASS_CARAVEL'		,
	'UNITCLASS_GREAT_ADMIRAL'		
);

/*
INSERT OR REPLACE INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_OCEAN_IMPASSABLE'
FROM Units WHERE Class IN (
	'UNITCLASS_BIREME'		,
	'UNITCLASS_TRIREME'		,
	'UNITCLASS_GALLEASS'	
);
*/

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_EXTRA_SIGHT_NOUPGRADE_I'
FROM Units WHERE Class IN (
	'UNITCLASS_DESTROYER',
	'UNITCLASS_MISSILE_DESTROYER'
);

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_SIGHT_PENALTY'
FROM Units WHERE Class IN (
	'UNITCLASS_SUBMARINE',
	'UNITCLASS_NUCLEAR_SUBMARINE'
);

--
-- Free Air Promotions
--

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_LAND_BONUS_II'
FROM Units WHERE CombatClass IN (
	'UNITCOMBAT_BOMBER'
);

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_SEA_BONUS_II'
FROM Units WHERE CombatClass IN (
	'UNITCOMBAT_BOMBER'
);


DELETE FROM Unit_FreePromotions
WHERE PromotionType = 'PROMOTION_ANTI_AIR_II';

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_ANTI_AIR'
FROM Units WHERE CombatClass IN (
	'UNITCOMBAT_FIGHTER'
);

INSERT INTO Unit_FreePromotions (UnitType, PromotionType)
SELECT DISTINCT Type, 'PROMOTION_ANTI_HELICOPTER'
FROM Units WHERE CombatClass IN (
	'UNITCOMBAT_FIGHTER'
);


--
-- Promotion Classes
--

UPDATE UnitPromotions
SET Class = 'PROMOTION_CLASS_ATTRIBUTE_POSITIVE'
WHERE ((PediaType = 'PEDIA_ATTRIBUTES' AND LostWithUpgrade = 1)
	OR Type LIKE '%NOUPGRADE%'
	OR Type IN (
		'PROMOTION_CITY_SIEGE'					, -- 
		'PROMOTION_GREAT_GENERAL'				, -- leadership
		'PROMOTION_CAN_MOVE_AFTER_ATTACKING'	, -- mobile
		'PROMOTION_ANTI_HELICOPTER'				, -- fighters
		'PROMOTION_MERCENARY'					  -- landsknecht
	)
);

UPDATE UnitPromotions
SET Class = 'PROMOTION_CLASS_ATTRIBUTE_NEGATIVE'
WHERE (Type LIKE '%PENALTY%'
	OR Type IN (
		'PROMOTION_MUST_SET_UP'					,
		'PROMOTION_ROUGH_TERRAIN_ENDS_TURN'		,
		'PROMOTION_FOLIAGE_IMPASSABLE'			,
		'PROMOTION_NO_CAPTURE'					,
		'PROMOTION_ONLY_DEFENSIVE'				,
		'PROMOTION_NO_DEFENSIVE_BONUSES',
		'PROMOTION_OCEAN_IMPASSABLE_UNTIL_ASTRONOMY'
	)
);

UPDATE UnitPromotions
SET Class = 'PROMOTION_CLASS_ATTRIBUTE_POSITIVE'
WHERE PediaType = 'PEDIA_ATTRIBUTES'
AND NOT Type IN (
	'PROMOTION_INDIRECT_FIRE' 					,-- earned
	'PROMOTION_CAN_MOVE_AFTER_ATTACKING'		,-- not important
	'PROMOTION_IGNORE_TERRAIN_COST'				,-- minutemen
	'PROMOTION_PHALANX'							,-- hoplites
	'PROMOTION_GOLDEN'							,-- immortals	
	'PROMOTION_DESERT_POWER'					,-- barbarians
	'PROMOTION_ARCTIC_POWER'					,-- barbarians
	'PROMOTION_GUERRILLA'						,-- barbarians
	'PROMOTION_FREE_UPGRADES'					,-- citystates	
	'PROMOTION_HANDICAP'						,-- handicap
	'PROMOTION_OCEAN_MOVEMENT'					,-- england
	'PROMOTION_EXTRA_MOVES_I'					,-- special bonus
	'PROMOTION_BUFFALO_HORNS'					,-- zulus
	'PROMOTION_BUFFALO_CHEST'					,-- zulus
	'PROMOTION_BUFFALO_LOINS'					-- zulus
	)
AND NOT Type IN (
	SELECT PromotionType
	FROM Unit_FreePromotions
	WHERE UnitType IN (
		SELECT UnitType
		FROM Civilization_UnitClassOverrides
		WHERE CivilizationType != 'CIVILIZATION_BARBARIAN'
	)
);

UPDATE UnitPromotions
SET LostWithUpgrade = 0
WHERE Class = 'PROMOTION_CLASS_PERSISTENT';

UPDATE UnitPromotions
SET LostWithUpgrade = 1
WHERE Class <> 'PROMOTION_CLASS_PERSISTENT';

UPDATE UnitPromotions
SET   PortraitIndex = '58'
WHERE PortraitIndex = '59'
AND   Class = 'PROMOTION_CLASS_ATTRIBUTE_POSITIVE';

UPDATE UnitPromotions
SET   PortraitIndex = '59'
WHERE PortraitIndex = '58'
AND   Class = 'PROMOTION_CLASS_PERSISTENT'
AND NOT Type IN (
	'PROMOTION_HANDICAP' 		-- handicap
);

--
-- Promotion icon order
--

-- Promotions sort from left (high priority) to right (low priority)

UPDATE UnitPromotions
SET OrderPriority = 10;

UPDATE UnitPromotions
SET OrderPriority = 100
WHERE Type IN (
	'PROMOTION_SCOUTING_1',
	'PROMOTION_SCOUTING_2',
	'PROMOTION_NAVAL_RECON_1',
	'PROMOTION_NAVAL_RECON_2'
);

UPDATE UnitPromotions
SET OrderPriority = 90
WHERE Type IN (
	'PROMOTION_SHOCK_1',
	'PROMOTION_SHOCK_2',
	'PROMOTION_SHOCK_3',
	'PROMOTION_ACCURACY_1',
	'PROMOTION_ACCURACY_2',
	'PROMOTION_ACCURACY_3',
	'PROMOTION_TARGETING_1',
	'PROMOTION_TARGETING_2',
	'PROMOTION_TARGETING_3',
	'PROMOTION_INTERCEPTION_1',
	'PROMOTION_INTERCEPTION_2',
	'PROMOTION_INTERCEPTION_3',
	'PROMOTION_AIR_SIEGE_1',
	'PROMOTION_AIR_SIEGE_2',
	'PROMOTION_AIR_SIEGE_3'
);

UPDATE UnitPromotions
SET OrderPriority = 80
WHERE Type IN (
	'PROMOTION_DRILL_1',
	'PROMOTION_DRILL_2',
	'PROMOTION_DRILL_3',
	'PROMOTION_BARRAGE_1',
	'PROMOTION_BARRAGE_2',
	'PROMOTION_BARRAGE_3',
	'PROMOTION_BOMBARDMENT_1',
	'PROMOTION_BOMBARDMENT_2',
	'PROMOTION_BOMBARDMENT_3',
	'PROMOTION_DOGFIGHTING_1',
	'PROMOTION_DOGFIGHTING_2',
	'PROMOTION_DOGFIGHTING_3',
	'PROMOTION_AIR_TARGETING_1',
	'PROMOTION_AIR_TARGETING_2'
);

UPDATE UnitPromotions
SET OrderPriority = 70
WHERE Type IN (
	'PROMOTION_SIEGE',
	'PROMOTION_NAVAL_SIEGE',
	'PROMOTION_MEDIC',
	'PROMOTION_REPAIR',
	'PROMOTION_AIR_REPAIR',
	'PROMOTION_HELI_REPAIR',
	'PROMOTION_VOLLEY'
);

UPDATE UnitPromotions
SET OrderPriority = 60
WHERE Type IN (
	'PROMOTION_SUPPLY_I',
	'PROMOTION_SUPPLY_II',
	'PROMOTION_AIR_RANGE',
	'PROMOTION_SORTIE'
);

UPDATE UnitPromotions
SET OrderPriority = 50
WHERE Type IN (
	'PROMOTION_BLITZ',
	'PROMOTION_LOGISTICS',
	'PROMOTION_AIR_LOGISTICS',
	'PROMOTION_NAVAL_LOGISTICS',
	'PROMOTION_COVER_VANGUARD_1',
	'PROMOTION_COVER_VANGUARD_2',
	'PROMOTION_AIR_AMBUSH_1',
	'PROMOTION_AIR_AMBUSH_2'
);

UPDATE UnitPromotions
SET OrderPriority = 40
WHERE Type IN (
	'PROMOTION_CHARGE',
	'PROMOTION_INDIRECT_FIRE',
	'PROMOTION_RANGE'
);

UPDATE UnitPromotions
SET OrderPriority = 30
WHERE Type IN (
	'PROMOTION_COVER_1',
	'PROMOTION_COVER_2',
	'PROMOTION_SKIRMISH',
	'PROMOTION_AMBUSH_1',
	'PROMOTION_AMBUSH_2'
);


UPDATE LoadedFile SET Value=1 WHERE Type='CEU__Promotions_End.sql';