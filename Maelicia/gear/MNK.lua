function user_setup()
	state.OffenseMode:options('Normal', 'MidAcc', 'Acc')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'Acc')
	state.HybridMode:options('Normal', 'Mpaca', 'PDT', 'Counter')
	state.PhysicalDefenseMode:options('Mpaca', 'PDT', 'HP')
	state.IdleMode:options('CP', 'Normal', 'Regen')

	state.EnmityMode = M{['description']='Enmity Mode', 'None', 'Down', 'Up'}
	state.MalignanceMode = M(false, 'Malignance')
	state.TreasureMode = M(false, 'TH')

	gear.Segomo_dex_da = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}
	gear.Segomo_vit_wsd = { name="Segomo's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Damage taken-5%',}}
	
	update_combat_form()
	update_melee_groups()

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

	send_command('bind ^- gs c cycle enmitymode')
	send_command('bind ^= gs c toggle TreasureMode; input /echo --- TreasureMode ---')
	send_command('bind != gs c toggle MalignanceMode; input /echo --- MalignanceMode ---')
	
	select_default_macro_book()

	global_aliases()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^-')
	send_command('unbind ^=')
	send_command('unbind !=')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	--------------------------------------
	-- Base sets
	--------------------------------------

	sets.EnmityUp = {
		-- 8 Enmity
		head="Halitus helm",
		-- 10 Enmity
		neck="Unmoving Collar +1",
		-- 10 Enmity
		body="Emet Harness +1",
		-- 9 Enmity
		hands="Kurys Gloves",
		-- 5 Enmity
		ring1="Supershear Ring",
		-- 5 Enmity
		ring2="Pernicious Ring",
		-- 3 Enmity
		waist="Goading Belt",
	}

	sets.EnmityDown = {
		ear2="Schere Earring",
	}

	sets.Malignance = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	}
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs="Hes. Hose +3"}
	sets.precast.JA['Boost'] = {hands="Anch. Gloves +2"}
	sets.precast.JA['Dodge'] = {feet="Anch. Gaiters +3"}
	sets.precast.JA['Focus'] = {head="Anchor. Crown +1"}
	sets.precast.JA['Counterstance'] = {feet="Hes. Gaiters +3"}
	sets.precast.JA['Footwork'] = {feet="Tantra Gaiters +2"}
	sets.precast.JA['Formless Strikes'] = {body="Hes. Cyclas +1"}
	sets.precast.JA['Mantra'] = {feet="Hes. Gaiters +3"}

	-- Chi Blast - MND
	sets.precast.JA['Chi Blast'] = {
		head="Hes. Crown +3", -- Penance bonus
		neck="Phalaina Locket",
		body="Tatena. Harama. +1",
		hands="Malignance Gloves",
		ring2="Dark Ring",
		back="Tantalic Cape",
		waist="Luminary Sash",
		legs="Malignance Tights",
		feet="Malignance Boots",
	}

	-- Chakra - VIT
	sets.precast.JA['Chakra'] = {
		ammo="Tantra Tathlum",
		head="Hes. Crown +3",
		neck="Unmoving Collar +1",
		body="Anch. Cyclas +2",
		hands="Hes. Gloves +3",
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.Segomo_vit_wsd,
		waist="Flume Belt +1",
		legs="Tatena. Haidate +1",
		feet="Tatena. Sune. +1",
	}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Hes. Crown +3",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
		ring1="Dark Ring",
		ring1="Sirona's Ring",
		back=gear.Segomo_vit_wsd,
		waist="Flume Belt +1",
		legs="Anch. Hose +3",
		feet="Hes. Gaiters +3"
	}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Step = {}
	sets.precast.Flourish1 = {}


	-- Fast cast sets for spells
	
	sets.precast.FC = {
		--ammo="Impatiens",
		head=gear.Herculean_head_RA,
		neck="Voltsurge Torque",
		ear1="Loquac. Earring",
		ear2="Etiolation Earring",
		body="Taeon Tabard",
		hands="Leyline Gloves",
		ring1="Prolix Ring",
		legs=gear.Herculean_legs_Magic,
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Knobkierrie",
		--head="Rao Kabuto +1",
		head="Mpaca's Cap",
		neck="Fotia Gorget",
		--ear1="Brutal Earring",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		--body="Tatena. Harama. +1",
		body="Ken. Samue +1",
		hands=gear.Adhemar_hands_hq_B,
		ring1="Niqmaddu Ring",
		ring2="Gere Ring",
		back=gear.Segomo_dex_da,
		waist="Fotia Belt",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		--head="Rao Kabuto +1",
		head="Mpaca's Cap",
		body=gear.Adhemar_body_hq_B,
		hands=gear.Adhemar_hands_hq_B,
		back=gear.Segomo_dex_da,
		waist="Windbuffet Belt +1"
	})
	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
		neck=gear.ElementalGorget,
		waist=gear.ElementalBelt
	})
	sets.precast.WS.MAB = set_combine(sets.precast.WS, {
		head="Nyame Helm",
		neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Acumen Ring",
		back="Toro Cape",
		--waist="Yamabuki-no-Obi",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- 80% STR, crit chance varies with TP
	sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head=gear.Adhemar_head_hq_B,
		neck="Mnk. Nodowa +2",
		ear2="Odr Earring",
		body="Ken. Samue +1",
		ring1="Niqmaddu Ring",
		ring2="Gere Ring",
		waist="Moonbow Belt +1",
		legs="Ken. Hakama +1",
		back=gear.Segomo_dex_da,
		feet="Mpaca's Boots",
	})
	sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS["Victory Smite"], {
	})
	sets.precast.WS["Victory Smite"].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS["Victory Smite"], {
	})

	-- 30% STR / 30% DEX, damage varies with TP
	sets.precast.WS["Raging Fists"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		neck="Mnk. Nodowa +2",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		--body="Tatena. Harama +1",
		body=gear.Adhemar_body_hq_B,
		hands=gear.Adhemar_hands_hq_B,
		ring1="Niqmaddu Ring",
		ring2="Gere Ring",
		waist="Moonbow Belt +1",
		legs="Tatena. Haidate +1",
		back=gear.Segomo_dex_da,
		feet="Mpaca's Boots",
	})
	sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS["Raging Fists"], {
	})
	sets.precast.WS["Raging Fists"].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS["Raging Fists"], {
	})

	sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
		--head=gear.Rao_head_hq_B,
		head="Mpaca's Cap",
		ear2="Odr Earring",
		neck="Mnk. Nodowa +2",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		back=gear.Segomo_dex_da,
		--legs="Hes. Hose +3",
		legs="Tatena. Haidate +1",
		feet="Mpaca's Boots",
	})
	sets.precast.WS['Shijin Spiral'].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS['Shijin Spiral'], {
	})
	sets.precast.WS['Shijin Spiral'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS['Shijin Spiral'], {
	})

	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS['Asuran Fists'], {
	})
	sets.precast.WS['Asuran Fists'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS['Asuran Fists'], {
	})

	sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS["Ascetic's Fury"], {
	})
	sets.precast.WS["Ascetic's Fury"].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS["Ascetic's Fury"], {
	})

	sets.precast.WS["Howling Fist"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		neck="Mnk. Nodowa +2",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
		back=gear.Segomo_vit_wsd,
		waist="Moonbow Belt +1",
		legs="Tatena. Haidate +1",
		--feet="Mpaca's Boots",
		feet="Tatena. Sune. +1",
	})
	sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS["Howling Fist"], {
	})
	sets.precast.WS["Howling Fist"].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS["Howling Fist"], {
	})

	sets.precast.WS["Tornado Kick"] = set_combine(sets.precast.WS, {
		neck="Mnk. Nodowa +2",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
		back=gear.Segomo_vit_wsd,
		waist="Moonbow Belt +1",
		legs="Tatena. Haidate +1",
		feet="Anch. Gaiters +3",
	})
	sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS["Tornado Kick"], {
	})
	sets.precast.WS["Tornado Kick"].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS["Tornado Kick"], {
	})

	-- 30% STR / 30% INT, damage varies with TP
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS.MAB,{
		head="Pixie Hairpin +1",
		body="Nyame Mail",
	})

	-- 50% MND / 30% STR, single attack, damage varies with TP
	sets.precast.WS["Retribution"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		--head="Mpaca's Cap",
		head="Hes. Crown +3",
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		hands="Anchor. Gloves +2",
		back=gear.Segomo_vit_wsd,
		waist="Fotia Belt",
		legs="Nyame Flanchard",
	})
	sets.precast.WS["Retribution"].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS["Retribution"], {
	})
	sets.precast.WS["Retribution"].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS["Retribution"], {
	})

	-- 100% STR, DEF down, duration varies with TP
	sets.precast.WS["Shell Crusher"] = set_combine(sets.precast.WS, {
		head="Malignance Chapeau",
		ammo="Pemphredo Tathlum",
		neck="Sanctity Necklace",
		ear1="Crep. Earring",
		ear2="Digni. Earring",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Stikini Ring",
		ring2="Stikini Ring +1",
		waist="Luminary Sash",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	sets.precast.WS["Shell Crusher"].Acc = set_combine(sets.precast.WS.Acc, sets.precast.WS["Shell Crusher"], {
	})
	sets.precast.WS["Shell Crusher"].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS["Shell Crusher"], {
	})
	
	-- Midcast Sets

	-- 26% Haste
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
		
	-- Specific spells
	sets.midcast.Utsusemi = {
		neck="Voltsurge Torque"
	}
	
	-- Sets to return to when not performing an action.
	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Dark Ring",
		ring2="Defending Ring",
		--back="Moonbeam Cape",
		back="Mecisto. Mantle",
		waist="Moonbow Belt +1",
		legs="Nyame Flanchard",
		feet="Herald's Gaiters"
	}
	
	sets.noprotect = {ring1="Sheltered Ring"}

	sets.idle.Town = set_combine(sets.idle, {
		body="Councilor's Garb"
	})
	
	sets.idle.Weak = set_combine(sets.idle,{
	})
	
	sets.idle.Regen = set_combine(sets.idle,{
		head="Rao Kabuto +1",
		neck="Bathy Choker +1",
		--body="Hiza. Haramaki +2",
		ring1="Sheltered Ring"
	})

	-- Resting sets
	sets.resting = set_combine(sets.idle.Regen,{
	})


	-- DT: 54%
	sets.idle.PDT = set_combine(sets.idle,{
		-- DT 7%
		head="Nyame Helm",
		-- DT 9%
		body="Nyame Mail",
		-- DT 7%
		hands="Nyame Gauntlets",
		-- DT 10%
		ring2="Defending Ring",
		-- DT 6%
		waist="Moonbow Belt +1",
		-- DT 8%
		legs="Nyame Flanchard",
		-- DT 7%
		feet="Nyame Sollerets"
	})

	sets.idle.MDT = set_combine(sets.idle.PDT, {
	})
	
	-- Defense sets
	sets.defense.PDT = set_combine(sets.idle.PDT, {
	})

	sets.defense.HP = set_combine(sets.idle, {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets"
	})

	sets.defense.MDT = set_combine(sets.idle.MDT, {
	})

	sets.Kiting = set_combine(sets.idle, {
		feet="Herald's Gaiters"
	})

	sets.ExtraRegen = set_combine(sets.idle, {
		--body="Hiza. Haramaki +2",
		neck="Bathy Choker +1",
		ring1="Sheltered Ring"
	})

	-- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
	sets.impetus_body = {body="Bhikku Cyclas +1"}
	sets.footwork_kick_feet = {feet="Anch. Gaiters +3"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee sets
	sets.engaged = {
		ammo="Ginsen",
		head=gear.Adhemar_head_hq_B,
		neck="Mnk. Nodowa +2",
		ear1="Sherida Earring",
		ear2="Dedition Earring",
		body="Ken. Samue +1",
		hands=gear.Adhemar_hands_hq_B,
		ring1="Niqmaddu Ring",
		ring2="Gere Ring",
		back=gear.Segomo_dex_da,
		waist="Moonbow Belt +1",
		legs="Hes. Hose +3",
		feet="Anch. Gaiters +3",
	}
	sets.engaged.Impetus = set_combine(sets.engaged, sets.impetus_body, {
	})
	sets.engaged.MidAcc = set_combine(sets.engaged,{
		ear2="Telos Earring",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
	})
	sets.engaged.MidAcc.Impetus = set_combine(sets.engaged.MidAcc, sets.impetus_body, {
	})
	sets.engaged.Acc = set_combine(sets.engaged,{
		ammo="Falcon Eye",
		head="Malignance Chapeau",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
		ear1="Crep. Earring",
		ear2="Telos Earring",
		ring2="Cacoethic Ring +1",
		back=gear.Segomo_dex_da,
	})
	sets.engaged.Acc.Impetus = set_combine(sets.engaged.Acc, sets.impetus_body, {
	})

	sets.engaged.Mpaca = set_combine(sets.engaged, {
		head="Ken. Jinpachi +1",
		ear2="Schere Earring",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Malignance Boots",
	})
	sets.engaged.MidAcc.Mpaca = set_combine(sets.engaged.Mpaca, {
	})
	sets.engaged.Acc.Mpaca = set_combine(sets.engaged.Mpaca, {
	})
	sets.engaged.Mpaca.Impetus = set_combine(sets.engaged.Mpaca, sets.impetus_body, {
	})
	sets.engaged.MidAcc.Mpaca.Impetus = set_combine(sets.engaged.MidAcc.Mpaca, sets.impetus_body, {
	})
	sets.engaged.Acc.Mpaca.Impetus = set_combine(sets.engaged.Acc.Mpaca, sets.impetus_body, {
	})

	-- Defensive melee hybrid sets
	sets.engaged.PDT = set_combine(sets.engaged,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Moonbow Belt +1",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	sets.engaged.MidAcc.PDT = set_combine(sets.engaged.MidAcc,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Moonbow Belt +1",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Moonbow Belt +1",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	sets.engaged.Counter = set_combine(sets.engaged.PDT,{
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Sherida Earring",
		ear2="Telos Earring",
		body="Mpaca's Doublet",
		hands="Malignance Gloves",
		ring1="Niqmaddu Ring",
		ring2="Defending Ring",
		waist="Moonbow Belt +1",
		legs="Anch. Hose +3",
		feet="Malignance Boots",
	})
	sets.engaged.MidAcc.Counter = set_combine(sets.engaged.MidAcc.PDT, sets.engaged.Counter, {
	})
	sets.engaged.Acc.Counter = set_combine(sets.engaged.Acc.PDT, sets.engaged.Counter, {
	})
	sets.engaged.Counterstance = set_combine(sets.engaged.PDT,{
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Sherida Earring",
		ear2="Telos Earring",
		body="Mpaca's Doublet",
		hands="Malignance Gloves",
		ring1="Niqmaddu Ring",
		ring2="Defending Ring",
		waist="Moonbow Belt +1",
		legs="Anch. Hose +3",
		feet="Hes. Gaiters +3"
	})
	sets.engaged.MidAcc.Counterstance = set_combine(sets.engaged.MidAcc.PDT, sets.engaged.Counterstance, {
	})
	sets.engaged.Acc.Counterstance = set_combine(sets.engaged.Acc.PDT, sets.engaged.Counterstance, {
	})

	-- Hundred Fists/Impetus melee set mods
	sets.engaged.HF = set_combine(sets.engaged)
	sets.engaged.HF.Impetus = set_combine(sets.engaged, sets.impetus_body, {
	})
	sets.engaged.MidAcc.HF = set_combine(sets.engaged.MidAcc)
	sets.engaged.MidAcc.HF.Impetus = set_combine(sets.engaged.MidAcc, sets.impetus_body, {
	})
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc)
	sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc, sets.impetus_body, {
	})
	sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
	sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, sets.impetus_body, {
	})
	sets.engaged.MidAcc.Counter.HF = set_combine(sets.engaged.MidAcc.Counter)
	sets.engaged.MidAcc.Counter.HF.Impetus = set_combine(sets.engaged.MidAcc.Counter, sets.impetus_body, {
	})
	sets.engaged.Acc.Counter.HF = set_combine(sets.engaged.Acc.Counter)
	sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, sets.impetus_body, {
	})
	sets.engaged.Counterstance.HF = set_combine(sets.engaged.Counterstance)
	sets.engaged.Counterstance.HF.Impetus = set_combine(sets.engaged.Counterstance, sets.impetus_body, {
	})
	sets.engaged.MidAcc.Counterstance.HF = set_combine(sets.engaged.MidAcc.Counterstance)
	sets.engaged.MidAcc.Counterstance.HF.Impetus = set_combine(sets.engaged.MidAcc.Counterstance, sets.impetus_body, {
	})
	sets.engaged.Acc.Counterstance.HF = set_combine(sets.engaged.Acc.Counterstance)
	sets.engaged.Acc.Counterstance.HF.Impetus = set_combine(sets.engaged.Acc.Counterstance, sets.impetus_body, {
	})


	-- Footwork combat form
	sets.engaged.Footwork = set_combine(sets.engaged, sets.footwork_kick_feet, {
	})
	sets.engaged.Footwork.Acc = set_combine(sets.engaged.Acc, sets.footwork_kick_feet, {
	})

	sets.buff.Boost = {
		waist="Ask Sash",
	}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	-- Don't gearswap for weaponskills when Defense is on.
	if spell.type == 'WeaponSkill' then
		if (spell.target.model_size + spell.range * 1.642276421172564) < spell.target.distance then	
			add_to_chat(7,"--- Target "..spell.target.type.." ["..player.target.name.."] out of range of ["..spell.name.."] [ Distance: "..spell.target.distance.."] ---")
			cancel_spell()
		end

		if state.TreasureMode.value ~= false then
			equip(sets.sharedTH)
		end

		if state.DefenseMode.current ~= 'None' then
			eventArgs.handled = true
		end
	end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
		if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
			-- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
			if (state.OffenseMode.current == 'Normal' and info.impetus_hit_count > 5) or (info.impetus_hit_count > 8) then
				equip(sets.impetus_body)
			end
		elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
			equip(sets.footwork_kick_feet)
		end

		-- Replace Moonshade Earring if we're at cap TP
		if player.tp == 3000 then
			equip(sets.precast.MaxTP)
		end
	end
