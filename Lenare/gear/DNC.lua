-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false

	state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}
	state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
	state.AltStep = M{['description']='Alt Step', 'Quickstep', 'Feather Step', 'Stutter Step', 'Box Step'}
	state.UseAltStep = M(false, 'Use Alt Step')
	state.SelectStepTarget = M(false, 'Select Step Target')
	state.IgnoreTargetting = M(false, 'Ignore Targetting')

	state.CurrentStep = M{['description']='Current Step', 'Main', 'Alt'}
	state.SkillchainPending = M(false, 'Skillchain Pending')

	state.CP = M(false, "Capacity Points Mode")
	state.Warp = M(false, "Warp Mode")
	state.Weapon = M(false, "Weapon Lock")
	state.Neck = M(false, "Neck Mode")
	state.EngagedDT = M(false, 'Engaged Damage Taken Mode')

	determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.IdleMode:options('CP', 'Normal', 'StoreTP', 'Regen')
	state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.HybridMode:options('Normal', 'Evasion', 'PDT')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.PhysicalDefenseMode:options('Evasion', 'PDT')

	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Windbuffet Belt +1"

	gear.AugMantleRev = {
		name="Toetapper Mantle",
		augments={
			'"Store TP"+2',
			'"Rev. Flourish"+26',
			'Weapon skill damage +1%'
		}
	}
	gear.Senuna_DexDa = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}

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
	send_command('bind @` gs c cycle HasteMode') --WindowKey'A'
	send_command("bind @p gs equip sets.TaeonPhalanx; input /echo --- Phalanx set on ---") -- WindowKey'P'
	send_command('bind ^= gs c cycle mainstep') -- CTRL '='
	send_command('bind != gs c cycle altstep') -- ALT '='
	send_command('bind ^- gs c toggle selectsteptarget') -- CTRL '-'
	send_command('bind !- gs c toggle usealtstep') -- ALT '-'
	send_command('bind ^` input /ja "Chocobo Jig" <me>') -- CTRL '`'
	send_command('bind !` input /ja "Chocobo Jig II" <me>') -- ALT '`'

	send_command('bind @c gs c toggle CP') --WindowKey'C'
	send_command('bind @e gs c toggle EngagedDT') --Windowkey'E'
	send_command('bind @h gs c cycle TreasureMode') --Windowkey'H'
	send_command('bind @n gs c toggle Neck') --Windowkey'N'
	send_command('bind @r gs c toggle Warp') --Windowkey'R'
	send_command('bind @w gs c toggle Weapon') --Windowkey'W'

	select_default_macro_book()

	global_aliases()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind @`')
	send_command('unbind @b')
	send_command('unbind @p')
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind ^=')
	send_command('unbind !=')
	send_command('unbind ^-')
	send_command('unbind !-')

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
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs

	sets.precast.JA['No Foot Rise'] = {body="Horos Casaque +3"}

	sets.precast.JA['Trance'] = {head="Horos Tiara +3"}


	-- Waltz set (chr and vit)

	-- 54% (50% cap)
	sets.precast.Waltz = {
		-- 15%
		head="Horos Tiara +3",
		-- 5%
		--ear1="Roundel Earring",
		-- 10%
		ear2="Sjofn Earring",
		-- 17%
		body="Maxixi Casaque +2",
		hands="Meg. Gloves +2",
		ring1="Dark Ring",
		ring2="Sirona's Ring",
		-- 5%
		--back=gear.AugMantleRev,
		waist="Chaac Belt",
		legs="Horos Tights +3",
		-- 12%
		feet="Maxixi Toe Shoes +2"
	}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Samba = {
		head="Maxixi Tiara +2"
	}

	sets.precast.Jig = {
		legs="Horos Tights +3",
		feet="Maxixi Toe Shoes +2",
	}

	sets.precast.Acc = {
		--ammo="Jukukik Feather",
		head="Malignance Chapeau",
		--head="Maxixi Tiara +3",
		ear1="Telos Earring",
		ear2="Zennaroi Earring",
		neck="Sanctity Necklace",
		body="Meg. Cuirie +2",
		--hands="Malignance Gloves",
		hands="Maxixi Bangles +3",
		ring1="Cacoethic Ring",
		ring2="Chirich Ring",
		back=gear.Senuna_DexDa,
		waist="Eschan Stone",
		legs="Horos Tights +3",
		feet="Malignance Boots",
		--feet="Maxixi Toe Shoes +3",
	}
	sets.precast.Macc = {
		head="Malignance Chapeau",
		neck="Sanctity Necklace",
		ear1="Hermetic Earring",
		body="Mummu Jacket +2",
		hands="Malignance Gloves",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		waist="Eschan Stone",
		legs="Horos Tights +3",
		feet="Malignance Boots",
	}

	sets.precast.Step = set_combine(sets.precast.Acc,{
		head="Maxixi Tiara +2",
		hands="Maxixi Bangles +3",
		feet="Horos T. Shoes +3",
	})
	sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step,{
		feet="Macu. Toe Shoes +1"
	})

	sets.precast.Flourish1 = {}
	sets.precast.Flourish1['Violent Flourish'] = set_combine(sets.precast.Macc,{
		body="Horos Casaque +3"
	})
	sets.precast.Flourish1['Desperate Flourish'] = set_combine(sets.precast.Acc,{
	})

	sets.precast.Flourish2 = {}
	sets.precast.Flourish2['Reverse Flourish'] = {
		hands="Macu. Bangles +1",
		back=gear.AugMantleRev
	}

	sets.precast.Flourish3 = {}
	sets.precast.Flourish3['Striking Flourish'] = {body="Macu. Casaque +1"}
	sets.precast.Flourish3['Climactic Flourish'] = {head="Maculele Tiara +1"}

	-- Fast cast sets for spells

	sets.precast.FC = {
		--ammo="Impatiens",
		neck="Baetyl Pendant",
		ear1="Loquac. Earring",
		ear2="Etiolation Earring",
		body="Dread Jupon",
		hands="Leyline Gloves",
		ring1="Prolix Ring",
		ring2="Weather. Ring",
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	 
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Charis Feather",
		head=gear.Adhemar_head_B,
		neck="Asperity Necklace",
		--neck=gear.ElementalGorget,
		ear1="Moonshade Earring",
		ear2="Sherida Earring",
		body="Mummu Jacket +2",
		hands="Mummu Wrists +2",
		ring1="Rajas Ring",
		ring2="Apate Ring",
		back=gear.Senuna_DexDa,
		waist="Windbuffet Belt +1",
		legs="Horos Tights +3",
		feet="Mummu Gamash. +2",
	}
	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
		--ammo="Honed Tathlum",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
	})
	sets.precast.WS.HighAcc = set_combine(sets.precast.WS.MidAcc, {
		head="Mummu Bonnet +2",
		ring1="Cacoethic Ring",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS.HighAcc, {
		neck="Sanctity Necklace",
		waist="Eschan Stone",
	})
	sets.precast.WS.MAB = set_combine(sets.precast.WS, {
		head=gear.Herculean_head_mab,
		neck="Baetyl Pendant",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		--body="Samnuha Coat",
		body=gear.Herculean_body_mab,
		hands="Leyline Gloves",
		ring1="Acumen Ring",
		ring2="Arvina Ringlet +1",
		back="Toro Cape",
		waist="Eschan Stone",
		legs="Horos Tights +3",
		feet="Meg. Jam. +2",
	})

	-- 73~85% AGI
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		head=gear.Adhemar_head_B,
		ear1="Sherida Earring",
		ear2="Brutal Earring",
		body="Horos Casaque +3",
		hands="Maxixi Bangles +3",
		ring1="Garuda Ring +1",
		ring2="Garuda Ring +1",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS['Exenterator'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS['Exenterator'], {
	})
	sets.precast.WS['Exenterator'].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS['Exenterator'], {
	})
	sets.precast.WS['Exenterator'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Exenterator'], {
	})

	-- 40% DEX / 40% STR
	sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
		body="Horos Casaque +3",
		legs="Samnuha Tights",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS['Pyrrhic Kleos'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS['Pyrrhic Kleos'], {
	})
	sets.precast.WS['Pyrrhic Kleos'].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS['Pyrrhic Kleos'], {
	})
	sets.precast.WS['Pyrrhic Kleos'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Pyrrhic Kleos'], {
	})

	-- 	40% CHR / 40% DEX
	sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {
		legs="Samnuha Tights",
	})
	sets.precast.WS['Dancing Edge'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS['Dancing Edge'], {
	})
	sets.precast.WS['Dancing Edge'].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS['Dancing Edge'], {
	})
	sets.precast.WS['Dancing Edge'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Dancing Edge'], {
	})

	-- 50% DEX
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		ear1="Odr Earring",
		hands="Mummu Wrists +2",
		legs="Samnuha Tights",
	})
	sets.precast.WS['Evisceration'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS['Evisceration'], {
	})
	sets.precast.WS['Evisceration'].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS['Evisceration'], {
	})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Evisceration'], {
	})

	-- 80% DEX
	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		ear1="Odr Earring",
		head="Mummu Bonnet +2",
		hands="Maxixi Bangles +3",
		legs="Horos Tights +3",
	})
	sets.precast.WS["Rudra's Storm"].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS["Rudra's Storm"], {
	})
	sets.precast.WS["Rudra's Storm"].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS["Rudra's Storm"], {
	})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS["Rudra's Storm"], {
	})

	-- 40% DEX 40% AGI
	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
		hands="Maxixi Bangles +3"
	})
	sets.precast.WS['Shark Bite'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS["Shark Bite"], {
	})
	sets.precast.WS['Shark Bite'].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS["Shark Bite"], {
	})
	sets.precast.WS['Shark Bite'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS["Shark Bite"], {
	})

	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB,{
		hands="Maxixi Bangles +3",
		legs="Horos Tights +3",
	})

	sets.precast.Skillchain = {hands="Macu. Bangles +1"}

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		head="Malignance Chapeau",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1=gear.DarkRing.physical,
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Mummu Kecks +2",
		feet="Malignance Boots",
	});

	--------------------------------------
	-- Idle/resting/defense sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {
	}
	sets.ExtraRegen = {
	}

	sets.idle = {
		head="Malignance Chapeau",
		--ammo="Charis Feather",
		ammo="Crepuscular Pebble",
		neck="Loricate Torque +1",
		ear1="Novia Earring",
		ear2="Etiolation Earring",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		--back="Moonbeam Cape",
		back="Mecisto. Mantle",
		waist="Gishdubar Sash",
		legs="Mummu Kecks +2",
		feet="Skd. Jambeaux +1"
	}

	sets.noprotect = {ring1="Sheltered Ring"}

	sets.idle.Town = set_combine(sets.idle,{
	})

	sets.idle.Weak = set_combine(sets.idle,{
	})

	sets.idle.Regen = set_combine(sets.idle,{
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		neck="Bathy Choker +1",
		hands="Meg. Gloves +2",
		ring1="Sheltered Ring",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
	})

	-- Defense sets

	sets.defense.Evasion = set_combine(sets.idle,{
	back=gear.AugMantleRev,
	feet="Meg. Jam. +2"
	})

	sets.defense.PDT = set_combine(sets.idle,{
		ammo="Crepuscular Pebble",
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Mummu Kecks +2",
		feet="Malignance Boots",
	})

	sets.defense.MDT = set_combine(sets.idle,{
		ammo="Crepuscular Pebble",
		head="Malignance Chapeau",
		ear2="Etiolation Earring",
		neck="Loricate Torque +1",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Shadow Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Mummu Kecks +2",
		feet="Malignance Boots",
	})

	sets.Kiting = {feet="Skd. Jambeaux +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged = {
		ammo="Charis Feather",
		head="Maxixi Tiara +2",
		neck="Asperity Necklace",
		ear1="Suppanomimi",
		ear2="Sherida Earring",
		body="Macu. Casaque +1",
		hands="Mummu Wrists +2",
		ring1="Rajas Ring",
		ring2="Chirich Ring",
		back=gear.Senuna_DexDa,
		waist="Patentia Sash",
		legs="Meg. Chausses +2",
		feet="Horos T. Shoes +3",
	}
	sets.engaged.MidAcc = set_combine(sets.engaged,{
		ammo="Honed Tathlum",
		head="Horos Tiara +3",
		neck="Defiant Collar",
		body="Mummu Jacket +2",
		hands="Malignance Gloves",
		ring1="Cacoethic Ring",
	})
	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc,{
		head="Horos Tiara +3",
		ear2="Zennaroi Earring",
		hands="Malignance Gloves",
		waist="Eschan Stone",
	})
	sets.engaged.FullAcc = set_combine(sets.engaged.HighAcc,{
	})

	sets.engaged.Evasion = set_combine(sets.engaged,{
	})
	sets.engaged.MidAcc.Evasion = set_combine(sets.engaged.MidAcc,{
	})
	sets.engaged.HighAcc.Evasion = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.FullAcc.Evasion = set_combine(sets.engaged.FullAcc,{
	})

	sets.engaged.PDT = set_combine(sets.engaged.Evasion,{
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Mummu Kecks +2",
		feet="Malignance Boots",
	})
	sets.engaged.MidAcc.PDT = set_combine(sets.engaged.PDT,{
	})
	sets.engaged.HighAcc.PDT = set_combine(sets.engaged.PDT,{
	})
	sets.engaged.FullAcc.PDT = set_combine(sets.engaged.PDT,{
	})

	sets.engaged.MDT = set_combine(sets.engaged.Evasion,{
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear2="Etiolation Earring",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Shadow Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Mummu Kecks +2",
		feet="Malignance Boots",
	})
	sets.engaged.MidAcc.MDT = set_combine(sets.engaged.MDT,{
	})
	sets.engaged.HighAcc.MDT = set_combine(sets.engaged.MDT,{
	})
	sets.engaged.FullAcc.MDT = set_combine(sets.engaged.MDT,{
	})

	-- 15% Haste 
	-- DW needed: 32
	sets.engaged.Haste_15 = set_combine(sets.engaged,{
		ear1="Suppanomimi",
		ear2="Sherida Earring",
	})
	sets.engaged.MidAcc.Haste_15 = set_combine(sets.engaged.MidAcc,{
		ammo="Charis Feather",
		ear1="Suppanomimi",
		ear2="Sherida Earring",
		ring2="Apate Ring",
		legs="Mummu Kecks +2",
	})
	sets.engaged.HighAcc.Haste_15 = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.FullAcc.Haste_15 = set_combine(sets.engaged.FullAcc,{
	})

	sets.engaged.Evasion.Haste_15 = set_combine(sets.engaged.Evasion,{
		ear1="Suppanomimi",
		ear2="Sherida Earring",
	})
	sets.engaged.MidAcc.Evasion.Haste_15 = set_combine(sets.engaged.MidAcc.Evasion,{
		ammo="Charis Feather",
		ear1="Suppanomimi",
		ear2="Sherida Earring",
		ring2="Apate Ring",
		legs="Mummu Kecks +2",
	})
	sets.engaged.HighAcc.Evasion.Haste_15 = set_combine(sets.engaged.HighAcc.Evasion,{
	})
	sets.engaged.FullAcc.Evasion.Haste_15 = set_combine(sets.engaged.FullAcc.Evasion,{
	})
	
	sets.engaged.PDT.Haste_15 = set_combine(sets.engaged.PDT,{
		ear1="Suppanomimi",
		ear2="Sherida Earring",
	})
	sets.engaged.MidAcc.PDT.Haste_15 = set_combine(sets.engaged.MidAcc.PDT,{
		ear1="Suppanomimi",
		ear2="Sherida Earring",
	})
	sets.engaged.HighAcc.PDT.Haste_15 = set_combine(sets.engaged.HighAcc.PDT,{
	})
	sets.engaged.FullAcc.PDT.Haste_15 = set_combine(sets.engaged.FullAcc.PDT,{
	})

	sets.engaged.MDT.Haste_15 = set_combine(sets.engaged.MDT,{
	})
	sets.engaged.MidAcc.MDT.Haste_15 = set_combine(sets.engaged.MidAcc.MDT,{
	})
	sets.engaged.HighAcc.MDT.Haste_15 = set_combine(sets.engaged.HighAcc.MDT,{
	})
	sets.engaged.FullAcc.MDT.Haste_15 = set_combine(sets.engaged.FullAcc.MDT,{
	})

	-- 30% Haste 
	-- DW needed: 21
	sets.engaged.Haste_30 = set_combine(sets.engaged,{
		ear1="Brutal Earring",
		ear2="Sherida Earring",
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
	})
	sets.engaged.MidAcc.Haste_30 = set_combine(sets.engaged.MidAcc,{
		ammo="Charis Feather",
		ear1="Suppanomimi",
		ear2="Sherida Earring",
		ring2="Apate Ring",
		waist="Windbuffet Belt +1",
		legs="Mummu Kecks +2",
	})
	sets.engaged.HighAcc.Haste_30 = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.FullAcc.Haste_30 = set_combine(sets.engaged.FullAcc,{
	})

	sets.engaged.Evasion.Haste_30 = set_combine(sets.engaged.Evasion,{
		ear1="Brutal Earring",
		ear2="Sherida Earring",
	})
	sets.engaged.MidAcc.Evasion.Haste_30 = set_combine(sets.engaged.MidAcc.Evasion,{
		ear1="Suppanomimi",
		ear2="Sherida Earring",
	})
	sets.engaged.HighAcc.Evasion.Haste_30 = set_combine(sets.engaged.HighAcc.Evasion,{
	})
	sets.engaged.FullAcc.Evasion.Haste_30 = set_combine(sets.engaged.FullAcc.Evasion,{
	})
	
	sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.PDT,{
		ear1="Brutal Earring",
		ear2="Sherida Earring",
	})
	sets.engaged.MidAcc.PDT.Haste_30 = set_combine(sets.engaged.MidAcc.PDT,{
		ear1="Suppanomimi",
		ear2="Sherida Earring",
	})
	sets.engaged.HighAcc.PDT.Haste_30 = set_combine(sets.engaged.HighAcc.PDT,{
	})
	sets.engaged.FullAcc.PDT.Haste_30 = set_combine(sets.engaged.FullAcc.PDT,{
	})

	sets.engaged.MDT.Haste_30 = set_combine(sets.engaged.MDT,{
	})
	sets.engaged.MidAcc.MDT.Haste_30 = set_combine(sets.engaged.MidAcc.MDT,{
	})
	sets.engaged.HighAcc.MDT.Haste_30 = set_combine(sets.engaged.HighAcc.MDT,{
	})
	sets.engaged.FullAcc.MDT.Haste_30 = set_combine(sets.engaged.FullAcc.MDT,{
	})

	-- 35% Haste 
	-- DW needed: 16
	sets.engaged.Haste_35 = set_combine(sets.engaged,{
		ear1="Brutal Earring",
		ear2="Sherida Earring",
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
	})
	sets.engaged.MidAcc.Haste_35 = set_combine(sets.engaged.MidAcc,{
		ammo="Charis Feather",
		ear1="Suppanomimi Earring",
		ear2="Sherida Earring",
		ring2="Apate Ring",
		waist="Windbuffet Belt +1",
		legs="Mummu Kecks +2",
	})
	sets.engaged.HighAcc.Haste_35 = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.FullAcc.Haste_35 = set_combine(sets.engaged.FullAcc,{
	})

	sets.engaged.Evasion.Haste_35 = set_combine(sets.engaged.Evasion,{
		ear1="Brutal Earring",
		ear2="Sherida Earring",
	})
	sets.engaged.MidAcc.Evasion.Haste_35 = set_combine(sets.engaged.MidAcc.Evasion,{
		ear1="Suppanomimi Earring",
		ear2="Sherida Earring",
	})
	sets.engaged.HighAcc.Evasion.Haste_35 = set_combine(sets.engaged.HighAcc.Evasion,{
	})
	sets.engaged.FullAcc.Evasion.Haste_35 = set_combine(sets.engaged.FullAcc.Evasion,{
	})

	sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.PDT,{
		ear1="Brutal Earring",
		ear2="Sherida Earring",
	})
	sets.engaged.MidAcc.PDT.Haste_35 = set_combine(sets.engaged.MidAcc.PDT,{
		ear1="Suppanomimi Earring",
		ear2="Sherida Earring",
	})
	sets.engaged.HighAcc.PDT.Haste_35 = set_combine(sets.engaged.HighAcc.PDT,{
	})
	sets.engaged.FullAcc.PDT.Haste_35 = set_combine(sets.engaged.FullAcc.PDT,{
	})

	sets.engaged.MDT.Haste_35 = set_combine(sets.engaged.MDT,{
	})
	sets.engaged.MidAcc.MDT.Haste_35 = set_combine(sets.engaged.MidAcc.MDT,{
	})
	sets.engaged.HighAcc.MDT.Haste_35 = set_combine(sets.engaged.HighAcc.MDT,{
	})
	sets.engaged.FullAcc.MDT.Haste_35 = set_combine(sets.engaged.FullAcc.MDT,{
	})

	-- Delay Cap from spell + songs alone (43.75% Magic Haste cap)
	-- DW needed: 1
	sets.engaged.MaxHaste = set_combine(sets.engaged,{
		ear1="Brutal Earring",
		ear2="Sherida Earring",
		body="Horos Casaque +3",
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet="Horos T. Shoes +3",
	})
	sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.MidAcc,{
		ammo="Charis Feather",
		ear1="Brutal Earring",
		ear2="Sherida Earring",
		ring2="Apate Ring",
		waist="Windbuffet Belt +1",
		legs="Mummu Kecks +2",
	})
	sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.HighAcc,{
		ear1="Telos Earring",
	})
	sets.engaged.FullAcc.MaxHaste = set_combine(sets.engaged.FullAcc,{
		ear1="Telos Earring",
	})

	sets.engaged.Evasion.MaxHaste = set_combine(sets.engaged.Evasion,{
		ear1="Brutal Earring",
		ear2="Sherida Earring",
	})
	sets.engaged.MidAcc.Evasion.MaxHaste = set_combine(sets.engaged.MidAcc.Evasion,{
		ear1="Brutal Earring",
		ear2="Sherida Earring",
	})
	sets.engaged.HighAcc.Evasion.MaxHaste = set_combine(sets.engaged.HighAcc.Evasion,{
	})
	sets.engaged.FullAcc.Evasion.MaxHaste = set_combine(sets.engaged.FullAcc.Evasion,{
	})

	sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.PDT,{
		ear1="Brutal Earring",
		ear2="Sherida Earring",
	})
	sets.engaged.MidAcc.PDT.MaxHaste = set_combine(sets.engaged.MidAcc.PDT,{
		ear1="Brutal Earring",
		ear2="Sherida Earring",
	})
	sets.engaged.HighAcc.PDT.MaxHaste = set_combine(sets.engaged.HighAcc.PDT,{
	})
	sets.engaged.FullAcc.PDT.MaxHaste = set_combine(sets.engaged.FullAcc.PDT,{
	})

	sets.engaged.MDT.MaxHaste = set_combine(sets.engaged.MDT,{
	})
	sets.engaged.MidAcc.MDT.MaxHaste = set_combine(sets.engaged.MidAcc.MDT,{
	})
	sets.engaged.HighAcc.MDT.MaxHaste = set_combine(sets.engaged.HighAcc.MDT,{
	})
	sets.engaged.FullAcc.MDT.MaxHaste = set_combine(sets.engaged.FullAcc.MDT,{
	})

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Saber Dance'] = {
		legs="Horos Tights +3",
	}
	sets.buff['Climactic Flourish'] = {
		head="Maculele Tiara +1"
	}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(stateField, newValue, oldValue)
	if state.Weapon.value == true then
		disable('main','sub','range','ammo')
	else
		enable('main','sub','range','ammo')
	end
end

function job_precast(spell, action, spellMap, eventArgs)
	--auto_presto(spell)
	if spell.type == 'WeaponSkill' then
		if (spell.target.model_size + spell.range * 1.642276421172564) < spell.target.distance then	
			add_to_chat(7,"--- Target "..spell.target.type.." ["..player.target.name.."] out of range of ["..spell.name.."] [ Distance: "..spell.target.distance.."] ---")
			cancel_spell()
		end
	end
end

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
	elseif buff == 'Saber Dance' or buff == 'Climactic Flourish' then
		if gain and not midaction() then
			handle_equipping_gear(player.status)
		end
	end

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
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 7)
	elseif player.sub_job == 'NIN' then
		set_macro_page(2, 7)
	elseif player.sub_job == 'SAM' then
		set_macro_page(3, 7)
	else
		set_macro_page(1, 7)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

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

	if state.Neck.current == 'on' then
		equip(sets.Neck)
		disable('neck')
	else
		enable('neck')
	end

	if not buffactive['Protect'] then
		idleSet = set_combine(idleSet, sets.noprotect)
	end

	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.DefenseMode.value ~= 'None' then
		if buffactive['saber dance'] then
			meleeSet = set_combine(meleeSet, sets.buff['Saber Dance'])
		end
		if state.Buff['Climactic Flourish'] then
			meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
		end
	end

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
		meleeSet = set_combine(meleeSet, sets.sharedTH)
	end

	return meleeSet
end