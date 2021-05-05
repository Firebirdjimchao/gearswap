--------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
	state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.RangedMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.HybridMode:options('Normal', 'PDT', 'MDT', 'Reraise')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc', 'PDT', 'MDT')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.MagicalDefenseMode:options('MDT', 'Reraise')
	state.IdleMode:options('Normal', 'Regain', 'Regen', 'Reraise')

	state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}
	state.EnmityMode = M{['description']='Enmity Mode', 'None', 'Down', 'Up'}
	state.MeleeDTMode = M(false, 'PDT', 'MDT')
	state.TreasureMode = M(false, 'TH')
	
	gear.Smertrio_STP = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10','Damage taken-5%',}}
	gear.Smertrio_STP_DEX = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}
	gear.Smertrio_WS = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}}
	
	update_combat_form()

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
	--send_command('bind @` input /ja "Hasso" <me>')
	send_command('bind @` gs c cycle HasteMode')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind ^` gs equip sets.Twilight; input /echo --- Twilight Set equipped ---')
	send_command('bind ^- gs c cycle enmitymode')
	send_command('bind ^= gs c toggle TreasureMode; input /echo --- TreasureMode ---')
	send_command('bind != gs c toggle MeleeDTMode; input /echo --- MeleeDTMode ---')
	
	select_default_macro_book()

	global_aliases()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind @`')
	send_command('unbind ^`')
	send_command('unbind !`')
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

	-- 32% DT 28% PDT 10% MDT 30 MDB (43% DT if using Khonsu)
	sets.DT = {
		-- 6& DT
		--sub="Khonsu",
		-- 2% DT
		ammo="Staunch Tathlum +1",
		-- 5% MDT
		--head=gear.Valorous_head_WS,
		-- 7% PDT
		head="Mpaca's Cap",
		-- 2% MDT
		ear1="Odnowa Earring +1",
		-- 3% MDT
		ear2="Etiolation Earring",
		-- 6% DT
		neck="Loricate Torque +1",
		-- 10% DT 6 MDB
		--body="Tartarus Platemail",
		-- 8% DT 5 MDB
		--body="Wakido Domaru +3",
		-- 9% DT 8 MDB
		body="Nyame Mail",
		-- 6% PDT 3 MDB
		hands="Sakonji Kote +3",
		--ring1="Niqmaddu Ring",
		-- 5% PDT 5% MDT
		ring1="Dark Ring",
		-- 10% DT
		ring2="Defending Ring",
		-- 5% DT
		back=gear.Smertrio_STP,
		-- 4% PDT
		waist="Flume Belt +1",
		-- 8 MDB
		legs="Ken. Hakama +1",
		-- 4% DT 2 MDB
		--feet="Amm Greaves",
		-- 6% PDT 12 MDB
		feet="Mpaca's Boots",
	}

	sets.MAB = {
		head=gear.Valorous_head_Magic,
		--neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		body="Sacro Breastplate",
		hands="Leyline Gloves",
		ring1="Acumen Ring",
		back=gear.Smertrio_WS,
		legs="Wakido Haidate +3",
		--feet="Founder's Greaves"
		feet=gear.Valorous_feet_WS,
	}

	sets.STP =  {
		-- 3 STP
		ammo="Ginsen",
		-- 5 STP 4%
		head="Flam. Zucchetto +2",
		-- STP 7 + 7 aug
		neck="Sam. Nodowa +2",
		-- STP 8
		ear1="Dedition Earring",
		-- 1 STP
		ear2="Brutal Earring",
		-- 9 STP
		body="Wakido Domaru +3",
		-- 7 STP 4% Hasso +4
		hands="Wakido Kote +3",
		-- 5 STP
		ring1="Flamma Ring",
		-- 5 STP
		ring2="Rajas Ring",
		-- 10 STP
		back=gear.Smertrio_STP,
		-- 4 STP
		waist="Reiki Yotai",
		-- 9 STP
		legs="Wakido Haidate +3",
	}

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
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
	-- Precast sets to enhance JAs
	sets.precast.JA.Meditate = {
		head="Wakido kabuto +3",
		hands="Sakonji Kote +3",
		back="Smertrios's Mantle"
	}
	sets.precast.JA['Warding Circle'] = {head="Wakido kabuto +3"}
	sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +3"}
	sets.precast.JA['Hasso'] = {feet="Wakido Sune. +3"}

	sets.precast.JA['Jump'] = set_combine(sets.STP,{})
	sets.precast.JA['High Jump'] = set_combine(sets.STP,{})

	sets.precast.JA['Provoke'] = set_combine(sets.EnmityUp, {})

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Wakido kabuto +3",
		body="Dagon Breastplate",
		hands="Wakido Kote +3",
		back="Tantalic Cape",
		waist="Flume Belt +1",
		legs="Wakido Haidate +3",
		feet="Wakido Sune. +3"
	}
	    
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	-- Sets for fast cast gear for spells
	sets.precast.FC = {
		-- 4% FC
		neck="Voltsurge Torque",
		-- 2%
		ear1="Loquac. Earring",
		-- 1%
		ear2="Etiolation Earring",
		-- 10%
		body="Sacro Breastplate",
		-- 5% + 3%
		hands="Leyline Gloves",
		-- 2%
		ring1="Prolix Ring",
		-- 2%
		--ring2="Rahab Ring",
		-- 3%
		legs="Limbo Trousers"
	}
	
	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		ring1="Haverton Ring"
	}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Knobkierrie",
		--head=gear.Rao_head_hq_B,
		head=gear.Valorous_head_WS,
		neck="Fotia Gorget",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		body="Sakonji Domaru +3",
		--hands=gear.Valorous_hand_TP,
		hands=gear.Valorous_hand_WS,
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.Smertrio_WS,
		waist="Fotia Belt",
		legs="Wakido Haidate +3",
		feet=gear.Valorous_feet_WS,
	}
	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
	})
	sets.precast.WS.HighAcc = set_combine(sets.precast.WS, {
		feet="Wakido Sune. +3"
	})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {
		--neck="Subtlety Spec.",
		hands="Wakido Kote +3",
		waist="Grunfeld Rope",
		legs="Wakido Haidate +3",
		--feet="Flam. Gambieras +1"
		--feet=gear.Rao_feet_hq_B,
		feet="Wakido Sune. +3",
	})
	sets.precast.WS.MAB = set_combine(sets.MAB, sets.precast.WS, {
		ring2="Beithir Ring",
	})
	sets.precast.WS.RA = set_combine(sets.precast.WS,{
		ear1="Telos Earring",
		ear2="Moonshade Earring",
		body="Sakonji Domaru +3",
		legs="Wakido Haidate +3",
		feet="Wakido Sune. +3"
	})

	sets.precast.WS.MaxTP = {
		ear2="Ishvara Earring",
		--ear1="Lugra Earring +1",
	}

	sets.precast.WS.PDTBase = {
		head="Mpaca's Cap",
		body="Wakido Domaru +3",
		hands="Sakonji Kote +3",
		ring2="Defending Ring",
		feet="Mpaca Boots",
	}

	sets.precast.WS.MDTBase = {
		head="Mpaca's Cap",
		body="Wakido Domaru +3",
		hands="Sakonji Kote +3",
		ring2="Defending Ring",
		legs="Ken. Hakama +1",
	}

	-- Fudo/Kasha/Gekko/Yukikaze
	sets.precast.WS1Hit = set_combine(sets.precast.WS,{
		ammo="Knobkierrie",
		--head=gear.Valorous_head_WS,
		head="Mpaca's Cap",
		neck="Sam. Nodowa +2",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		body="Sakonji Domaru +3",
		hands=gear.Valorous_hand_WS,
		ring1="Niqmaddu Ring",
		--ring2="Regal Ring",
		ring2="Beithir Ring",
		back=gear.Smertrio_WS,
		waist="Sailfi Belt +1",
		--waist="Fotia Belt",
		legs="Wakido Haidate +3",
		feet=gear.Valorous_feet_WS,
	})
	sets.precast.WS1Hit.MidAcc = set_combine(sets.precast.WS1Hit,{
	})
	sets.precast.WS1Hit.HighAcc = set_combine(sets.precast.WS1Hit.MidAcc,{
		ear1="Telos Earring",
		hands="Wakido Kote +3",
		ring2="Regal Ring",
	})
	sets.precast.WS1Hit.FullAcc = set_combine(sets.precast.WS1Hit.HighAcc,{
		head="Wakido Kabuto +3",
	})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	-- 80% STR (1-hit)
	sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS1Hit, {
	})
	sets.precast.WS['Tachi: Fudo'].MidAcc = set_combine(sets.precast.WS1Hit.MidAcc, {
	})
	sets.precast.WS['Tachi: Fudo'].HighAcc = set_combine(sets.precast.WS1Hit.HighAcc, {
	})
	sets.precast.WS['Tachi: Fudo'].FullAcc = set_combine(sets.precast.WS1Hit.FullAcc, {
	})
	sets.precast.WS['Tachi: Fudo'].PDT = set_combine(sets.precast.WS1Hit.FullAcc, sets.precast.WS.PDTBase, {
	})
	sets.precast.WS['Tachi: Fudo'].MDT = set_combine(sets.precast.WS1Hit.FullAcc, sets.precast.WS.MDTBase, {
	})

	-- 75% STR (1-hit)
	sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS1Hit, {
	})
	sets.precast.WS['Tachi: Kasha'].MidAcc = set_combine(sets.precast.WS1Hit.MidAcc, {
	})
	sets.precast.WS['Tachi: Kasha'].HighAcc = set_combine(sets.precast.WS1Hit.HighAcc, {
	})
	sets.precast.WS['Tachi: Kasha'].FullAcc = set_combine(sets.precast.WS1Hit.FullAcc, {
	})
	sets.precast.WS['Tachi: Kasha'].PDT = set_combine(sets.precast.WS1Hit.FullAcc, sets.precast.WS.PDTBase, {
	})
	sets.precast.WS['Tachi: Kasha'].MDT = set_combine(sets.precast.WS1Hit.FullAcc, sets.precast.WS.MDTBase, {
	})

	-- 75% STR (1-hit)
	sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Tachi: Gekko'].MidAcc = set_combine(sets.precast.WS1Hit.MidAcc, {
	})
	sets.precast.WS['Tachi: Gekko'].HighAcc = set_combine(sets.precast.WS1Hit.HighAcc, {
	})
	sets.precast.WS['Tachi: Gekko'].FullAcc = set_combine(sets.precast.WS1Hit.FullAcc, {
	})
	sets.precast.WS['Tachi: Gekko'].PDT = set_combine(sets.precast.WS1Hit.FullAcc, sets.precast.WS.PDTBase, {
	})
	sets.precast.WS['Tachi: Gekko'].MDT = set_combine(sets.precast.WS1Hit.FullAcc, sets.precast.WS.MDTBase, {
	})
	
	-- 75% STR (1-hit)
	sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Tachi: Yukikaze'].MidAcc = set_combine(sets.precast.WS1Hit.MidAcc, {
	})
	sets.precast.WS['Tachi: Yukikaze'].HighAcc = set_combine(sets.precast.WS1Hit.HighAcc, {
	})
	sets.precast.WS['Tachi: Yukikaze'].FullAcc = set_combine(sets.precast.WS1Hit.FullAcc, {
	})
	sets.precast.WS['Tachi: Yukikaze'].PDT = set_combine(sets.precast.WS1Hit.FullAcc, sets.precast.WS.PDTBase, {
	})
	sets.precast.WS['Tachi: Yukikaze'].MDT = set_combine(sets.precast.WS1Hit.FullAcc, sets.precast.WS.MDTBase, {
	})
	
	-- 73-85% STR (2-hit)
	sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		--head=gear.Valorous_head_WS,
		head="Mpaca's Cap",
		neck="Sam. Nodowa +2",
		ear1="Thrud Earring",
		ear2="Moonshade Earring",
		body="Sakonji Domaru +3",
		hands=gear.Valorous_hand_WS,
		ring1="Niqmaddu Ring",
		--ring2="Regal Ring",
		ring2="Beithir Ring",
		back=gear.Smertrio_WS,
		waist="Sailfi Belt +1",
		legs="Wakido Haidate +3",
		feet=gear.Valorous_feet_WS,
		--feet="Flam. Gambieras +2",
	})
	sets.precast.WS['Tachi: Shoha'].MidAcc = set_combine(sets.precast.WS['Tachi: Shoha'], {
	})
	sets.precast.WS['Tachi: Shoha'].HighAcc = set_combine(sets.precast.WS['Tachi: Shoha'], {
		ear1="Telos Earring",
		hands="Wakido Kote +3",
		ring2="Regal Ring",
	})
	sets.precast.WS['Tachi: Shoha'].FullAcc = set_combine(sets.precast.WS['Tachi: Shoha'], {
		head="Wakido Kabuto +3",
	})
	sets.precast.WS['Tachi: Shoha'].PDT = set_combine(sets.precast.WS['Tachi: Shoha'].FullAcc, sets.precast.WS.PDTBase, {
	})
	sets.precast.WS['Tachi: Shoha'].MDT = set_combine(sets.precast.WS['Tachi: Shoha'].FullAcc, sets.precast.WS.MDTBase, {
	})
	
	-- 50% STR (3-hit)
	sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Tachi: Rana'].MidAcc = set_combine(sets.precast.WS['Tachi: Rana'], {
	})
	sets.precast.WS['Tachi: Rana'].HighAcc = set_combine(sets.precast.WS['Tachi: Rana'], {
		ear1="Telos Earring",
		hands="Wakido Kote +3",
		ring2="Regal Ring",
	})
	sets.precast.WS['Tachi: Rana'].FullAcc = set_combine(sets.precast.WS['Tachi: Rana'], {
		head="Wakido Kabuto +3",
		ear1="Telos Earring",
		hands="Wakido Kote +3",
		ring2="Regal Ring",
		feet="Wakido Sune. +3"
	})
	sets.precast.WS['Tachi: Rana'].PDT = set_combine(sets.precast.WS['Tachi: Rana'].FullAcc, sets.precast.WS.PDTBase, {
	})
	sets.precast.WS['Tachi: Rana'].MDT = set_combine(sets.precast.WS['Tachi: Rana'].FullAcc, sets.precast.WS.MDTBase, {
	})
	
	-- 40% STR 60% CHR (1-hit), DEF down effect accuracy affected by MACC
	sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		head="Mpaca's Cap",
		ear1="Hermetic Earring",
		ear2="Digni. Earring",
		neck="Sanctity Necklace",
		body="Sakonji Domaru +3",
		hands="Flam. Manopolas +2",
		--waist="Eschan Stone",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring",
		--legs="Flamma Dirs +2",
		--feet="Flam. Gambieras +2",
	})
	sets.precast.WS['Tachi: Ageha'].MidAcc = set_combine(sets.precast.WS['Tachi: Ageha'], {
	})
	sets.precast.WS['Tachi: Ageha'].HighAcc = set_combine(sets.precast.WS['Tachi: Ageha'], {
	})
	sets.precast.WS['Tachi: Ageha'].FullAcc = set_combine(sets.precast.WS['Tachi: Ageha'], {
	})
	sets.precast.WS['Tachi: Ageha'].PDT = set_combine(sets.precast.WS['Tachi: Ageha'], sets.precast.WS.PDTBase, {
	})
	sets.precast.WS['Tachi: Ageha'].MDT = set_combine(sets.precast.WS['Tachi: Ageha'], sets.precast.WS.MDTBase, {
	})
	
	-- Magical WS
	sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS.MAB, {
		head="Mpaca's Cap",
		neck="Sam. Nodowa +2",
		ear2="Moonshade Earring",
		hands=gear.Valorous_hand_WS,
	})
	sets.precast.WS['Tachi: Jinpu'].PDT = set_combine(sets.precast.WS['Tachi: Jinpu'], sets.precast.WS.PDTBase, {
	})
	sets.precast.WS['Tachi: Jinpu'].MDT = set_combine(sets.precast.WS['Tachi: Jinpu'], sets.precast.WS.MDTBase, {
	})
	sets.precast.WS['Tachi: Goten'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Tachi: Kagero'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Tachi: Koki'] = set_combine(sets.precast.WS.MAB, {
	})

	-- 100% STR, 2-hit, Damage varies with TP, WS at 1750
	sets.precast.WS['Impulse Drive'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		neck="Sam. Nodowa +2",
		ear2="Moonshade Earring",
		body="Sakonji Domaru +3",
		ring2="Beithir Ring",
		waist="Sailfi Belt +1",
		feet=gear.Valorous_feet_WS,
	})
	sets.precast.WS['Impulse Drive'].MidAcc = set_combine(sets.precast.WS['Impulse Drive'], {
	})
	sets.precast.WS['Impulse Drive'].HighAcc = set_combine(sets.precast.WS['Impulse Drive'], {
	})
	sets.precast.WS['Impulse Drive'].FullAcc = set_combine(sets.precast.WS['Impulse Drive'], {
	})

	-- 73%~85%STR, 4-hit, Damage varies with TP
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		neck="Fotia Gorget",
		ear2="Moonshade Earring",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
		ring2="Beithir Ring",
		waist="Fotia Belt",
		legs="Ken. Hakama +1",
		feet=gear.Valorous_feet_WS,
	})
	sets.precast.WS['Stardiver'].MidAcc = set_combine(sets.precast.WS['Stardiver'], {
		ring2="Regal Ring",
	})
	sets.precast.WS['Stardiver'].HighAcc = set_combine(sets.precast.WS['Stardiver'], {
	})
	sets.precast.WS['Stardiver'].FullAcc = set_combine(sets.precast.WS['Stardiver'], {
	})
	
	-- Ranged WS
	-- 50% AGI 20% STR
	sets.precast.WS['Flaming Arrow'] = set_combine(sets.precast.WS.MAB, {
	})
	-- 50% AGI 20% STR
	sets.precast.WS['Sidewinder'] = set_combine(sets.precast.WS.RA, {
	})
	sets.precast.WS['Sidewinder'].MidAcc = set_combine(sets.precast.WS['Sidewinder'], {
	})
	sets.precast.WS['Sidewinder'].HighAcc = set_combine(sets.precast.WS['Sidewinder'], {
	})
	sets.precast.WS['Sidewinder'].FullAcc = set_combine(sets.precast.WS['Sidewinder'], {
	})
	-- 60% STR
	sets.precast.WS['Refulgent Arrow'] = set_combine(sets.precast.WS.RA, {
	})
	sets.precast.WS['Refulgent Arrow'].MidAcc = set_combine(sets.precast.WS['Refulgent Arrow'], {
	})
	sets.precast.WS['Refulgent Arrow'].HighAcc = set_combine(sets.precast.WS['Refulgent Arrow'], {
	})
	sets.precast.WS['Refulgent Arrow'].FullAcc = set_combine(sets.precast.WS['Refulgent Arrow'], {
	})
	-- 73%-85% AGI
	sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS.RA, {
	})
	sets.precast.WS['Apex Arrow'].MidAcc = set_combine(sets.precast.WS['Apex Arrow'], {
	})
	sets.precast.WS['Apex Arrow'].HighAcc = set_combine(sets.precast.WS['Apex Arrow'], {
	})
	sets.precast.WS['Apex Arrow'].FullAcc = set_combine(sets.precast.WS['Apex Arrow'], {
	})
	-- 40% STR 40% AGI
	sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS.RA, {
		ring1="Ilabrat Ring",
		ring2="Regal Ring"
	})
	sets.precast.WS['Namas Arrow'].MidAcc = set_combine(sets.precast.WS['Namas Arrow'], {
	})
	sets.precast.WS['Namas Arrow'].HighAcc = set_combine(sets.precast.WS['Namas Arrow'], {
		ear1="Telos Earring",
		ear2="Enervating Earring",
	})
	sets.precast.WS['Namas Arrow'].FullAcc = set_combine(sets.precast.WS['Namas Arrow'], {
		ear1="Telos Earring",
		ear2="Enervating Earring",
	})
	
	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = set_combine(sets.precast.FC, sets.DT, {
	})
	
	sets.midcast.RA = {
		head=gear.Rao_head_hq_B,
		neck="Marked Gorget",
		ear1="Telos Earring",
		ear2="Enervating Earring",
		body="Ken. Samue +1",
		hands="Wakido Kote +3",
		ring1="Ilabrat Ring",
		ring2="Regal Ring",
		back=gear.Smertrio_STP,
		waist="Yemaya Belt",
		legs="Ken. Hakama +1",
		feet="Wakido Sune. +3"
	}
	
	sets.midcast.RA.MidAcc = set_combine(sets.midcast.RA,{
		ring1="Haverton Ring",
		ring2="Cacoethic Ring +1"
	})
  
	sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA,{
		ring1="Haverton Ring",
		ring2="Cacoethic Ring +1"
	})
	
	sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA,{
		neck="Marked Gorget",
		ring1="Haverton Ring",
		ring2="Cacoethic Ring +1"
	})
	
	-- Sets to return to when not performing an action.

	sets.Twilight = {
		head="Twilight Helm",
		body="Twilight Mail"
	}
	
	-- Idle sets
	
	sets.idle = set_combine(sets.DT, {
		feet="Danzo Sune-ate"
	})
	
	sets.noprotect = {ring1="Sheltered Ring"}
	
	sets.idle.Town = set_combine(sets.idle,{
		ammo="Knobkierrie",
		--head="Rao Kabuto +1",
		--head=gear.Valorous_head_WS,
		head="Mpaca's Cap",
		neck="Sam. Nodowa +2",
		--body="Councilor's Garb"
		--body="Tartarus Platemail",
		--body="Sacro Breastplate",
		body="Tatena. Harama. +1",
		--hands="Wakido Kote +3",
		hands="Tatena. Gote +1",
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.Smertrio_WS,
		waist="Sailfi Belt +1",
		legs="Wakido Haidate +3",
		--feet="Rao Sune-Ate +1",
	})
	
	sets.idle.Regen = set_combine(sets.idle,{
		head="Rao Kabuto +1",
		neck="Bathy Choker +1",
		body="Sacro Breastplate",
		ring1="Sheltered Ring",
		feet="Rao Sune-Ate +1",
	})

	sets.idle.Regain = set_combine(sets.idle,{
		head="Wakido Kabuto +3",
	})

	sets.idle.Weak = set_combine(sets.idle.Regen, sets.Twilight, {
	})

		-- Resting sets
	sets.resting = set_combine(sets.idle.Regen,{
	})
	
	-- Defense sets

	sets.defense.DT = set_combine(sets.DT,{
	})

	sets.defense.PDT = set_combine(sets.defense.DT,{
	})
	
	sets.defense.Reraise = set_combine(sets.Twilight,{
	})
	
	sets.defense.MDT = set_combine(sets.defense.DT,{
		--neck="Inq. Bead Necklace",
		body="Sacro Breastplate",
	})
	
	sets.Kiting = {feet="Danzo Sune-ate"}
	
	sets.Reraise = set_combine(sets.Twilight,{
	})
	
	-- Engaged sets
	
	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- TP/hit = floor( Base TP/hit × (100 + Store TP Total)÷100 , 1)
	-- Delay: 450
	-- Base TP/hit for Delay 176~530: floor(17+(Delay×489÷2000)) = floor((450x489/2000) +17) = 127
	--
	-- Delay 450 5 hit: 58 Total Store TP
	-- 200 = floor( 127 × (100 + 58)÷100 , 1)
	-- 200 x 5 = 1000
	-- 
	-- Delay 450 4 hit: 97 Total Store TP
	-- 250 = floor( 127 × (100 + 97)÷100 , 1)
	-- 250 x 4 = 1000
	--
	-- With 164 (25 Save TP)
	-- 209 = floor( 127 × (100 + 65)÷100 , 1)
	-- 209 x 4 + 164 (25 Save Tp) = 1000
	-- 279 = floor( 127 × (100 + 120)÷100 , 1)
	-- 279 x 3 + 164 (25 Save Tp) = 1000
	--
	-- Delay 450 3 hit: 163 Total Store TP
	-- 334 = floor( 127 × (100 + 163)÷100 , 1)
	-- 334 x 3 = 1002
	--
	-- Delay 450 2 hit: 294 Total Store TP
	-- 500 = floor( 127 × (100 + 294)÷100 , 1)
	-- 500 x 2 = 1000
	--
	-- Store TP Breakdown
	-- Trait: 30 (SAM Lv.90)
	-- Merit: 10 (5 x 2 STP)
	-- SAM Roll: Lucky (2) 32 STP, Eleven 40 STP, Unlucky (6) 4 STP
	-- Gifts: 8 (4 x 2 STP)
	--
	-- Gear STP needed for 5 hit:
	-- No SAM Roll: 58 - 48 = 10 STP
	-- Lucky: 58 - 48 - 32 = 0 (-30)
	-- Eleven: 58 - 48 - 40 = 0 (-38)
	-- Unlucky: 58 - 48 - 4 = 6 STP
	--
	-- Gear STP needed for 4 hit:
	-- No SAM Roll: 97 - 48 = 49 STP
	-- Lucky: 97 - 48 - 32 = 17 STP
	-- Eleven: 97 - 48 - 40 = 9 STP
	-- Unlucky: 97 - 48 - 4 = 45 STP
	--
	-- Gear STP needed for 3 hit:
	-- No SAM Roll: 163 - 48 = 115 STP
	-- Lucky: 163 - 48 - 32 = 83 STP
	-- Eleven: 163 - 48 - 40 = 75 STP
	-- Unlucky: 163 - 48 - 4 = 111 STP
	--
	-- Gear STP needed for 2 hit:
	-- No SAM Roll: 294 - 48 = 246 STP
	-- Lucky: 294 - 48 - 32 = 214 STP
	-- Eleven: 294 - 48 - 40 = 206 STP
	-- Unlucky: 294 - 48 - 4 = 242 STP

	-- Normal melee group
	
	-- Delay 450 GK, 25 Save TP (Tsurumaru) => 65 Store TP for a 5-hit (25 Store TP in gear), 120 Store TP for a 4-hit (55 Store TP in gear)
	--
	-- Delay 450 GK => 5-hit (34 Store TP in gear/SAM Roll), 4-hit (78 Store TP in gear/SAM Roll), 3-hit (151 STP in gear/SAM Roll)
	-- Delay 494~496 => 10 STP gear/Sam Roll (5-hit), 47 STP gear/SAM Roll (4-hit), 110 STP gear/SAM Roll (3-hit)
	--
	-- SAM Roll: Lucky (2) 32 STP, Eleven 40 STP, Unlucky (6) 4 STP
	--
	-- 62~67 gear STP + 10 (Dojikiri Yasutsuna)
	-- Must use Duplus Grip
	--
	-- Gear Haste: 24%
	-- JA Haste (Hasso): 10 base + 9 gear = 19%
	-- (Hasso Gear does stack! - http://www.ffxiah.com/forum/topic/50068/does-hasso-gear-stack-now/#3211713) - Only Wakido Kote +1 and Unkai Haidate +2 didn't stack
	-- http://www.ffxiah.com/forum/topic/41903/bushido-the-way-of-the-samurai-a-guide-v-20/49#2866879
	--
	-- ** NOTE **
	-- Since there's a hard cap on overall haste at 80% (Used to be 93.75% from 43.75% Magic Haste + 25% Gear Haste + 25% JA Haste),
	-- With capped Magic Haste and capped Gear Haste you only need 11% JA Haste to reach overall cap, in this case, Hasso 10 base + 1 gear
	--
	-- /war base:
	-- 1233 ACC
	-- 1531 ATK
	sets.engaged = {
		--sub="Duplus Grip",
		-- 3 STP
		ammo="Ginsen",
		-- 5 STP 4%
		head="Flam. Zucchetto +2",
		-- STP 7 + 7 aug
		neck="Sam. Nodowa +2",
		-- STP 8
		ear1="Dedition Earring",
		-- 1 STP
		ear2="Brutal Earring",
		--ear2="Schere Earring",
		-- 12 STP 3%
		--body="Kasuga Domaru +1",
		-- STP 5~9
		body="Tatena. Harama. +1",
		-- 7 STP 4% Hasso +4
		hands="Wakido Kote +3",
		ring1="Niqmaddu Ring",
		-- 5 STP
		--ring2="Rajas Ring",
		ring2="Hetairoi Ring",
		-- 10 STP
		back=gear.Smertrio_STP,
		-- 9%
		waist="Sailfi Belt +1",
		-- 9 STP 5% Hasso +3
		--legs="Kasuga Haidate +1",
		legs="Wakido Haidate +3",
		-- 5 STP 2%
		--feet="Flam. Gambieras +1",
		-- 3% Hasso +2
		feet="Wakido Sune. +3",
	}
	-- 62~66 gear STP + 10 (Dojikiri Yasutsuna) = total: 72~76
	-- Must use Utu Grip
	--
	-- Gear Haste: 25%
	-- JA Haste (Hasso): 10 base + 6 gear = 16%
	-- /war base:
	-- 1288 ACC
	-- 1543 ATK
	sets.engaged.MidAcc = set_combine(sets.engaged,{
		--sub="Utu Grip",
		-- 3 STP
		ammo="Ginsen",
		-- 5 STP 4%
		head="Flam. Zucchetto +2",
		-- STP 7 + 7 aug
		neck="Sam. Nodowa +2",
		-- 3 STP
		ear1="Cessance Earring",
		-- 1 STP
		ear2="Brutal Earring",
		--ear2="Schere Earring",
		-- 1%
		--body="Dagon Breastplate",
		-- STP 5~9
		body="Tatena. Harama. +1",
		-- 7 STP 4% Hasso +4
		hands="Wakido Kote +3",
		ring1="Niqmaddu Ring",
		--ring2="Hetairoi Ring",
		ring2="Regal Ring",
		-- 10 STP
		back=gear.Smertrio_STP,
		-- 8%
		waist="Ioskeha Belt +1",
		-- 9 STP 5%
		legs="Wakido Haidate +3",
		-- 3% Hasso +2
		feet="Wakido Sune. +3",
	})
	-- 66~70 gear STP + 10 (Dojikiri Yasutsuna) = total: 76~80
	-- Must use Utu Grip
	--
	-- Gear Haste: 27%
	-- JA Haste (Hasso): 10 base + 6 gear = 16%
	-- Overall Haste: 0% Magic Haste (43.75% cap) + 25% Gear Haste (25% cap) + 16% (25% cap) = 41%, 80% cap
	-- JA Haste needed to cap: MIN(39%, 25%) = 25%, 25% cap
	--
	-- /war base:
	-- 1305 ACC
	-- 1469 ATK
	sets.engaged.HighAcc = set_combine(sets.engaged,{
		--sub="Utu Grip",
		-- 3 STP
		ammo="Ginsen",
		-- 5 STP 4%
		head="Flam. Zucchetto +2",
		-- STP 7 + 7 aug
		neck="Sam. Nodowa +2",
		-- 5 STP
		ear1="Telos Earring",
		-- 1 STP
		ear2="Brutal Earring",
		--ear2="Schere Earring",
		-- 1%
		--body="Dagon Breastplate",
		-- STP 5~9
		body="Tatena. Harama. +1",
		--hands=gear.Ryuo_hands_D,
		-- 7 STP 4% Hasso +4
		hands="Wakido Kote +3",
		ring1="Niqmaddu Ring",
		-- 5 STP
		--ring2="Ilabrat Ring",
		ring2="Regal Ring",
		-- 10 STP
		back=gear.Smertrio_STP_DEX,
		-- 8%
		waist="Ioskeha Belt +1",
		--waist="Windbuffet Belt +1",
		-- 9 STP 5%
		--legs="Wakido Haidate +3",
		-- 9%
		legs="Ken. Hakama +1",
		-- 5 STP 2%
		--feet="Flam. Gambieras +1",
		-- 3% Hasso +2
		feet="Wakido Sune. +3",
	})
	-- 62 gear STP + 10 (Dojikiri Yasutsuna) = total: 72
	-- Must use Utu Grip
	--
	-- Gear Haste: 30%
	-- JA Haste (Hasso): 10 base + 6 gear = 16% (assuming Hasso)
	-- JA Haste needed to cap: 55%, 25% cap
	--
	-- /war base:
	-- 1343 ACC
	-- 1567 ATK
	sets.engaged.FullAcc = set_combine(sets.engaged,{
		--sub="Utu Grip",
		-- 3 STP
		ammo="Ginsen",
		-- 7% Haste
		head="Wakido kabuto +3",
		-- STP 7 + 7 aug
		neck="Sam. Nodowa +2",
		-- 5 STP
		ear1="Telos Earring",
		ear2="Digni. Earring",
		-- 9 STP 3% Haste
		--body="Wakido Domaru +3",
		-- STP 5~9 3% Haste
		body="Tatena. Harama. +1",
		--hands=gear.Ryuo_hands_D,
		-- 7 STP 4% Haste Hasso +4
		hands="Wakido Kote +3",
		-- 10 STP
		back=gear.Smertrio_STP_DEX,
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		-- 8% Haste
		waist="Ioskeha Belt +1",
		-- 9 STP 5% Haste
		legs="Wakido Haidate +3",
		-- 5 STP
		--feet=gear.Valorous_feet_TP,
		--feet=gear.Rao_feet_hq_B,
		-- 3% Haste Hasso +2
		feet="Wakido Sune. +3",
	})

	-- JA Haste needed to cap: 40%, 25% cap (assuming Hasso)
	sets.engaged.Haste_15 = set_combine(sets.engaged,{
	})
	-- JA Haste needed to cap: 25%, 25% cap (assuming Hasso)
	sets.engaged.Haste_30 = set_combine(sets.engaged,{
	})
	-- JA Haste needed to cap: 20%, 25% cap (assuming Hasso)
	sets.engaged.Haste_35 = set_combine(sets.engaged,{
	})
	-- JA Haste needed to cap: 11.25%, 25% cap (assuming Hasso)
	sets.engaged.MaxHaste = set_combine(sets.engaged,{
	})
	sets.engaged.MaxHasteHasso = set_combine(sets.engaged.MaxHaste,{
		hands="Tatena. Gote +1",
		feet="Wakido Sune. +3",
	})

	-- JA Haste needed to cap: 40%, 25% cap (assuming Hasso)
	sets.engaged.MidAcc.Haste_15 = set_combine(sets.engaged.MidAcc,{
	})
	-- JA Haste needed to cap: 25%, 25% cap (assuming Hasso)
	sets.engaged.MidAcc.Haste_30 = set_combine(sets.engaged.MidAcc,{
	})
	-- JA Haste needed to cap: 20%, 25% cap (assuming Hasso)
	sets.engaged.MidAcc.Haste_35 = set_combine(sets.engaged.MidAcc,{
	})
	-- JA Haste needed to cap: 11.25%, 25% cap (assuming Hasso)
	sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.MidAcc,{
	})
	sets.engaged.MidAcc.MaxHasteHasso = set_combine(sets.engaged.MidAcc.MaxHaste,{
		hands="Tatena. Gote +1",
		feet="Wakido Sune. +3",
	})

	-- JA Haste needed to cap: 40%, 25% cap (assuming Hasso)
	sets.engaged.HighAcc.Haste_15 = set_combine(sets.engaged.HighAcc,{
	})
	-- JA Haste needed to cap: 25%, 25% cap (assuming Hasso)
	sets.engaged.HighAcc.Haste_30 = set_combine(sets.engaged.HighAcc,{
	})
	-- JA Haste needed to cap: 20%, 25% cap (assuming Hasso)
	sets.engaged.HighAcc.Haste_35 = set_combine(sets.engaged.HighAcc,{
	})
	-- JA Haste needed to cap: 11.25%, 25% cap (assuming Hasso)
	sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.HighAcc.MaxHasteHasso = set_combine(sets.engaged.HighAcc.MaxHaste,{
		hands="Tatena. Gote +1",
		feet="Wakido Sune. +3",
	})

	-- JA Haste needed to cap: 40%, 25% cap (assuming Hasso)
	sets.engaged.FullAcc.Haste_15 = set_combine(sets.engaged.FullAcc,{
	})
	-- JA Haste needed to cap: 25%, 25% cap (assuming Hasso)
	sets.engaged.FullAcc.Haste_30 = set_combine(sets.engaged.FullAcc,{
	})
	-- JA Haste needed to cap: 20%, 25% cap (assuming Hasso)
	sets.engaged.FullAcc.Haste_35 = set_combine(sets.engaged.FullAcc,{
	})
	-- JA Haste needed to cap: 11.25%, 25% cap (assuming Hasso)
	sets.engaged.FullAcc.MaxHaste = set_combine(sets.engaged.FullAcc,{
	})
	sets.engaged.FullAcc.MaxHasteHasso = set_combine(sets.engaged.FullAcc.MaxHaste,{
		hands="Tatena. Gote +1",
		feet="Wakido Sune. +3",
	})

	sets.engagedPDTBase =  {
		--sub="Utu Grip",
		-- 2% DT
		ammo="Staunch Tathlum +1",
		-- 7% PDT
		head="Mpaca's Cap",
		-- STP 7 + 7 aug
		neck="Sam. Nodowa +2",
		-- 8% DT
		body="Wakido Domaru +3",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back=gear.Smertrio_STP_DEX,
		waist="Ioskeha Belt +1",
		legs="Ken. Hakama +1",
		-- 6% PDT 12 MDB
		feet="Mpaca's Boots",
	}
	sets.engaged.PDT = set_combine(sets.engaged,sets.engagedPDTBase,{
	})
	sets.engaged.MidAcc.PDT = set_combine(sets.engaged.MidAcc,sets.engagedPDTBase,{
	})
	sets.engaged.HighAcc.PDT = set_combine(sets.engaged.HighAcc,sets.engagedPDTBase,{
	})
	sets.engaged.FullAcc.PDT = set_combine(sets.engaged.FullAcc,sets.engagedPDTBase,{
	})

	sets.engaged.PDT.Haste_15 = set_combine(sets.engaged,sets.engagedPDTBase,{
	})
	sets.engaged.MidAcc.PDT.Haste_15 = set_combine(sets.engaged.MidAcc,sets.engagedPDTBase,{
	})
	sets.engaged.HighAcc.PDT.Haste_15 = set_combine(sets.engaged.HighAcc,sets.engagedPDTBase,{
	})
	sets.engaged.FullAcc.PDT.Haste_15 = set_combine(sets.engaged.FullAcc,sets.engagedPDTBase,{
	})
	sets.engaged.PDT.Haste_30 = set_combine(sets.engaged,sets.engagedPDTBase,{
	})
	sets.engaged.MidAcc.PDT.Haste_30 = set_combine(sets.engaged.MidAcc,sets.engagedPDTBase,{
	})
	sets.engaged.HighAcc.PDT.Haste_30 = set_combine(sets.engaged.HighAcc,sets.engagedPDTBase,{
	})
	sets.engaged.FullAcc.PDT.Haste_30 = set_combine(sets.engaged.FullAcc,sets.engagedPDTBase,{
	})
	sets.engaged.PDT.Haste_35 = set_combine(sets.engaged,sets.engagedPDTBase,{
	})
	sets.engaged.MidAcc.PDT.Haste_35 = set_combine(sets.engaged.MidAcc,sets.engagedPDTBase,{
	})
	sets.engaged.HighAcc.PDT.Haste_35 = set_combine(sets.engaged.HighAcc,sets.engagedPDTBase,{
	})
	sets.engaged.FullAcc.PDT.Haste_35 = set_combine(sets.engaged.FullAcc,sets.engagedPDTBase,{
	})
	sets.engaged.PDT.MaxHaste = set_combine(sets.engaged,sets.engagedPDTBase,{
	})
	sets.engaged.MidAcc.PDT.MaxHaste = set_combine(sets.engaged.MidAcc,sets.engagedPDTBase,{
	})
	sets.engaged.HighAcc.PDT.MaxHaste = set_combine(sets.engaged.HighAcc,sets.engagedPDTBase,{
	})
	sets.engaged.FullAcc.PDT.MaxHaste = set_combine(sets.engaged.FullAcc,sets.engagedPDTBase,{
	})
	sets.engaged.PDT.MaxHasteHasso = set_combine(sets.engaged.PDT.MaxHaste,{
	})
	sets.engaged.MidAcc.PDT.MaxHasteHasso = set_combine(sets.engaged.MidAcc.PDT.MaxHaste,{
	})
	sets.engaged.HighAcc.PDT.MaxHasteHasso = set_combine(sets.engaged.HighAcc.PDT.MaxHaste,{
	})
	sets.engaged.FullAcc.PDT.MaxHasteHasso = set_combine(sets.engaged.FullAcc.PDT.MaxHaste,{
	})

	sets.engagedMDTBase = {
		--sub="Utu Grip",
		-- 2% DT
		ammo="Staunch Tathlum +1",
		-- 7% PDT
		head="Mpaca's Cap",
		-- STP 7 + 7 aug
		neck="Sam. Nodowa +2",
		body="Sacro Breastplate",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back=gear.Smertrio_STP_DEX,
		waist="Ioskeha Belt +1",
		legs="Ken. Hakama +1",
		-- 6% PDT 12 MDB
		feet="Mpaca's Boots",
	}
	sets.engaged.MDT = set_combine(sets.engaged,sets.engagedMDTBase,{
	})
	sets.engaged.MidAcc.MDT = set_combine(sets.engaged.MidAcc,sets.engagedMDTBase,{
	})
	sets.engaged.HighAcc.MDT = set_combine(sets.engaged.HighAcc,sets.engagedMDTBase,{
	})
	sets.engaged.FullAcc.MDT = set_combine(sets.engaged.FullAcc,sets.engagedMDTBase,{
	})

	sets.engaged.MDT.Haste_15 = set_combine(sets.engaged,sets.engagedMDTBase,{
	})
	sets.engaged.MidAcc.MDT.Haste_15 = set_combine(sets.engaged.MidAcc,sets.engagedMDTBase,{
	})
	sets.engaged.HighAcc.MDT.Haste_15 = set_combine(sets.engaged.HighAcc,sets.engagedMDTBase,{
	})
	sets.engaged.FullAcc.MDT.Haste_15 = set_combine(sets.engaged.FullAcc,sets.engagedMDTBase,{
	})
	sets.engaged.MDT.Haste_30 = set_combine(sets.engaged,sets.engagedMDTBase,{
	})
	sets.engaged.MidAcc.MDT.Haste_30 = set_combine(sets.engaged.MidAcc,sets.engagedMDTBase,{
	})
	sets.engaged.HighAcc.MDT.Haste_30 = set_combine(sets.engaged.HighAcc,sets.engagedMDTBase,{
	})
	sets.engaged.FullAcc.MDT.Haste_30 = set_combine(sets.engaged.FullAcc,sets.engagedMDTBase,{
	})
	sets.engaged.MDT.Haste_35 = set_combine(sets.engaged,sets.engagedMDTBase,{
	})
	sets.engaged.MidAcc.MDT.Haste_35 = set_combine(sets.engaged.MidAcc,sets.engagedMDTBase,{
	})
	sets.engaged.HighAcc.MDT.Haste_35 = set_combine(sets.engaged.HighAcc,sets.engagedMDTBase,{
	})
	sets.engaged.FullAcc.MDT.Haste_35 = set_combine(sets.engaged.FullAcc,sets.engagedMDTBase,{
	})
	sets.engaged.MDT.MaxHaste = set_combine(sets.engaged,sets.engagedMDTBase,{
	})
	sets.engaged.MidAcc.MDT.MaxHaste = set_combine(sets.engaged.MidAcc,sets.engagedMDTBase,{
	})
	sets.engaged.HighAcc.MDT.MaxHaste = set_combine(sets.engaged.HighAcc,sets.engagedMDTBase,{
	})
	sets.engaged.FullAcc.MDT.MaxHaste = set_combine(sets.engaged.FullAcc,sets.engagedMDTBase,{
	})
	sets.engaged.MDT.MaxHasteHasso = set_combine(sets.engaged.MDT.MaxHaste,{
	})
	sets.engaged.MidAcc.MDT.MaxHasteHasso = set_combine(sets.engaged.MidAcc.MDT.MaxHaste,{
	})
	sets.engaged.HighAcc.MDT.MaxHasteHasso = set_combine(sets.engaged.HighAcc.MDT.MaxHaste,{
	})
	sets.engaged.FullAcc.MDT.MaxHasteHasso = set_combine(sets.engaged.FullAcc.MDT.MaxHaste,{
	})

	sets.engaged.Reraise = set_combine(sets.engaged, sets.Twilight, {
	})
	sets.engaged.MidAcc.Reraise = set_combine(sets.engaged.MidAcc, sets.Twilight, {
	})
	sets.engaged.HighAcc.Reraise = set_combine(sets.engaged.HighAcc, sets.Twilight, {
	})
	sets.engaged.FullAcc.Reraise = set_combine(sets.engaged.FullAcc, sets.Twilight, {
	})

	sets.engaged.Reraise.Haste_15 = set_combine(sets.engaged.Haste_15,sets.Twilight,{
	})
	sets.engaged.MidAcc.Reraise.Haste_15 = set_combine(sets.engaged.MidAcc.Haste_15,sets.Twilight,{
	})
	sets.engaged.HighAcc.Reraise.Haste_15 = set_combine(sets.engaged.HighAcc.Haste_15,sets.Twilight,{
	})
	sets.engaged.FullAcc.Reraise.Haste_15 = set_combine(sets.engaged.FullAcc.Haste_15,sets.Twilight,{
	})
	sets.engaged.Reraise.Haste_30 = set_combine(sets.engaged.Haste_30,sets.Twilight,{
	})
	sets.engaged.MidAcc.Reraise.Haste_30 = set_combine(sets.engaged.MidAcc.Haste_30,sets.Twilight,{
	})
	sets.engaged.HighAcc.Reraise.Haste_30 = set_combine(sets.engaged.HighAcc.Haste_30,sets.Twilight,{
	})
	sets.engaged.FullAcc.Reraise.Haste_30 = set_combine(sets.engaged.FullAcc.Haste_30,sets.Twilight,{
	})
	sets.engaged.Reraise.Haste_35 = set_combine(sets.engaged.Haste_35,sets.Twilight,{
	})
	sets.engaged.MidAcc.Reraise.Haste_35 = set_combine(sets.engaged.MidAcc.Haste_35,sets.Twilight,{
	})
	sets.engaged.HighAcc.Reraise.Haste_35 = set_combine(sets.engaged.HighAcc.Haste_35,sets.Twilight,{
	})
	sets.engaged.FullAcc.Reraise.Haste_35 = set_combine(sets.engaged.FullAcc.Haste_35,sets.Twilight,{
	})
	sets.engaged.Reraise.MaxHaste = set_combine(sets.engaged,sets.Twilight,{
	})
	sets.engaged.MidAcc.Reraise.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste,sets.Twilight,{
	})
	sets.engaged.HighAcc.Reraise.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste,sets.engagedReraiseBase,{
	})
	sets.engaged.FullAcc.Reraise.MaxHaste = set_combine(sets.engaged.FullAcc.MaxHaste,sets.engagedReraiseBase,{
	})
	sets.engaged.Reraise.MaxHasteHasso = set_combine(sets.engaged.Reraise.MaxHaste,{
	})
	sets.engaged.MidAcc.Reraise.MaxHasteHasso = set_combine(sets.engaged.MidAcc.Reraise.MaxHaste,{
	})
	sets.engaged.HighAcc.Reraise.MaxHasteHasso = set_combine(sets.engaged.HighAcc.Reraise.MaxHaste,{
	})
	sets.engaged.FullAcc.Reraise.MaxHasteHasso = set_combine(sets.engaged.FullAcc.Reraise.MaxHaste,{
	})
	    
	-- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
	-- Delay 450 GK, 25 Save TP (Tsurumaru) + 10 Save TP (Ionis) => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
	-- Delay 450 GK => 5-hit (34 Store TP in gear/SAM Roll), 4-hit (78 Store TP in gear/SAM Roll)
	-- SAM Roll: Lucky (2) 32 STP, Eleven 40 STP, Unlucky (6) 4 STP
	sets.engaged.Adoulin = set_combine(sets.engaged,{
	})
	sets.engaged.Adoulin.MidAcc = set_combine(sets.engaged.MidAcc,{
	})
	sets.engaged.Adoulin.HighAcc = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.Adoulin.FullAcc = set_combine(sets.engaged.FullAcc,{
	})
	sets.engaged.Adoulin.Haste_15 = set_combine(sets.engaged.Adoulin,{
	})
	sets.engaged.Adoulin.MidAcc.Haste_15 = set_combine(sets.engaged.MidAcc.Adoulin,{
	})
	sets.engaged.Adoulin.HighAcc.Haste_15 = set_combine(sets.engaged.HighAcc.Adoulin,{
	})
	sets.engaged.Adoulin.FullAcc.Haste_15 = set_combine(sets.engaged.FullAcc.Adoulin,{
	})
	sets.engaged.Adoulin.Haste_30 = set_combine(sets.engaged.Adoulin,{
	})
	sets.engaged.Adoulin.MidAcc.Haste_30 = set_combine(sets.engaged.Adoulin.MidAcc,{
	})
	sets.engaged.Adoulin.HighAcc.Haste_30 = set_combine(sets.engaged.Adoulin.HighAcc,{
	})
	sets.engaged.Adoulin.FullAcc.Haste_30 = set_combine(sets.engaged.Adoulin.FullAcc,{
	})
	sets.engaged.Adoulin.Haste_35 = set_combine(sets.engaged.Adoulin,{
	})
	sets.engaged.Adoulin.MidAcc.Haste_35 = set_combine(sets.engaged.Adoulin.MidAcc,{
	})
	sets.engaged.Adoulin.HighAcc.Haste_35 = set_combine(sets.engaged.Adoulin.HighAcc,{
	})
	sets.engaged.Adoulin.FullAcc.Haste_35 = set_combine(sets.engaged.Adoulin.FullAcc,{
	})
	sets.engaged.Adoulin.MaxHaste = set_combine(sets.engaged.Adoulin,{
	})
	sets.engaged.Adoulin.MidAcc.MaxHaste = set_combine(sets.engaged.Adoulin.MidAcc,{
	})
	sets.engaged.Adoulin.HighAcc.MaxHaste = set_combine(sets.engaged.Adoulin.HighAcc,{
	})
	sets.engaged.Adoulin.FullAcc.MaxHaste = set_combine(sets.engaged.Adoulin.FullAcc,{
	})
	sets.engaged.Adoulin.MaxHasteHasso = set_combine(sets.engaged.Adoulin.MaxHaste,{
	})
	sets.engaged.Adoulin.MidAcc.MaxHasteHasso = set_combine(sets.engaged.Adoulin.MidAcc.MaxHaste,{
	})
	sets.engaged.Adoulin.HighAcc.MaxHasteHasso = set_combine(sets.engaged.Adoulin.HighAcc.MaxHaste,{
	})
	sets.engaged.Adoulin.FullAcc.MaxHasteHasso = set_combine(sets.engaged.Adoulin.FullAcc.MaxHaste,{
	})

	sets.engaged.Adoulin.PDT = set_combine(sets.engaged.PDT,{
	})
	sets.engaged.Adoulin.MidAcc.PDT = set_combine(sets.engaged.MidAcc.PDT,{
	})
	sets.engaged.Adoulin.HighAcc.PDT = set_combine(sets.engaged.HighAcc.PDT,{
	})
	sets.engaged.Adoulin.FullAcc.PDT = set_combine(sets.engaged.FullAcc.PDT,{
	})
	sets.engaged.Adoulin.Haste_15 = set_combine(sets.engaged.Adoulin.PDT,{
	})
	sets.engaged.Adoulin.MidAcc.PDT.Haste_15 = set_combine(sets.engaged.Adoulin.MidAcc.PDT,{
	})
	sets.engaged.Adoulin.HighAcc.PDT.Haste_15 = set_combine(sets.engaged.Adoulin.HighAcc.PDT,{
	})
	sets.engaged.Adoulin.FullAcc.PDT.Haste_15 = set_combine(sets.engaged.Adoulin.FullAcc.PDT,{
	})
	sets.engaged.Adoulin.PDT.Haste_30 = set_combine(sets.engaged.Adoulin.PDT,{
	})
	sets.engaged.Adoulin.MidAcc.PDT.Haste_30 = set_combine(sets.engaged.Adoulin.MidAcc.PDT,{
	})
	sets.engaged.Adoulin.HighAcc.PDT.Haste_30 = set_combine(sets.engaged.Adoulin.HighAcc.PDT,{
	})
	sets.engaged.Adoulin.FullAcc.PDT.Haste_30 = set_combine(sets.engaged.Adoulin.FullAcc.PDT,{
	})
	sets.engaged.Adoulin.PDT.Haste_35 = set_combine(sets.engaged.PDT,{
	})
	sets.engaged.Adoulin.MidAcc.PDT.Haste_35 = set_combine(sets.engaged.Adoulin.MidAcc.PDT,{
	})
	sets.engaged.Adoulin.HighAcc.PDT.Haste_35 = set_combine(sets.engaged.Adoulin.HighAcc.PDT,{
	})
	sets.engaged.Adoulin.FullAcc.PDT.Haste_35 = set_combine(sets.engaged.Adoulin.FullAcc.PDT,{
	})
	sets.engaged.Adoulin.PDT.MaxHaste = set_combine(sets.engaged.Adoulin.PDT,{
	})
	sets.engaged.Adoulin.MidAcc.PDT.MaxHaste = set_combine(sets.engaged.Adoulin.MidAcc.PDT,{
	})
	sets.engaged.Adoulin.HighAcc.PDT.MaxHaste = set_combine(sets.engaged.Adoulin.HighAcc.PDT,{
	})
	sets.engaged.Adoulin.FullAcc.PDT.MaxHaste = set_combine(sets.engaged.Adoulin.FullAcc.PDT,{
	})
	sets.engaged.Adoulin.PDT.MaxHasteHasso = set_combine(sets.engaged.Adoulin.PDT.MaxHaste,{
	})
	sets.engaged.Adoulin.MidAcc.PDT.MaxHasteHasso = set_combine(sets.engaged.Adoulin.MidAcc.PDT.MaxHaste,{
	})
	sets.engaged.Adoulin.HighAcc.PDT.MaxHasteHasso = set_combine(sets.engaged.Adoulin.HighAcc.PDT.MaxHaste,{
	})
	sets.engaged.Adoulin.FullAcc.PDT.MaxHasteHasso = set_combine(sets.engaged.Adoulin.FullAcc.PDT.MaxHaste,{
	})

	sets.engaged.Adoulin.MDT = set_combine(sets.engaged.MDT,{
	})
	sets.engaged.Adoulin.MidAcc.MDT = set_combine(sets.engaged.MidAcc.MDT,{
	})
	sets.engaged.Adoulin.HighAcc.MDT = set_combine(sets.engaged.HighAcc.MDT,{
	})
	sets.engaged.Adoulin.FullAcc.MDT = set_combine(sets.engaged.FullAcc.MDT,{
	})
	sets.engaged.Adoulin.Haste_15 = set_combine(sets.engaged.Adoulin.MDT,{
	})
	sets.engaged.Adoulin.MidAcc.MDT.Haste_15 = set_combine(sets.engaged.Adoulin.MidAcc.MDT,{
	})
	sets.engaged.Adoulin.HighAcc.MDT.Haste_15 = set_combine(sets.engaged.Adoulin.HighAcc.MDT,{
	})
	sets.engaged.Adoulin.FullAcc.MDT.Haste_15 = set_combine(sets.engaged.Adoulin.FullAcc.MDT,{
	})
	sets.engaged.Adoulin.MDT.Haste_30 = set_combine(sets.engaged.Adoulin.MDT,{
	})
	sets.engaged.Adoulin.MidAcc.MDT.Haste_30 = set_combine(sets.engaged.Adoulin.MidAcc.MDT,{
	})
	sets.engaged.Adoulin.HighAcc.MDT.Haste_30 = set_combine(sets.engaged.Adoulin.HighAcc.MDT,{
	})
	sets.engaged.Adoulin.FullAcc.MDT.Haste_30 = set_combine(sets.engaged.Adoulin.FullAcc.MDT,{
	})
	sets.engaged.Adoulin.MDT.Haste_35 = set_combine(sets.engaged.MDT,{
	})
	sets.engaged.Adoulin.MidAcc.MDT.Haste_35 = set_combine(sets.engaged.Adoulin.MidAcc.MDT,{
	})
	sets.engaged.Adoulin.HighAcc.MDT.Haste_35 = set_combine(sets.engaged.Adoulin.HighAcc.MDT,{
	})
	sets.engaged.Adoulin.FullAcc.MDT.Haste_35 = set_combine(sets.engaged.Adoulin.FullAcc.MDT,{
	})
	sets.engaged.Adoulin.MDT.MaxHaste = set_combine(sets.engaged.Adoulin.MDT,{
	})
	sets.engaged.Adoulin.MidAcc.MDT.MaxHaste = set_combine(sets.engaged.Adoulin.MidAcc.MDT,{
	})
	sets.engaged.Adoulin.HighAcc.MDT.MaxHaste = set_combine(sets.engaged.Adoulin.HighAcc.MDT,{
	})
	sets.engaged.Adoulin.FullAcc.MDT.MaxHaste = set_combine(sets.engaged.Adoulin.FullAcc.MDT,{
	})
	sets.engaged.Adoulin.MDT.MaxHasteHasso = set_combine(sets.engaged.Adoulin.MDT.MaxHaste,{
	})
	sets.engaged.Adoulin.MidAcc.MDT.MaxHasteHasso = set_combine(sets.engaged.Adoulin.MidAcc.MDT.MaxHaste,{
	})
	sets.engaged.Adoulin.HighAcc.MDT.MaxHasteHasso = set_combine(sets.engaged.Adoulin.HighAcc.MDT.MaxHaste,{
	})
	sets.engaged.Adoulin.FullAcc.MDT.MaxHasteHasso = set_combine(sets.engaged.Adoulin.FullAcc.MDT.MaxHaste,{
	})

	sets.engaged.Adoulin.Reraise = set_combine(sets.engaged.Reraise,{
	})
	sets.engaged.Adoulin.MidAcc.Reraise = set_combine(sets.engaged.MidAcc.Reraise,{
	})
	sets.engaged.Adoulin.HighAcc.Reraise = set_combine(sets.engaged.HighAcc.Reraise,{
	})
	sets.engaged.Adoulin.FullAcc.Reraise = set_combine(sets.engaged.FullAcc.Reraise,{
	})
	sets.engaged.Adoulin.Haste_15 = set_combine(sets.engaged.Adoulin.Reraise,{
	})
	sets.engaged.Adoulin.MidAcc.Reraise.Haste_15 = set_combine(sets.engaged.Adoulin.MidAcc.Reraise,{
	})
	sets.engaged.Adoulin.HighAcc.Reraise.Haste_15 = set_combine(sets.engaged.Adoulin.HighAcc.Reraise,{
	})
	sets.engaged.Adoulin.FullAcc.Reraise.Haste_15 = set_combine(sets.engaged.Adoulin.FullAcc.Reraise,{
	})
	sets.engaged.Adoulin.Reraise.Haste_30 = set_combine(sets.engaged.Adoulin.Reraise,{
	})
	sets.engaged.Adoulin.MidAcc.Reraise.Haste_30 = set_combine(sets.engaged.Adoulin.MidAcc.Reraise,{
	})
	sets.engaged.Adoulin.HighAcc.Reraise.Haste_30 = set_combine(sets.engaged.Adoulin.HighAcc.Reraise,{
	})
	sets.engaged.Adoulin.FullAcc.Reraise.Haste_30 = set_combine(sets.engaged.Adoulin.FullAcc.Reraise,{
	})
	sets.engaged.Adoulin.Reraise.Haste_35 = set_combine(sets.engaged.Reraise,{
	})
	sets.engaged.Adoulin.MidAcc.Reraise.Haste_35 = set_combine(sets.engaged.Adoulin.MidAcc.Reraise,{
	})
	sets.engaged.Adoulin.HighAcc.Reraise.Haste_35 = set_combine(sets.engaged.Adoulin.HighAcc.Reraise,{
	})
	sets.engaged.Adoulin.FullAcc.Reraise.Haste_35 = set_combine(sets.engaged.Adoulin.FullAcc.Reraise,{
	})
	sets.engaged.Adoulin.Reraise.MaxHaste = set_combine(sets.engaged.Adoulin.Reraise,{
	})
	sets.engaged.Adoulin.MidAcc.Reraise.MaxHaste = set_combine(sets.engaged.Adoulin.MidAcc.Reraise,{
	})
	sets.engaged.Adoulin.HighAcc.Reraise.MaxHaste = set_combine(sets.engaged.Adoulin.HighAcc.Reraise,{
	})
	sets.engaged.Adoulin.FullAcc.Reraise.MaxHaste = set_combine(sets.engaged.Adoulin.FullAcc.Reraise,{
	})
	sets.engaged.Adoulin.Reraise.MaxHasteHasso = set_combine(sets.engaged.Adoulin.Reraise.MaxHaste,{
	})
	sets.engaged.Adoulin.MidAcc.Reraise.MaxHasteHasso = set_combine(sets.engaged.Adoulin.MidAcc.Reraise.MaxHaste,{
	})
	sets.engaged.Adoulin.HighAcc.Reraise.MaxHasteHasso = set_combine(sets.engaged.Adoulin.HighAcc.Reraise.MaxHaste,{
	})
	sets.engaged.Adoulin.FullAcc.Reraise.MaxHasteHasso = set_combine(sets.engaged.Adoulin.FullAcc.Reraise.MaxHaste,{
	})
	
	sets.buff.Sekkanoki = {hands="Kasuga Kote +1"}
	sets.buff.Sengikori = {hands="Kas. Sune-Ate +1"}
	sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate"} -- only works when equipped
	sets.slept = {neck="Vim Torque +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' then
		if (spell.target.model_size + spell.range * 1.642276421172564) < spell.target.distance then	
			add_to_chat(7,"--- Target "..spell.target.type.." ["..player.target.name.."] out of range of ["..spell.name.."] [ Distance: "..spell.target.distance.."] ---")
			cancel_spell()
		end

		if state.TreasureMode.value ~= false then
			equip(sets.sharedTH)
		end

		-- Don't gearswap for weaponskills when Defense is active and Hybrid Mode set to a specific state
		if state.DefenseMode.value ~= 'None' and state.HybridMode ~= 'Normal' then
			eventArgs.handled = true
		end
	end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if state.Buff.Sekkanoki then
			equip(sets.buff.Sekkanoki)
		end
		if state.Buff.Sengikori then
			equip(sets.buff.Sengikori)
		end
		if state.Buff['Meikyo Shisui'] then
			equip(sets.buff['Meikyo Shisui'])
		end

		if state.DefenseMode.value ~= 'None' and state.HybridMode ~= 'Normal' then
			-- Replace Moonshade Earring if we're at cap TP
			if player.tp >= 2750 then
				equip(sets.precast.WS.MaxTP)
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
	if areas.Adoulin:contains(world.area) and buffactive.ionis then
		state.CombatForm:set('Adoulin')
	else
		state.CombatForm:reset()
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 17)
	elseif player.sub_job == 'DNC' then
		set_macro_page(2, 17)
	elseif player.sub_job == 'THF' then
		set_macro_page(3, 17)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 17)
	elseif player.sub_job == 'RUN' then
		set_macro_page(5, 17)
	else
		set_macro_page(1, 17)
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
			if buffactive['Hasso'] then
				add_to_chat(8, '-------------Max-Haste Hasso Mode Enabled--------------')
				classes.CustomMeleeGroups:append('MaxHasteHasso')
			else
				add_to_chat(8, '-------------Max-Haste Mode Enabled--------------')
				classes.CustomMeleeGroups:append('MaxHaste')
			end
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
			if buffactive['Hasso'] then
				add_to_chat(8, '-------------Max-Haste Hasso Mode Enabled--------------')
				classes.CustomMeleeGroups:append('MaxHasteHasso')
			else
				add_to_chat(8, '-------------Max Haste Mode Enabled--------------')
				classes.CustomMeleeGroups:append('MaxHaste')
			end
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
	if state.EnmityMode.value == 'Down' then
		meleeSet = set_combine(meleeSet, sets.EnmityDown)
	elseif state.EnmityMode.value == 'Up' then
		meleeSet = set_combine(meleeSet, sets.EnmityUp)
	end
	if state.MeleeDTMode.value == 'PDT' then
		meleeSet = set_combine(meleeSet, sets.engagedPDTBase)
	elseif state.MeleeDTMode.value == 'MDT' then
		meleeSet = set_combine(meleeSet, sets.engagedMDTBase)
	end
	if state.TreasureMode.value ~= false then
		meleeSet = set_combine(meleeSet, sets.sharedTH)
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

