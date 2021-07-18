function user_setup()	
	state.IdleMode:options('CP', 'Normal', 'StoreTP', 'Regen', 'CPPDT', 'CPMDT')
	state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.HybridMode:options('Normal', 'HybridTH', 'Evasion', 'PDT')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.PhysicalDefenseMode:options('HybridTH', 'Evasion', 'PDT')

	state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}
	state.BehindMode = M{['description']='Behind Mode', 'None', 'Normal'}
	
	--gear.default.weaponskill_neck = "Asperity Necklace"
	--gear.default.weaponskill_waist = "Caudata Belt"
	gear.default.weaponskill_neck = "Fotia Gorget"
	gear.default.weaponskill_waist = "Fotia Belt"
	
	gear.jsecape_dex_crit = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Damage taken-5%',}}
	gear.jsecape_dex_dw = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+6','Damage taken-5%',}}
	gear.jsecape_dex_wsd = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}

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
	send_command('bind ^` input /ja "Flee" <me>')
	send_command('bind ^= gs c cycle treasuremode')
	send_command('bind !- gs c cycle targetmode')
	send_command('bind @` gs c cycle HasteMode')
	send_command('bind !` gs c cycle BehindMode')
	
	select_default_macro_book()

	global_aliases()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^`')
	send_command('unbind ^=')
	send_command('unbind !-')
	send_command('unbind @`')
	send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Special sets
	--------------------------------------

	sets.TreasureHunter = {
		hands="Plun. Armlets +3",
		--feet="Skulk. Poulaines +1",
		--feet="Volte Boots",
	}
	sets.ExtraRegen = {}
	sets.Kiting = {
		feet="Skd. Jambeaux +1"
	}

	sets.buff['Sneak Attack'] = {
		head="Pill. Bonnet +3",
		neck="Moepapa Medal",
		ear1="Sherida Earring",
		ear2="Suppanomimi",
		body="Meg. Cuirie +2",
		hands="Skulk. Armlets +1",
		ring1="Regal Ring",
		ring2="Ilabrat Ring",
		back=gear.jsecape_dex_dw,
		waist="Reiki Yotai",
		legs="Pill. Culottes +3",
		feet="Plun. Poulaines +3"
	}

	sets.buff['Trick Attack'] = {
		head="Pill. Bonnet +3",
		neck="Moepapa Medal",
		ear1="Sherida Earring",
		ear2="Suppanomimi",
		body="Plunderer's Vest +3",
		hands="Pill. Armlets +3",
		ring1="Regal Ring",
		ring2="Ilabrat Ring",
		back=gear.jsecape_dex_dw,
		waist="Reiki Yotai",
		legs="Pill. Culottes +3",
		feet="Plun. Poulaines +3"
	}
	sets.Behind = {
		body="Plunderer's Vest +3",
	}


	--------------------------------------
	-- Precast sets
	--------------------------------------
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Collaborator'] = {head="Skulker's Bonnet +1"}
	sets.precast.JA['Accomplice'] = {head="Skulker's Bonnet +1"}
	sets.precast.JA['Flee'] = {feet="Pill. Poulaines +1"}
	sets.precast.JA['Hide'] = {body="Pillager's Vest +3"}
	sets.precast.JA['Conspirator'] = {body="Skulker's Vest +1"}
	sets.precast.JA['Steal'] = {head="Plun. Bonnet +3",neck="Rabbit Charm",hands="Pill. Armlets +3",legs="Pill. Culottes +3",feet="Pill. Poulaines +1"}
	sets.precast.JA['Despoil'] = {legs="Skulk. Culottes +1",feet="Skulk. Poulaines +1"}
	sets.precast.JA['Perfect Dodge'] = {hands="Plun. Armlets +3"}
	sets.precast.JA['Feint'] = {
		legs="Plun. Culottes +3"
	}
	
	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Mummu Bonnet +2",
		body="Pillager's Vest +3",
		hands="Pill. Armlets +3",
		ring1="Regal Ring",
		ring2="Sirona's Ring",
		back="Tantalic Cape",
		waist="Chaac Belt",
		legs="Pill. Culottes +3",
		feet="Meg. Jam. +2"
	}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	-- TH actions
	sets.precast.Step = sets.precast.TreasureHunter
	sets.precast.Flourish1 = sets.precast.TreasureHunter
	sets.precast.JA.Provoke = sets.precast.TreasureHunter
	
	
	-- Fast cast sets for spells
	
	-- 35% 27% Haste
	sets.precast.FC = {
		-- 7%  8H
		head=gear.Herculean_head_RA,
		-- 4%
		neck="Voltsurge Torque",
		-- 2%
		ear1="Loquacious Earring",
		-- 1%
		ear2="Etiolation Earring",
		-- 4% + 5% 4H
		body="Taeon Tabard",
		-- 5% + 2% 5H
		hands="Leyline Gloves",
		-- 2%
		ring1="Prolix Ring",
		-- 3% 6H
		--legs="Limbo Trousers",
		-- 5% 6H
		legs=gear.Herculean_legs_Magic,
		-- 4H
		feet="Herculean Boots"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	-- Ranged snapshot gear
	sets.precast.RA = {
		head="Uk'uxkaj Cap",
		body=gear.pursuer_body_D,
		hands="Mrigavyadha Gloves",
		ring2="Haverton Ring",
		waist="Yemaya Belt",
		legs=gear.Adhemar_legs_D,
		feet="Meg. Jam. +2"
	}

		 
	-- Weaponskill sets
	
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Yamarang",
		head="Pill. Bonnet +3",
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body="Pillager's Vest +3",
		hands="Mummu Wrists +2",
		ring1="Epona's Ring",
		ring2="Ilabrat Ring",
		back=gear.jsecape_dex_crit,
		waist="Fotia Belt",
		--legs="Lustr. Subligar +1",
		legs="Plun. Culottes +3",
		feet="Lustra. Leggings +1"
	}
	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
	})
	sets.precast.WS.HighAcc = set_combine(sets.precast.WS, {
		hands="Meg. Gloves +2",
		waist="Grunfeld Rope",
	})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {
		head="Pill. Bonnet +3",
		body="Pillager's Vest +3",
		hands="Pill. Armlets +3",
		ring1="Regal Ring",
		ring2="Ilabrat Ring",
		back=gear.jsecape_dex_crit,
		waist="Eschan Stone",
		legs="Pill. Culottes +3",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS.MAB = set_combine(sets.precast.WS, {
		head=gear.Herculean_head_Magic,
		neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		body=gear.Herculean_body_Magic,
		hands="Leyline Gloves",
		ring1="Acumen Ring",
		back=gear.jsecape_dex_wsd,
		--waist="Eschan Stone",
		--legs="Limbo Trousers",
		legs=gear.Herculean_legs_Magic,
		feet="Nyame Sollerets",
	})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- 73~85% AGI, duration of effect varies with TP
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		head="Plun. Bonnet +3",
		neck="Fotia Gorget",
		ear2="Brutal Earring",
		body="Plunderer's Vest +3",
		hands="Mummu Wrists +2",
		ring1="Regal Ring",
		waist="Fotia Belt",
		legs="Meg. Chausses +2",
		feet="Plun. Poulaines +3",
	})
	sets.precast.WS['Exenterator'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS['Exenterator'], {
	})
	sets.precast.WS['Exenterator'].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS['Exenterator'], {
	})
	sets.precast.WS['Exenterator'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Exenterator'], {
	})
	sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'], {
		ammo="Yetshila",
		hands="Meg. Gloves +2",
		legs="Plun. Culottes +3",
	})
	sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'], {
		ammo="Yetshila",
		--hands="Pill. Armlets +3",
		hands="Meg. Gloves +2",
		legs="Plun. Culottes +3",
	})
	sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'], {
		ammo="Yetshila",
		--hands="Skulk. Armlets +1",
		--hands="Pill. Armlets +3",
		hands="Meg. Gloves +2",
		legs="Plun. Culottes +3",
	})

	-- 40% DEX 40% CHR, Acc varies with TP
	sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {
		ammo="Yetshila",
	})
	sets.precast.WS['Dancing Edge'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS['Dancing Edge'], {
	})
	sets.precast.WS['Dancing Edge'].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS['Dancing Edge'], {
	})
	sets.precast.WS['Dancing Edge'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Dancing Edge'], {
	})
	sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'], {
		ring1="Regal Ring",
		--hands="Skulk. Armlets +1",
		hands="Meg. Gloves +2",
		back=gear.jsecape_dex_wsd,
		legs="Pill. Culottes +3",
		feet="Plun. Poulaines +3",
	})
	sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'], {
		ring1="Regal Ring",
		hands="Pill. Armlets +3",
		back=gear.jsecape_dex_wsd,
		legs="Pill. Culottes +3",
		feet="Plun. Poulaines +3",
	})
	sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'], {
		ring1="Regal Ring",
		--hands="Skulk. Armlets +1",
		hands="Pill. Armlets +3",
		back=gear.jsecape_dex_wsd,
		legs="Pill. Culottes +3",
		legs="Pill. Culottes +3",
		feet="Plun. Poulaines +3",
	})

	-- 50% DEX, Crit rate varies with TP
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		ammo="Yetshila",
		head=gear.Adhemar_head_hq_B,
		ear1="Odr Earring",
		body="Plunderer's Vest +3",
		hands=gear.Adhemar_hands_hq_B,
		ring1="Regal Ring",
		feet="Lustra. Leggings +1",
	})
	sets.precast.WS['Evisceration'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS['Evisceration'], {
	})
	sets.precast.WS['Evisceration'].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS['Evisceration'], {
	})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Evisceration'], {
	})
	sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'], {
		ring1="Regal Ring",
		--hands="Skulk. Armlets +1",
		hands="Meg. Gloves +2",
		back=gear.jsecape_dex_wsd,
		legs="Pill. Culottes +3",
		feet="Plun. Poulaines +3",
	})
	sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'], {
		ring1="Regal Ring",
		--hands="Pill. Armlets +3",
		hands="Meg. Gloves +2",
		back=gear.jsecape_dex_wsd,
		legs="Pill. Culottes +3",
		feet="Plun. Poulaines +3",
	})
	sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'], {
		ring1="Regal Ring",
		--hands="Skulk. Armlets +1",
		--hands="Pill. Armlets +3",
		hands="Meg. Gloves +2",
		back=gear.jsecape_dex_wsd,
		legs="Pill. Culottes +3",
		feet="Plun. Poulaines +3",
	})

	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		ammo="Yamarang",
		--ear1="Ishvara Earring",
		ear1="Odr Earring",
		body="Pillager's Vest +3",
		hands="Meg. Gloves +2",
		ring1="Regal Ring",
		back=gear.jsecape_dex_wsd,
		waist="Grunfeld Rope",
		--legs="Lustr. Subligar +1",
		legs="Plun. Culottes +3",
		feet="Lustra. Leggings +1",
		feet="Nyame Sollerets",
	})
	sets.precast.WS["Rudra's Storm"].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS["Rudra's Storm"], {
		body="Plunderer's Vest +3",
	})
	sets.precast.WS["Rudra's Storm"].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS["Rudra's Storm"], {
		body="Plunderer's Vest +3",
	})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS["Rudra's Storm"], {
		body="Plunderer's Vest +3",
	})
	sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {
		ammo="Yetshila",
		body="Plunderer's Vest +3",
	})
	sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"], {
		ammo="Yetshila",
		body="Plunderer's Vest +3",
	})
	sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"], {
		ammo="Yetshila",
		body="Plunderer's Vest +3",
	})

	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
		ammo="Yamarang",
		--ear1="Ishvara Earring",
		ear1="Odr Earring",
		body="Pillager's Vest +3",
		hands="Meg. Gloves +2",
		ring1="Regal Ring",
		back=gear.jsecape_dex_wsd,
		waist="Grunfeld Rope",
		--legs="Lustr. Subligar +1",
		legs="Plun. Culottes +3",
		feet="Lustra. Leggings +1",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Shark Bite'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS["Shark Bite"], {
		body="Plunderer's Vest +3",
	})
	sets.precast.WS['Shark Bite'].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS["Shark Bite"], {
		body="Plunderer's Vest +3",
	})
	sets.precast.WS['Shark Bite'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS["Shark Bite"], {
		body="Plunderer's Vest +3",
	})
	sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'], {
		ammo="Yetshila",
		body="Plunderer's Vest +3",
	})
	sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'], {
		ammo="Yetshila",
		body="Plunderer's Vest +3",
	})
	sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'], {
		ammo="Yetshila",
		body="Plunderer's Vest +3",
	})

	sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {
		ammo="Yamarang",
		--ear1="Ishvara Earring",
		ear1="Odr Earring",
		body="Pillager's Vest +3",
		hands="Meg. Gloves +2",
		ring1="Regal Ring",
		back=gear.jsecape_dex_wsd,
		waist="Grunfeld Rope",
		--legs="Lustr. Subligar +1",
		legs="Plun. Culottes +3",
		feet="Lustra. Leggings +1",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Mandalic Stab'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS['Mandalic Stab'], {
		body="Plunderer's Vest +3",
	})
	sets.precast.WS['Mandalic Stab'].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS['Mandalic Stab'], {
		body="Plunderer's Vest +3",
	})
	sets.precast.WS['Mandalic Stab'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Mandalic Stab'], {
		body="Plunderer's Vest +3",
	})
	sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'], {
		ammo="Yetshila",
		body="Plunderer's Vest +3",
	})
	sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'], {
		ammo="Yetshila",
		body="Plunderer's Vest +3",
	})
	sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'], {
		ammo="Yetshila",
		body="Plunderer's Vest +3",
	})

	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB,{
	})

	sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)
	
	
	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
	-- 26% Haste
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {
	})

	-- Ranged gear
	sets.midcast.RA = {
		head="Meghanada Visor +2",
		neck="Iskur Gorget",
		ear1="Enervating Earring",
		ear2="Telos Earring",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		ring1="Cacoethic Ring +1",
		ring2="Haverton Ring",
		back="Libeccio Mantle",
		waist="Yemaya Belt",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2"
	}

	sets.midcast.RA.MidAcc = set_combine(sets.midcast.RA,{
	})

	sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA,{
	})
	
	sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA,{
	})
	
	--------------------------------------
	-- Idle/resting/defense sets
	--------------------------------------
	
	-- Resting sets
	sets.resting = {
		neck="Bathy Choker +1",
		ring1="Sheltered Ring"
	}
	

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {
		--head="Malignance Chapeau",
		head="Turms Cap",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Malignance Tights",
		feet="Skd. Jambeaux +1"
	}
	
	sets.noprotect = {ring1="Sheltered Ring"}

	sets.idle.Town = set_combine(sets.idle,{
		body="Councilor's Garb"
	})
	
	sets.idle.Weak = set_combine(sets.idle,{
	})
	
	sets.idle.Regen = set_combine(sets.idle,{
		head="Turms Cap",
		neck="Bathy Choker +1",
		ring1="Sheltered Ring",
	})
	
	sets.idle.CP = set_combine(sets.idle,{
		--back="Mecisto. Mantle"
	})

	sets.idle.StoreTP = set_combine(sets.idle,{
		ammo="Yamarang",
		head="Malignance Chapeau",
		neck="Iskur Gorget",
		ear1="Sherida Earring",
		ear2="Dedition Earring",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Rajas Ring",
		ring2="Ilabrat Ring",
		waist="Goading Belt",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	
	sets.idle.CPPDT = set_combine(sets.defense.PDT,{
		--back="Mecisto. Mantle"
	})
	
	sets.idle.CPMDT = set_combine(sets.defense.MDT,{
		--back="Mecisto. Mantle"
	})

	-- Defense sets

	sets.defense.Evasion = set_combine(sets.idle,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})

	-- DT: 50% PDT: 9% MDT: 10%
	sets.defense.PDT = set_combine(sets.idle,{
		-- DT 6%
		head="Malignance Chapeau",
		-- DT 6%
		neck="Loricate Torque +1",
		-- 2% MDT
		ear1="Odnowa Earring +1",
		-- 3% MDT
		ear2="Etiolation Earring",
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
		-- PDT 4%
		waist="Flume Belt +1",
		-- DT 7%
		legs="Malignance Tights",
		-- DT 4%
		feet="Malignance Boots",
	})

	-- DT: 50%
	-- PDT: 9%
	-- MDT: 10%
	-- MDB: 29
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.defense.MDT = set_combine(sets.idle,{
		-- DT 6% MDB 5
		head="Malignance Chapeau",
		-- 2% MDT
		ear1="Odnowa Earring +1",
		-- 3% MDT
		ear2="Etiolation Earring",
		-- MDB 8
		--neck="Inq. Bead Necklace",
		-- DT 6%
		neck="Loricate Torque +1",
		-- DT 9% MDB 8
		body="Malignance Tabard",
		-- DT 5% MDB 4
		hands="Malignance Gloves",
		-- PDT 5% MDT 5%
		ring1="Dark Ring",
		--ring1="Shadow Ring",
		-- DT 10%
		ring2="Defending Ring",
		-- DT 5%
		back="Moonbeam Cape",
		-- PDT 4%
		waist="Flume Belt +1",
		-- DT: 7% MDB 7
		legs="Malignance Tights",
		-- DT 4% MDB 5
		feet="Malignance Boots",
	})


	--------------------------------------
	-- Melee sets
	--------------------------------------

	-- (1 - Dual Wield %) × (1 - Haste %)  ≥  0.2
	--
	-- Trait: 25
	-- Gift: 5
	--
	--			Magic Haste
	--			0%	10%	15%	30%	35%	Cap
	--T3(25)	49	45	42	31	26	11
	--T4(30)	44	40	37	26	21 	6
	
	-- Normal melee group
	-- DW needed: 49 (44 with gift)
	-- 34 Gear DW
	sets.engaged = {
		head=gear.Adhemar_head_hq_B,
		neck="Iskur Gorget",
		ear1="Sherida Earring",
		-- 5 DW
		ear2="Suppanomimi",
		-- 6 DW
		body=gear.Adhemar_body_hq_B,
		-- 5 DW
		hands="Pill. Armlets +3",
		ring1="Epona's Ring",
		-- 5 DW
		ring2="Haverton Ring",
		--ring2="Petrov Ring",
		-- 6 DW
		back=gear.jsecape_dex_dw,
		-- 7 DW
		waist="Reiki Yotai",
		legs="Samnuha Tights",
		feet="Plun. Poulaines +3"
	}

	-- 28 Gear DW
	sets.engaged.MidAcc = set_combine(sets.engaged,{
		ammo="Yamarang",
		neck="Lissome Necklace",
		body="Pillager's Vest +3",
		hands="Pill. Armlets +3",
		legs="Meg. Chausses +2",
	})

	-- 11 Gear DW
	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc,{
		head="Plun. Bonnet +3",
		ear1="Digni. Earring",
		ear2="Telos Earring",
		ring1="Cacoethic Ring +1",
		ring2="Regal Ring",
		waist="Eschan Stone",
		legs="Pill. Culottes +3",
	})

	-- 11 Gear DW
	sets.engaged.FullAcc = set_combine(sets.engaged.HighAcc, {
		head="Pill. Bonnet +3",
		neck="Subtlety Spec.",
		body="Pillager's Vest +3",
		hands="Pill. Armlets +3",
		ring1="Regal Ring",
		legs="Pill. Culottes +3",
		feet="Malignance Boots",
	})
	
	-- 6 Gear DW
	sets.engaged.Evasion = set_combine(sets.engaged,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring2="Ilabrat Ring",
		back=gear.jsecape_dex_dw,
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	sets.engaged.MidAcc.Evasion = set_combine(sets.engaged.MidAcc,sets.engaged.Evasion,{
	})
	sets.engaged.HighAcc.Evasion = set_combine(sets.engaged.HighAcc,sets.engaged.Evasion,{
	})
	sets.engaged.FullAcc.Evasion = set_combine(sets.engaged.FullAcc,sets.engaged.Evasion,{
	})
	sets.engaged.PDT = set_combine(sets.engaged.Evasion,{
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	sets.engaged.MidAcc.PDT = set_combine(sets.engaged.PDT,{
	})
	sets.engaged.HighAcc.PDT = set_combine(sets.engaged.MidAcc.PDT,{
	})
	sets.engaged.FullAcc.PDT = set_combine(sets.engaged.HighAcc.PDT,{
	})
	sets.engaged.MDT = set_combine(sets.engaged.Evasion,{
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	sets.engaged.MidAcc.MDT = set_combine(sets.engaged.MDT,{
	})
	sets.engaged.HighAcc.MDT = set_combine(sets.engaged.MidAcc.MDT,{
	})
	sets.engaged.FullAcc.MDT = set_combine(sets.engaged.HighAcc.MDT,{
	})
	-- To activate, must cycle both HybridMode and PhysicalDefenseMode to HybridTH
	-- gs c cycle PhysicalDefenseMode + gs c cycle HybridMode
	-- Use Sandung, Chaac Belt, or Perfect Taming Sari to cap TH at 8
	sets.engaged.HybridTH = set_combine(sets.engaged.PDT, sets.TreasureHunter,{
		-- DT 3%
		--ammo="Staunch Tathlum +1",
		ammo="Yamarang",
		-- DT 6%
		head="Malignance Chapeau",
		-- DT 6%
		neck="Loricate Torque +1",
		ear1="Sherida Earring",
		-- MDT 3%
		ear2="Etiolation Earring",
		-- DT 9%
		body="Malignance Tabard",
		hands="Plun. Armlets +3",
		-- DT 5%
		ring1="Dark Ring",
		-- DT 10%
		ring2="Defending Ring",
		-- DT 5%
		back="Moonbeam Cape",
		waist="Reiki Yotai",
		-- DT 7%
		legs="Malignance Tights",
		-- DT 4%
		feet="Malignance Boots",
	})
	sets.engaged.MidAcc.HybridTH = set_combine(sets.engaged.HybridTH,{
	})
	sets.engaged.HighAcc.HybridTH = set_combine(sets.engaged.MidAcc.HybridTH,{
	})
	sets.engaged.FullAcc.HybridTH = set_combine(sets.engaged.HighAcc.HybridTH,{
	})

	-- ==== Haste sets ================

	-- Normal -------
	-- DW needed: 42 (37 with gift)
	-- 33 Gear DW
	sets.engaged.Haste_15 = set_combine(sets.engaged,{
	})
	-- DW needed: 31 (26 with gift)
	-- 26 Gear DW
	sets.engaged.Haste_30 = set_combine(sets.engaged,{
		waist="Windbuffet Belt +1",
	})
	-- DW needed: 26 (21 with gift)
	-- 22 Gear DW
	sets.engaged.Haste_35 = set_combine(sets.engaged,{
		-- 5 DW
		ear2="Suppanomimi",
		body="Pillager's Vest +3",
		-- 5 DW
		hands="Pill. Armlets +3",
		-- 5 DW
		ring2="Haverton Ring",
		back=gear.jsecape_dex_crit,
		-- 7 DW
		waist="Reiki Yotai",
		legs="Meg. Chausses +2",
	})
	-- DW needed: 11 (6 with gift)
	-- 6 Gear DW
	sets.engaged.MaxHaste = set_combine(sets.engaged,{
		ear1="Sherida Earring",
		ear2="Telos Earring",
		body="Pillager's Vest +3",
		--hands="Pill. Armlets +3",
		--hands="Malignance Gloves",
		hands=gear.Adhemar_hands_hq_B,
		ring1="Gere Ring",
		--back=gear.jsecape_dex_crit,
		-- 6 DW
		back=gear.jsecape_dex_dw,
		waist="Windbuffet Belt +1",
		legs="Meg. Chausses +2",
	})

	sets.engaged.MidAcc.Haste_15 = set_combine(sets.engaged.MidAcc,{
		ear1="Sherida Earring",
		ear2="Suppanomimi",
	})
	sets.engaged.MidAcc.Haste_30 = set_combine(sets.engaged.MidAcc,{
		ear1="Sherida Earring",
		ear2="Suppanomimi",
	})
	sets.engaged.MidAcc.Haste_35 = set_combine(sets.engaged.MidAcc,{
		ear1="Sherida Earring",
		ear2="Suppanomimi",
		back=gear.jsecape_dex_crit,
	})
	sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.MidAcc,{
		ear1="Sherida Earring",
		ear2="Telos Earring",
		ring1="Gere Ring",
		back=gear.jsecape_dex_dw,
		waist="Windbuffet Belt +1",
	})

	sets.engaged.HighAcc.Haste_15 = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.HighAcc.Haste_30 = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.HighAcc.Haste_35 = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.HighAcc,{
	})

	sets.engaged.FullAcc.Haste_15 = set_combine(sets.engaged.FullAcc,{
	})
	sets.engaged.FullAcc.Haste_30 = set_combine(sets.engaged.FullAcc,{
	})
	sets.engaged.FullAcc.Haste_35 = set_combine(sets.engaged.FullAcc,{
	})
	sets.engaged.FullAcc.MaxHaste = set_combine(sets.engaged.FullAcc,{
	})

	-- Evasion -------
	sets.engaged.Evasion.Haste_15 = set_combine(sets.engaged.Evasion,{
	})
	sets.engaged.Evasion.Haste_30 = set_combine(sets.engaged.Evasion,{
	})
	sets.engaged.Evasion.Haste_35 = set_combine(sets.engaged.Evasion,{
	})
	sets.engaged.Evasion.MaxHaste = set_combine(sets.engaged.Evasion,{
	})

	sets.engaged.MidAcc.Evasion.Haste_15 = set_combine(sets.engaged.MidAcc.Evasion,{
	})
	sets.engaged.MidAcc.Evasion.Haste_30 = set_combine(sets.engaged.MidAcc.Evasion,{
	})
	sets.engaged.MidAcc.Evasion.Haste_35 = set_combine(sets.engaged.MidAcc.Evasion,{
	})
	sets.engaged.MidAcc.Evasion.MaxHaste = set_combine(sets.engaged.MidAcc.Evasion,{
	})

	sets.engaged.HighAcc.Evasion.Haste_15 = set_combine(sets.engaged.HighAcc.Evasion,{
	})
	sets.engaged.HighAcc.Evasion.Haste_30 = set_combine(sets.engaged.HighAcc.Evasion,{
	})
	sets.engaged.HighAcc.Evasion.Haste_35 = set_combine(sets.engaged.HighAcc.Evasion,{
	})
	sets.engaged.HighAcc.Evasion.MaxHaste = set_combine(sets.engaged.HighAcc.Evasion,{
	})

	sets.engaged.FullAcc.Evasion.Haste_15 = set_combine(sets.engaged.FullAcc.Evasion,{
	})
	sets.engaged.FullAcc.Evasion.Haste_30 = set_combine(sets.engaged.FullAcc.Evasion,{
	})
	sets.engaged.FullAcc.Evasion.Haste_35 = set_combine(sets.engaged.FullAcc.Evasion,{
	})
	sets.engaged.FullAcc.Evasion.MaxHaste = set_combine(sets.engaged.FullAcc.Evasion,{
	})

	-- PDT -------
	sets.engaged.PDT.Haste_15 = set_combine(sets.engaged.PDT,{
	})
	sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.PDT,{
	})
	sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.PDT,{
	})
	sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.PDT,{
	})

	sets.engaged.MidAcc.PDT.Haste_15 = set_combine(sets.engaged.MidAcc,{
	})
	sets.engaged.MidAcc.PDT.Haste_30 = set_combine(sets.engaged.MidAcc.PDT,{
	})
	sets.engaged.MidAcc.PDT.Haste_35 = set_combine(sets.engaged.MidAcc.PDT,{
	})
	sets.engaged.MidAcc.PDT.MaxHaste = set_combine(sets.engaged.MidAcc.PDT,{
	})

	sets.engaged.HighAcc.PDT.Haste_15 = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.HighAcc.PDT.Haste_30 = set_combine(sets.engaged.HighAcc.PDT,{
	})
	sets.engaged.HighAcc.PDT.Haste_35 = set_combine(sets.engaged.HighAcc.PDT,{
	})
	sets.engaged.HighAcc.PDT.MaxHaste = set_combine(sets.engaged.HighAcc.PDT,{
	})

	sets.engaged.FullAcc.PDT.Haste_15 = set_combine(sets.engaged.FullAcc,{
	})
	sets.engaged.FullAcc.PDT.Haste_30 = set_combine(sets.engaged.FullAcc.PDT,{
	})
	sets.engaged.FullAcc.PDT.Haste_35 = set_combine(sets.engaged.FullAcc.PDT,{
	})
	sets.engaged.FullAcc.PDT.MaxHaste = set_combine(sets.engaged.FullAcc.PDT,{
	})

	-- MDT -------
	sets.engaged.MDT.Haste_15 = set_combine(sets.engaged,{
	})
	sets.engaged.MDT.Haste_30 = set_combine(sets.engaged.MDT,{
	})
	sets.engaged.MDT.Haste_35 = set_combine(sets.engaged.MDT,{
	})
	sets.engaged.MDT.MaxHaste = set_combine(sets.engaged.MDT,{
	})

	sets.engaged.MidAcc.MDT.Haste_15 = set_combine(sets.engaged.MidAcc.MDT,{
	})
	sets.engaged.MidAcc.MDT.Haste_30 = set_combine(sets.engaged.MidAcc.MDT,{
	})
	sets.engaged.MidAcc.MDT.Haste_35 = set_combine(sets.engaged.MidAcc.MDT,{
	})
	sets.engaged.MidAcc.MDT.MaxHaste = set_combine(sets.engaged.MidAcc.MDT,{
	})

	sets.engaged.HighAcc.MDT.Haste_15 = set_combine(sets.engaged.HighAcc.MDT,{
	})
	sets.engaged.HighAcc.MDT.Haste_30 = set_combine(sets.engaged.HighAcc.MDT,{
	})
	sets.engaged.HighAcc.MDT.Haste_35 = set_combine(sets.engaged.HighAcc.MDT,{
	})
	sets.engaged.HighAcc.MDT.MaxHaste = set_combine(sets.engaged.HighAcc.MDT,{
	})

	sets.engaged.FullAcc.MDT.Haste_15 = set_combine(sets.engaged.FullAcc.MDT,{
	})
	sets.engaged.FullAcc.MDT.Haste_30 = set_combine(sets.engaged.FullAcc.MDT,{
	})
	sets.engaged.FullAcc.MDT.Haste_35 = set_combine(sets.engaged.FullAcc.MDT,{
	})
	sets.engaged.FullAcc.MDT.MaxHaste = set_combine(sets.engaged.FullAcc.MDT,{
	})

	-- HybridTH -------
	sets.engaged.HybridTH.Haste_15 = set_combine(sets.engaged,{
	})
	sets.engaged.HybridTH.Haste_30 = set_combine(sets.engaged.HybridTH,{
	})
	sets.engaged.HybridTH.Haste_35 = set_combine(sets.engaged.HybridTH,{
	})
	sets.engaged.HybridTH.MaxHaste = set_combine(sets.engaged.HybridTH,{
	})

	sets.engaged.MidAcc.HybridTH.Haste_15 = set_combine(sets.engaged.MidAcc.HybridTH,{
	})
	sets.engaged.MidAcc.HybridTH.Haste_30 = set_combine(sets.engaged.MidAcc.HybridTH,{
	})
	sets.engaged.MidAcc.HybridTH.Haste_35 = set_combine(sets.engaged.MidAcc.HybridTH,{
	})
	sets.engaged.MidAcc.HybridTH.MaxHaste = set_combine(sets.engaged.MidAcc.HybridTH,{
	})

	sets.engaged.HighAcc.HybridTH.Haste_15 = set_combine(sets.engaged.HighAcc.HybridTH,{
	})
	sets.engaged.HighAcc.HybridTH.Haste_30 = set_combine(sets.engaged.HighAcc.HybridTH,{
	})
	sets.engaged.HighAcc.HybridTH.Haste_35 = set_combine(sets.engaged.HighAcc.HybridTH,{
	})
	sets.engaged.HighAcc.HybridTH.MaxHaste = set_combine(sets.engaged.HighAcc.HybridTH,{
	})

	sets.engaged.FullAcc.HybridTH.Haste_15 = set_combine(sets.engaged.FullAcc.HybridTH,{
	})
	sets.engaged.FullAcc.HybridTH.Haste_30 = set_combine(sets.engaged.FullAcc.HybridTH,{
	})
	sets.engaged.FullAcc.HybridTH.Haste_35 = set_combine(sets.engaged.FullAcc.HybridTH,{
	})
	sets.engaged.FullAcc.HybridTH.MaxHaste = set_combine(sets.engaged.FullAcc.HybridTH,{
	})

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end

		-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
		determine_haste_group()
		if not midaction() then
				handle_equipping_gear(player.status)
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 11)
	elseif player.sub_job == 'NIN' then
		set_macro_page(2, 11)
	elseif player.sub_job == 'COR' then
		set_macro_page(3, 11)
	elseif player.sub_job == 'RUN' then
		set_macro_page(4, 11)
	else
		set_macro_page(1, 11)
	end
