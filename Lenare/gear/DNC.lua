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

	determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.HybridMode:options('Normal', 'Evasion', 'PDT')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.PhysicalDefenseMode:options('Evasion', 'PDT')

	state.HasteMode = M('Normal', 'Hi')

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

	-- Additional local binds
	send_command('bind ^= gs c cycle mainstep')
	send_command('bind != gs c cycle altstep')
	send_command('bind ^- gs c toggle selectsteptarget')
	send_command('bind !- gs c toggle usealtstep')
	send_command('bind ^` input /ja "Chocobo Jig" <me>')
	send_command('bind !` input /ja "Chocobo Jig II" <me>')
	send_command('bind @` gs c cycle HasteMode')

	select_default_macro_book()

	global_aliases()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind ^=')
	send_command('unbind !=')
	send_command('unbind ^-')
	send_command('unbind !-')
	send_command('unbind @`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs

	sets.precast.JA['No Foot Rise'] = {body="Horos Casaque"}

	sets.precast.JA['Trance'] = {head="Horos Tiara +1"}


	-- Waltz set (chr and vit)

	-- 48%
	sets.precast.Waltz = {
		-- 11%
		head="Horos Tiara +1",
		-- 5%
		ear1="Roundel Earring",
		-- 17%
		body="Maxixi Casaque +2",
		hands="Meg. Gloves +2",
		-- 5%
		back=gear.AugMantleRev,
		waist="Caudata Belt",
		legs="Meg. Chausses +2",
		-- 10%
		feet="Maxixi Shoes +1"
	}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.precast.Samba = {
		head="Maxixi Tiara +2"
	}

	sets.precast.Jig = {
		legs="Horos Tights +1",
		feet="Maxixi Shoes +1"
	}

	sets.precast.Acc = {
		--ammo="Jukukik Feather",
		head="Meghanada Visor +2",
		ear1="Heartseeker Earring",
		ear2="Steelflash Earring",
		neck="Sanctity Necklace",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		ring2="Cacoethic Ring",
		back=gear.Senuna_DexDa,
		waist="Eschan Stone",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2"
	}
	sets.precast.Macc = {
		head="Mummu Bonnet +2",
		neck="Sanctity Necklace",
		ear1="Hermetic Earring",
		body="Mummu Jacket +2",
		hands="Mummu Wrists +2",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		waist="Eschan Stone",
		legs="Mummu Kecks +2",
		feet="Mummu Gamash. +2",
	}

	sets.precast.Step = set_combine(sets.precast.Acc,{
	})
	sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step,{
		feet="Macu. Toe Shoes +1"
	})

	sets.precast.Flourish1 = {}
	sets.precast.Flourish1['Violent Flourish'] = set_combine(sets.precast.Macc,{
		body="Horos Casaque"
		--body="Horos Casaque +1"
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
		legs="Samnuha Tights",
		--legs=gear.Herculean_legs_WSD,
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
		--legs="Shned. Tights +1",
		legs=gear.Herculean_legs_WSD,
		feet="Meg. Jam. +2",
	})

	-- 73~85% AGI
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		ring1="Garuda Ring",
	})
	sets.precast.WS['Exenterator'].MidAcc = set_combine(sets.precast.WS.MidAcc, {
		ring1="Garuda Ring",
	})
	sets.precast.WS['Exenterator'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
	})
	sets.precast.WS['Exenterator'].FullAcc = set_combine(sets.precast.WS.FullAcc, {
	})

	-- 40% DEX / 40% STR
	sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {
		body="Meg. Cuirie +2",
		legs="Samnuha Tights",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS['Pyrrhic Kleos'].MidAcc = set_combine(sets.precast.WS.MidAcc, {
		head="Meghanada Visor +2",
		legs="Samnuha Tights",
	})
	sets.precast.WS['Pyrrhic Kleos'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
	})
	sets.precast.WS['Pyrrhic Kleos'].FullAcc = set_combine(sets.precast.WS.FullAcc, {
	})

	-- 	40% CHR / 40% DEX
	sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Dancing Edge'].MidAcc = set_combine(sets.precast.WS.MidAcc, {
	})
	sets.precast.WS['Dancing Edge'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
	})
	sets.precast.WS['Dancing Edge'].FullAcc = set_combine(sets.precast.WS.FullAcc, {
	})

	-- 50% DEX
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Evisceration'].MidAcc = set_combine(sets.precast.WS.MidAcc, {
	})
	sets.precast.WS['Evisceration'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
	})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {
	})

	-- 80% DEX
	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		head="Mummu Bonnet +2",
		hands="Mummu Wrists +2",
	})
	sets.precast.WS["Rudra's Storm"].MidAcc = set_combine(sets.precast.WS.MidAcc, {
		head="Mummu Bonnet +2",
		hands="Meg. Gloves +2",
	})
	sets.precast.WS["Rudra's Storm"].HighAcc = set_combine(sets.precast.WS.HighAcc, {
		hands="Meg. Gloves +2",
	})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {
		hands="Meg. Gloves +2",
	})

	-- 40% DEX 40% AGI
	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
		hands="Meg. Gloves +2",
	})
	sets.precast.WS['Shark Bite'].MidAcc = set_combine(sets.precast.WS.MidAcc, {
		hands="Meg. Gloves +2",
	})
	sets.precast.WS['Shark Bite'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
		hands="Meg. Gloves +2",
	})
	sets.precast.WS['Shark Bite'].FullAcc = set_combine(sets.precast.WS.FullAcc, {
		hands="Meg. Gloves +2",
	})

	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB,{
	})

	sets.precast.Skillchain = {hands="Macu. Bangles +1"}

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		head="Skormoth Mask",
		body="Mekosu. Harness",
		back="Shadow Mantle",
		waist="Cetl Belt",
		feet="Maxixi Shoes +1"
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
		head="Meghanada Visor +2",
		--ammo="Charis Feather",
		ammo="Staunch Tathlum",
		neck="Twilight Torque",
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

	-- Defense sets

	sets.defense.Evasion = set_combine(sets.idle,{
	back=gear.AugMantleRev,
	feet="Meg. Jam. +2"
	})

	sets.defense.PDT = set_combine(sets.idle,{
		ammo="Staunch Tathlum",
		head="Meghanada Visor +2",
		neck="Twilight Torque",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Mummu Kecks +2",
		feet="Meg. Jam. +2"
	})

	sets.defense.MDT = set_combine(sets.idle,{
		ammo="Staunch Tathlum",
		head="Skormoth Mask",
		ear2="Etiolation Earring",
		neck="Twilight Torque",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Shadow Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Mummu Kecks +2",
		feet="Meg. Jam. +2"
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
		ear1="Heartseeker Earring",
		ear2="Dudgeon Earring",
		body="Macu. Casaque +1",
		hands="Mummu Wrists +2",
		ring1="Rajas Ring",
		ring2="K'ayres Ring",
		back=gear.Senuna_DexDa,
		waist="Patentia Sash",
		legs="Meg. Chausses +2",
		feet="Macu. Toe Shoes +1",
	}
	sets.engaged.MidAcc = set_combine(sets.engaged,{
		ammo="Honed Tathlum",
		head="Mummu Bonnet +2",
		neck="Defiant Collar",
		body="Mummu Jacket +2",
		ring2="Cacoethic Ring",
		feet="Mummu Gamash. +2",
	})
	sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc,{
		ear2="Zennaroi Earring",
		hands="Malignance Gloves",
		waist="Eschan Stone",
		feet="Malignance Boots",
	})
	sets.engaged.FullAcc = set_combine(sets.engaged.HighAcc,{
	})

	sets.engaged.Evasion = set_combine(sets.engaged,{
		body="Meg. Cuirie +2",
	})
	sets.engaged.MidAcc.Evasion = set_combine(sets.engaged.MidAcc,{
		body="Meg. Cuirie +2",
	})
	sets.engaged.HighAcc.Evasion = set_combine(sets.engaged.HighAcc,{
		body="Meg. Cuirie +2",
	})
	sets.engaged.FullAcc.Evasion = set_combine(sets.engaged.FullAcc,{
		body="Meg. Cuirie +2",
	})

	sets.engaged.PDT = set_combine(sets.engaged.Evasion,{
		head="Meghanada Visor +2",
		neck="Twilight Torque",
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
		head="Skormoth Mask",
		neck="Twilight Torque",
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
		body="Mummu Jacket +2",
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
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
	})
	sets.engaged.FullAcc.MaxHaste = set_combine(sets.engaged.FullAcc,{
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
		legs="Horos Tights +1"
	}
	sets.buff['Climactic Flourish'] = {
		head="Maculele Tiara +1"
	}
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
	if not buffactive['Protect'] then
		idleSet = set_combine(idleSet, sets.noprotect)
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