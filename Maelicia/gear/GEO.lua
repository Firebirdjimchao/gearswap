-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()	
	gear.GeoBell = "Dunna"

	gear.AugLifestreamIndi = { name="Lifestream Cape", augments={'Geomancy Skill +8','Indi. eff. dur. +20','Pet: Damage taken -5%','Damage taken-2%',}}
	gear.Nanto_nuke = { name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.Nanto_luopan = { name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}}
	gear.default.obi_waist = "Sacro Cord"
	gear.default.obi_back = gear.Nanto_nuke
	
	state.OffenseMode:options('None', 'Normal', 'MidAcc', 'Acc')
	--state.OffenseMode:options('None')
	state.CastingMode:options('Normal', 'Resistant', 'Proc', 'Naked')
	state.IdleMode:options('Normal', 'Encumbered', 'PDT', 'MDT', 'MDTOnca', 'CP', 'CPPDT', 'CPMDT')
	state.WeaponskillMode:options('Normal', 'Acc')

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
	set_macro_page(1, 13)

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
	-- 81%/40% Total (80/40 cap) + 15% (if RDM sub)
	sets.precast.FC = {
		-- 3%
		--main=gear.FastcastStaff,
		--sub="Enki Strap",
		--ammo="Impatiens",
		-- 6%
		main="Gada",
		-- 10%
		head="Nahtirah Hat",
		-- 4%
		neck="Voltsurge Torque",
		-- 4%
		ear1="Malignance Earring",
		-- 2%
		ear2="Loquacious Earring",
		-- 14%
		body="Zendik Robe",
		-- 3%
		hands="Otomi Gloves",
		-- 4%
		ring1="Kishar Ring",
		-- 2%
		ring2="Prolix Ring",
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
		ear2="Mendi. Earring",
		back="Pahtli Cape",
		hands=gear.Vanya_hands_B,
		waist="Acerbic Sash +1",
		legs="Doyen Pants",
		feet=gear.Vanya_feet_B
	})
	
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"
	})
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
		head="Umuthi Hat",
		hands="Carapacho Cuffs",
		legs="Doyen Pants",
	})
	
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		--ear1="Barkaro. Earring",
		hands="Bagua Mitaines +3"
	})
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head=empty,
		body="Twilight Cloak"
	})

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak"})
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head=gear.Merlinic_head_nuke,
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Bagua Tunic +3",
		hands="Jhakri Cuffs +2",
		ring1="Rajas Ring",
		ring2="Petrov Ring",
		back="Aurist's Cape +1",
		waist="Fotia Belt",
		legs="Bagua Pants +3",
		feet="Bagua Sandals +3"
	}
	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
		ear1="Telos Earring",
		ring1="Cacoethic Ring +1",
	})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		ear1="Telos Earring",
		ear2="Digni. Earring",
		ring1="Cacoethic Ring +1",
		ring2="Patricius Ring",
		waist="Eschan Stone"
	})
	
	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		head=gear.Merlinic_head_nuke,
		--neck="Sanctity Necklace",
		--ear1="Barkaro. Earring",
		ear1="Malignance Earring",
		ear2="Regal Earring",
		body="Bagua Tunic +3",
		--hands="Amalric Gages",
		hands="Jhakri Cuffs +2",
		ring1="Freke Ring",
		ring2="Strendu Ring",
		back=gear.Nanto_nuke,
		--waist="Yamabuki-no-Obi",
		legs="Bagua Pants +3",
		feet="Bagua Sandals +3"
	})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS,{
	})
	sets.precast.WS['Retribution'] = set_combine(sets.precast.WS,{
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
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {
		head="Blistering Sallet +1",
		neck="Loricate Torque +1",
		ear1="Genmei Earring",
		body="Shamash Robe",
		hands="Geo. Mitaines +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Goading Belt",
		legs="Gyve Trousers",
		--feet="Azimuth Gaiters +1"
		feet=gear.Vanya_feet_B
	})
	
	sets.midcast.MACC = {
		--main="Idris",
		--sub="Ammurapi Shield",
		main=gear.MainStaff,
		sub="Khonsu",
		range=gear.GeoBell,
		head="Geo. Galero +2",
		neck="Bagua Charm",
		ear1="Malignance Earring",
		ear2="Regal Earring",
		body="Geomancy Tunic +2",
		hands="Geo. Mitaines +2",
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring",
		back=gear.Nanto_nuke,
		waist="Luminary Sash",
		legs="Geomancy Pants +2",
		feet="Geo. Sandals +3"
	}
	
	sets.midcast.MAB = {
		main="Idris",
		sub="Ammurapi Shield",
		--main=gear.MainStaff,
		--sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head=gear.Merlinic_head_nuke,
		neck="Sanctity Necklace",
		--ear1="Barkaro. Earring",
		ear1="Malignance Earring",
		ear2="Regal Earring",
		--body="Ea Houppelande",
		body="Bagua Tunic +3",
		hands="Bagua Mitaines +3",
		ring1="Freke Ring",
		ring2="Strendu Ring",
		--back=gear.ElementalCape,
		back=gear.Nanto_nuke,
		waist=gear.ElementalObi,
		legs="Merlinic Shalwar",
		--feet=gear.Merlinic_feet_burst
		feet="Bagua Sandals +3"
	}
	
	sets.midcast.ConserveMP = set_combine(sets.midcast.FastRecast,{
		-- 5
		--neck="Reti Pendant",
		-- 3
		ear1="Gifted Earring",
		-- 5
		back="Fi Follet Cape +1",
		-- 8
		waist="Austerity Belt",
		-- 5
		legs="Lengo Pants",
		-- 4
		feet="Merlinic Crackows",
	})

	-- === Geomancy =========================================
	
	-- 373 + 373 + 16 + 16 = 778 + with gifts (36 Geomancy, 36 Handbell) = 850 (900 to cap all spell potency)
	-- Set total: 54
	-- Total: 904
	-- ConserveMP total: 25
	sets.midcast.Geomancy = set_combine(sets.midcast.ConserveMP,{
		main="Idris",
		sub="Genmei Shield",
		-- 18
		range=gear.GeoBell,
		-- 15
		head="Azimuth Hood +1",
		neck="Bagua Charm",
		-- ConserveMP +3
		ear1="Gifted Earring",
		-- 16
		body="Bagua Tunic +3",
		hands="Azimuth Gloves +1",
		ring1="Metamor. Ring +1",
		-- 5
		ring2="Stikini Ring",
		-- ConserveMP +5
		back="Fi Follet Cape +1",
		-- ConserveMP +8
		waist="Austerity Belt",
		-- ConserveMP +5
		legs="Lengo Pants",
		-- ConserveMP +4
		feet="Merlinic Crackows",
	})
	-- Set total: 54
	-- Total: 904
	-- ConserveMP total: 14
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy,{
		main="Idris",
		sub="Genmei Shield",
		-- ConserveMP +3
		head=gear.Merlinic_head_nuke,
		neck="Incanter's Torque",
		ring2="Persis Ring",
		-- +20
		back=gear.Nanto_luopan,
		-- +21
		legs="Bagua Pants +3",
		-- +20
		feet="Azimuth Gaiters +1"
	})

	-- === Healing Magic =========================================
	
	sets.midcast['Healing Magic'] = {
		main="Divinity",
		sub="Ammurapi Shield",
		head="Hyksos Khat",
		neck="Incanter's Torque",
		body=gear.Vanya_body_B,
		hands=gear.Vanya_hands_B,
		ring1="Sirona's Ring",
		ring2="Ephedra Ring",
		back="Altruistic Cape",
		feet=gear.Vanya_feet_B
	}
    
	-- 53% Total
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'],{
		-- 15%
		main="Divinity",
		sub="Ammurapi Shield",
		head="Befouled Crown",
		neck="Incanter's Torque",
		ear1="Malignance Earring",
		ear2="Regal Earring",
		-- 13%
		body="Vrikodara Jupon",
		-- 10%
		hands="Telchine Gloves",
		-- 10%
		legs="Gyve Trousers",
		-- 5%
		feet=gear.Vanya_feet_B
	});
			
	sets.midcast.Curaga = set_combine(sets.midcast.Cure,{
		body="Vrikodara Jupon"
	})
	sets.midcast.CureSelf = set_combine(sets.midcast.Cure,{
		waist="Gishdubar Sash",
	})
	sets.midcast.Cursna = set_combine(sets.midcast['Healing Magic'],{
		neck="Malison Medallion",
		ring1="Ephedra Ring",
		ring2="Ephedra Ring",
		feet=gear.Vanya_feet_B
	})
	sets.midcast.CursnaSelf = set_combine(sets.midcast.Cursna,{
		waist="Gishdubar Sash",
	})

	-- === Enhancing Magic =========================================
	
	-- 139 WHM sub, 144 RDM sub
	-- 16 merits
	-- 91 gear
	-- 246 WHM sub, 251 RDM sub
	-- 47% DUR
	sets.midcast['Enhancing Magic'] = {
		-- 18
		main="Gada",
		-- 10% DUR
		sub="Ammurapi Shield",
		-- 16
		head="Befouled Crown",
		-- 10
		neck="Incanter's Torque",
		-- 5
		ear1="Andoaa Earring",
		ear2="Regal Earring",
		-- 12 10% DUR
		body=gear.Telchine_body_pet,
		-- 10
		-- hands="Ayao's Gages",
		-- 9% DUR
		hands=gear.Telchine_hands_pet,
		-- 5
		ring1="Stikini Ring",
		-- 5
		ring2="Stikini Ring",
		-- 9
		back="Fi Follet Cape +1",
		-- 10% DUR
		waist="Embla Sash",
		-- 8% DUR
		legs=gear.Telchine_legs_pet,
		-- 11
		feet="Regal Pumps +1"		
	}
	
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],{
		neck="Nodens Gorget",
		ear1="Earthcry Earring",
		waist="Siegel Sash",
		legs="Haven Hose"
	})
	
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{
		main="Bolelabunga",
		sub="Genmei Shield",
		body="Telchine Chas."
	})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],{
		head="Amalric Coif",
	})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{
		head="Amalric Coif",
	})
	sets.midcast.RefreshSelf = set_combine(sets.midcast,Refresh,{
		waist="Gishdubar Sash",
		feet="Inspirited Boots"
	})
	
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'],{
		ring1="Sheltered Ring"
	})

	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'],{
		ring1="Sheltered Ring"
	})

	-- === Enfeebling Magic =========================================
	
	-- 378 Base
	-- 16 merits
	-- 394 Initial
	-- 118 gear
	-- 512 total
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.MACC,{
		-- 16
		head="Befouled Crown",
		-- 10
		neck="Incanter's Torque",
		-- 20
		body="Vanya Robe",
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
		--waist="Rumination Sash",
		-- 18
		legs="Psycloth Lappas",
		-- 21
		feet="Bagua Sandals +3"
	})

	-- For enfeebs with no known skill caps
	-- 394 Initial
	-- 128 gear
	-- 522 total
	sets.midcast.enfeebFullSkill = set_combine(sets.midcast['Enfeebling Magic'], {
		-- 5
		ring1="Stikini Ring",
	})

	-- For MND potency based enfeebs
	sets.midcast.enfeebMND = set_combine(sets.midcast['Enfeebling Magic'], {
		--neck="Imbodla Necklace",
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
	})

	-- For INT potency based enfeebs
	sets.midcast.enfeebINT = set_combine(sets.midcast['Enfeebling Magic'], {
		head="Ea Hat",
		--neck="Imbodla Necklace",
		ring2="Metamor. Ring +1",
		back=gear.Nanto_nuke,
		legs=gear.Merlinic_legs_nuke,
		feet="Jhakri Pigaches +2",
	})

	-- For enfeebs with static values (use MACC and duration+ gear)
	sets.midcast.enfeebStatic = set_combine(sets.midcast.MACC, {
		neck="Erra Pendant",
		-- Duration +10%
		ring1="Kishar Ring",
		ring2="Metamor. Ring +1",
	})

	-- For enfeebs with 500 skill caps
	-- 394 Initial
	-- 105 gear
	-- 504 total
	sets.midcast.enfeebSkillCap = set_combine(sets.midcast['Enfeebling Magic'], {
		-- 5
		ring1="Stikini Ring",
		hands="Geo. Mitaines +2",
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

	sets.midcast['Silence'] = set_combine(sets.midcast.enfeebFullSkill,{
	})

	sets.midcast['Silence'].Resistant = set_combine(sets.midcast.MACC,{
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

	sets.midcast['Dispelga'] =  set_combine(sets.midcast.MACC,{
		main="Daybreak",
	})

	-- === Elemental Magic =========================================
	
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast.MAB,{
		--head="Geo. Galero +2",
		head=gear.Merlinic_head_nuke,
		hands="Amalric Gages",
		--ring2="Resonance Ring",
	})
	
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{
		head=gear.Merlinic_head_nuke,
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring",
		legs="Merlinic Shalwar",
		feet=gear.Merlinic_feet_burst
	})
	
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {
		head=gear.Merlinic_head_nuke,
	})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {
		head=gear.Merlinic_head_nuke,
	})
	
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

	-- For 5k+ non-killing MB
	sets.midcast['Elemental Magic'].Proc = {
		head=empty,
		neck=empty,
		ear1="Etiolation Earring",
		ear2="Loquac. Earring",
		body=empty,
		hands="Amalric Gages",
		ring1="Stikini Ring",
		ring2="Persis Ring",
		back="Moonbeam Cape",
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
		sub="Ammurapi Shield",
		neck="Erra Pendant",
		ring1="Evanescence Ring",
		--ring2="Stikini Ring",
		ring2="Metamor. Ring +1",
		legs="Azimuth Tights +1"
	})
	
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
		main=gear.MainStaff,
		sub="Khonsu",
	})
	
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		main="Rubicundity",
		sub="Ammurapi Shield",
		head="Bagua Galero +3",
		neck="Erra Pendant",
		ring1="Evanescence Ring",
		waist="Fucho-no-Obi",
		feet=gear.Merlinic_feet_absorb,
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
		main="Daybreak",
		--main="Idris",
		sub="Genmei Shield",				
		range=gear.GeoBell,
		head="Amalric Coif",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
		body="Jhakri Robe +2",
		hands="Bagua Mitaines +3",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Fucho-no-Obi",
		legs="Lengo Pants",
		feet="Geo. Sandals +3"
	}
	
	sets.noprotect = {ring1="Sheltered Ring"}

	sets.idle.Encumbered = set_combine(sets.midcast.MAB,{
	})

	-- DT: 47%
	-- PDT: 22%
	-- MDT: 10%
	-- To cap MDT: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	-- <36%: use Shadow Mantle
	sets.idle.PDT = set_combine(sets.idle,{
		-- 20% DT
		main=gear.Staff.DT,
		-- 6% DT
		sub="Khonsu",
		-- 3% PDT
		head="Blistering Sallet +1",
		-- 6% DT
		neck="Loricate Torque +1",
		-- 2% PDT
		ear1="Genmei Earring",
		-- 10% PDT
		body="Shamash Robe",
		-- 2% PDT
		hands="Geo. Mitaines +2",
		-- 5% PDT 5% MDT
		ring1="Dark Ring",
		-- 10% DT
		ring2="Defending Ring",
		-- 5% DT
		back="Moonbeam Cape",
		-- 2% MDT
		legs="Gyve Trousers",
		--feet="Azimuth Gaiters +1"
		-- 3% MDT
		feet=gear.Vanya_feet_B
	})
			
	-- MDT: 35%
	-- MDB: 26
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.idle.MDT = set_combine(sets.idle,{
		main=gear.Staff.DT,
		sub="Khonsu",
		-- 6
		head="Azimuth Hood +1",
		-- 6%
		neck="Loricate Torque +1",
		-- 3%
		ear1="Etiolation Earring",
		-- 2%
		ear2="Odnowa Earring +1",
		-- 6 1% DT 3%
		body=gear.Vanya_body_B,
		-- 3
		hands="Geo. Mitaines +2",
		ring1="Shadow Ring",
		-- 10%
		ring2="Defending Ring",
		-- 5%
		back="Moonbeam Cape",
		-- 2% 6
		legs="Gyve Trousers",
		-- 3% 5
		feet=gear.Vanya_feet_B
	})
	
	sets.idle.MDTOnca = {
		main=gear.Staff.DT,
		sub="Khonsu",
		-- 6
		head="Azimuth Hood +1",
		-- 6%
		neck="Loricate Torque +1",
		-- 3%
		ear1="Etiolation Earring",
		ear2="Arete del Luna",
		-- 12
		body="Onca Suit",
		hands=empty,
		ring1="Shadow Ring",
		-- 10%
		ring2="Defending Ring",
		back="Tantalic Cape",
		legs=empty,
		feet=empty
	}
	
	sets.idle.CP = set_combine(sets.idle,{
	})
	
	sets.idle.CPPDT = set_combine(sets.idle.PDT,{
	})
	
	sets.idle.CPMDT = set_combine(sets.idle.MDT,{
	})
	
	sets.idle.Town = set_combine(sets.idle,{
		main="Idris",
		sub="Ammurapi Shield",
		--body="Councilor's Garb",
		body="Shamash Robe",
		feet="Geo. Sandals +3"
	})
	
	sets.idle.Weak = set_combine(sets.idle,{
	})
	
	sets.idle.Regen = set_combine(sets.idle,{
		neck="Bathy Choker +1",
		ring1="Sheltered Ring"
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
		-- PDT: 10%
		sub="Genmei Shield",
		-- Pet: DT 5%
		range=gear.GeoBell,
		-- Pet: regen +3
		--head="Azimuth Hood +1",
		head="Bagua Galero +3",
		-- Pet: DT 6%
		neck="Bagua Charm",
		ear1="Etiolation Earring",
		ear2="Ethereal Earring",
		-- Pet: regen +3
		body=gear.Telchine_body_pet,
		-- Pet: regen +3
		hands=gear.Telchine_hands_pet,
		-- PDT: 5%
		-- MDT: 5%
		ring1="Dark Ring",
		-- DT: 10%
		ring2="Defending Ring",
		-- Pet: regen +15
		back=gear.Nanto_luopan,
		-- Pet: DT 3%, regen +1
		waist="Isa Belt",
		-- Pet: regen +3
		legs=gear.Telchine_legs_pet,
		-- Pet: regen +5
		feet="Bagua Sandals +3"
	})
	
	sets.idle.PDT.Pet = set_combine(sets.idle.Pet,{
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

	sets.Kiting = {feet="Geo. Sandals +3"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {
		head="Jhakri Coronal +2",
		neck="Asperity Necklace",
		ear1="Telos Earring",
		ear2="Brutal Earring",
		body="Onca Suit",
		hands=empty,
		ring1="Rajas Ring",
		ring2="Petrov Ring",
		back="Buquwik Cape",
		waist="Goading Belt",
		legs=empty,
		feet=empty
	}

	sets.engaged.MidAcc = set_combine(sets.engaged, {
		neck="Lissome Necklace",
		body="Bagua Tunic +3",
		hands="Bagua Mitaines +3",
		ring1="Cacoethic Ring +1",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
	})
	
	sets.engaged.Acc = set_combine(sets.engaged.MidAcc, {
		neck="Subtlety Spec.",
		ear2="Digni. Earring",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		ring2="Patricius Ring",
		back="Aurist's Cape +1",
		waist="Eschan Stone",
	})

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	-- 37% (40 cap) + 24% II
	sets.magic_burst = set_combine(sets.midcast.MAB, {
		-- 6% II 6%
		head="Ea Hat",
		-- 10%
		neck="Mizu. Kubikazari",
		--body="Amalric Doublet",
		-- 7%
		--body=gear.Merlinic_body_burst,
		-- 8% II 8%
		body="Ea Houppelande",
		-- 5% II 5%
		hands="Ea Cuffs",
		-- 5% II
		ring1="Mujin Band",
		-- 2%
		ring2="Jhakri Ring",
		-- 6%
		feet=gear.Merlinic_feet_burst
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
	if state.Buff.Doom then
		idleSet = set_combine(idleSet, sets.buff.Doom)
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.Buff.Doom then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
	end
	return meleeSet
end

function customize_defense_set(defenseSet)    
	if state.Buff.Doom then
		defenseSet = set_combine(defenseSet, sets.buff.Doom)
	end
	return defenseSet
end