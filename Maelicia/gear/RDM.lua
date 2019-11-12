function user_setup()

	state.OffenseMode:options('None', 'Normal', 'Acc')
	--state.OffenseMode:options('None')
	state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT', 'MDT')

	state.MagicBurst = M(false, 'Magic Burst')

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
	send_command('bind @` gs c cycle MagicBurst')

	send_command('alias rdmfulldebuff input /ma "Inundation" <t>;wait 5;input /ma "Distract II" <t>;wait 5;input /ma "Frazzle II" <t>;wait 5;input /ma "Dia III" <t>;wait 5;input /ma "Paralyze II" <t>;wait 5;input /ma "Slow II" <t>;wait 5;input /ma "Blind II" <t>;wait 5;input /ma "Poison II" <t>;wait 5;input /ma "Addle" <t>;')
	send_command('alias rdmdddebuff input /ma "Inundation" <t>;wait 5;input /ma "Distract II" <t>;wait 5;input /ma "Dia III" <t>;wait 5;input /ma "Poison II" <t>;')
	send_command('alias rdmtankdebuff input /ma "Paralyze II" <t>;wait 5;input /ma "Slow II" <t>;wait 5;input /ma "Blind II" <t>;wait 5;input /ma "Addle" <t>;')

	send_command('alias rdmmeleebuff input /ma "Haste II" <me>;wait 5;input /ma "Refresh II" <me>;wait 5;input /ma "Temper" <me>;wait 5;input /ma "Gain-Dex" <me>;wait 5;input /ma "Ice Spikes" <me>;wait 5;input /ma "Aquaveil" <me>;wait 5;input /ma "Phalanx II" <me>;wait 5;input /ma "Stoneskin" <me>;wait 5;input /ma "Regen II" <me>;')

	global_aliases()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind @`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body="Viti. Tabard +3"}
	
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Atro. Chapeau +1",
		ear1="Roundel Earring",
		body="Viti. Tabard +3",
		hands="Lurid Mitts",
		legs="Gyve Trousers",
		feet="Vanya Clogs"
	}
			
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	-- Fast cast sets for spells
	
	-- 78%/39% Total + 8% (JP) + 30% (RDM) (80/40 cap)
	sets.precast.FC = {
		-- 4%
		main="Grioavolr",
		sub="Enki Strap",
		--ammo="Impatiens",
		-- 12%
		head="Atro. Chapeau +1",
		-- 4%
		neck="Voltsurge Torque", 
		-- 4 %
		ear1="Malignance Earring",
		-- 2%
		ear2="Loquac. Earring",
		-- 15%
		body="Viti. Tabard +3",
		-- 7%
		hands="Gendewitha Gages",
		-- 2%
		ring1="Prolix Ring",
		-- 4%
		ring2="Kishar Ring",
		-- 10%
		back=gear.sucellos_mnd,
		-- 3%
		waist="Witful Belt",
		-- 7%
		legs="Psycloth Lappas",
		-- 4%
		feet="Chelona Boots"
	}
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		back="Pahtli Cape",
		feet=gear.Vanya_feet_B
	})
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
	
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

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head=empty,
		body="Twilight Cloak"
	})
		 
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Viti. Chapeau +3",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Ayanmo Corazza +2",
		hands="Jhakri Cuffs +2",
		ring1="Rajas Ring",
		ring2="Petrov Ring",
		back="Atheling Mantle",
		waist="Fotia Belt",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"
	}
	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		head=gear.Merlinic_head_nuke,
		--neck="Sanctity Necklace",
		ear1="Malignance Earring",
		ear2="Regal Earring",
		body="Ea Houppelande",
		hands="Jhakri Cuffs +2",
		ring1="Freke Ring",
		ring2="Strendu Ring",
		back=gear.sucellos_mab,
		--waist="Yamabuki-no-Obi",
		legs=gear.Merlinic_legs_nuke,
		feet=gear.Merlinic_feet_burst,
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
		neck="Fotia Gorget",
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
	
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
	});
	
	sets.midcast.MACC = {
		--main=gear.MainStaff,
		main="Grioavolr",
		sub="Enki Strap",
		--ammo="Regal Gem",
		range="Ullr",
		--head=gear.Chironic_head_nuke,
		head="Viti. Chapeau +3",
		--head="Atro. Chapeau +3",
		neck="Dls. Torque +1",
		--neck="Incanter's Torque",
		ear1="Malignance Earring",
		--ear2="Hermetic Earring",
		ear2="Regal Earring",
		--body="Jhakri Robe +2",
		body="Atrophy Tabard +2",
		hands="Jhakri Cuffs +2",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back=gear.sucellos_mnd,
		waist="Luminary Sash",
		legs="Chironic Hose",
		feet="Jhakri Pigaches +2"
	}
	
	sets.midcast.MAB = {
		--main=gear.MainStaff,
		main="Grioavolr",
		sub="Enki Strap",
		range="Ullr",
		--ammo="Ghastly Tathlum",
		head=gear.Merlinic_head_nuke,
		neck="Sanctity Necklace",
		ear1="Malignance Earring",
		ear2="Regal Earring",
		body="Ea Houppelande",
		hands="Jhakri Cuffs +2",
		ring1="Freke Ring",
		ring2="Strendu Ring",
		back=gear.sucellos_mab,
		waist=gear.ElementalObi,
		legs=gear.Merlinic_legs_nuke,
		feet=gear.Merlinic_feet_burst,
	}
	
	sets.midcast['Healing Magic'] = {
		head="Hyksos Khat",
		neck="Incanter's Torque",
		body="Viti. Tabard +3",
		hands=gear.Vanya_hands_B,
		ring1="Sirona's Ring",
		ring2="Ephedra Ring",
		legs="Carmine Cuisses +1",
		feet=gear.Vanya_feet_B
	}
	
	-- 50% Total
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'],{
		-- 22%
		main="Tamaxchi",
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
		body="Vrikodara Jupon",
		--body="Viti. Tabard +3",
		hands=gear.Vanya_hands_B,
		back=gear.sucellos_mnd,
		waist="Luminary Sash",
		-- 10%
		legs="Atrophy Tights +1",
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
		ring1="Ephedra Ring",
		ring2="Ephedra Ring",
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
		-- 18 DUR
		hands="Atrophy Gloves +2",
		-- 5
		ring1="Stikini Ring",
		-- 5
		ring2="Stikini Ring",
		-- 20 DUR
		back=gear.sucellos_mnd,
		-- 17
		--legs="Atrophy Tights +1",
		-- 18
		legs="Carmine Cuisses +1",
		-- 25 30 DUR
		feet="Leth. Houseaux +1"
	}
	
	-- 504 total, 45 Gear + 456 (420 base + 36 Gift), 88 DUR (68 + 20 JP)
	-- Using as many of Empy pieces as possible to maximize Composure bonus
	sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'],{
		-- 10 DUR
		sub="Ammurapi Shield",
		--head="Leth. Chappel +1",
		-- 10 
		--neck="Incanter's Torque",
		neck="Dls. Torque +1",
		ear1="Malignance Earring",
		--body="Lethargy Sayon +1",
		-- 23 15 DUR
		body="Viti. Tabard +3",
		-- 18 DUR
		hands="Atrophy Gloves +2",
		-- 5
		ring1="Stikini Ring",
		-- 5
		ring2="Stikini Ring",
		-- 20 DUR
		back=gear.sucellos_mnd,
		legs="Leth. Fuseau +1",
		-- 25 30 DUR
		feet="Leth. Houseaux +1"
	})

	-- INT potency mod for spikes
	-- ~105 +208 INT
	sets.midcast.spikes = set_combine(sets.midcast.EnhancingDuration,{
		-- 19 INT
		main=gear.MainStaff,
		-- 10 INT
		sub="Enki Strap",
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
		body="Atrophy Tabard +2",
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
		head="Chironic Hat"
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
	-- 87 gear
	-- 563 total
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.MACC,{
		main=gear.MainStaff,
		sub="Enki Strap",
		range="Ullr",
		-- effect +10
		--ammo="Regal Gem",
		-- 26 3s x # Merit DUR
		head="Viti. Chapeau +3",
		-- 10
		--neck="Incanter's Torque",
		neck="Dls. Torque +1",
		-- 19
		body="Atrophy Tabard +2",
		-- effect +14
		--body="Lethargy Sayon +1",
		-- 19, Saboteur +12
		hands="Leth. Gantherots +1",
		-- Duration +20%
		-- hands="Regal Cuffs",
		-- Duration +10%
		ring1="Kishar Ring",
		-- 5
		--ring1="Stikini Ring",
		-- 5
		ring2="Stikini Ring",
		back=gear.sucellos_mnd,
		-- 7
		waist="Rumination Sash",
		-- 13 Immunobreak +1
		legs=gear.Chironic_legs_nuke,
		-- 17
		feet="Skaoi Boots",
		-- 14
		--feet="Vitiation Boots +2"
	})

	-- For enfeebs with no known skill caps
	-- 476 Initial
	-- 108 gear
	-- 584 total
	sets.midcast.enfeebFullSkill = set_combine(sets.midcast['Enfeebling Magic'], {
		-- 21
		--body="Atrophy Tabard +3",
		-- 5
		ring1="Stikini Ring",
	})

	-- For MND potency based enfeebs
	sets.midcast.enfeebMND = set_combine(sets.midcast['Enfeebling Magic'], {
		--ammo="Regal Gem",
		head="Viti. Chapeau +3",
		neck="Dls. Torque +1",
		waist="Luminary Sash",
	})

	-- For INT potency based enfeebs
	sets.midcast.enfeebINT = set_combine(sets.midcast['Enfeebling Magic'], {
		neck="Dls. Torque +1",
		-- 10 INT
		ring1="Freke Ring",
		-- 6 INT
		ring2="Persis Ring",
		back=gear.sucellos_mab,
		legs=gear.Merlinic_legs_nuke,
		feet="Jhakri Pigaches +2",
		--feet="Vitiation Boots +3",
	})

	-- For enfeebs with static values (use duration+ gear)
	sets.midcast.enfeebStatic = set_combine(sets.midcast['Enfeebling Magic'], {
		--head="Atro. Chapeau +3",
		neck="Dls. Torque +1",
		--body="Atrophy Tabard +3",
		-- Duration +20%
		-- hands="Regal Cuffs",
		-- Duration +10%
		ring1="Kishar Ring",
		--feet="Vitiation Boots +2",
	})

	-- For enfeebs with 500 skill caps
	-- 476 Initial
	-- 28 gear
	-- 504 total
	sets.midcast.enfeebSkillCap = set_combine(sets.midcast['Enfeebling Magic'], {
		--head="Atro. Chapeau +3",
		neck="Dls. Torque +1",
		hands="Jhakri Cuffs +2",
		waist="Luminary Sash",
		feet="Jhakri Pigaches +2",
	})

	-- Static value (use duration+ gear)
	sets.midcast['Dia'] = set_combine(sets.midcast.enfeebStatic, {
		ammo="Regal Gem",
	})
	-- Static value (use duration+ gear)
	sets.midcast['Dia II'] = set_combine(sets.midcast.enfeebStatic, {
		ammo="Regal Gem",
	})	
	-- Static value (use duration+ gear)
	sets.midcast['Dia III'] = set_combine(sets.midcast.enfeebStatic, {
		ammo="Regal Gem",
	})

	sets.midcast['Dispel*'] = set_combine(sets.midcast.MACC, {
		neck="Dls. Torque +1",
	})

	-- MND potency mod
	-- Lowest value at -75 MND compared to enemy: About 7.3%
	-- Highest value at +75 MND compared to enemy: About 29.2%
	sets.midcast['Slow'] = set_combine(sets.midcast.enfeebMND, {
	})
	-- MND potency mod
	-- Lowest value at -75 MND compared to enemy: About 12.5%
	-- Highest value at +75 MND compared to enemy: About 35.1%
	-- *When merit level is increased by 1, the effect is increased by about 1%.
	sets.midcast['Slow II'] = set_combine(sets.midcast.enfeebMND, {
	})

	-- MND potency mod
	-- Lowest value at -40 MND compared to enemy: 5%
	-- Highest value at +40 MND compared to enemy: 25%
	sets.midcast['Paralyze'] = set_combine(sets.midcast.enfeebMND, {
	})
	
	-- MND potency mod
	-- Lowest value at -40 MND compared to enemy: 10%
	-- Highest value at +40 MND compared to enemy: 30%
	-- *When merit level is increased by 1, the effect is increased by 1%.
	sets.midcast['Paralyze II'] = set_combine(sets.midcast.enfeebMND, {
	})

	-- MND potency mod
	-- Magic Accuracy Penalty = min(floor(dMND/5), 20) + 20 (caps at -40 macc)
	sets.midcast['Addle'] = set_combine(sets.midcast.enfeebMND, {
	})

	-- MND potency mod
	-- Magic Accuracy Penalty = min(floor(dMND/5), 20) + 50 (caps at -70 macc)
	sets.midcast['Addle II'] = set_combine(sets.midcast.enfeebMND, {
	})

	-- INT potency mod
	-- Lowest value at -80 player INT compared to enemy INT: 5
	-- Highest value at +120 player INT compared to enemy INT: 50
	sets.midcast['Blind'] = set_combine(sets.midcast.enfeebINT, {
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

	-- Skill mod
	-- 500 skill cap
	sets.midcast['Poison'] = set_combine(sets.midcast.enfeebSkillCap, {
	})

	-- Skill mod
	-- No known cap
	sets.midcast['Poison II'] = set_combine(sets.midcast.enfeebFullSkill, {
	})

	-- Skill mod
	-- Max 3 damage/tick
	sets.midcast['Poisonga'] = set_combine(sets.midcast.enfeebSkillCap, {
	})

	-- Distract sets --
	-- MND and Skill mod

	-- Distract I (caps 125 skill for -25 eva, -35 eva cap with MND)
	sets.midcast['Distract'] = set_combine(sets.midcast['Enfeebling Magic'], {
		--head="Atro. Chapeau +3",
	})
	-- Distract II (caps 350 skill for -40 eva, -50 eva cap with MND)
	sets.midcast['Distract II'] = set_combine(sets.midcast['Enfeebling Magic'], {
		--head="Atro. Chapeau +3",
	})
	-- Distract III (caps 610 skill for -120 eva, -130 eva cap with MND)
	-- 476 Initial
	-- 87 gear
	-- 563 skill total
	sets.midcast['Distract III'] = set_combine(sets.midcast['Enfeebling Magic'], {
		ring1="Stikini Ring",
	})
	-----------------------

	-- Frazzle sets --
	-- MND and Skill mod

	-- Frazzle I (caps 135 skill for -25 meva, -35 meva cap with MND)
	sets.midcast['Frazzle'] = set_combine(sets.midcast['Enfeebling Magic'], {
		--head="Atro. Chapeau +3",
	})
	-- Frazzle II (caps 365 skill for -40 meva, -50 meva cap with MND)
	sets.midcast['Frazzle II'] = set_combine(sets.midcast['Enfeebling Magic'], {
		--head="Atro. Chapeau +3",
	})
	-- Frazzle III (caps 625 skill for -120 meva, -130 meva cap with MND)
	-- 476 Initial
	-- 87 gear
	-- 563 skill total
	sets.midcast['Frazzle III'] = set_combine(sets.midcast['Enfeebling Magic'], {
		ring1="Stikini Ring",
	})
	-----------------------
	
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast.MAB,{
	})
	
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{
		sub="Enki Strap",
		range="Ullr",
		head="Jhakri Coronal +2",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
	})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAB,{
	})
			
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})
	
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.MACC,{
		neck="Erra Pendant",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
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
		main="Bolelabunga",
		sub="Genmei Shield",
		ammo="Homiliary",
		head="Viti. Chapeau +3",
		neck="Loricate Torque +1",
		ear1="Ethereal Earring",
		ear2="Novia Earring",
		body="Jhakri Robe +2",
		hands="Aya. Manopolas +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Mecisto. Mantle",
		--back="Moonbeam Cape",
		waist="Fucho-no-Obi",
		legs="Carmine Cuisses +1",
		feet=gear.Vanya_feet_B
	}
	
	sets.idle.Town = set_combine(sets.idle,{
		--ammo="Regal Gem",
		neck="Dls. Torque +1",
		body="Councilor's Garb",
		back=gear.sucellos_mnd,
	})
	
	sets.idle.Weak = set_combine(sets.idle,{
	})
	
	-- Total: 48% + 20% (PDT Staff)
	-- <36%: use Shadow Mantle
	sets.idle.PDT = set_combine(sets.idle,{
		main=gear.Staff.PDT,
		-- 3%
		ammo="Staunch Tathlum +1",
		-- 3%
		head="Blistering Sallet +1",
		-- 6%
		neck="Loricate Torque +1",
		-- 6%
		body="Ayanmo Corazza +2",
		-- 2%
		hands="Aya. Manopolas +2",
		-- 4%
		ring1=gear.DarkRing.physical,
		-- 10%
		ring2="Defending Ring",
		-- 5%
		back="Moonbeam Cape",
		-- 6%
		legs="Aya. Cosciales +2",
		-- 3%
		feet="Aya. Gambieras +2",
	})
	
	-- MDT: 46%
	-- MDB: 23
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.idle.MDT = set_combine(sets.idle,{
		-- 3%
		ammo="Staunch Tathlum +1",
		-- 6 2%
		head="Chironic Hat",
		-- 6%
		neck="Loricate Torque +1",
		-- 7
		--body="Atrophy Tabard +3",
		-- 6% 6
		body="Ayanmo Corazza +2",
		-- 2 2%
		hands="Aya. Manopolas +2",
		-- 3%
		ring1=gear.DarkRing.physical,
		-- 10%
		ring2="Defending Ring",
		-- 5%
		back="Moonbeam Cape",
		-- 5 6%
		legs="Aya. Cosciales +2",
		-- 5 3%
		feet="Aya. Gambieras +2",
	})
	
	
	-- Defense sets
	
	sets.defense.PDT = set_combine(sets.idle.PDT,{
	})
	
	
	sets.defense.MDT = set_combine(sets.idle.MDT,{
	})

	sets.idle.MDTOnca = {
		-- 6 2%
		head="Chironic Hat",
		-- 5%
		neck="Loricate Torque +1",
		-- 3%
		ear1="Etiolation Earring",
		ear2="Arete del Luna",
		-- 12
		body="Onca Suit",
		hands=empty,
		-- 5%
		back="Moonbeam Cape",
		--back="Tantalic Cape",
		legs=empty,
		feet=empty
	}
	
	sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}

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
		-- 5% II
		--hands="Amalric Gages",
		-- 5% II 5% INT 35 MACC 39 MAB 30
		hands="Ea Cuffs",
		-- 5% II
		ring1="Mujin Band",
		-- 2%
		ring2="Jhakri Ring",
		back=gear.sucellos_mab,
		legs=gear.Merlinic_legs_nuke,
		-- 4% II 4% MACC 38 MAB 27
		feet="Ea Pigaches",
	})

	sets.magic_burst.Resistant = set_combine(sets.magic_burst,{
		sub="Enki Strap",
		head="Jhakri Coronal +2",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
	})
	
	-- Engaged sets
	
	-- Variations for TP weapon and (optional) offense/defense modes.	Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	-- Haste: 25%
	sets.engaged = {
		ammo="Ginsen",
		-- 6%
		head="Aya. Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Sherida Earring",
		-- 4%
		body="Ayanmo Corazza +2",
		-- 3%
		hands="Atrophy Gloves +2",
		ring1="Rajas Ring",
		ring2="Cacoethic Ring",
		back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		-- 9%
		legs="Aya. Cosciales +2",
		-- 3%
		feet="Aya. Gambieras +2"
	}
	
	-- Haste: 27%
	sets.engaged.Acc = set_combine(sets.engaged,{
		ammo="Ginsen",
		neck="Subtlety Spec.",
		ear1="Digni. Earring",
		ear2="Telos Earring",
		-- 2%
		back="Ground. Mantle +1",
	})
	
	sets.engaged.Defense = set_combine(sets.engaged,{
		head="Aya. Zucchetto +2",
		neck="Loricate Torque +1",
		body="Ayanmo Corazza +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2"
	})

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
		equip(sets.buff.Saboteur)
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