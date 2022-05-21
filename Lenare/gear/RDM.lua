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

	gear.sucellos_mab = { name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}}
	gear.sucellos_mnd = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','"Fast Cast"+10',}}
	gear.default.obi_back = gear.sucellos_mab

	-- list of spell that has its own sets defined below and should not default to using EnhancingDuration midcast set
	EnhancingDurationSkip = S{'Aquaveil', 'Blaze Spikes', 'Ice Spikes', 'Regen', 'Regen II', 'Refresh', 'Refresh II', 'Refresh III',
		'Shock Spikes', 'Stoneskin', 'Temper', 'Temper II'}

	set_macro_page(1, 6)

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

	send_command('alias rdmfulldebuff input /ma "Inundation" <t>;wait 5;input /ma "Distract III" <t>;wait 5;input /ma "Frazzle III" <t>;wait 5;input /ma "Dia III" <t>;wait 5;input /ma "Paralyze II" <t>;wait 5;input /ma "Slow II" <t>;wait 5;input /ma "Blind II" <t>;wait 5;input /ma "Poison II" <t>;wait 5;input /ma "Addle II" <t>;')
	send_command('alias rdmdddebuff input /ma "Inundation" <t>;wait 5;input /ma "Distract III" <t>;wait 5;input /ma "Dia III" <t>;wait 5;input /ma "Poison II" <t>;')
	send_command('alias rdmtankdebuff input /ma "Paralyze II" <t>;wait 5;input /ma "Slow II" <t>;wait 5;input /ma "Blind II" <t>;wait 5;input /ma "Addle II" <t>;')

	send_command('alias rdmmeleebuff input /ma "Haste II" <me>;wait 5;input /ma "Refresh III" <me>;wait 5;input /ma "Temper II" <me>;wait 5;input /ma "Gain-Dex" <me>;wait 5;input /ma "Ice Spikes" <me>;wait 5;input /ma "Aquaveil" <me>;wait 5;input /ma "Phalanx II" <me>;wait 5;input /ma "Stoneskin" <me>;wait 5;input /ma "Regen II" <me>;')

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
		--body="Malignance Tabard",
		hands="Malignance Gloves",
		--legs="Malignance Tights",
		feet="Malignance Boots",
	}
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Chainspell'] = {body="Viti. Tabard +3"}
	
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Atro. Chapeau +3",
		ear1="Roundel Earring",
		ear2="Sjofn Earring",
		body="Atrophy Tabard +3",
		hands="Atrophy Gloves +3",
		legs="Merlinic Shalwar",
		feet="Vanya Clogs"
	}
			
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	-- Fast cast sets for spells
	
	-- 30% Base RDM traits
	-- 8% JP
	-- 79% gear (42 needed for 80%)
	-- (80/40 cap) Note: Quick Magic does not allow midcast sets
	sets.precast.FC = {
		-- 10%
		--main="Emissary",
		--main="Grioavolr",
		--sub="Enki Strap",
		--ammo="Impatiens",
		-- 16%
		head="Atro. Chapeau +3",
		-- 4%
		neck="Baetyl Pendant",
		-- 2%
		ear1="Loquac. Earring",
		-- 4%
		ear2="Malignance Earring",
		-- 15%
		body="Viti. Tabard +3",
		-- 7%
		hands="Gendewitha Gages",
		-- 4%
		ring1="Kishar Ring",
		-- 5%
		ring2="Weather. Ring",
		-- 10%
		back=gear.sucellos_mnd,
		-- 3%
		--waist="Witful Belt",
		-- 5%
		waist="Embla Sash",
		-- 7%
		legs="Psycloth Lappas",
		-- 8%
		--feet="Carmine Greaves +1",
	}
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		ear1="Mendi. Earring",
		back="Pahtli Cape",
		feet=gear.Vanya_feet_B
	})
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak"})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"
	})
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
		head="Umuthi Hat",
	})
	
	sets.precast.FC['Enfeebling Magic'] = set_combine(sets.precast.FC, {
		head="Leth. Chappel +1"
	})
		 
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Viti. Chapeau +3",
		neck="Asperity Necklace",
		ear1="Moonshade Earring",
		ear2="Sherida Earring",
		body="Ayanmo Corazza +2",
		--hands="Jhakri Cuffs +2",
		hands="Atrophy Gloves +3",
		ring1="Rajas Ring",
		ring2="Cacoethic Ring",
		back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		legs="Atrophy Tights +2",
		feet="Jhakri Pigaches +2"
	}
	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		head="Jhakri Coronal +2",
		neck="Baetyl Pendant",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		body=gear.Merlinic_body_nuke,
		hands="Jhakri Cuffs +2",
		ring1="Acumen Ring",
		ring2="Jhakri Ring",
		back=gear.sucellos_mab,
		waist="Eschan Stone",
		legs=gear.Merlinic_legs_nuke,
		feet="Vitiation Boots +3",
	})
	
	-- Specific weaponskill sets.	Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB, {
		neck=gear.ElementalGorget
	})
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		neck=gear.ElementalGorget
	})
	
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		ammo="Regal Gem",
		head="Viti. Chapeau +3",
		neck=gear.ElementalGorget,
		ear1="Moonshade Earring",
		body="Viti. Tabard +3",
		--hands="Jhakri Cuffs +2",
		hands="Atrophy Gloves +3",
		legs="Jhakri Slops +2",
		feet="Vitiation Boots +3",
	})
	sets.precast.WS['Death Blossom'] = set_combine(sets.precast.WS, {
		neck=gear.ElementalGorget
	})
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.MAB,{
		neck=gear.ElementalGorget
	})
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		neck=gear.ElementalGorget
	})
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
		neck=gear.ElementalGorget
	})
	
	-- Midcast Sets
	
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
	});
	
	sets.midcast.MACC = {
		main=gear.MaccStaff,
		sub="Enki Strap",
		ammo=empty,
		range="Ullr",
		--ammo="Regal Gem",
		head="Atro. Chapeau +3",
		neck="Dls. Torque +1",
		ear1="Snotra Earring",
		ear2="Malignance Earring",
		body="Atrophy Tabard +3",
		hands="Regal Cuffs",
		ring1="Stikini Ring",
		ring2="Crepuscular Ring",
		back=gear.sucellos_mnd,
		waist="Luminary Sash",
		legs="Chironic Hose",
		feet="Vitiation Boots +3",
	}
	
	sets.midcast.MAB = {
		--main=gear.MainStaff,
		--main="Grioavolr",
		--sub="Niobid Strap",
		--sub="Enki Strap",
		main="Septoptic +1",
		sub="Ammurapi Shield",
		range="Ullr",
		--ammo="Ghastly Tathlum",
		head=gear.Merlinic_head_burst,
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Malignance Earring",
		body=gear.Merlinic_body_nuke,
		hands="Amalric Gages",
		ring1="Acumen Ring",
		ring2="Jhakri Ring",
		back=gear.ElementalCape,
		waist=gear.ElementalObi,
		legs=gear.Merlinic_legs_nuke,
		feet="Vitiation Boots +3",
	}
	
	sets.midcast['Healing Magic'] = {
		head="Hyksos Khat",
		neck="Incanter's Torque",
		body="Viti. Tabard +3",
		hands=gear.Vanya_hands_B,
		ring1="Sirona's Ring",
		ring2="Haoma's Ring",
		legs="Carmine Cuisses +1",
		feet=gear.Vanya_feet_B
	}
	
	-- 49% Total
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'],{
		-- 22%
		main="Tamaxchi",
		sub="Ammurapi Shield",
		ammo="Regal Gem",
		head="Befouled Crown",
		neck="Incanter's Torque",
		--ear1="Lifestorm Earring",
		-- 5%
		ear1="Mendi. Earring",
		-- 5%
		ear2="Roundel Earring",
		--ear2="Malignance Earring",
		body="Viti. Tabard +3",
		-- 16%
		--hands=gear.Telchine_hands_cure,
		hands=gear.Vanya_hands_B,
		back=gear.sucellos_mnd,
		waist="Luminary Sash",
		-- 12%
		legs="Atrophy Tights +2",
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
		feet="Gende. Galoshes"
	})

	sets.midcast.CursnaSelf = set_combine(sets.midcast.Cursna,{
		waist="Gishdubar Sash",
	})
	
	-- 562 total, 103 Gear + 456 (420 base + 36 Gift), 120 DUR (95 + 20 JP) + 5 DUR (Grioavolr aug)
	sets.midcast['Enhancing Magic'] = {
		-- 5 DUR
		--main="Grioavolr",
		--sub="Enki Strap",
		main="Septoptic +1",
		-- 10 DUR
		sub="Ammurapi Shield",
		-- 16
		head="Befouled Crown",
		-- 10 
		neck="Incanter's Torque",
		ear1="Lifestorm Earring",
		-- ear2="Andoaa Earring", -- don't have
		ear2="Malignance Earring",
		-- 23 15 DUR
		body="Viti. Tabard +3",
		-- 21 DUR
		hands="Atrophy Gloves +3",
		-- 5
		ring1="Stikini Ring",
		-- 5
		ring2="Stikini Ring",
		-- 10 DUR
		waist="Embla Sash",
		-- 20 DUR
		back=gear.sucellos_mnd,
		-- 21
		legs="Atrophy Tights +2",
		-- 18
		--legs="Carmine Cuisses +1",
		-- 25 30 DUR
		feet="Leth. Houseaux +1"
	}
	
	-- 514 total, 58 Gear + 456 (420 base + 36 Gift), 140 DUR (115 + 20 JP) + 5 DUR (Grioavolr aug)
	-- Using as many of Empy pieces as possible to maximize Composure bonus
	sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'],{
		-- 5 DUR
		--main="Grioavolr",
		--sub="Enki Strap",
		main="Septoptic +1",
		-- 10 DUR
		sub="Ammurapi Shield",
		head="Leth. Chappel +1",
		-- 10 
		--neck="Incanter's Torque",
		-- 20 DUR
		neck="Dls. Torque +1",
		--body="Lethargy Sayon +1",
		-- 23 15 DUR
		body="Viti. Tabard +3",
		-- 21 DUR
		hands="Atrophy Gloves +3",
		-- 5
		ring1="Stikini Ring",
		-- 5
		ring2="Stikini Ring",
		-- 20 DUR
		back=gear.sucellos_mnd,
		-- 10 DUR
		waist="Embla Sash",
		legs="Leth. Fuseau +1",
		-- 25 30 DUR
		feet="Leth. Houseaux +1"
	})

	-- INT potency mod for spikes
	-- ~104 +195 INT
	sets.midcast.spikes = set_combine(sets.midcast.EnhancingDuration,{
		-- 19 INT
		--main=gear.MainStaff,
		-- 10 INT
		--sub="Enki Strap",
		-- 15 INT
		main="Maxentius",
		-- 13 INT
		sub="Ammurapi Shield",
		-- 7 INT
		--neck="Imbodla Necklace",
		neck="Dls. Torque +1",
		-- 2 INT
		ring1="Acumen Ring",
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
		sub="Ammurapi Shield",
		-- 10 DUR
		--sub="Ammurapi Shield",
		neck="Dls. Torque +1",
		body="Telchine Chas."
	})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],{
		head="Amalric Coif",
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
	-- 60 gear
	-- 536 total
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
		--neck="Imbodla Necklace",
		ear1="Snotra Earring",
		-- 21
		--body="Atrophy Tabard +3",
		-- effect +14
		body="Lethargy Sayon +1",
		-- 19, Saboteur +12
		--hands="Leth. Gantherots +1",
		-- Duration +20%
		hands="Regal Cuffs",
		-- Duration +10%
		ring1="Kishar Ring",
		-- 5
		--ring1="Stikini Ring",
		-- 5
		ring2="Stikini Ring",
		-- effect +10
		back=gear.sucellos_mnd,
		-- 7
		--waist="Rumination Sash",
		waist="Luminary Sash",
		-- 13 Immunobreak +1
		legs=gear.Chironic_legs_nuke,
		-- 16 effect +10
		feet="Vitiation Boots +3",
	})

	sets.midcast['Enfeebling Magic'].Resistant = set_combine(sets.midcast['Enfeebling Magic'],{
		ammo=empty,
		range="Ullr",
		-- effect +10
		--ammo="Regal Gem",
		ear2="Regal Earring",
		-- 21
		body="Atrophy Tabard +3",
		ring2="Crepuscular Ring",
	})

	-- For enfeebs with no known skill caps
	-- 476 Initial
	-- 108 gear
	-- 584 total
	sets.midcast.enfeebFullSkill = set_combine(sets.midcast['Enfeebling Magic'], {
		-- 21
		body="Atrophy Tabard +3",
		-- 5
		ring1="Stikini Ring",
		-- 5
		ring2="Stikini Ring",
	})

	-- For MND potency based enfeebs
	sets.midcast.enfeebMND = set_combine(sets.midcast['Enfeebling Magic'], {
		--ammo="Regal Gem",
		head="Viti. Chapeau +3",
		ear1="Snotra Earring",
		neck="Dls. Torque +1",
		waist="Luminary Sash",
	})

	-- For INT potency based enfeebs
	sets.midcast.enfeebINT = set_combine(sets.midcast['Enfeebling Magic'], {
		neck="Dls. Torque +1",
		back=gear.sucellos_mab,
		legs=gear.Merlinic_legs_nuke,
		feet="Vitiation Boots +3",
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
		ring1="Kishar Ring",
		feet="Vitiation Boots +3",
	})

	-- For enfeebs with 500 skill caps
	-- 476 Initial
	-- 44 gear
	-- 520 total
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
		head="Atro. Chapeau +3",
	})
	sets.midcast['Distract'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, sets.midcast['Distract'], {
	})
	-- Distract II (caps 350 skill for -40 eva, -50 eva cap with MND)
	sets.midcast['Distract II'] = set_combine(sets.midcast['Enfeebling Magic'], {
		head="Atro. Chapeau +3",
	})
	sets.midcast['Distract II'].Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, sets.midcast['Distract II'], {
	})
	-- Distract III (caps 610 skill for -120 eva, -130 eva cap with MND)
	-- 476 Initial
	-- 87 gear
	-- 563 skill total
	sets.midcast['Distract III'] = set_combine(sets.midcast['Enfeebling Magic'], {
		ring1="Stikini Ring",
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
	-- 87 gear
	-- 563 skill total
	sets.midcast['Frazzle III'] = set_combine(sets.midcast['Enfeebling Magic'], {
		ring1="Stikini Ring",
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
		sub="Enki Strap",
		range="Ullr",
		ammo=empty,
		head="Jhakri Coronal +2",
		body=gear.Merlinic_body_nuke,
		ring1="Stikini Ring",
		ring2="Stikini Ring",
	})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAB,{
		ring2="Weather. Ring"
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
		head="Leth. Chappel +1",
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
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Viti. Chapeau +3",
		neck="Loricate Torque +1",
		ear1="Ethereal Earring",
		ear2="Novia Earring",
		body="Jhakri Robe +2",
		hands="Malignance Gloves",
		ring1=gear.DarkRing.physical,
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Fucho-no-Obi",
		--legs=gear.Merlinic_legs_idle,
		legs="Carmine Cuisses +1",
		--feet=gear.Vanya_feet_B
		feet="Malignance Boots",
	}
	
	sets.idle.Town = set_combine(sets.idle,{
		--ammo="Regal Gem",
		neck="Dls. Torque +1",
		--body="Councilor's Garb",
		body="Shamash Robe",
		hands="Regal Cuffs",
		back=gear.sucellos_mnd,
	})
	
	sets.idle.Weak = set_combine(sets.idle,{
	})
	
	-- Total: 53% + 20% (PDT Staff)
	-- <36%: use Shadow Mantle
	sets.idle.PDT = set_combine(sets.idle,{
		--main=gear.Staff.PDT,
		--sub="Enki Strap",
		-- 2%
		ammo="Crepuscular Pebble",
		head="Malignance Chapeau",
		-- 5%
		neck="Loricate Torque +1",
		-- 9%
		body="Nyame Mail",
		-- 5%
		hands="Malignance Gloves",
		-- 4%
		ring1=gear.DarkRing.physical,
		-- 10%
		ring2="Defending Ring",
		-- 5%
		back="Moonbeam Cape",
		-- 6%
		legs="Aya. Cosciales +2",
		-- 3%
		--feet="Aya. Gambieras +2",
		-- 4%
		feet="Malignance Boots",
	})
	
	-- MDT: 52%
	-- MDB: 29
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.idle.MDT = set_combine(sets.idle,{
		-- 2%
		ammo="Crepuscular Pebble",
		head="Malignance Chapeau",
		-- 5%
		neck="Loricate Torque +1",
		-- 3%
		ear2="Etiolation Earring",
		-- 7
		--body="Atrophy Tabard +3",
		-- 9% 8
		body="Nyame Mail",
		-- 4 5%
		hands="Malignance Gloves",
		-- 3%
		ring1=gear.DarkRing.physical,
		-- 10%
		ring2="Defending Ring",
		-- 5%
		back="Moonbeam Cape",
		-- 5 6%
		legs="Aya. Cosciales +2",
		-- 5 3%
		--feet="Aya. Gambieras +2",
		-- 5 4%
		feet="Malignance Boots",
	})
	
	
	-- Defense sets
	
	sets.defense.PDT = set_combine(sets.idle.PDT,{
	})
	
	
	sets.defense.MDT = set_combine(sets.idle.MDT,{
	})
	
	sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}

	-- 26% (40 cap) + 5% II
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
		hands="Ea Cuffs",
		-- 2%
		ring2="Jhakri Ring",
		feet=gear.Chironic_feet_nuke,
	})

	sets.magic_burst.Resistant = set_combine(sets.magic_burst,{
		sub="Enki Strap",
		head="Jhakri Coronal +2",
		body=gear.Merlinic_body_nuke,
		hands="Regal Cuffs",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
	})
	
	-- Engaged sets
	
	-- Variations for TP weapon and (optional) offense/defense modes.	Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	-- Haste: 28%
	sets.engaged = {
		ammo="Amar Cluster",
		-- 8%
		head="Blistering Sallet +1",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Sherida Earring",
		-- 4%
		body="Ayanmo Corazza +2",
		-- 4%
		hands="Malignance Gloves",
		ring1="Rajas Ring",
		ring2="Chirich Ring",
		back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		-- 9%
		legs="Aya. Cosciales +2",
		-- 3%
		--feet="Aya. Gambieras +2",
		-- 4%
		feet="Malignance Boots",
	}
	
	-- Haste: 27%
	sets.engaged.Acc = set_combine(sets.engaged,{
		ammo="Amar Cluster",
		head="Malignance Chapeau",
		neck="Defiant Collar",
		ear1="Zennaroi Earring",
		ring1="Cacoethic Ring",
		-- 2%
		back="Ground. Mantle +1",
		waist="Eschan Stone",
	})

	sets.engaged.enspell = set_combine(sets.engaged,{
		--range="Ullr",
		head="Umuthi Hat",
		neck="Sanctity Necklace",
		body="Ayanmo Corazza +2",
		--ear2="Regal Earring",
		hands="Aya. Manopolas +2",
		--ring1="Ilabrat Ring",
		ring2="Jhakri Ring",
		back="Ghostfyre Cape",
		legs="Jhakri Slops +2",
	})
	sets.engaged.enspellDW = set_combine(sets.engaged.enspell,{
		ear1="Suppanomimi",
		--ring1="Haverton Ring",
		--waist="Reiki Yotai",
	})
	sets.engaged.enspell.Acc = set_combine(sets.engaged.Acc, sets.engaged.enspell,{
	})
	sets.engaged.enspellDW.Acc = set_combine(sets.engaged.Acc, sets.engaged.enspell,sets.engaged.enspellDW,{
	})

	sets.engaged.DefenseBase = set_combine(sets.Malignance,{
		neck="Loricate Torque +1",
		body="Ayanmo Corazza +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
		legs="Aya. Cosciales +2",
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
		body="Nyame Mail",
		legs="Nyame Flanchard",
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