function job_buff_change(buff, gain)
	if buff == "Aftermath: Lv.3" or buff == "Aftermath: Lv.2" or buff == "Aftermath" then
		--classes.CustomMeleeGroups:clear()
		if (buff == "Aftermath: Lv.3" and gain) or buffactive["Aftermath: Lv.3"] then
			if player.equipment.main == "Masamune" then
				--classes.CustomMeleeGroups:append('AM3')
				if gain then
					send_command('timers create "Aftermath: Lv.3" 180 down;wait 120;input /echo Aftermath: Lv.3 [WEARING OFF IN 60 SEC.];wait 30;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
				else
					send_command('timers delete "Aftermath: Lv.3"')
					add_to_chat(123,'AM3: [OFF]')
				end
			end
		end
		if (buff == "Aftermath: Lv.2" and gain) or buffactive["Aftermath: Lv.2"] then
			if player.equipment.main == "Masamune" then
				if gain then
					send_command('timers create "Aftermath: Lv.2" 120 down;wait 60;input /echo Aftermath: Lv.3 [WEARING OFF IN 60 SEC.];wait 30;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
				else
					send_command('timers delete "Aftermath: Lv.2"')
					add_to_chat(123,'AM2: [OFF]')
				end
			end
		end
		if (buff == "Aftermath" and gain) or buffactive.Aftermath then
			if player.equipment.main == "Masamune" then
				if gain then
					send_command('timers create "Aftermath: Lv.1" 60 down;wait 30;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
				else
					send_command('timers delete "Aftermath: Lv.1"')
					add_to_chat(123,'AM1: [OFF]')
				end
			end
		end
	end
	if buff == 'Warcry' and gain then
		send_command('timers create "Warcry" 60 down abilities/00255.png')
		else
		send_command('timers delete "Warcry"')
	end
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste', 'hasso'}:contains(buff:lower()) then
		determine_haste_group()
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end
	if buff == "sleep" and gain and player.hp > 200 and player.status == "Engaged" then
		equip(sets.slept)
		else
		handle_equipping_gear(player.status)
	end
end