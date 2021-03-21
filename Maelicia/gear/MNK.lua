function user_setup()
	state.OffenseMode:options('Normal', 'SomeAcc', 'Acc', 'Fodder')
	state.WeaponskillMode:options('Normal', 'SomeAcc', 'Acc', 'Fodder')
	state.HybridMode:options('Normal', 'PDT', 'Counter')
	state.PhysicalDefenseMode:options('PDT', 'HP')
	state.IdleMode:options('CP', 'Normal', 'Regen')

	gear.Segomo_dex_da = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}
	
	update_combat_form()
	update_melee_groups()
	
	select_default_macro_book()

	global_aliases()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs="Hes. Hose +1"}
	sets.precast.JA['Boost'] = {hands="Anch. Gloves +1"}
	sets.precast.JA['Dodge'] = {feet="Anch. Gaiters +1"}
	sets.precast.JA['Focus'] = {head="Temple Crown"}
	sets.precast.JA['Counterstance'] = {feet="Mel. Gaiters +1"}
	sets.precast.JA['Footwork'] = {feet="Tantra Gaiters +2"}
	sets.precast.JA['Formless Strikes'] = {body="Hes. Cyclas +1"}
	sets.precast.JA['Mantra'] = {feet="Mel. Gaiters +1"}

	-- Chi Blast - MND
	sets.precast.JA['Chi Blast'] = {
		head="Dampening Tam",
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
		head="Rao Kabuto +1",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
		ring1="Dark Ring",
		back="Anchoret's Mantle",
		waist="Flume Belt +1",
		legs="Anch. Hose +1",
		feet="Malignance Boots",
	}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Malignance Chapeau",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
		ring1="Dark Ring",
		ring1="Sirona's Ring",
		back="Anchoret's Mantle",
		waist="Flume Belt +1",
		legs="Anch. Hose +1",
		feet="Malignance Boots",
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
		--legs="Limbo Trousers"
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
		hands=gear.Adhemar_hands_B,
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.Segomo_dex_da,
		waist="Fotia Belt",
		legs="Hiza. Hizayoroi +2",
		feet=gear.Adhemar_feet_B
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		--head="Rao Kabuto +1",
		head="Mpaca's Cap",
		body=gear.Adhemar_body_B,
		hands=gear.Adhemar_hands_B,
		back=gear.Segomo_dex_da,
		legs="Hiza. Hizayoroi +2",
		waist="Windbuffet Belt +1"
	})
	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {
		neck=gear.ElementalGorget,
		waist=gear.ElementalBelt
	})
	sets.precast.WS.MAB = set_combine(sets.precast.WS, {
		--head=gear.Herculean_head_Magic,
		neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		--body=gear.Herculean_body_Magic,
		body="Cohort Cloak +1",
		hands="Leyline Gloves",
		ring1="Acumen Ring",
		back="Toro Cape",
		--waist="Yamabuki-no-Obi",
		--legs="Limbo Trousers",
		legs=gear.Herculean_legs_Magic,
		feet="Adhemar Gamashes"
	})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- 80% STR, crit chance varies with TP
	sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
		head=gear.Adhemar_head_B,
		ear2="Odr Earring",
		body="Ken. Samue +1",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		waist="Moonbow Belt",
		legs="Ken. Hakama +1",
		back=gear.Segomo_dex_da,
		feet="Mpaca's Boots",
	})
	sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS.Acc, {
	})
	sets.precast.WS["Victory Smite"].SomeAcc = set_combine(sets.precast.WS["Victory Smite"], {})

	sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
		--head=gear.Rao_head_hq_B,
		head="Mpaca's Cap",
		ear2="Odr Earring",
		neck="Caro Necklace",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		back=gear.Segomo_dex_da,
		legs="Jokushu Haidate",
		feet="Mpaca's Boots",
	})
	sets.precast.WS['Shijin Spiral'].Acc = set_combine(sets.precast.WS.Acc, {
	})
	sets.precast.WS['Shijin Spiral'].SomeAcc = set_combine(sets.precast.WS['Shijin Spiral'], {
	})

	sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Asuran Fists'].Acc = set_combine(sets.precast.WS.Acc, {
	})
	sets.precast.WS['Asuran Fists'].SomeAcc = set_combine(sets.precast.WS['Asuran Fists'], {
	})

	sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS.Acc, {
	})
	sets.precast.WS["Ascetic's Fury"].SomeAcc = set_combine(sets.precast.WS["Ascetic's Fury"], {
	})

	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS.MAB,{
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
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		--back="Moonbeam Cape",
		back="Mecisto. Mantle",
		waist="Moonbow Belt",
		legs="Malignance Tights",
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


	-- DT: 57% PDT: 5% MDT: 10%
	sets.idle.PDT = set_combine(sets.idle,{
		-- DT 6%
		head="Malignance Chapeau",
		-- MDT 2%
		ear1="Odnowa Earring +1",
		-- MDT 3%
		ear2="Etiolation Earring",
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
		-- DT 5%
		waist="Moonbow Belt",
		-- DT 7%
		legs="Malignance Tights",
		-- DT 4%
		feet="Malignance Boots"
	})

	-- DT: 57% PDT: 5% MDT: 10%
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.idle.MDT = set_combine(sets.idle, {
		-- DT 6%
		head="Malignance Chapeau",
		-- MDT 2%
		ear1="Odnowa Earring +1",
		-- MDT 3%
		ear2="Etiolation Earring",
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
		-- DT 5%
		waist="Moonbow Belt",
		-- DT 7%
		legs="Malignance Tights",
		-- DT 4%
		feet="Malignance Boots"
	})
	
	-- Defense sets
	sets.defense.PDT = set_combine(sets.idle.PDT, {
	})

	sets.defense.HP = set_combine(sets.idle, {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Malignance Tights",
		feet="Malignance Boots"
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

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee sets
	sets.engaged = {
		ammo="Ginsen",
		--head=gear.Adhemar_head_B,
		head="Dampening Tam",
		neck="Moonbeam Nodowa",
		ear1="Sherida Earring",
		ear2="Dedition Earring",
		body="Ken. Samue +1",
		hands="Tatena. Gote +1",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.Segomo_dex_da,
		waist="Moonbow Belt",
		legs="Ken. Hakama +1",
		feet="Malignance Boots",
	}
	sets.engaged.SomeAcc = set_combine(sets.engaged,{
		ear2="Telos Earring",
		body="Tatena. Harama. +1",
	})
	sets.engaged.Acc = set_combine(sets.engaged,{
		ammo="Falcon Eye",
		head="Malignance Chapeau",
		body="Tatena. Harama. +1",
		ear1="Digni. Earring",
		ear2="Telos Earring",
		ring2="Cacoethic Ring +1",
		back=gear.Segomo_dex_da,
	})

	-- Defensive melee hybrid sets
	sets.engaged.PDT = set_combine(sets.engaged,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Moonbow Belt",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	sets.engaged.SomeAcc.PDT = set_combine(sets.engaged.SomeAcc,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Moonbow Belt",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		waist="Moonbow Belt",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	sets.engaged.Counter = set_combine(sets.engaged,{
		legs="Anch. Hose +1",
		feet="Mel. Gaiters +1"
	})
	sets.engaged.Acc.Counter = set_combine(sets.engaged.Acc,{
		legs="Anch. Hose +1",
		feet="Mel. Gaiters +1"
	})

	-- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
	sets.impetus_body = {body="Bhikku Cyclas +1"}
	sets.footwork_kick_feet = {feet="Anch. Gaiters +1"}

	-- Hundred Fists/Impetus melee set mods
	sets.engaged.HF = set_combine(sets.engaged)
	sets.engaged.HF.Impetus = set_combine(sets.engaged, {
		body="Bhikku Cyclas +1"
	})
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc)
	sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc, {
		body="Bhikku Cyclas +1"
	})
	sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
	sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {
		body="Bhikku Cyclas +1"
	})
	sets.engaged.Acc.Counter.HF = set_combine(sets.engaged.Acc.Counter)
	sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, {
		body="Bhikku Cyclas +1"
	})


	-- Footwork combat form
	sets.engaged.Footwork = set_combine(sets.engaged,{
		feet="Anch. Gaiters +1"
	})
	sets.engaged.Footwork.Acc = set_combine(sets.engaged.Acc,{
		feet="Anch. Gaiters +1"
	})

	sets.buff.Boost = {
		waist="Ask Sash",
	}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
    -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
    
    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()
        
        if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            classes.CustomMeleeGroups:append('HF')
        end
        
        if (buff == "Impetus" and gain) or buffactive.impetus then
            classes.CustomMeleeGroups:append('Impetus')
        end
    end

    if buff == "Boost" then
    	equip(sets.buff.Boost)
    end

    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" or buff == "Boost" then
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