end

function job_buff_change(buff, gain)
	-- debugging
	--add_to_chat(112,"buff: " .. buff)
	--add_to_chat(112,"gain: " .. tostring(gain))
	--add_to_chat(112, "player.status: " .. player.status)

	-- Set Footwork as combat form any time it's active and Hundred Fists is not.
	if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
		state.CombatForm:set('Footwork')
	elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
		state.CombatForm:set('Footwork')
	else
		state.CombatForm:reset()
	end

	-- Hundred Fists and Impetus modify the custom melee groups
	if buff == "Hundred Fists" or buff == "Impetus" or buff == 'Counterstance' then
		classes.CustomMeleeGroups:clear()

		if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
			classes.CustomMeleeGroups:append('HF')
		end

		if (buff == "Impetus" and gain) or buffactive.impetus then
			classes.CustomMeleeGroups:append('Impetus')
		end

		if (buff == "Counterstance" and gain) or buffactive['Counterstance'] then
			classes.CustomMeleeGroups:append('Counterstance')
		end
	end

	if buff == "Boost" then
		equip(sets.buff.Boost)
	end

	-- Update gear if any of the above changed
	if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" or buff == "Boost" or buff == 'Counterstance' then
		handle_equipping_gear(player.status)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 12)
	elseif player.sub_job == 'NIN' then
		set_macro_page(2, 12)
	elseif player.sub_job == 'WAR' then
		set_macro_page(3, 12)
	elseif player.sub_job == 'RUN' then
		set_macro_page(4, 12)
	else
		set_macro_page(1, 12)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if player.hpp < 75 then
		idleSet = set_combine(idleSet, sets.ExtraRegen)
	end
	if not buffactive['Protect'] then
		idleSet = set_combine(idleSet, sets.noprotect)
	end
	if buffactive['Boost'] then
		idleSet = set_combine(idleSet, sets.buff.Boost)
	end
	if buffactive['Doom'] then
		idleSet = set_combine(idleSet, sets.buff.Doom)
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.EnmityMode.value == 'Down' then
		meleeSet = set_combine(meleeSet, sets.EnmityDown)
	elseif state.EnmityMode.value == 'Up' then
		meleeSet = set_combine(meleeSet, sets.EnmityUp)
	end
	if state.MalignanceMode.value ~= false then
		meleeSet = set_combine(meleeSet, sets.Malignance)
	end
	if state.TreasureMode.value ~= false then
		meleeSet = set_combine(meleeSet, sets.sharedTH)
	end
	if buffactive['Boost'] then
		meleeSet = set_combine(meleeSet, sets.buff.Boost)
	end
	if buffactive['Doom'] then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
	end
	return meleeSet
end

function customize_defense_set(defenseSet)		
	if buffactive['Boost'] then
		defenseSet = set_combine(defenseSet, sets.buff.Boost)
	end
	if buffactive['Doom'] then
		defenseSet = set_combine(defenseSet, sets.buff.Doom)
	end
	return defenseSet
end