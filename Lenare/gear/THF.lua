-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
	state.Buff['Trick Attack'] = buffactive['trick attack'] or false
	state.Buff['Feint'] = buffactive['feint'] or false

	include('Mote-TreasureHunter')

	-- For th_action_check():
	-- JA IDs for actions that always have TH: Provoke, Animated Flourish
	info.default_ja_ids = S{35, 204}
	-- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
	info.default_u_ja_ids = S{201, 202, 203, 205, 207}

	state.CP = M(false, "Capacity Points Mode")
	state.Warp = M(false, "Warp Mode")
	state.Weapon = M(false, "Weapon Lock")
	state.Neck = M(false, "Neck Mode")
	state.EngagedDT = M(false, 'Engaged Damage Taken Mode')
end

function user_setup()
	state.IdleMode:options('CP', 'Normal', 'StoreTP', 'Regen', 'CPPDT', 'CPMDT')
	state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.HybridMode:options('Normal', 'HybridTH', 'Evasion', 'PDT')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.PhysicalDefenseMode:options('HybridTH', 'Evasion', 'PDT')

	state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}
	state.BehindMode = M{['description']='Behind Mode', 'None', 'Normal'}
	
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Windbuffet Belt +1"

	gear.jsecape_dex_crit = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Damage taken-5%',}}
	gear.jsecape_dex_dw = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+6','Damage taken-5%',}}
	gear.jsecape_dex_wsd = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}}

	gear.CannyDW = { name="Canny Cape", augments={'DEX+2','AGI+3','"Dual Wield"+3',}}
	
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
	send_command('bind @b gs c cycle BehindMode') --WindowKey'B'
	send_command("bind @p gs equip sets.TaeonPhalanx; input /echo --- Phalanx set on ---") -- WindowKey'P'

	send_command('bind @c gs c toggle CP') --WindowKey'C'
	send_command('bind @e gs c toggle EngagedDT') --Windowkey'E'
	send_command('bind @h gs c cycle TreasureMode') --Windowkey'H'
	send_command('bind @n gs c toggle Neck') --Windowkey'N'
	send_command('bind @r gs c toggle Warp') --Windowkey'R'
	send_command('bind @w gs c toggle Weapon') --Windowkey'W'

	global_aliases()
	
	select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind @`')
	send_command('unbind @b')
	send_command('unbind @p')

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
	-- Special sets
	--------------------------------------

	-- 3 Base (8 gear cap)
	-- 0 Gift
	sets.TreasureHunter = {
		--ammo="Per. Lucky Egg",
		-- Assuming +1 from perfect Taming Sari
		--head="Wh. Rarab Cap +1",
		-- 4
		hands="Plun. Armlets +3",
		-- 2
		--legs=gear.Herculean_legs_TA,
		-- 3
		--feet="Skulk. Poulaines +1"
	}
	sets.ExtraRegen = {}
	sets.Kiting = {
		feet="Skd. Jambeaux +1"
	}

	sets.buff['Sneak Attack'] = {
		head="Pill. Bonnet +3",
		neck="Caro Necklace",
		ear1="Sherida Earring",
		ear2="Suppanomimi",
		body="Pillager's Vest +3",
		hands="Skulk. Armlets +1",
		ring1="Rajas Ring",
		ring2="Apate Ring",
		back=gear.jsecape_dex_crit,
		waist="Eschan Stone",
		--legs="Samnuha Tights",
		legs="Pill. Culottes +3",
		feet="Meg. Jam. +2"
	}

	sets.buff['Trick Attack'] = {
		head="Pill. Bonnet +3",
		neck="Iskur Gorget",
		ear1="Sherida Earring",
		ear2="Suppanomimi",
		body="Plunderer's Vest +3",
		hands="Pill. Armlets +3",
		ring1="Garuda Ring +1",
		ring2="Garuda Ring +1",
		back="Canny Cape",
		waist="Eschan Stone",
		--legs="Samnuha Tights",
		legs="Pill. Culottes +3",
		feet="Meg. Jam. +2"
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
	sets.precast.JA['Steal'] = {neck="Rabbit Charm",hands="Pill. Armlets +3",legs="Assassin's Culottes",feet="Pill. Poulaines +1"}
	sets.precast.JA['Despoil'] = {legs="Skulk. Culottes +1",feet="Skulk. Poulaines +1"}
	sets.precast.JA['Perfect Dodge'] = {hands="Plun. Armlets +3"}
	sets.precast.JA['Feint'] = {
		--legs="Assassin's Culottes +2"
	}
	
	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Pill. Bonnet +3",
		ear1="Roundel Earring",
		body="Pillager's Vest +3",
		hands="Pill. Armlets +3",
		ring1="Dark Ring",
		ring2="Sirona's Ring",
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
	
	
	-- Fast cast sets for spells=
	
	sets.precast.FC = {
		neck="Baetyl Pendant",
		ear1="Loquac. Earring",
		ear2="Etiolation Earring",
		body="Dread Jupon",
		hands="Leyline Gloves",
		ring1="Prolix Ring",
		ring2="Weather. Ring",
		legs="Shned. Tights +1"
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	-- Ranged snapshot gear
	sets.precast.RA = {
		head="Uk'uxkaj Cap",
		hands="Iuitl Wristband +1",
		ring1="Crepuscular Ring",
		legs="Nahtirah Trousers",
		feet="Meg. Jam. +2"
	}


	-- Weaponskill sets
	
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Pill. Bonnet +3",
		neck="Asperity Necklace",
		--neck=gear.ElementalGorget,
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		--body="Plunderer's Vest +3",
		body="Pillager's Vest +3",
		hands="Mummu Wrists +2",
		ring1="Epona's Ring",
		ring2="Apate Ring",
		back=gear.jsecape_dex_crit,
		waist="Windbuffet Belt +1",
		--legs="Samnuha Tights",
		legs=gear.Herculean_legs_WSD,
		feet="Mummu Gamash. +2",
	}
	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
	})
	sets.precast.WS.HighAcc = set_combine(sets.precast.WS, {
		head="Pill. Bonnet +3",
		body="Pillager's Vest +3",
		hands="Meg. Gloves +2",
		waist="Eschan Stone",
		--legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {
		head="Pill. Bonnet +3",
		neck="Sanctity Necklace",
		body="Pillager's Vest +3",
		--hands="Meg. Gloves +2",
		hands="Pill. Armlets +3",
		back=gear.jsecape_dex_crit,
		waist="Eschan Stone",
		legs="Pill. Culottes +3",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS.MAB = set_combine(sets.precast.WS, {
		head=gear.Herculean_head_mab,
		neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		--body="Samnuha Coat",
		body=gear.Herculean_body_mab,
		hands="Leyline Gloves",
		ring1="Acumen Ring",
		ring2="Arvina Ringlet +1",
		back=gear.jsecape_dex_wsd,
		waist="Eschan Stone",
		--legs="Shned. Tights +1",
		legs=gear.Herculean_legs_WSD,
	})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		head=gear.Adhemar_head_B,
		ear1="Sherida Earring",
		ear2="Brutal Earring",
		body="Plunderer's Vest +3",
		hands="Meg. Gloves +2",
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
	sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'], {
		--hands="Skulk. Armlets +1",
	})
	sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'], {
	})
	sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'], {
		--hands="Skulk. Armlets +1",
	})

	sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Dancing Edge'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS['Dancing Edge'], {
	})
	sets.precast.WS['Dancing Edge'].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS['Dancing Edge'], {
	})
	sets.precast.WS['Dancing Edge'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Dancing Edge'], {
	})
	sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'], {
		--hands="Skulk. Armlets +1",
		hands="Meg. Gloves +2",
		back=gear.jsecape_dex_wsd,
	})
	sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'], {
		hands="Pill. Armlets +3",
		back=gear.jsecape_dex_wsd,
	})
	sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'], {
		--hands="Skulk. Armlets +1",
		hands="Pill. Armlets +3",
		back=gear.jsecape_dex_wsd,

	})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		ear1="Odr Earring",
		body="Plunderer's Vest +3",
		hands="Mummu Wrists +2",
		ring2="Mummu Ring",
		legs="Pill. Culottes +3",
	})
	sets.precast.WS['Evisceration'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS['Evisceration'], {
	})
	sets.precast.WS['Evisceration'].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS['Evisceration'], {
	})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Evisceration'], {
	})
	sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'], {
		--hands="Skulk. Armlets +1",
		hands="Meg. Gloves +2",
		back=gear.jsecape_dex_wsd,
	})
	sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'], {
		hands="Meg. Gloves +2",
		back=gear.jsecape_dex_wsd,
	})
	sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'], {
		--hands="Skulk. Armlets +1",
		hands="Meg. Gloves +2",
		back=gear.jsecape_dex_wsd,
	})

	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		ear1="Odr Earring",
		body="Plunderer's Vest +3",
		hands="Meg. Gloves +2",
		back=gear.jsecape_dex_wsd,
	})
	sets.precast.WS["Rudra's Storm"].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS["Rudra's Storm"], {
	})
	sets.precast.WS["Rudra's Storm"].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS["Rudra's Storm"], {
	})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS["Rudra's Storm"], {
	})
	sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {
	})
	sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"], {
	})
	sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"], {
	})

	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
		ear1="Odr Earring",
		body="Plunderer's Vest +3",
		hands="Meg. Gloves +2",
		back=gear.jsecape_dex_wsd,
	})
	sets.precast.WS['Shark Bite'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS["Shark Bite"], {
	})
	sets.precast.WS['Shark Bite'].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS["Shark Bite"], {
	})
	sets.precast.WS['Shark Bite'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS["Shark Bite"], {
	})
	sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'], {
	})
	sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'], {
	})
	sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'], {
	})

	sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {
		ear1="Odr Earring",
		body="Plunderer's Vest +3",
		hands="Meg. Gloves +2",
		back=gear.jsecape_dex_wsd,
	})
	sets.precast.WS['Mandalic Stab'].MidAcc = set_combine(sets.precast.WS.MidAcc, sets.precast.WS['Mandalic Stab'], {
	})
	sets.precast.WS['Mandalic Stab'].HighAcc = set_combine(sets.precast.WS.HighAcc, sets.precast.WS['Mandalic Stab'], {
	})
	sets.precast.WS['Mandalic Stab'].FullAcc = set_combine(sets.precast.WS.FullAcc, sets.precast.WS['Mandalic Stab'], {
	})
	sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'], { 
	})
	sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'], {
	})
	sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'], {
	})

	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB,{
	})

	sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	sets.precast.WS['Burning Blade'] = set_combine(sets.precast.WS.MAB,{
	})

	sets.precast.WS['Burning Blade'].TH = set_combine(sets.precast.WS['Burning Blade'], sets.TreasureHunter)
	
	
	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		head="Malignance Chapeau",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Mummu Kecks +2",
		feet="Malignance Boots",
	});
		
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
		ring1="Cacoethic Ring",
		ring2="Garuda Ring +1",
		back="Libeccio Mantle",
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
	}

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

	sets.idle = {
		ammo="Crepuscular Pebble",
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Novia Earring",
		ear2="Etiolation Earring",
		body="Nyame Mail",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		--back="Moonbeam Cape",
		back="Mecisto. Mantle",
		waist="Gishdubar Sash",
		legs="Nyame Flanchard",
		feet="Skd. Jambeaux +1"
	}

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

	sets.idle.CP = set_combine(sets.idle,{
		back="Mecisto. Mantle"
	})
	
	sets.idle.CPPDT = set_combine(sets.defense.PDT,{
		back="Mecisto. Mantle"
	})
	
	sets.idle.CPMDT = set_combine(sets.defense.MDT,{
		back="Mecisto. Mantle"
	})
	

	-- Defense sets

	sets.defense.Evasion = set_combine(sets.idle,{
		back="Canny Cape",
		feet="Malignance Boots",
	})

	sets.defense.PDT = set_combine(sets.idle,{
		ammo="Crepuscular Pebble",
		back="Moonbeam Cape",
		feet="Malignance Boots",
	})

	sets.defense.MDT = set_combine(sets.idle,{
		ammo="Crepuscular Pebble",
		back="Moonbeam Cape",
		feet="Malignance Boots",
	})

	--------------------------------------
	-- Melee sets
	--------------------------------------
	
	-- Normal melee group
	sets.engaged = {
		head=gear.Adhemar_head_B,
		neck="Asperity Necklace",
		ear1="Sherida Earring",
		-- 5 DW
		ear2="Suppanomimi",
		--body="Plunderer's Vest +3",
		-- 5 DW
		body=gear.Adhemar_body_B,
		-- 5 DW
		hands="Pill. Armlets +3",
		ring1="Epona's Ring",
		ring2="Chirich Ring",
		-- 3 DW
		--back="Canny Cape",
		back=gear.jsecape_dex_crit,
		-- 5 DW
		waist="Patentia Sash",
		legs="Samnuha Tights",
		feet="Plun. Poulaines +1"
	}
	sets.engaged.MidAcc = set_combine(sets.engaged,{
		body="Pillager's Vest +3",
		legs="Pill. Culottes +3",
		feet="Mummu Gamash. +2",
	})
	sets.engaged.HighAcc = set_combine(sets.engaged,{
		ammo="Honed Tathlum",
		head="Malignance Chapeau",
		ear2="Telos Earring",
		neck="Sanctity Necklace",
		body="Pillager's Vest +3",
		waist="Eschan Stone",
		legs="Pill. Culottes +3",
		feet="Malignance Boots",
	})
	sets.engaged.FullAcc = set_combine(sets.engaged,{
		ammo="Honed Tathlum",
		head="Malignance Chapeau",
		ear1="Zennaroi Earring",
		ear2="Telos Earring",
		body="Pillager's Vest +3",
		hands="Pill. Armlets +3",
		ring1="Cacoethic Ring",
		waist="Eschan Stone",
		legs="Pill. Culottes +3",
		feet="Malignance Boots",
	})
	sets.engaged.Evasion = set_combine(sets.engaged,{
		ammo="Amar Cluster",
		head="Malignance Chapeau",
		body="Plunderer's Vest +3",
		hands="Malignance Gloves",
		back="Canny Cape",
		feet="Malignance Boots",
	})
	sets.engaged.MidAcc.Evasion = set_combine(sets.engaged.MidAcc,{
	})
	sets.engaged.HighAcc.Evasion = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.FullAcc.Evasion = set_combine(sets.engaged.FullAcc,{
	})

	sets.engaged.DT = {
		head="Malignance Chapeau",
		body="Nyame Mail",
		--body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Nyame Flanchard",
		--legs="Malignance Tights",
		feet="Malignance Boots",
	}

	sets.engaged.PDT = set_combine(sets.engaged.Evasion,sets.engaged.DT,{
		neck="Loricate Torque +1",
	})
	sets.engaged.MidAcc.PDT = set_combine(sets.engaged.PDT,{
	})
	sets.engaged.HighAcc.PDT = set_combine(sets.engaged.MidAcc.PDT,{
	})
	sets.engaged.FullAcc.PDT = set_combine(sets.engaged.HighAcc.PDT,{
	})
	sets.engaged.MDT = set_combine(sets.engaged.Evasion,sets.engaged.DT,{
		ear2="Etiolation Earring",
		ring1="Shadow Ring",
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
		-- DT 2%
		ammo="Crepuscular Pebble",
		-- DT 6%
		head="Malignance Chapeau",
		-- DT 6%
		neck="Loricate Torque +1",
		ear1="Sherida Earring",
		-- MDT 3%
		ear2="Etiolation Earring",
		-- DT 9%
		body="Nyame Mail",
		hands="Plun. Armlets +3",
		-- PDT 4% MDT 3%
		ring1="Dark Ring",
		-- DT 10%
		ring2="Defending Ring",
		-- DT 5%
		back="Moonbeam Cape",
		waist="Patentia Sash",
		-- DT 8%
		legs="Nyame Flanchard",
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
	-- 20 Gear DW
	sets.engaged.Haste_15 = set_combine(sets.engaged,{
		ear1="Sherida Earring",
		ear2="Suppanomimi",
	})
	-- DW needed: 31 (26 with gift)
	-- 20 Gear DW
	sets.engaged.Haste_30 = set_combine(sets.engaged,{
		ear1="Sherida Earring",
		ear2="Suppanomimi",
	})
	-- DW needed: 26 (21 with gift)
	-- 20 Gear DW
	sets.engaged.Haste_35 = set_combine(sets.engaged,{
		ear1="Sherida Earring",
		ear2="Suppanomimi",
	})
	-- DW needed: 11 (6 with gift)
	-- 10 Gear DW
	sets.engaged.MaxHaste = set_combine(sets.engaged,{
		ear1="Sherida Earring",
		ear2="Suppanomimi",
		--ear2="Telos Earring",
		body="Plunderer's Vest +3",
		hands=gear.Adhemar_hands_B,
		waist="Windbuffet Belt +1",
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
		body="Pillager's Vest +3",
		waist="Windbuffet Belt +1",
	})

	sets.engaged.HighAcc.Haste_15 = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.HighAcc.Haste_30 = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.HighAcc.Haste_35 = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.HighAcc,{
		ear1="Sherida Earring",
		body="Pillager's Vest +3",
		waist="Windbuffet Belt +1",
	})

	sets.engaged.FullAcc.Haste_15 = set_combine(sets.engaged.FullAcc,{
	})
	sets.engaged.FullAcc.Haste_30 = set_combine(sets.engaged.FullAcc,{
	})
	sets.engaged.FullAcc.Haste_35 = set_combine(sets.engaged.FullAcc,{
	})
	sets.engaged.FullAcc.MaxHaste = set_combine(sets.engaged.FullAcc,{
		ear1="Sherida Earring",
		body="Pillager's Vest +3",
		waist="Windbuffet Belt +1",
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

function job_state_change(stateField, newValue, oldValue)
	if state.Weapon.value == true then
		disable('main','sub','range','ammo')
	else
		enable('main','sub','range','ammo')
	end
end

function job_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' then
		if (spell.target.model_size + spell.range * 1.642276421172564) < spell.target.distance then	
			add_to_chat(7,"--- Target "..spell.target.type.." ["..player.target.name.."] out of range of ["..spell.name.."] [ Distance: "..spell.target.distance.."] ---")
			cancel_spell()
		end
	end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
	--add_to_chat(112, state.TreasureMode.value)
	--add_to_chat(112, spell.action_type)
	if state.TreasureMode.value ~= 'None' and (spell.action_type == 'Ranged Attack' or spell.action_type == 'Magic') then
		--add_to_chat(112, 'Equip TH gear')
		equip(sets.TreasureHunter)
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
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 1)
	elseif player.sub_job == 'NIN' then
		set_macro_page(2, 1)
	elseif player.sub_job == 'COR' then
		set_macro_page(3, 1)
	elseif player.sub_job == 'RUN' then
		set_macro_page(4, 1)
	else
		set_macro_page(1, 1)
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

function customize_melee_set(meleeSet)
	if state.BehindMode.value == 'Normal' then
		meleeSet = set_combine(meleeSet, sets.Behind)
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

	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end

	return meleeSet
end

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
	if (category == 2) or -- any ranged attack
		(category == 4) or -- any magic action
		(category == 3 and param == 30) or -- Aeolian Edge
		(category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
		(category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
		then return true
	end
end