end

function determine_haste_group()

	classes.CustomMeleeGroups:clear()
	-- assuming +4 for marches (ghorn has +5)
	-- Haste (white magic) 15%
	-- Haste Samba (Sub) 5%
	-- Haste (Merited DNC) 10% (never account for this)
	-- Victory March +0/+3/+4/+5    9.4/14%/15.6%/17.1% +0
	-- Advancing March +0/+3/+4/+5  6.3/10.9%/12.5%/14%  +0
	-- Embrava 30% with 500 enhancing skill
	-- Mighty Guard - 15%
	-- buffactive[580] = geo haste
	-- buffactive[33] = regular haste
	-- buffactive[604] = mighty guard
	-- state.HasteMode = toggle for when you know Haste II is being cast on you
	-- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
	if state.HasteMode.value == 'Hi' then
		if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
			( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
			( buffactive.march == 2 and buffactive[604] ) ) then
			add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
			classes.CustomMeleeGroups:append('MaxHaste')
		elseif ( (buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba'] ) then
			add_to_chat(8, '-------------Haste 35%-------------')
			classes.CustomMeleeGroups:append('Haste_35')
		elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
			( buffactive.march == 1 and buffactive[604] ) ) then
			add_to_chat(8, '-------------Haste 30%-------------')
			classes.CustomMeleeGroups:append('Haste_30')
		elseif ( buffactive.march == 1 or buffactive[604] ) then
			add_to_chat(8, '-------------Haste 15%-------------')
			classes.CustomMeleeGroups:append('Haste_15')
		end
	else
		if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
			( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
			( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
			( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
			add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
			classes.CustomMeleeGroups:append('MaxHaste')
		elseif ( (buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or -- MG or haste + samba with 1 march
			( buffactive.march == 2 and buffactive['haste samba'] ) or
			( buffactive[580] and buffactive['haste samba'] ) then 
			add_to_chat(8, '-------------Haste 35%-------------')
			classes.CustomMeleeGroups:append('Haste_35')
		elseif ( buffactive.march == 2 ) or -- two marches from ghorn
			( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
			( buffactive[580] ) or  -- geo haste
			( buffactive[33] and buffactive[604] ) then  -- haste with MG
			add_to_chat(8, '-------------Haste 30%-------------')
			classes.CustomMeleeGroups:append('Haste_30')
		elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
			add_to_chat(8, '-------------Haste 15%-------------')
			classes.CustomMeleeGroups:append('Haste_15')
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if not buffactive['Protect'] then
		idleSet = set_combine(idleSet, sets.noprotect)
	end
	if buffactive['Doom'] then
		idleSet = set_combine(idleSet, sets.buff.Doom)
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
	if state.BehindMode.value == 'Normal' then
		meleeSet = set_combine(meleeSet, sets.Behind)
	end
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