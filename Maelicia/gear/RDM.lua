-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff.Saboteur = buffactive.saboteur or false

	state.CP = M(false, "Capacity Points Mode")
	state.Warp = M(false, "Warp Mode")
	state.Weapon = M(false, "Weapon Lock")
	state.Neck = M(false, "Neck Mode")
	state.TreasureMode = M(false, 'TH')
	state.EngagedDT = M(false, 'Engaged Damage Taken Mode')
end

function user_setup()

	state.OffenseMode:options('None', 'Normal', 'Acc', 'enspell','enspellDW','enspell.Acc','enspellDW.Acc')
	--state.OffenseMode:options('None')
	state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT', 'MDT')

	state.MagicBurst = M(false, 'Magic Burst')
	state.RangeLock = M(false, 'Range Lock')

	gear.default.obi_waist = "Sacro Cord"
	gear.sucellos_mab = { name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.sucellos_mnd = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10',}}
	gear.default.obi_back = gear.sucellos_mab
	gear.AugGhostfyre = {
		name="Ghostfyre Cape",
		augments={
			"Mag. Acc. +10",
			"Enfb.mag. skill +10",
			"Enha.mag. skill +4"
		}
	}
	
	gear.AugGhostfyreEnhance = {
		name="Ghostfyre Cape",
		augments={
			"Enfb.mag. skill +3",
			"Enha.mag. skill +4",
			"Enh. Mag. eff. dur. +16"
		}
	}

	-- list of spell that has its own sets defined below and should not default to using EnhancingDuration midcast set
	EnhancingDurationSkip = S{'Aquaveil', 'Blaze Spikes', 'Ice Spikes', 'Regen', 'Regen II', 'Refresh', 'Refresh II', 'Refresh III',
		'Shock Spikes', 'Stoneskin', 'Temper', 'Temper II'}

	set_macro_page(1, 4)

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
	send_command('bind @` gs c toggle MagicBurst') --WindowKey'`'
	send_command('bind @b gs c toggle RangeLock') --WindowKey'B' for Bow

	send_command('bind @c gs c toggle CP') --WindowKey'C'
	send_command('bind @e gs c toggle EngagedDT') --Windowkey'E'
	send_command('bind @h gs c toggle TreasureMode') --Windowkey'H'
	send_command('bind @n gs c toggle Neck') --Windowkey'N'
	send_command('bind @r gs c toggle Warp') --Windowkey'R'
	send_command('bind @w gs c toggle Weapon') --Windowkey'W'

	send_command('alias rdmfulldebuff input /ma "Inundation" <t>;wait 5;input /ma "Distract II" <t>;wait 5;input /ma "Frazzle II" <t>;wait 5;input /ma "Dia III" <t>;wait 5;input /ma "Paralyze II" <t>;wait 5;input /ma "Slow II" <t>;wait 5;input /ma "Blind II" <t>;wait 5;input /ma "Poison II" <t>;wait 5;input /ma "Addle" <t>;')
	send_command('alias rdmdddebuff input /ma "Inundation" <t>;wait 5;input /ma "Distract II" <t>;wait 5;input /ma "Dia III" <t>;wait 5;input /ma "Poison II" <t>;')
	send_command('alias rdmtankdebuff input /ma "Paralyze II" <t>;wait 5;input /ma "Slow II" <t>;wait 5;input /ma "Blind II" <t>;wait 5;input /ma "Addle" <t>;')

	send_command('alias rdmmeleebuff input /ma "Haste II" <me>;wait 5;input /ma "Refresh II" <me>;wait 5;input /ma "Temper" <me>;wait 5;input /ma "Gain-Dex" <me>;wait 5;input /ma "Ice Spikes" <me>;wait 5;input /ma "Aquaveil" <me>;wait 5;input /ma "Phalanx II" <me>;wait 5;input /ma "Stoneskin" <me>;wait 5;input /ma "Regen II" <me>;')

	global_aliases()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind @`')
	send_command('unbind @b')
	
	send_command('unbind @c')
	send_command('unbind @e')
	send_command('unbind @h')
	send_command('unbind @n')
	send_command('unbind @r')
	send_command('unbind @w')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- set used to lock Ullr in conjunction with RangeLock
	sets.EnforceMACCResistant =  {
		range="Ullr",
		ammo=empty,
	}

	sets.Malignance = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	}
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body="Viti. Tabard +3"}
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Atro. Chapeau +3",
		ear1="Roundel Earring",
		body="Viti. Tabard +3",
		hands="Atrophy Gloves +3",
		legs="Gyve Trousers",
		feet="Malignance Boots"
	}
			
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	-- Fast cast sets for spells
	
	-- 30% Base RDM traits
	-- 8% JP
	-- 62% gear (42 needed for 80%)
	-- (80/40 cap) Note: Quick Magic does not allow midcast sets
	sets.precast.FC = {
		-- 4%
		--main="Grioavolr",
		--sub="Enki Strap",
		--ammo="Impatiens",
		-- 16%
		head="Atro. Chapeau +3",
		-- 4%
		neck="Voltsurge Torque", 
		-- 4%
		ear1="Malignance Earring",
		-- 2%
		ear2="Loquac. Earring",
		-- 15%
		body="Viti. Tabard +3",
		-- 5% + 3% aug
		--hands="Leyline Gloves",
		-- 2%
		ring1="Prolix Ring",
		-- 4%
		ring2="Kishar Ring",
		-- 10%
		back=gear.sucellos_mnd,
		-- 3%
		--waist="Witful Belt",
		-- 5%
		waist="Embla Sash",
		-- 7%
		--legs="Psycloth Lappas",
		-- 4%
		--feet="Chelona Boots"
		-- 8%
		--feet="Carmine Greaves +1",
	}
	
	-- Cannot exceed 80/40 FC cap in combination with FC
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
	})
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak"})
	
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"
	})
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
		head="Umuthi Hat",
		hands="Carapacho Cuffs"
	})
	
	sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC, {
		head="Leth. Chappel +1"
	})
		 
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Viti. Chapeau +3",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Sherida Earring",
		body="Ayanmo Corazza +2",
		--hands="Jhakri Cuffs +2",
		hands="Atrophy Gloves +3",
		ring1="Petrov Ring",
		ring2="Rajas Ring",
		back="Atheling Mantle",
		waist="Fotia Belt",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"
	}
	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		head="Nyame Helm",
		--neck="Sanctity Necklace",
		ear1="Malignance Earring",
		ear2="Regal Earring",
		body="Ea Houppelande",
		hands="Jhakri Cuffs +2",
		ring1="Freke Ring",
		ring2="Strendu Ring",
		back=gear.sucellos_mab,
		--waist="Yamabuki-no-Obi",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	
	-- Specific weaponskill sets.	Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB, {
		neck="Fotia Gorget",
	})
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
	})
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ammo="Regal Gem",
		head="Viti. Chapeau +3",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Regal Earring",
		body="Viti. Tabard +3",
		hands="Jhakri Cuffs +2",
		ring1="Metamor. Ring +1",
		ring2="Rajas Ring",
		waist="Sailfi Belt +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
	})
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.MAB,{
		neck="Fotia Gorget",
	})
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
	})
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget",
	})
	
	-- Midcast Sets
	-- DT 51%
	-- PDT 5%
	-- MDT 5%
	-- MDB 32
	-- Haste 26%
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		-- DT 6% MDB 5 Haste 6%
		head="Malignance Chapeau",
		-- DT 6%
		neck="Loricate Torque +1",
		-- DT 9% MDB 8 Haste 4%
		body="Malignance Tabard",
		-- DT 5% MDB 4 Haste 4%
		hands="Malignance Gloves",
		-- PDT 5% MDT 5%
		ring1="Dark Ring",
		-- DT 10%
		ring2="Defending Ring",
		-- DT 5%
		back="Moonbeam Cape",
		-- DT 6% MDB 5 Haste 9%
		legs="Aya. Cosciales +2",
		-- DT 4% MDB 5 Haste 3%
		feet="Malignance Boots",
		-- MDB 3 Haste 4%
		--feet="Carmine Greaves +1",
	});
	
	sets.midcast.MACC = {
		main=gear.MaccStaff,
		sub="Enki Strap",
		--main="Daybreak",
		--sub="Ammurapi Shield",
		--ammo="Regal Gem",
		ammo=empty,
		range="Ullr",
		--head=gear.Chironic_head_nuke,
		--head="Viti. Chapeau +3",
		head="Atro. Chapeau +3",
		neck="Dls. Torque +1",
		--neck="Incanter's Torque",
		ear1="Snotra Earring",
		--ear2="Digni. Earring",
		ear2="Regal Earring",
		body="Atrophy Tabard +3",
		hands=gear.Kaykaus_hands_hq_A,
		--hands="Regal Cuffs",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
		--back=gear.sucellos_mnd,
		back="Aurist's Cape +1",
		waist="Luminary Sash",
		legs="Chironic Hose",
		feet="Vitiation Boots +3",
	}
	
	sets.midcast.MAB = {
		--main=gear.MainStaff,
		--main="Grioavolr",
		--sub="Enki Strap",
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		range="Ullr",
		--ammo="Ghastly Tathlum",
		head=gear.Merlinic_head_nuke,
		neck="Sanctity Necklace",
		ear1="Malignance Earring",
		ear2="Regal Earring",
		body="Ea Houppelande",
		--hands="Jhakri Cuffs +2",
		hands=gear.Amalric_hands_hq_D,
		ring1="Freke Ring",
		ring2="Strendu Ring",
		back=gear.sucellos_mab,
		waist=gear.ElementalObi,
		legs=gear.Merlinic_legs_nuke,
		--feet="Vitiation Boots +3",
		feet=gear.Amalric_feet_hq_D,
	}
	
	sets.midcast['Healing Magic'] = {
		head="Hyksos Khat",
		neck="Incanter's Torque",
		body="Viti. Tabard +3",
		hands=gear.Vanya_hands_B,
		ring1="Menelaus's Ring",
		ring2="Sirona's Ring",
		waist="Luminary Sash",
		--legs="Carmine Cuisses +1",
		legs="Atrophy Tights +3",
		feet=gear.Vanya_feet_B
	}
	
	-- 52% Total
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'],{
		-- 30%
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Befouled Crown",
		neck="Incanter's Torque",
		ear1="Malignance Earring",
		-- 5%
		--ear2="Roundel Earring",
		ear2="Novia Earring",
		-- 5%
		--ear2="Mendi. Earring",
		-- 13%
		--body="Vrikodara Jupon",
		body="Viti. Tabard +3",
		hands=gear.Vanya_hands_B,
		-- 5%
		ring1="Menelaus's Ring",
		back="Aurist's Cape +1",
		waist=gear.ElementalObi,
		-- 12%
		legs="Atrophy Tights +3",
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
		ring1="Menelaus's Ring",
		ring2="Haoma's Ring",
		feet="Gende. Galosh +1"
	})

	sets.midcast.CursnaSelf = set_combine(sets.midcast.Cursna,{
		waist="Gishdubar Sash",
	})
	
	sets.midcast['Enhancing Magic'] = {
		-- 10 DUR
		sub="Ammurapi Shield",
		-- 16
		head="Befouled Crown",
		-- 10 
		neck="Incanter's Torque",
		ear1="Malignance Earring",
		-- 5
		ear2="Andoaa Earring",
		-- 23 15 DUR
		body="Viti. Tabard +3",
		-- 20 DUR
		hands="Atrophy Gloves +3",
		-- 5
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		-- 8
		ring2="Stikini Ring +1",
		-- 20 DUR
		back=gear.sucellos_mnd,
		-- 10 DUR
		waist="Embla Sash",
		-- 21
		legs="Atrophy Tights +3",
		-- 25 30 DUR
		feet="Leth. Houseaux +1"
	}
	
	-- 505 total, 72 Gear + 433 (420 base + 13 Gift), 143 DUR (125 + 18 JP)
	-- Using as many of Empy pieces as possible to maximize Composure bonus
	sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'],{
		-- 10 DUR
		sub="Ammurapi Shield",
		--head="Leth. Chappel +1",
		-- 16
		head="Befouled Crown",
		-- 10 
		--neck="Incanter's Torque",
		-- 20 DUR
		neck="Dls. Torque +1",
		ear1="Malignance Earring",
		--body="Lethargy Sayon +1",
		-- 23 15 DUR
		body="Viti. Tabard +3",
		-- 20 DUR
		hands="Atrophy Gloves +3",
		-- 5
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		-- 8
		ring2="Stikini Ring +1",
		-- 20 DUR
		back=gear.sucellos_mnd,
		-- 10 DUR
		waist="Embla Sash",
		legs="Leth. Fuseau +1",
		-- 25 30 DUR
		feet="Leth. Houseaux +1"
	})

	-- INT potency mod for spikes
	-- ~105 +208 INT
	sets.midcast.spikes = set_combine(sets.midcast.EnhancingDuration,{
		-- 19 INT
		--main=gear.MainStaff,
		-- 10 INT
		--sub="Enki Strap",
		-- 10 INT
		ear2="Regal Earring",
		-- 12 INT
		neck="Dls. Torque +1",
		-- 10 INT
		ring1="Freke Ring",
		-- 6 INT
		ring2="Persis Ring",
		-- 30 INT 20 DUR
		back=gear.sucellos_mab,
	})
	
	-- Static value (Use Duration+ and Potency+ gear) --
	sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration,{
		body="Atrophy Tabard +3",
		legs="Leth. Fuseau +1"
	})

	-- Static value (Use Duration+ and Potency+ gear) --
	sets.midcast.RefreshSelf = set_combine(sets.midcast.Refresh,{
		waist="Gishdubar Sash",
		feet="Inspirited Boots",
	})
	
	-- MND + Skill mod (500 Skill cap, or 350 HP damage taken cap + potency+ gear)
	sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration,{
		ammo="Regal Gem",
		neck="Stone Gorget",
		ear1="Earthcry Earring",
		waist="Siegel Sash",
		legs="Haven Hose",
	})
	
	-- Static value (Use Duration+ and Potency+ gear) --
	sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration,{
		main="Bolelabunga",
		-- 10 DUR
		sub="Ammurapi Shield",
		body="Telchine Chas."
	})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],{
		head="Chironic Hat",
		hands="Regal Cuffs",
	})

	-- Skill mod (500 cap)
	sets.midcast['Phalanx'] = set_combine(sets.midcast.EnhancingDuration,{
	})
	
	-- Skill mod (500 cap)
	sets.midcast['Phalanx II'] = set_combine(sets.midcast.EnhancingDuration,{
	})

	-- INT potency mod
	-- (cap 250 INT at time of cast, MAB determined at time of proc)
	sets.midcast['Blaze Spikes'] = set_combine(sets.midcast.spikes,{
	})
	-- INT potency mod
	-- (cap 250 INT at time of cast, MAB determined at time of proc)
	sets.midcast['Ice Spikes'] = set_combine(sets.midcast.spikes,{
	})
	-- INT potency mod
	-- (cap 250 INT at time of cast, MAB determined at time of proc)
	sets.midcast['Shock Spikes'] = set_combine(sets.midcast.spikes,{
	})
	
	-- 424 Base
	-- 16 merits
	-- 36 gifts
	-- 476 Initial
	-- 55 gear
	-- 531 total
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.MACC,{
		main=gear.MaccStaff,
		sub="Enki Strap",
		range="Ullr",
		ammo=empty,
		-- effect +10
		--ammo="Regal Gem",
		-- 26 3s x # Merit DUR
		head="Viti. Chapeau +3",
		-- 10
		--neck="Incanter's Torque",
		neck="Dls. Torque +1",
		ear1="Snotra Earring",
		-- 21
		--body="Atrophy Tabard +3",
		-- effect +14
		body="Lethargy Sayon +1",
		-- 19, Saboteur +12
		--hands="Leth. Gantherots +1",
		-- Duration +20%
		hands="Regal Cuffs",
		-- 5
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		-- 8
		--ring2="Stikini Ring +1",
		-- Duration +10%
		ring2="Kishar Ring",
		-- effect +10
		back=gear.sucellos_mnd,
		waist="Luminary Sash",
		-- 7
		--waist="Rumination Sash",
		-- 13 Immunobreak +1
		legs=gear.Chironic_legs_nuke,
		-- 16
		feet="Vitiation Boots +3",
	})

	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'],{
		ammo=empty,
		range="Ullr",
		-- effect +10
		--ammo="Regal Gem",
		head="Atrophy Chapeau +3",
		ear2="Regal Earring",
		-- 21
		body="Atrophy Tabard +3",
		hands=gear.Kaykaus_hands_hq_A,
		ring2="Stikini Ring +1",
		back="Aurist's Cape +1",
	})

	-- For enfeebs with no known skill caps
	-- 476 Initial
	-- 111 gear
	-- 587 total
	sets.midcast.enfeebFullSkill = set_combine(sets.midcast['Enfeebling Magic'], {
		-- 21
		body="Atrophy Tabard +3",
		-- 8
		ring1="Stikini Ring +1",
	})
	sets.midcast.enfeebFullSkill.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, sets.midcast.enfeebFullSkill, {
	})

	-- For MND potency based enfeebs
	sets.midcast.enfeebMND = set_combine(sets.midcast['Enfeebling Magic'], {
		--ammo="Regal Gem",
		head="Viti. Chapeau +3",
		neck="Dls. Torque +1",
		waist="Luminary Sash",
	})
	sets.midcast.enfeebMND.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
	})

	-- For INT potency based enfeebs
	sets.midcast.enfeebINT = set_combine(sets.midcast['Enfeebling Magic'], {
		neck="Dls. Torque +1",
		body="Atrophy Tabard +3",
		-- 10 INT
		ring1="Freke Ring",
		-- 6 INT
		ring2="Persis Ring",
		back=gear.sucellos_mab,
		legs=gear.Merlinic_legs_nuke,
		feet="Vitiation Boots +3",
	})
	sets.midcast.enfeebINT.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {
	})

	-- For enfeebs with static values (use duration+ gear)
	sets.midcast.enfeebStatic = set_combine(sets.midcast['Enfeebling Magic'], {
		head="Atro. Chapeau +3",
		neck="Dls. Torque +1",
		ear1="Snotra Earring",
		body="Atrophy Tabard +3",
		-- Duration +20%
		hands="Regal Cuffs",
		-- Duration +10%
		ring2="Kishar Ring",
		feet="Vitiation Boots +3",
	})
	sets.midcast.enfeebStatic.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, sets.midcast.enfeebStatic, {
	})

	-- For enfeebs with 500 skill caps
	-- 476 Initial + (Master Level)
	-- 44 gear
	-- 499 total
	sets.midcast.enfeebSkillCap = set_combine(sets.midcast['Enfeebling Magic'], {
		head="Atro. Chapeau +3",
		neck="Dls. Torque +1",
		hands="Regal Cuffs",
		waist="Luminary Sash",
		feet="Vitiation Boots +3",
	})
	sets.midcast.enfeebSkillCap.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, sets.midcast.enfeebSkillCap, {
	})

	-- Static value (use duration+ gear)
	sets.midcast['Dia'] = set_combine(sets.midcast.enfeebStatic, {
		range=empty,
		ammo="Regal Gem",
	})
	-- Static value (use duration+ gear)
	sets.midcast['Dia II'] = set_combine(sets.midcast.enfeebStatic, {
		range=empty,
		ammo="Regal Gem",
	})	
	-- Static value (use duration+ gear)
	sets.midcast['Dia III'] = set_combine(sets.midcast.enfeebStatic, {
		range=empty,
		ammo="Regal Gem",
	})

	sets.midcast['Dispel*'] = set_combine(sets.midcast.MACC, {
		range="Ullr",
		ammo=empty,
		neck="Dls. Torque +1",
	})

	-- MND potency mod
	-- Lowest value at -75 MND compared to enemy: About 7.3%
	-- Highest value at +75 MND compared to enemy: About 29.2%
	sets.midcast['Slow'] = set_combine(sets.midcast.enfeebMND, {
	})
	sets.midcast['Slow'].Resistant = set_combine(sets.midcast.enfeebMND.Resistant, sets.midcast['Slow'], {
	})
	-- MND potency mod
	-- Lowest value at -75 MND compared to enemy: About 12.5%
	-- Highest value at +75 MND compared to enemy: About 35.1%
	-- *When merit level is increased by 1, the effect is increased by about 1%.
	sets.midcast['Slow II'] = set_combine(sets.midcast.enfeebMND, {
	})
	sets.midcast['Slow II'].Resistant = set_combine(sets.midcast.enfeebMND.Resistant, sets.midcast['Slow II'], {
	})

	-- MND potency mod
	-- Lowest value at -40 MND compared to enemy: 5%
	-- Highest value at +40 MND compared to enemy: 25%
	sets.midcast['Paralyze'] = set_combine(sets.midcast.enfeebMND, {
	})
	sets.midcast['Paralyze'].Resistant = set_combine(sets.midcast.enfeebMND.Resistant, sets.midcast['Paralyze'], {
	})
	
	-- MND potency mod
	-- Lowest value at -40 MND compared to enemy: 10%
	-- Highest value at +40 MND compared to enemy: 30%
	-- *When merit level is increased by 1, the effect is increased by 1%.
	sets.midcast['Paralyze II'] = set_combine(sets.midcast.enfeebMND, {
	})
	sets.midcast['Paralyze II'].Resistant = set_combine(sets.midcast.enfeebMND.Resistant, sets.midcast['Paralyze II'], {
	})

	-- MND potency mod
	-- Magic Accuracy Penalty = min(floor(dMND/5), 20) + 20 (caps at -40 macc)
	sets.midcast['Addle'] = set_combine(sets.midcast.enfeebMND, {
	})
	sets.midcast['Addle'].Resistant = set_combine(sets.midcast.enfeebMND.Resistant, sets.midcast['Addle'], {
	})

	-- MND potency mod
	-- Magic Accuracy Penalty = min(floor(dMND/5), 20) + 50 (caps at -70 macc)
	sets.midcast['Addle II'] = set_combine(sets.midcast.enfeebMND, {
	})
	sets.midcast['Addle II'].Resistant = set_combine(sets.midcast.enfeebMND.Resistant, sets.midcast['Addle II'], {
	})

	-- INT potency mod
	-- Lowest value at -80 player INT compared to enemy INT: 5
	-- Highest value at +120 player INT compared to enemy INT: 50
	sets.midcast['Blind'] = set_combine(sets.midcast.enfeebINT, {
	})
	sets.midcast['Blind'].Resistant = set_combine(sets.midcast.enfeebINT.Resistant, sets.midcast['Blind'], {
	})
	
	-- INT potency mod
	-- Lowest value at -80 player INT compared to enemy INT: 15
	-- Highest value at +120 player INT compared to enemy INT: 90
	-- 1 Merit: Potency = Floor(3/8)(dINT +120); potency caps at 15 and 90.
	-- 2 Merits: Potency = Floor(3/8)(dINT +123); potency caps at 16 and 91.
	-- 3 Merits: Potency = Floor(3/8)(dINT +125.5); potency caps at 17 and 92.
	-- 4 Merits: Potency = Floor(3/8)(dINT +128); potency caps at 18 and 93.
	-- 5 Merits: Potency = Floor(3/8)(dINT +130.7); potency caps at 19 and 94.
	sets.midcast['Blind II'] = set_combine(sets.midcast.enfeebINT, {
	})
	sets.midcast['Blind II'].Resistant = set_combine(sets.midcast.enfeebINT.Resistant, sets.midcast['Blind II'], {
	})

	-- Skill mod
	-- 500 skill cap
	sets.midcast['Poison'] = set_combine(sets.midcast.enfeebSkillCap, {
	})
	sets.midcast['Poison'].Resistant = set_combine(sets.midcast.enfeebSkillCap.Resistant, sets.midcast['Poison'], {
	})

	-- Skill mod
	-- No known cap
	sets.midcast['Poison II'] = set_combine(sets.midcast.enfeebFullSkill, {
	})
	sets.midcast['Poison II'].Resistant = set_combine(sets.midcast.enfeebFullSkill.Resistant, sets.midcast['Poison II'], {
	})

	-- Skill mod
	-- Max 3 damage/tick
	sets.midcast['Poisonga'] = set_combine(sets.midcast.enfeebSkillCap, {
	})
	sets.midcast['Poisonga'].Resistant = set_combine(sets.midcast.enfeebSkillCap.Resistant, sets.midcast['Poisonga'], {
	})

	-- Distract sets --
	-- MND and Skill mod

	-- Distract I (caps 125 skill for -25 eva, -35 eva cap with MND)
	sets.midcast['Distract'] = set_combine(sets.midcast['Enfeebling Magic'], {
		--head="Atro. Chapeau +3",
	})
	sets.midcast['Distract'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, sets.midcast['Distract'], {
	})
	-- Distract II (caps 350 skill for -40 eva, -50 eva cap with MND)
	sets.midcast['Distract II'] = set_combine(sets.midcast['Enfeebling Magic'], {
		--head="Atro. Chapeau +3",
	})
	sets.midcast['Distract II'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, sets.midcast['Distract II'], {
	})
	-- Distract III (caps 610 skill for -120 eva, -130 eva cap with MND)
	-- 476 Initial
	-- 90 gear
	-- 566 skill total
	sets.midcast['Distract III'] = set_combine(sets.midcast['Enfeebling Magic'], {
		ring1="Stikini Ring +1",
	})
	sets.midcast['Distract III'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, sets.midcast['Distract III'], {
	})
	-----------------------

	-- Frazzle sets --
	-- MND and Skill mod

	-- Frazzle I (caps 135 skill for -25 meva, -35 meva cap with MND)
	sets.midcast['Frazzle'] = set_combine(sets.midcast['Enfeebling Magic'], {
		head="Atro. Chapeau +3",
	})
	sets.midcast['Frazzle'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, sets.midcast['Frazzle'], {
	})
	-- Frazzle II (caps 365 skill for -40 meva, -50 meva cap with MND)
	sets.midcast['Frazzle II'] = set_combine(sets.midcast['Enfeebling Magic'], {
		head="Atro. Chapeau +3",
	})
	sets.midcast['Frazzle II'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, sets.midcast['Frazzle II'], {
	})
	-- Frazzle III (caps 625 skill for -120 meva, -130 meva cap with MND)
	-- 476 Initial
	-- 90 gear
	-- 566 skill total
	sets.midcast['Frazzle III'] = set_combine(sets.midcast['Enfeebling Magic'], {
		ring1="Stikini Ring +1",
	})
	sets.midcast['Frazzle III'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, sets.midcast['Frazzle III'], {
	})
	-----------------------

	sets.midcast['Dispelga'] =  set_combine(sets.midcast.MACC,{
		main="Daybreak",
		range="Ullr",
		neck="Dls. Torque +1",
	})
	
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast.MAB,{
	})
	
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{
		--sub="Enki Strap",
		range="Ullr",
		ammo=empty,
		head="Jhakri Coronal +2",
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
	})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAB,{
	})
			
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})
	
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.MACC,{
		neck="Erra Pendant",
		--ring1="Stikini Ring +1",
		ring1="Metamor. Ring +1",
		ring2="Evanescence Ring",
		back=gear.sucellos_mab,
		feet=gear.Merlinic_feet_nuke,
	})

	-- (DoT based on Dark Magic skill)
	sets.midcast['Bio III'] = set_combine(sets.midcast['Dark Magic'], {
	})
	
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
	})
	
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		neck="Erra Pendant",
		ring2="Evanescence Ring",
		waist="Fucho-no-Obi",
	})
	
	sets.midcast.Aspir = sets.midcast.Drain
	
	
	-- Sets for special buff conditions on spells.
			
	sets.buff.ComposureOther = set_combine(sets.midcast.EnhancingDuration,{
		--head="Leth. Chappel +1",
		--body="Lethargy Sayon +1",
		body="Viti. Tabard +3",
		--hands="Leth. Gantherots +1",
		legs="Leth. Fuseau +1",
		feet="Leth. Houseaux +1"
	})
	
	sets.buff.Saboteur = {hands="Leth. Gantherots +1"}
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = set_combine(sets.sharedResting,{
	})
	
	-- Idle sets
	sets.idle = {
		main="Daybreak",
		sub="Genmei Shield",
		ammo="Homiliary",
		head="Viti. Chapeau +3",
		neck="Loricate Torque +1",
		ear1="Ethereal Earring",
		ear2="Novia Earring",
		body="Jhakri Robe +2",
		hands="Nyame Gauntlets",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Fucho-no-Obi",
		legs="Carmine Cuisses +1",
		feet="Nyame Sollerets",
	}
	
	sets.idle.Town = set_combine(sets.idle,{
		--ammo="Regal Gem",
		neck="Dls. Torque +1",
		body="Councilor's Garb",
		hands="Regal Cuffs",
		back=gear.sucellos_mnd,
	})
	
	sets.idle.Weak = set_combine(sets.idle,{
	})
	
	-- Total: DT 54%, PDT 5% + 20% (PDT Staff), MDT 5%
	-- <36%: use Shadow Mantle
	sets.idle.PDT = set_combine(sets.idle,{
		--main=gear.Staff.PDT,
		-- DT 3%
		ammo="Staunch Tathlum +1",
		-- DT 6%
		head="Malignance Chapeau",
		-- DT 6%
		neck="Loricate Torque +1",
		-- DT 9%
		body="Malignance Tabard",
		-- DT 5%
		hands="Malignance Gloves",
		-- PDT 5% MDT 5%
		ring1="Dark Ring",
		-- DT 10%
		ring2="Defending Ring",
		-- DT 5%
		back="Moonbeam Cape",
		-- DT 6%
		legs="Aya. Cosciales +2",
		-- DT 4%
		feet="Malignance Boots",
	})
	
	-- DT: 54%
	-- MDT: 7%
	-- MDB: 27
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.idle.MDT = set_combine(sets.idle,{
		-- DT 3%
		ammo="Staunch Tathlum +1",
		-- DT 6% MDB 5
		head="Malignance Chapeau",
		-- DT 6%
		neck="Loricate Torque +1",
		-- DT 9% MDB 8
		body="Malignance Tabard",
		-- DT 5% MDB 4
		hands="Malignance Gloves",
		-- PDT 5% MDT 5%
		ring1="Dark Ring",
		-- DT 10%
		ring2="Defending Ring",
		-- DT 5%
		back="Moonbeam Cape",
		-- DT 6% MDB 5
		legs="Aya. Cosciales +2",
		-- DT 4% MDB 5
		feet="Malignance Boots",
	})
	
	
	-- Defense sets
	
	sets.defense.PDT = set_combine(sets.idle.PDT,{
	})
	
	
	sets.defense.MDT = set_combine(sets.idle.MDT,{
	})
	
	sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}

	-- 41% (40% cap), 24% II
	sets.magic_burst = set_combine(sets.midcast.MAB, {
		-- INT 4 MACC 8 MAB 4
		ammo="Pemphredo Tathlum",
		--head=gear.Merlinic_head_burst,
		-- 6% II 6% INT 38 MACC 40 MAB 33
		head="Ea Hat",
		-- 10%
		neck="Mizu. Kubikazari",
		-- INT 10 MAB 7
		ear2="Regal Earring",
		--body="Amalric Doublet",
		-- 8% II 8% INT 43 MACC 42 MAB 39
		body="Ea Houppelande",
		-- 6% II INT 36 MACC 20 MAB 53
		--hands=gear.Amalric_hands_hq_D,
		-- 5% II 5% INT 35 MACC 39 MAB 30
		hands="Ea Cuffs",
		-- 5% II
		ring1="Mujin Band",
		-- 2%
		--ring2="Jhakri Ring",
		back=gear.sucellos_mab,
		legs=gear.Merlinic_legs_nuke,
		-- 4% II 4% MACC 38 MAB 27
		--feet="Ea Pigaches",
		-- INT 30 MACC 43 MAB 55
		--feet="Vitiation Boots +3"
		-- 7% INT 44 MACC 42 MAB 39
		feet="Jhakri Pigaches +2",
		-- INT 21 MACC 20 MAB 52
		--feet=gear.Amalric_feet_hq_D,
	})

	sets.magic_burst.Resistant = set_combine(sets.magic_burst,{
		sub="Enki Strap",
		head="Jhakri Coronal +2",
		hands="Regal Cuffs",
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
	})
	
	-- Engaged sets
	
	-- Variations for TP weapon and (optional) offense/defense modes.	Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	-- Haste: 28%
	sets.engaged = {
		ammo="Ginsen",
		-- 8%
		head="Blistering Sallet +1",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Sherida Earring",
		-- 4%
		body="Ayanmo Corazza +2",
		-- 4%
		hands="Malignance Gloves",
		ring1="Ilabrat Ring",
		ring2="Hetairoi Ring",
		back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		-- 9%
		legs="Aya. Cosciales +2",
		-- 3%
		--feet="Aya. Gambieras +2",
		feet="Malignance Boots",
	}
	
	-- Haste: 30%
	sets.engaged.Acc = set_combine(sets.engaged,{
		ammo="Ginsen",
		neck="Subtlety Spec.",
		ear1="Crep. Earring",
		ear2="Telos Earring",
		ring1="Cacoethic Ring +1",
		ring2="Jhakri Ring",
		back="Aurist's Cape +1",
		waist="Reiki Yotai",
	})
	sets.engaged.enspell = set_combine(sets.engaged,{
		--range="Ullr",
		head="Umuthi Hat",
		neck="Sanctity Necklace",
		body="Ayanmo Corazza +2",
		ear2="Regal Earring",
		hands="Aya. Manopolas +2",
		ring1="Ilabrat Ring",
		back="Ghostfyre Cape",
		legs="Jhakri Slops +2",
	})
	sets.engaged.enspellDW = set_combine(sets.engaged.enspell,{
		ear1="Suppanomimi",
		ring1="Freke Ring",
		ring2="Haverton Ring",
		waist="Reiki Yotai",
		legs=gear.Carmine_legs_hq_D,
		feet=gear.Carmine_feet_hq_B,
	})
	sets.engaged.enspell.Acc = set_combine(sets.engaged.Acc, sets.engaged.enspell,{
		back="Aurist's Cape +1",
		feet="Malignance Boots",
	})
	sets.engaged.enspellDW.Acc = set_combine(sets.engaged.Acc, sets.engaged.enspell,sets.engaged.enspellDW,{
		back="Aurist's Cape +1",
		feet="Malignance Boots",
	})

	sets.engaged.DefenseBase = set_combine(sets.Malignance,{
		neck="Loricate Torque +1",
		body="Ayanmo Corazza +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
	})
	
	sets.engaged.Defense = set_combine(sets.engaged,sets.engaged.DefenseBase,{
	})
	sets.engaged.Defense.Acc = set_combine(sets.engaged.Acc,sets.engaged.DefenseBase,{
	})
	sets.engaged.Defense.enspell = set_combine(sets.engaged.enspell,sets.engaged.DefenseBase,{
	})
	sets.engaged.Defense.enspellDW = set_combine(sets.engaged.enspellDW,sets.engaged.DefenseBase,{
	})
	sets.engaged.Defense.enspell.Acc = set_combine(sets.engaged.enspell.Acc,sets.engaged.DefenseBase,{
	})
	sets.engaged.Defense.enspellDW.Acc = set_combine(sets.engaged.enspellDW.Acc,sets.engaged.DefenseBase,{
	})

	-- not combining these with any specific engaged sets so it can 
	-- automatically combine with whichever current engaged set you are using
	sets.engaged.TH = set_combine(sets.sharedTH,{
	})
	sets.engaged.DT = set_combine(sets.Malignance,{
	})

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(stateField, newValue, oldValue)
	if state.Weapon.value == true then
		disable('main','sub','range','ammo')
	else
		enable('main','sub','range','ammo')
	end

	if state.RangeLock.value == true then
		equip(sets.EnforceMACCResistant)
		disable('range','ammo')
	elseif state.Weapon.value ~= true then
		enable('range','ammo')
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' then
		if (spell.target.model_size + spell.range * 1.642276421172564) < spell.target.distance then	
			add_to_chat(7,"--- Target "..spell.target.type.." ["..player.target.name.."] out of range of ["..spell.name.."] [ Distance: "..spell.target.distance.."] ---")
			cancel_spell()
		end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
		equip(sets.buff.Saboteur)

		if spell == 'Dispel*' or state.CastingMode == 'Resistant' then
			equip(sets.EnforceMACCResistant)
		end
	elseif spell.skill == 'Enhancing Magic' then
		if not EnhancingDurationSkip:contains(spell.english) then
			equip(sets.midcast.EnhancingDuration)
		end
		if buffactive.composure and spell.target.type == 'PLAYER' then
			equip(sets.buff.ComposureOther)
		elseif spellMap == 'Refresh' and spell.target.type == 'SELF' then
			equip(sets.midcast.RefreshSelf)
		end
	elseif spellMap == 'Cursna' and spell.target.type == 'SELF' then
		equip(sets.midcast.CursnaSelf)
	elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
		equip(sets.midcast.CureSelf)
	elseif spell.skill == 'Elemental Magic' then
		if state.MagicBurst.value then
			equip(sets.magic_burst)
		end 

		if state.CastingMode == 'Resistant' then
			equip(sets.EnforceMACCResistant)
		end
	end

	if state.TreasureMode.value ~= false and spell.target.type ~= 'SELF' and spell.target.type ~= 'PLAYER' then
		equip(sets.sharedTH)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "doom" then
		if gain then
			equip(sets.buff.Doom)
			send_command('@input /echo ==== Doomed. ====')
			disable()
		else
			enable()
			handle_equipping_gear(player.status)
		end
	end

end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if state.CP.current == 'on' then
		equip(sets.CP)
		disable('back')
	else
		enable('back')
	end

	if state.Warp.current == 'on' then
		equip(sets.Warp)
		disable('ring1','ring2')
	else
		enable('ring1','ring2')
	end

	if state.Weapon.current == 'on' then
		disable('main','sub')
	else
		enable('main','sub')
	end

	if state.Neck.current == 'on' then
		equip(sets.Neck)
		disable('neck')
	else
		enable('neck')
	end

	if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end

	if not buffactive['Protect'] then
		idleSet = set_combine(idleSet, sets.noprotect)
	end

	return idleSet
end

function customize_melee_set(meleeSet)
	if state.CP.current == 'on' then
		equip(sets.CP)
		disable('back')
	else
		enable('back')
	end

	if state.Warp.current == 'on' then
		equip(sets.Warp)
		disable('ring1','ring2')
	else
		enable('ring1','ring2')
	end

	if state.Weapon.current == 'on' then
		disable('main','sub')
	else
		enable('main','sub')
	end

	if state.Neck.current == 'on' then
		equip(sets.Neck)
		disable('neck')
	else
		enable('neck')
	end

	if state.EngagedDT.current == 'on' then
		meleeSet = set_combine(meleeSet, sets.engaged.DT)
	end

	if state.TreasureMode.current == 'on' then
		meleeSet = set_combine(meleeSet, sets.engaged.TH)
	end

	return meleeSet
end