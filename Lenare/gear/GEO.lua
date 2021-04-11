-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	gear.GeoBell = "Dunna"
	
	gear.AugLifestreamIndi = { name="Lifestream Cape", augments={'Geomancy Skill +6','Indi. eff. dur. +20','Pet: Damage taken -1%',}}
	gear.Nanto_nuke = { name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.Nanto_luopan = { name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}}
	gear.default.obi_back = gear.Nanto_nuke

	state.OffenseMode:options('None', 'Normal', 'MidAcc', 'Acc')
	--state.OffenseMode:options('None')
	state.CastingMode:options('Normal', 'Resistant', 'Proc', 'Naked')
	state.IdleMode:options('Normal', 'Encumbered', 'PDT', 'MDT', 'CP', 'CPPDT', 'CPMDT')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'Acc')

	state.MagicBurst = M(false, 'Magic Burst')
	state.WeaponLock = M(false, 'Weapon Lock')

	LowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
		'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
		'Stonera', 'Watera', 'Aerora', 'Fira', 'Blizzara', 'Thundara',
		'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
		'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

	-------------------------------------------------
	-- Default bindings
	--
	-- F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
	-- Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
	-- Alt-F9 - Cycle Ranged Mode.
	-- Win-F9 - Cycle Weaponskill Mode.
	-- F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
	-- F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
	-- Ctrl-F10 - Cycle type of Physical Defense Mode in use.
	-- Alt-F12 - Turns off any emergency defense mode.
	-- Alt-F10 - Toggles Kiting Mode.
	-- Ctrl-F11 - Cycle Casting Mode.
	-- F12 - Update currently equipped gear, and report current status.
	-- Ctrl-F12 - Cycle Idle Mode.
	-------------------------------------------------

	-- "CTRL: ^ ALT: ! Windows Key: @ Apps Key: #"
	
	-- Additional local binds

	send_command('bind @` gs c cycle MagicBurst')
	send_command('bind ^` input /ma Stun <stnpc>; input /echo ------ Stun <t> -----')
	send_command('bind !` gs c toggle WeaponLock; input /echo --- Weapons Lock ---')

	-- Default macro set/book
	set_macro_page(1, 11)

	global_aliases()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind @`')
	send_command('unbind ^`')
	send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

	--------------------------------------
	-- Precast sets
	--------------------------------------
	
	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body="Bagua Tunic +3"}
	sets.precast.JA['Life cycle'] = {
		body="Geomancy Tunic +2",
		back="Nantosuelta's Cape",
	}
	sets.precast.JA['Primeaval Zeal'] = {head="Bagua Galero +3"}
	sets.precast.JA['Concentric Pulse'] = {head="Bagua Galero +3"}
	-- AF2 hands enhances Curative Recantation
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood +1",hands="Bagua Mitaines +3"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants +3"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +3"}
	
	-- Fast cast sets for spells
	-- 72%/36% Total (80/40 cap) + 15% (if RDM sub)
	sets.precast.FC = {
		-- 6%
		main="Gada",
		-- 10%
		head="Nahtirah Hat",
		-- 4%
		neck="Baetyl Pendant",
		-- 2%
		ear1="Loquacious Earring",
		-- 4%
		ear2="Malignance Earring",
		-- 5%
		body="Vanir Cotehardie",
		-- 3%
		hands="Otomi Gloves",
		-- 4%
		ring1="Kishar Ring",
		-- 5%
		ring2="Weather. Ring",
		-- 7%
		back="Lifestream Cape",
		-- 3%
		--waist="Witful Belt",
		-- 5%
		waist="Embla Sash",
		-- 13%
		legs="Geomancy Pants +2",
		-- 4% + 1%~3%
		feet="Regal Pumps +1"      
	}
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		ear1="Mendi. Earring",
		back="Pahtli Cape",
		feet=gear.Vanya_feet_B
	})
	
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"
	})
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
		head="Umuthi Hat"
	})
	
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		ear1="Barkaro. Earring",
		hands="Bagua Mitaines +3"
	})
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head=empty,
		body="Twilight Cloak"
	})
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Jhakri Coronal +2",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Bagua Tunic +3",
		hands="Jhakri Cuffs +2",
		ring1="Rajas Ring",
		ring2="Apate Ring",
		back="Buquwik Cape",
		waist="Windbuffet Belt +1",
		legs="Bagua Pants +3",
		feet="Bagua Sandals +3"
	}
	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
		neck="Sanctity Necklace",
		ear1="Zennaroi Earring",
	})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		neck="Sanctity Necklace",
		ear1="Zennaroi Earring",
		waist="Cetl Belt",
		back="Aurist's Cape +1",
	})
	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		head="Jhakri Coronal +2",
		neck="Baetyl Pendant",
		ear1="Barkaro. Earring",
		ear2="Malignance Earring",
		body="Bagua Tunic +3",
		hands="Jhakri Cuffs +2",
		ring1="Acumen Ring",
		ring2="Jhakri Ring",
		back=gear.Nanto_nuke,
		waist=gear.ElementalObi,
		--legs=gear.Merlinic_legs_nuke,
		legs="Bagua Pants +3",
		feet="Bagua Sandals +3"
	})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- 30% STR 30% MND, Critical hit chance varies with TP
	sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS,{
		neck=gear.ElementalGorget,
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
	})
	sets.precast.WS['Hexa Strike'].MidAcc = set_combine(sets.precast.WS.MidAcc,sets.precast.WS['Hexa Strike'],{
	})
	sets.precast.WS['Hexa Strike'].Acc = set_combine(sets.precast.WS.Acc,sets.precast.WS['Hexa Strike'].MidAcc,{
	})
	-- 73%~85% MND, Acc varies with TP
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS,{
		neck=gear.ElementalGorget,
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
	})
	sets.precast.WS['Realmrazer'].MidAcc = set_combine(sets.precast.WS.MidAcc,sets.precast.WS['Realmrazer'],{
	})
	sets.precast.WS['Realmrazer'].Acc = set_combine(sets.precast.WS.Acc,sets.precast.WS['Realmrazer'].MidAcc,{
	})
	-- 50% INT 50% MND, Aftermath varies with TP
	sets.precast.WS['Exudation'] = set_combine(sets.precast.WS,{
		neck=gear.ElementalGorget,
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		waist="Luminary Sash",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
	})
	sets.precast.WS['Exudation'].MidAcc = set_combine(sets.precast.WS.MidAcc,sets.precast.WS['Exudation'],{
	})
	sets.precast.WS['Exudation'].Acc = set_combine(sets.precast.WS.Acc,sets.precast.WS['Exudation'].MidAcc,{
	})
	-- 70% MND 30% STR, Damage varies with TP
	sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS,{
		neck=gear.ElementalGorget,
		ear2="Moonshade Earring",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		waist="Luminary Sash",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
	})
	sets.precast.WS['Black Halo'].MidAcc = set_combine(sets.precast.WS.MidAcc,sets.precast.WS['Black Halo'],{
	})
	sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS.Acc,sets.precast.WS['Black Halo'].MidAcc,{
	})

	sets.precast.WS['Retribution'] = set_combine(sets.precast.WS,{
	})
	sets.precast.WS['Retribution'].MidAcc = set_combine(sets.precast.WS.MidAcc,{
	})
	sets.precast.WS['Retribution'].Acc = set_combine(sets.precast.WS.Acc,{
	})
	
	-- Magical WS
	
	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS.MAB,{
	})
	sets.precast.WS['Spirit Taker'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS.MAB, {
	})
	
	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
	-- Base fast recast for spells
	-- 27% Haste
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		-- 8% Haste
		head="Blistering Sallet +1",
		neck="Twilight Torque",
		-- 3% Haste
		body="Bagua Tunic +3",
		-- 3% Haste
		hands="Geo. Mitaines +2",
		ring1=gear.DarkRing.physical,
		ring2="Defending Ring",
		back="Moonbeam Cape",
		-- 5% Haste
		waist="Cetl Belt",
		-- 5% Haste
		legs="Bagua Pants +3",
		-- 3% Haste
		feet="Bagua Sandals +3"
	});
	
	sets.midcast.MACC = {
		main=gear.MaccStaff,
		sub="Khonsu",
		range="Aureole",
		--head="Jhakri Coronal +2",
		head="Geo. Galero +2",
		neck="Bagua Charm",
		ear1="Barkaro. Earring",
		ear2="Malignance Earring",
		--body="Jhakri Robe +2",
		body="Geomancy Tunic +2",
		--hands="Jhakri Cuffs +2",
		hands="Geo. Mitaines +2",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back=gear.Nanto_nuke,
		waist="Luminary Sash",
		--legs=gear.Merlinic_legs_nuke,
		legs="Geomancy Pants +2",
		feet="Geo. Sandals +2"
	}
	
	sets.midcast.MAB = {
		main=gear.MainStaff,
		--sub="Niobid Strap",
		--sub="Enki Strap",
		sub="Khonsu",
		ammo="Ghastly Tathlum",
		head="Merlinic Hood",
		neck="Sanctity Necklace",
		ear1="Barkaro. Earring",
		ear2="Malignance Earring",
		body="Bagua Tunic +3",
		hands="Bagua Mitaines +3",
		ring1="Acumen Ring",
		ring2="Jhakri Ring",
		back=gear.Nanto_nuke,
		waist=gear.ElementalObi,
		legs=gear.Merlinic_legs_nuke,
		feet="Bagua Sandals +3"
	}
	
	sets.midcast.ConserveMP = set_combine(sets.midcast.FastRecast,{
		-- 2
		ear1="Mendi. Earring",
		-- 5
		back="Fi Follet Cape +1",
		-- 4
		waist="Luminary Sash",
		-- 5
		legs="Lengo Pants",
		-- 4
		feet="Merlinic Crackows",
	})
	
	-- === Geomancy =========================================
	
	-- 373 + 373 + 16 + 16 = 778 base (900 to cap all spell potency)
	-- 23 Geomancy Gift
	-- 23 Handbell Gift
	-- 824 Subtotal
	-- Set total: 76
	-- Total: 900
	-- ConserveMP total: 20
	sets.midcast.Geomancy = set_combine(sets.midcast.ConserveMP,{
		main="Idris",
		sub="Culminus",
		-- 18
		range=gear.GeoBell,
		-- 15
		head="Azimuth Hood +1",
		neck="Bagua Charm",
		-- ConserveMP +2
		ear1="Mendi. Earring",
		ear2="Etiolation Earring",
		-- 16
		body="Bagua Tunic +3",
		-- 17
		hands="Geo. Mitaines +2",
		-- 5
		ring1="Stikini Ring",
		-- 5
		ring2="Stikini Ring",
		-- 5 + 6
		--back=gear.AugLifestreamIndi,
		-- ConserveMP +5
		back="Fi Follet Cape +1",
		-- ConserveMP +4
		waist="Luminary Sash",
		-- ConserveMP +5
		legs="Lengo Pants",
		-- ConserveMP +4
		feet="Merlinic Crackows",
	})
	-- Set total: 76
	-- Total: 900
	-- ConserveMP total: 6
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy,{
		main="Idris",
		sub="Culminus",
		-- +20
		back=gear.AugLifestreamIndi,
		-- +21
		legs="Bagua Pants +3",
		-- +20
		feet="Azimuth Gaiters +1"
	})
	
	sets.midcast['Healing Magic'] = {
		main="Divinity",
		sub="Genbu's Shield'",
		head="Hyksos Khat",
		neck="Incanter's Torque",
		hands="Ayao's Gages",
		ring1="Sirona's Ring",
		ring2="Haoma's Ring",
		back="Altruistic Cape",
		feet=gear.Vanya_feet_B
	}
	
	-- 55% Total
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'],{
		-- 22%
		main="Tamaxchi",
		sub="Genbu's Shield",
		head="Befouled Crown",
		neck="Incanter's Torque",
		ear1="Lifestorm Earring",
		ear2="Malignance Earring",
		-- 5%
		--ear1="Mendi. Earring",
		-- 5%
		--ear2="Roundel Earring",
		-- 12%
		body="Annoint. Kalasiris",
		-- 16%
		hands=gear.Telchine_hands_cure,
		back="Aurist's Cape +1",
		-- 5%
		feet=gear.Vanya_feet_B
	});
			
	sets.midcast.Curaga = set_combine(sets.midcast.Cure,{
	})
	sets.midcast.CureSelf = set_combine(sets.midcast.Cure,{
		waist="Gishdubar Sash",
	})
	
	sets.midcast.Cursna = set_combine(sets.midcast['Healing Magic'],{
		neck="Malison Medallion",
		ring1="Haoma's Ring",
		ring2="Haoma's Ring",
		feet=gear.Vanya_feet_B
	})
	sets.midcast.CursnaSelf = set_combine(sets.midcast.Cursna,{
		waist="Gishdubar Sash",
	})

	-- === Enhancing Magic =========================================
	
	-- 139 WHM sub, 144 RDM sub
	-- 16 merits
	-- 86 gear
	-- 241 WHM sub, 246 RDM sub
	-- 35% DUR
	sets.midcast['Enhancing Magic'] = {
		-- 18
		main="Gada",
		sub="Genbu's Shield",
		-- 16
		head="Befouled Crown",
		neck="Incanter's Torque",
		--ear2="Andoaa Earring",
		-- 12 9% DUR
		body=gear.Telchine_body_pet,
		-- 9% DUR
		hands=gear.Telchine_hands_pet,
		-- 5
		ring1="Stikini Ring",
		-- 5
		ring2="Stikini Ring",
		-- 10% DUR
		waist="Embla Sash",
		-- 9
		back="Fi Follet Cape +1",
		-- 7% DUR
		legs=gear.Telchine_legs_pet,
		feet="Regal Pumps +1"
	}
	
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],{
		neck="Stone Gorget",
		ear1="Earthcry Earring",
		waist="Siegel Sash",
		legs="Haven Hose",
	})
	
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{
		main="Bolelabunga",
		sub="Genbu's Shield",
		body=gear.Telchine_body_pet,
	})
	
	sets.midcast.RefreshSelf = set_combine(sets.midcast['Enhancing Magic'],{
		waist="Gishdubar Sash",
		feet="Inspirited Boots",
	})

	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'],{
	})

	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'],{
	})

	-- === Enfeebling Magic =========================================

	-- 378 Base
	-- 16 merits
	-- 394 Initial
	-- 125 gear
	-- 519 total
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.MACC,{
		-- 16
		head="Befouled Crown",
		-- 10
		neck="Incanter's Torque",
		-- 18
		hands="Azimuth Gloves +1",
		-- 5
		--ring1="Stikini Ring",
		-- Duration +10%
		ring1="Kishar Ring",
		-- 5
		ring2="Stikini Ring",
		-- 10
		back="Lifestream Cape",
		-- 7
		waist="Rumination Sash",
		-- 18
		legs="Psycloth Lappas",
		-- 21
		feet="Bagua Sandals +3"
	})

	-- For enfeebs with no known skill caps
	-- 394 Initial
	-- 124 gear
	-- 518 total
	sets.midcast.enfeebFullSkill = set_combine(sets.midcast['Enfeebling Magic'], {
		-- 5
		ring1="Stikini Ring",
	})

	-- For MND potency based enfeebs
	sets.midcast.enfeebMND = set_combine(sets.midcast['Enfeebling Magic'], {
		--neck="Imbodla Necklace",
		ring1="Stikini Ring",
	})

	-- For INT potency based enfeebs
	sets.midcast.enfeebINT = set_combine(sets.midcast['Enfeebling Magic'], {
		--neck="Imbodla Necklace",
		back=gear.Nanto_nuke,
		legs=gear.Merlinic_legs_nuke,
		feet="Jhakri Pigaches +2",
	})

	-- For enfeebs with static values (use MACC and duration+ gear)
	sets.midcast.enfeebStatic = set_combine(sets.midcast.MACC, {
		neck="Erra Pendant",
		-- Duration +10%
		ring1="Kishar Ring",
	})

	-- For enfeebs with 500 skill caps
	-- 394 Initial
	-- 114 gear
	-- 508 total
	sets.midcast.enfeebSkillCap = set_combine(sets.midcast['Enfeebling Magic'], {
	})

	-- Static value (use duration+ gear)
	sets.midcast['Dia'] = set_combine(sets.midcast.enfeebStatic, {
	})
	-- Static value (use duration+ gear)
	sets.midcast['Dia II'] = set_combine(sets.midcast.enfeebStatic, {
	})

	-- MND potency mod
	-- Lowest value at -75 MND compared to enemy: About 7.3%
	-- Highest value at +75 MND compared to enemy: About 29.2%
	sets.midcast['Slow'] = set_combine(sets.midcast.enfeebMND, {
	})

	-- MND potency mod
	-- Lowest value at -40 MND compared to enemy: 5%
	-- Highest value at +40 MND compared to enemy: 25%
	sets.midcast['Paralyze'] = set_combine(sets.midcast.enfeebMND, {
	})

	-- INT potency mod
	-- Lowest value at -80 player INT compared to enemy INT: 5
	-- Highest value at +120 player INT compared to enemy INT: 50
	sets.midcast['Blind'] = set_combine(sets.midcast.enfeebINT, {
	})

	-- Skill mod
	-- 500 skill cap
	sets.midcast['Poison'] = set_combine(sets.midcast.enfeebSkillCap, {
	})

	-- Skill mod
	-- Max 3 damage/tick
	sets.midcast['Poisonga'] = set_combine(sets.midcast.enfeebSkillCap, {
	})
	
	-- MND and Skill mod

	-- Distract I (caps 125 skill for -25 eva, -35 eva cap with MND)
	-- Already skill-capped without gear, use MACC to make sure it lands
	sets.midcast['Distract'] = set_combine(sets.midcast.MACC, {
	})

	-- Frazzle I (caps 135 skill for -25 meva, -35 meva cap with MND)
	-- Already skill-capped without gear, use MACC to make sure it lands
	sets.midcast['Frazzle'] = set_combine(sets.midcast.MACC, {
	})

	-- === Elemental Magic =========================================
	
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast.MAB,{
		hands="Amalric Gages",
	})
	
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{
		sub="Khonsu",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
	})

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {
	})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {
	})
	
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

	-- For 5k+ non-killing MB
	sets.midcast['Elemental Magic'].Proc = {
		head=empty,
		neck=empty,
		ear1="Loquac. Earring",
		ear2="Etiolation Earring",
		body=empty,
		hands="Amalric Gages",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back=empty,
		waist="Luminary Sash",
		legs=empty,
		feet=empty
	}

	-- For low damage procs Omen sub-objectives
	sets.midcast['Elemental Magic'].Naked = {
		ammo=empty,
		head=empty,
		neck=empty,
		ear1=empty,
		ear2=empty,
		body=empty,
		hands=empty,
		ring1=empty,
		ring2=empty,
		back=empty,
		waist=empty,
		legs=empty,
		feet=empty
	}

	-- === Divine Magic =========================================
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAB,{
	})
	
	sets.midcast.Repose = set_combine(sets.midcast.FastRecast,{
	})

	-- === Dark Magic =========================================
	
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.MACC,{
		main="Rubicundity",
		neck="Erra Pendant",
		body="Geomancy Tunic +2",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		legs="Azimuth Tights +1",
		feet=gear.Merlinic_feet_nuke,
	})
	
	sets.midcast.Stun = set_combine(sets.midcast.FastRecast, {
		main=gear.MaccStaff,
		sub="Khonsu"
	})
	
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main="Rubicundity",
		head="Bagua Galero +3",
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
	})
	
	sets.midcast.Aspir = sets.midcast.Drain

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Resting sets
	sets.resting = set_combine(sets.sharedResting,{
	})

	-- Idle sets
	sets.idle = {
		main="Bolelabunga",
		--sub="Genbu's Shield",				
		sub="Culminus",
		range=gear.GeoBell,
		head="Befouled Crown",
		neck="Twilight Torque",
		ear1="Ethereal Earring",
		ear2="Novia Earring",
		body="Jhakri Robe +2",
		hands="Bagua Mitaines +3",
		ring1=gear.DarkRing.physical,
		ring2="Defending Ring",
		back="Moonbeam Cape",
		--back="Mecistopins Mantle",
		waist="Fucho-no-Obi",
		--legs="Lengo Pants",
		legs=gear.Merlinic_legs_idle,
		feet="Geo. Sandals +2"
	}

	sets.noprotect = {}

	sets.idle.Encumbered = set_combine(sets.midcast.MAB,{
	})

	-- Total: 44% + 20% (PDT Staff)
	-- <36%: use Shadow Mantle
	sets.idle.PDT = set_combine(sets.idle,{
		main=gear.Staff.DT,
		-- 6% DT
		sub="Khonsu",
		-- 3%
		head="Blistering Sallet +1",
		-- 5%
		neck="Twilight Torque",
		-- 10%
		body="Shamash Robe",
		-- 1%
		hands="Geo. Mitaines +2",
		-- 4%
		ring1=gear.DarkRing.physical,
		-- 10%
		ring2="Defending Ring",
		-- 5%
		back="Moonbeam Cape",
		--back="Mecistopins Mantle",
		legs="Bagua Pants +3",
		feet="Geo. Sandals +2"
	})
			
	-- MDT: 32%
	-- MDB: 27
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.idle.MDT = set_combine(sets.idle,{
		main=gear.Staff.DT,
		-- 6% DT
		sub="Khonsu",
		-- 5
		head="Geo. Galero +2",
		-- 5%
		neck="Twilight Torque",
		-- 3%
		ear2="Etiolation Earring",
		-- 6
		body="Shamash Robe",
		-- 3
		hands="Geo. Mitaines +2",
		ring1="Shadow Ring",
		-- 10%
		ring2="Defending Ring",
		-- 5%
		back="Moonbeam Cape",
		-- 8
		legs="Bagua Pants +3",
		-- 5 3%
		feet=gear.Vanya_feet_B
	})
	
	sets.idle.CP = set_combine(sets.idle,{
	})
	
	sets.idle.CPPDT = set_combine(sets.idle.PDT,{
	})
	
	sets.idle.CPMDT = set_combine(sets.idle.MDT,{
	})

	sets.idle.Town = set_combine(sets.idle,{
		main="Idris",
		sub="Culminus",
		--body="Councilor's Garb",
		body="Shamash Robe",
	})

	sets.idle.Weak = set_combine(sets.idle,{
	})

	sets.idle.Regen = set_combine(sets.idle,{
	})

	-- Pet sets are for when Luopan is present.
	--
	-- Luopan Perp cost --
	-- Base: -24/tick
	-- Lasting emanation: -17/tick
	-- Ecliptic Attrition: -30/tick
	-- Both: -23/tick
	--
	-- Pet DT cap: 87.5%
	-- Luopan innate DT: 50%
	-- Pet DT: -39% (37.5% to cap)
	-- Pet regen: +30
	sets.idle.Pet = set_combine(sets.idle,{
		-- Pet: DT 25%
		main="Idris",
		-- Luopan: DT 5%
		range=gear.GeoBell,
		-- Pet: regen +3
		--head="Azimuth Hood +1",
		head="Bagua Galero +3",
		-- Pet DT: 6%
		neck="Bagua Charm",
		ear1="Ethereal Earring",
		ear2="Etiolation Earring",
		-- Pet: regen +3
		body=gear.Telchine_body_pet,
		-- Pet: DT 11%
		--hands="Geo. Mitaines +2",
		-- Pet: regen +3
		hands=gear.Telchine_hands_pet,
		-- PDT 4%
		-- MDT 3%
		ring1=gear.DarkRing.physical,
		-- DT: 10%
		ring2="Defending Ring",
		-- Pet: regen +15
		back=gear.Nanto_luopan,
		--back="Mecistopins Mantle",
		-- Pet: DT 1%
		--back="Lifestream Cape",
		-- Pet: DT 3%, regen +1
		waist="Isa Belt",
		-- Pet: regen +3
		legs=gear.Telchine_legs_pet,
		-- Pet: regen +5
		feet="Bagua Sandals +3",
	})
	
	sets.idle.PDT.Pet = set_combine(sets.idle.PDT,{
	})

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {
	})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {
	})
	sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {
	})
	sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {
	})

	-- Defense sets

	sets.defense.PDT = set_combine(sets.idle.PDT,{
	})
	
	sets.defense.MDT = set_combine(sets.idle.MDT,{
	})

	sets.Kiting = {feet="Geo. Sandals +2"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	-- 24% Haste
	sets.engaged = {
		-- 8% Haste
		head="Blistering Sallet +1",
		neck="Asperity Necklace",
		ear1="Zennaroi Earring",
		ear2="Brutal Earring",
		-- 3% Haste
		body="Bagua Tunic +3",
		-- 3% Haste
		hands="Bagua Mitaines +3",
		ring1="Rajas Ring",
		ring2="Chirich Ring",
		back="Buquwik Cape",
		-- 5% Haste
		waist="Cetl Belt",
		-- 2% Haste
		legs="Jhakri Slops +2",
		-- 3% Haste
		feet="Bagua Sandals +3",		
	}

	sets.engaged.MidAcc = set_combine(sets.engaged, {
		head="Bagua Galero +3",
		neck="Sanctity Necklace",
		ring2="Cacoethic Ring",
	})
	
	sets.engaged.Acc = set_combine(sets.engaged.MidAcc, {
		ear1="Zennaroi Earring",
		back="Aurist's Cape +1",
		waist="Eschan Stone",
	})

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	-- 33% (40 cap) + 0% II
	sets.magic_burst = set_combine(sets.midcast.MAB, {
		-- 9%
		head=gear.Merlinic_head_burst,
		-- 10%
		neck="Mizu. Kubikazari",
		--body="Amalric Doublet",
		body=gear.Merlinic_body_nuke,
		-- 5% II
		--hands="Amalric Gages",
		-- 5% 5% II
		--hands="Ea Cuffs",
		-- 12%
		hands="Bagua Mitaines +3",
		-- 2%
		ring2="Jhakri Ring",
	})

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(stateField, newValue, oldValue)
	if state.WeaponLock.value == true then
		disable('main','sub','range','ammo')
	else
		enable('main','sub','range','ammo')
	end
end

function job_get_spell_map(spell, default_spell_map)
	if spell.action_type == 'Magic' then
		if spell.skill == 'Enfeebling Magic' then
			if spell.type == 'WhiteMagic' then
				return 'MndEnfeebles'
			else
				return 'IntEnfeebles'
			end
		elseif spell.skill == 'Geomancy' then
			if spell.english:startswith('Indi') then
				return 'Indi'
			end
		elseif spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
			if LowTierNukes:contains(spell.english) then
				return 'LowTierNuke'
			else
				return 'HighTierNuke'
			end
			end
	end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Enhancing Magic' then
		if spellMap == 'Refresh' and spell.target.type == 'SELF' then
			equip(sets.midcast.RefreshSelf)
		end
	elseif spellMap == 'Cursna' and spell.target.type == 'SELF' then
		equip(sets.midcast.CursnaSelf)
	elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
		equip(sets.midcast.CureSelf)
	elseif spell.skill == 'Elemental Magic' and state.MagicBurst.value then
		equip(sets.magic_burst)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if pet.isvalid then
		idleSet = set_combine(idleSet, sets.idle.Pet)
	elseif not buffactive['Protect'] then
		idleSet = set_combine(idleSet, sets.noprotect)
	elseif not pet.isvalid and (player.mpp < 51) then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end
	if buffactive['Doom'] then
		idleSet = set_combine(idleSet, sets.buff.Doom)
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if buffactive['Doom'] then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
	end
	return meleeSet
end

function customize_defense_set(defenseSet)    
	if buffactive['Doom'] then
		defenseSet = set_combine(defenseSet, sets.buff.Doom)
	end
	return defenseSet
end