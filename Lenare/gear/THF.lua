function user_setup()
	state.IdleMode:options('CP', 'Normal', 'Regen', 'CPPDT', 'CPMDT')
	state.OffenseMode:options('Normal', 'CappedDelay', 'MidAcc', 'MidAccCappedDelay', 'HighAcc', 'HighAccCappedDelay', 'FullAcc')
	state.HybridMode:options('Normal', 'Evasion', 'PDT')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.PhysicalDefenseMode:options('Evasion', 'PDT')
	
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Windbuffet Belt +1"

	gear.CannyDW = { name="Canny Cape", augments={'DEX+2','AGI+3','"Dual Wield"+3',}}
	
	-- Additional local binds
	send_command('bind ^` input /ja "Flee" <me>')
	send_command('bind ^= gs c cycle treasuremode')
	send_command('bind !- gs c cycle targetmode')

	global_aliases()
	
	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Special sets
	--------------------------------------

	-- 3 Base (8 gear cap)
	-- 0 Gift
	sets.TreasureHunter = {
		--head="Wh. Rarab Cap +1",
		-- 3
		hands="Plun. Armlets +1",
		-- 2
		--legs=gear.Herculean_legs_TA,
		-- 3
		feet="Skulk. Poulaines +1"
	}
	sets.ExtraRegen = {}
	sets.Kiting = {
		feet="Skd. Jambeaux +1"
	}

	sets.buff['Sneak Attack'] = {
		head=gear.Adhemar_head_B,
		neck="Spike Necklace",
		ear1="Dudgeon Earring",
		ear2="Heartseeker Earring",
		body="Meg. Cuirie +2",
		hands="Raid. Armlets +2",
		ring1="Rajas Ring",
		ring2="Apate Ring",
		back="Canny Cape",
		waist="Hurch'lan Sash",
		legs="Samnuha Tights",
		feet="Meg. Jam. +2"
	}

	sets.buff['Trick Attack'] = {
		head=gear.Adhemar_head_B,
		neck="Spike Necklace",
		ear1="Dudgeon Earring",
		ear2="Heartseeker Earring",
		body="Meg. Cuirie +2",
		hands="Pillager's Armlets",
		ring1="Garuda Ring",
		ring2="Garuda Ring",
		back="Canny Cape",
		waist="Hurch'lan Sash",
		legs="Samnuha Tights",
		feet="Meg. Jam. +2"
	}


	--------------------------------------
	-- Precast sets
	--------------------------------------
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Collaborator'] = {head="Raider's Bonnet +2"}
	sets.precast.JA['Accomplice'] = {head="Raider's Bonnet +2"}
	sets.precast.JA['Flee'] = {feet="Pillager's Poulaines"}
	sets.precast.JA['Hide'] = {body="Pillager's Vest"}
	sets.precast.JA['Conspirator'] = {body="Raider's Vest +2"}
	sets.precast.JA['Steal'] = {hands="Pillager's Armlets",legs="Assassin's Culottes",feet="Pillager's Poulaines"}
	sets.precast.JA['Despoil'] = {legs="Raider's Culottes +2",feet="Skulk. Poulaines +1"}
	sets.precast.JA['Perfect Dodge'] = {hands="Plun. Armlets +1"}
	sets.precast.JA['Feint'] = {
		--legs="Assassin's Culottes +2"
	}
	
	sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
	sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Mummu Bonnet +2",
		ear1="Roundel Earring",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		ring1="Dark Ring",
		ring2="Sirona's Ring",
		legs="Meg. Chausses +2",
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
		waist="Impulse Belt",
		legs="Nahtirah Trousers",
		feet="Meg. Jam. +2"
	}


	-- Weaponskill sets
	
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head=gear.Adhemar_head_B,
		neck="Asperity Necklace",
		--neck=gear.ElementalGorget,
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		ring1="Rajas Ring",
		ring2="Apate Ring",
		back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		--legs="Samnuha Tights",
		legs=gear.Herculean_legs_WSD,
		feet="Mummu Gamash. +2",
	}
	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
	})
	sets.precast.WS.HighAcc = set_combine(sets.precast.WS, {
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		waist="Hurch'lan Sash",
		--legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {
		head="Meghanada Visor +2",
		neck="Sanctity Necklace",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		waist="Hurch'lan Sash",
		back="Canny Cape",
		--legs="Meg. Chausses +2",
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
		back="Toro Cape",
		--legs="Shned. Tights +1",
		legs=gear.Herculean_legs_WSD,
	})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Exenterator'].MidAcc = set_combine(sets.precast.WS.MidAcc, {
	})
	sets.precast.WS['Exenterator'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
	})
	sets.precast.WS['Exenterator'].FullAcc = set_combine(sets.precast.WS.FullAcc, {
	})
	sets.precast.WS['Exenterator'].SA = set_combine(sets.precast.WS['Exenterator'], {
	})
	sets.precast.WS['Exenterator'].TA = set_combine(sets.precast.WS['Exenterator'], {
	})
	sets.precast.WS['Exenterator'].SATA = set_combine(sets.precast.WS['Exenterator'], {
	})

	sets.precast.WS['Dancing Edge'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Dancing Edge'].MidAcc = set_combine(sets.precast.WS.MidAcc, {
	})
	sets.precast.WS['Dancing Edge'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
	})
	sets.precast.WS['Dancing Edge'].FullAcc = set_combine(sets.precast.WS.FullAcc, {
	})
	sets.precast.WS['Dancing Edge'].SA = set_combine(sets.precast.WS['Dancing Edge'], {
	})
	sets.precast.WS['Dancing Edge'].TA = set_combine(sets.precast.WS['Dancing Edge'], {
	})
	sets.precast.WS['Dancing Edge'].SATA = set_combine(sets.precast.WS['Dancing Edge'], {
	})

	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Evisceration'].MidAcc = set_combine(sets.precast.WS.MidAcc, {
	})
	sets.precast.WS['Evisceration'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
	})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {
	})
	sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'], {
	})
	sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'], {
	})
	sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'], {
	})

	sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {
		hands="Meg. Gloves +2",
	})
	sets.precast.WS["Rudra's Storm"].MidAcc = set_combine(sets.precast.WS.MidAcc, {
		hands="Meg. Gloves +2",
		back="Atheling Mantle"
	})
	sets.precast.WS["Rudra's Storm"].HighAcc = set_combine(sets.precast.WS.HighAcc, {
		hands="Meg. Gloves +2",
	})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {
		hands="Meg. Gloves +2",
	})
	sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"], {
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2"
	})
	sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"], {
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
	})
	sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"], {
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
	})

	sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {
		hands="Meg. Gloves +2",
	})
	sets.precast.WS['Shark Bite'].MidAcc = set_combine(sets.precast.WS.MidAcc, {
		hands="Meg. Gloves +2",
		back="Atheling Mantle",
	})
	sets.precast.WS['Shark Bite'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
		hands="Meg. Gloves +2",
	})
	sets.precast.WS['Shark Bite'].FullAcc = set_combine(sets.precast.WS.FullAcc, {
		hands="Meg. Gloves +2",
	})
	sets.precast.WS['Shark Bite'].SA = set_combine(sets.precast.WS['Shark Bite'], {
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
	})
	sets.precast.WS['Shark Bite'].TA = set_combine(sets.precast.WS['Shark Bite'], {
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
	})
	sets.precast.WS['Shark Bite'].SATA = set_combine(sets.precast.WS['Shark Bite'], {
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
	})

	sets.precast.WS['Mandalic Stab'] = set_combine(sets.precast.WS, {
		hands="Meg. Gloves +2",
	})
	sets.precast.WS['Mandalic Stab'].MidAcc = set_combine(sets.precast.WS.MidAcc, {
		hands="Meg. Gloves +2",
	})
	sets.precast.WS['Mandalic Stab'].HighAcc = set_combine(sets.precast.WS.HighAcc, {
		hands="Meg. Gloves +2",
	})
	sets.precast.WS['Mandalic Stab'].FullAcc = set_combine(sets.precast.WS.FullAcc, {
		hands="Meg. Gloves +2",
	})
	sets.precast.WS['Mandalic Stab'].SA = set_combine(sets.precast.WS['Mandalic Stab'], { 
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
	})
	sets.precast.WS['Mandalic Stab'].TA = set_combine(sets.precast.WS['Mandalic Stab'], {
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
	})
	sets.precast.WS['Mandalic Stab'].SATA = set_combine(sets.precast.WS['Mandalic Stab'], {
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
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
		head="Blistering Sallet +1",
		body="Mekosu. Harness",
		back="Shadow Mantle",
		waist="Hurch'lan Sash",
		feet="Pillager's Poulaines"
	});
		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {
	})

	-- Ranged gear
	sets.midcast.RA = {
		head="Meghanada Visor +2",
		neck="Marked Gorget",
		ear1="Enervating Earring",
		ear2="Volley Earring",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		ring1="Hajduk Ring",
		ring2="Cacoethic Ring",
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
		head="Meghanada Visor +2",
		neck="Twilight Torque",
		ear1="Dudgeon Earring",
		ear2="Heartseeker Earring",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		ring1=gear.DarkRing.physical,
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Cetl Belt",
		legs="Mummu Kecks +2",
		feet="Skd. Jambeaux +1"
	}

	sets.idle.Town = set_combine(sets.idle,{
	})
	
	sets.idle.Weak = set_combine(sets.idle,{
	})

	sets.idle.Regen = set_combine(sets.idle,{
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
		feet="Meg. Jam. +2",
	})

	sets.defense.PDT = set_combine(sets.idle,{
		feet="Meg. Jam. +2",
	})

	sets.defense.MDT = set_combine(sets.idle,{
		head="Skormoth Mask",
		neck="Inq. Bead Necklace",
		ear2="Etiolation Earring",
		ring1="Shadow Ring",
		feet="Meg. Jam. +2",
	})

	--------------------------------------
	-- Melee sets
	--------------------------------------
	
	-- Normal melee group
	sets.engaged = {
		head="Skormoth Mask",
		neck="Asperity Necklace",
		ear1="Dudgeon Earring",
		ear2="Heartseeker Earring",
		body="Thaumas Coat",
		hands="Mummu Wrists +2",
		ring1="Rajas Ring",
		ring2="K'ayres Ring",
		back="Canny Cape",
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet="Plun. Poulaines"
	}
	-- assuming Haste II and March 2
	sets.engaged.CappedDelay = set_combine(sets.engaged,{
	})
	sets.engaged.MidAcc = set_combine(sets.engaged,{
		body="Meg. Cuirie +2",
		waist="Hurch'lan Sash",
		feet="Mummu Gamash. +2",
	})
	-- assuming Haste II and March 2
	sets.engaged.MidAccCappedDelay = set_combine(sets.engaged.MidAcc,{
	})
	sets.engaged.HighAcc = set_combine(sets.engaged,{
		head="Skormoth Mask",
		neck="Sanctity Necklace",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		waist="Hurch'lan Sash",
		legs="Meg. Chausses +2",
		feet="Mummu Gamash. +2",
	})
	-- assuming Haste II and March 2
	sets.engaged.HighAccCappedDelay = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.FullAcc = set_combine(sets.engaged,{
		head="Meghanada Visor +2",
		ear1="Zennaroi Earring",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		ring2="Cacoethic Ring",
		waist="Hurch'lan Sash",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
	})
	sets.engaged.Evasion = set_combine(sets.engaged,{
		body="Mekosu. Harness",
		back="Canny Cape",
	})
	sets.engaged.MidAcc.Evasion = set_combine(sets.engaged.MidAcc,{
	})
	sets.engaged.HighAcc.Evasion = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.FullAcc.Evasion = set_combine(sets.engaged.FullAcc,{
	})
	sets.engaged.PDT = set_combine(sets.engaged.Evasion,{
		head="Meghanada Visor +2",
		neck="Twilight Torque",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		ring1="Dark Ring",
		ring2="Dark Ring",
		back="Shadow Mantle",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
	})
	sets.engaged.MDT = set_combine(sets.engaged.Evasion,{
		head="Skormoth Mask",
		ear2="Etiolation Earring",
		ring1="Shadow Ring",
	})

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