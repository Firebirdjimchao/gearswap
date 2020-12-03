-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
	state.OffenseMode:options('Normal', 'Ailments', 'Hybrid', 'Melee', 'MeleeMidAcc', 'MeleeAcc')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'Acc')
	state.PhysicalDefenseMode:options('PDT', 'MDT', 'Ailments', 'Charm')
	state.IdleMode:options('Regen', 'Refresh')

	state.PartyAlertMode = M('true', 'false')

	--gear.aug_ogma_dt = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}}
	gear.aug_ogma_dt = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Magic dmg. taken-10%',}}
	gear.aug_ogma_dex_da = { name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}
	gear.aug_ogma_ws = { name="Ogma's Cape", augments={}}
	gear.aug_ogma_fc = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}}

	select_default_macro_book()

	global_aliases()
end


function init_gear_sets()
	sets.enmity = {
		-- 2 Enmity
		--ammo="Sapience Orb",
		-- 6 Enmity
		head="Rabid Visor",
		-- 8 Enmity
		--head="Halitus helm",
		-- 10 Enmity
		--neck="Unmoving Collar +1",
		-- 7 Enmity
		neck="Futhark Torque +1",
		-- 4 Enmity
		ear1="Cryptic Earring",
		-- 5 Enmity
		ear2="Trux Earring",
		-- 10 Enmity
		body="Emet Harness +1",
		-- 9 Enmity
		hands="Kurys Gloves",
		-- 5 Enmity
		ring1="Supershear Ring",
		-- 5 Enmity
		ring2="Pernicious Ring",
		-- 10 Enmity
		back=gear.aug_ogma_dt,
		-- 3 Enmity
		waist="Goading Belt",
		-- 11 Enmity
		legs="Eri. Leg Guards +1",
		-- 7 Enmity
		feet="Ahosi Leggings"
	}

	sets.MAB = {
		ammo="Seeth. Bomblet +1",
		head=gear.Herculean_head_Magic,
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		body=gear.Herculean_body_Magic,
		hands="Leyline Gloves",
		ring1="Acumen Ring",
		ring2="Arvina Ringlet +1",
		back="Toro Cape",
		waist="Eschan Stone",
		legs=gear.Herculean_legs_Magic,
		feet="Adhemar Gamashes"
	}

	-- Defense sets
	-- PDT 2% (Alber Strap)
	--
	-- PDT: 50% (52% with Alber Stap)
	-- MDT: 50%
	-- Eva: 295
	-- Meva: 428
	-- Ailment resist: 26
	sets.DT = {
		-- DT 3% Ailment 11
		ammo="Staunch Tathlum +1",
		-- MDT 4% Eva 41 Meva 43
		head="Dampening Tam",
		-- DT 6%
		neck="Futhark Torque +1",
		-- MDT 2%
		ear1="Odnowa earring +1",
		ear2="Ethereal earring",
		-- DT 9% Eva 69 Meva 84
		body="Futhark Coat +3",
		-- DT 3% Eva 19 Meva 37
		--hands="Aya. Manopolas +2",
		-- DT 2% Eva 44 Meva 57
		--hands="Kurys Gloves",
		hands="Turms Mittens +1",
		-- PDT 5% MDT 5%
		ring1="Dark Ring",
		-- DT 10%
		ring2="Defending Ring",
		-- MDT 10% Eva 20 Meva 30
		back=gear.aug_ogma_dt,
		-- PDT 4%
		waist="Flume Belt +1",
		-- DT 5%  Eva 24 Meva 69
		--legs="Aya. Cosciales +2",
		-- PDT 7% Eva 44 Meva 107
		legs="Eri. Leg Guards +1",
		-- PDT 4% Eva 77 Meva 107 Ailment 15
		feet="Ahosi Leggings",
	}
	-- Ailment resist: 47
	sets.Ailments = set_combine(sets.DT, {
		-- 11
		ammo="Staunch Tathlum +1",
		-- 5
		ear1="Hearty Earring",
		body="Runeist's coat +3",
		-- 6
		hands="Erilaz Gauntlets +1",
		-- 10
		legs="Rune. Trousers +3",
		-- 15
		feet="Ahosi Leggings",
	})
	-- 24
	sets.Charm = set_combine(sets.Ailments, {
		-- 9
		neck="Unmoving Collar +1",
		-- 15
		back="Solemnity Cape",
	})

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Vallation'] = {body="Runeist's coat +3",legs="Futhark Trousers +3"} 
	sets.precast.JA['Valiance'] = sets.precast.JA['Vallation'] 
	sets.precast.JA['Pflug'] = {feet="Runeist bottes +1"} 
	sets.precast.JA['Battuta'] = {head="Fu. Bandeau +3"}
	sets.precast.JA['Liement'] = {body="Futhark Coat +3"}
 	sets.precast.JA['Gambit'] = {hands="Runeist mitons +1"} 
	sets.precast.JA['Rayke'] = {feet="Futhark Bottes +1"} 
	sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat +3"} 
	sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +1"} 
	sets.precast.JA['Embolden'] = {back="Evasionist's cape"} 
	-- Divine Magic Skill
	-- Tenebrae restores MP, rest of runes restores HP
	sets.precast.JA['Vivacious Pulse'] = {
		head="Erilaz galea +1",
		neck="Incanter's Torque",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		legs="Rune. Trousers +3",
	}

	sets.precast.JA['One For All'] = {
		-- 10 HP
		--ammo="Falcon eye",
		-- 109 HP
		head="Rune. Bandeau +3",
		-- 33 HP
		neck="Futhark Torque +1",
		-- 100 HP (from MP conversion)
		ear1="Odnowa earring +1",
		-- 50 HP
		ear2="Etiolation Earring",
		-- 100 HP (from MP conversion)
		--ear2="Odnowa earring",
		-- 218 HP
		body="Runeist's coat +3",
		-- 74 HP
		hands="Turms Mittens +1",
		-- 60 HP
		ring1="Ilabrat Ring",
		-- 50 HP
		ring2="Regal ring",
		-- 250 HP
		back="Moonbeam cape",
		-- 20 HP
		waist="Eschan Stone",
		-- 55 HP
		--waist="Oneiros belt",
		-- 107 HP
		legs="Futhark Trousers +3",
		-- 43 HP
		feet="Runeist bottes +1"
	}
		
	sets.precast.JA['Provoke'] = set_combine(sets.enmity,{
	})
	
	sets.precast.JA['Lunge'] = set_combine(sets.MAB,{
	})
	
	sets.precast.JA['Swipe'] = set_combine(sets.MAB,{
	})

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Rune. Bandeau +3",
		body="Runeist's coat +3",
		hands="Meg. Gloves +2",
		ring1="Dark Ring",
		ring2="Sirona's Ring",
		back="Tantalic Cape",
		waist="Chaac Belt",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
	}
			
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	-- 64/32
	sets.precast.FC = {
		--ammo="Impatiens",
		-- 14%
		head="Rune. Bandeau +3",
		-- 4%
		neck="Voltsurge Torque",
		-- 2%
		ear1="Loquac. Earring",
		-- 1%
		ear2="Etiolation Earring",
		-- 4% + 5%
		body="Taeon Tabard",
		-- 5% + 3%
		hands="Leyline Gloves",
		-- 2%
		ring1="Prolix Ring",
		-- 4%
		ring2="Kishar Ring",
		-- 10%
		back=gear.aug_ogma_fc,
		-- 6%
		legs="Aya. Cosciales +2",
		-- 4%
		feet="Chelona Boots",
		-- 8%
		--feet="Carmine greaves +1",
	}
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash", 
		legs="Futhark Trousers +3"
	})
	sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {neck='Magoraga beads'})
	sets.precast.FC['Utsusemi: Ni'] = set_combine(sets.precast.FC['Utsusemi: Ichi'], {})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
		legs="Doyen Pants",
	})

	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
	})

	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		ear2="Mendi. Earring",
		back="Pahtli Cape",
		waist="Acerbic Sash +1",
		legs="Doyen Pants",
	})

	-- Weaponskill sets
	sets.precast.WS = {
		ammo="Knobkierrie",
		head=gear.Adhemar_head_B,
		neck="Fotia Gorget",
		--ear1="Brutal Earring",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body=gear.Adhemar_body_B,
		hands="Meg. Gloves +2",
		ring1="Niqmaddu Ring",
		ring2="Epona Ring",
		back=gear.aug_ogma_dex_da,
		waist="Fotia Belt",
		legs="Meg. Chausses +2",
		feet=gear.Adhemar_feet_B
	}
	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		ring2="Regal Ring",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS.Acc = set_combine(sets.precast.WS.MidAcc, {
	})
	sets.precast.WS.MAB = set_combine(sets.MAB, {
		neck="Fotia Gorget",
		--waist="Fotia Belt",
	})

	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,{
	})
	sets.precast.WS['Resolution'].MidAcc = set_combine(sets.precast.WS['Resolution'], {
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		ring2="Regal Ring",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].MidAcc, {
		ammo="Yamarang",
	})
 
	sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS,{
		head="Dampening Tam",
		body=gear.Herculean_body_WS,
		legs="Lustr. Subligar +1",
		feet="Lustra. Leggings +1"
	})
	sets.precast.WS['Dimidiation'].MidAcc = set_combine(sets.precast.WS['Dimidiation'], {
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		ring2="Regal Ring",
	})
	sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'].MidAcc, {
	})
		
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Sanguine Blade'].MidAcc = set_combine(sets.precast.WS['Sanguine Blade'], {
	})
	sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'].MidAcc, {
	})
 
	sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Herculean Slash'].MidAcc = set_combine(sets.precast.WS['Herculean Slash'], {
	})
	sets.precast.WS['Herculean Slash'].Acc = set_combine(sets.precast.WS['Herculean Slash'].MidAcc, {
	})

	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
	sets.midcast.FastRecast = set_combine(sets.DT, {
		hands="Turms Mittens +1",
		back=gear.aug_ogma_dt,
		legs="Eri. Leg Guards +1",
		--feet="Turms leggings",
	})

	-- 406 (RUN: B-, Lv. 99)
	-- 16 (Merits)
	-- 36 (Gifts)
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
		-- 11
		--head="Carmine Mask +1",
		-- 10
		neck="Incanter's Torque",
		-- 5
		ear1="Andoaa Earring",
		-- 15
		hands="Runeist Mitons +1",
		-- 5
		ring1="Stikini Ring",
		-- 5
		ring2="Stikini Ring",
		-- 5
		--back="Merciful Cape",
		-- 5
		--waist="Olympus Sash",
		-- 18
		legs="Carmine Cuisses +1",
	})

	-- 20 (Gifts)
	sets.midcast.EnhancingDuration = set_combine(sets.midcast['Enhancing Magic'], {
		-- 15 DUR
		head="Erilaz galea +1",
		-- 20 DUR
		--hands="Regal Gauntlets",
		-- 30 DUR
		legs="Futhark Trousers +3"
	})

	sets.midcast['Temper'] = set_combine(sets.midcast['Enhancing Magic'], {
	})
	
	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
	})
	
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
		head="Fu. Bandeau +3",
	})
		
	sets.midcast['Stoneskin'] = set_combine(sets.midcast['Enhancing Magic'], {
		ear1="Earthcry Earring",
		waist="Siegel Sash",
		legs="Haven Hose"
	})
	
	sets.midcast['Regen'] = set_combine(sets.midcast.EnhancingDuration, {
		head="Rune. Bandeau +3"
	})		
	sets.midcast['Refresh'] = set_combine(sets.midcast.EnhancingDuration, {
		waist="Gishdubar Sash"
	})

	sets.midcast['Healing Magic'] = set_combine(sets.enmity, {})
	sets.midcast.Cure = set_combine(sets.midcast['Headling Magic'], {
		ear1="Mendi. Earring",
		body="Vrikodara Jupon",
	})

 	sets.midcast['Divine Magic'] = set_combine(sets.enmity, {})
 	sets.midcast['Elemental Magic'] = set_combine(sets.enmity, {})
 	sets.midcast['Enfeebing Magic'] = set_combine(sets.enmity, {})
 	sets.midcast['Dark Magic'] = set_combine(sets.enmity, {})
 	sets.midcast['Foil'] = set_combine(sets.enmity, {})
	sets.midcast['Blue Magic'] = set_combine(sets.enmity, {})
	sets.midcast['Wild Carrot'] = set_combine(sets.midcast.Cure, {})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	sets.idle = {
		--ammo="Staunch Tathlum +1",
		ammo="Homiliary",
		head="Rawhide mask",
		neck="Futhark Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Ethereal Earring",
		body="Runeist's coat +3",
		hands="Meg. Gloves +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back=gear.aug_ogma_dt,
		waist="Flume Belt +1",
		legs="Carmine cuisses +1",
		feet="Aya. Gambieras +2",
	}

	sets.noprotect = {ring1="Sheltered Ring"}

	sets.idle.Town = set_combine(sets.idle, {
		body="Councilor's Garb",
	})

	sets.idle.Refresh = set_combine(sets.idle, {
		body="Runeist's coat +3",
		waist="Fucho-no-obi"
	})

	sets.idle.PDT = set_combine(sets.DT, {
	})
	sets.idle.MDT = set_combine(sets.DT, {
	})
				   
	sets.defense.PDT = set_combine(sets.DT, {
	})
	sets.defense.MDT = set_combine(sets.DT, {
	})
	sets.defense.Ailments = set_combine(sets.Ailments, {
	})
	sets.defense.Charm = set_combine(sets.Charm, {
	})

	sets.Kiting = set_combine(sets.DT, {
		legs="Carmine cuisses +1",
	})


	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = set_combine(sets.DT, {
		hands="Turms Mittens +1",
	})
 
	sets.engaged.Ailments = set_combine(sets.Ailments, {
	})
		
	sets.engaged.Hybrid = set_combine(sets.DT, {
		head="Fu. Bandeau +3",
		ear2="Sherida earring",
		back=gear.aug_ogma_dex_da,
		waist="Ioskeha belt",
		legs="Meg. Chausses +2",
	})
		 
	-- Use Duplus Grip
	sets.engaged.Melee = {
		ammo="Yamarang",
		head=gear.Adhemar_head_B,
		neck="Anu Torque",
		ear1="Telos Earring",
		ear2="Sherida earring",
		body=gear.Adhemar_body_B,
		hands=gear.Adhemar_hands_B,
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back=gear.aug_ogma_dex_da,
		waist="Ioskeha belt",
		legs="Samnuha tights",
		feet="Aya. Gambieras +2",
	}

	-- Use Utu Grip
	sets.engaged.MeleeMidAcc = set_combine(sets.engaged.Melee, {
		head="Dampening Tam",
		neck="Lissome Necklace",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
	})
	
	-- Use Utu Grip
	sets.engaged.MeleeAcc = set_combine(sets.engaged.MeleeMidAcc, {
		head="Rune. Bandeau +3",
		neck="Subtlety Spec.",
		ear2="Digni. Earring",
		ring1="Cacoethic ring +1",
		ring2="Regal Ring",
		waist="Eschan Stone",
		legs="Rune. Trousers +3",
		feet="Meg. Jam. +2",
	})

end

--------------------------------------
-- Custom buff sets
--------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	-- alert for missing buffs
	if state.OffenseMode.value == 'Normal' or
		state.OffenseMode.value == 'Ailments' or
		state.OffenseMode.value == 'Hybrid' then
		state.CombatWeapon:set(player.equipment.range)

		if not buffactive['Runes'] or buffactive['Runes'] < 3 then
			add_to_chat(122,"--- [Runes Count] less than 3 ---")
		end

		if not buffactive['Aquaveil'] then
			add_to_chat(122,"--- [Aquaveil] x ---")
		end
		if not buffactive['Enmity Boost'] then
			add_to_chat(122,"--- [Crusade] x ---")
		end
		if not buffactive['Foil'] then
			add_to_chat(122,"--- [Foil] x ---")
		end
		if not buffactive['Refresh'] then
			add_to_chat(122,"--- [Refresh] x ---")
		end
		if not buffactive['Phalanx'] then
			add_to_chat(122,"--- [Phalanx] x ---")
		end
		if not buffactive['Ice Spikes'] then
			add_to_chat(122,"--- [Ice Spikes] x ---")
		end

		if player.sub_job == 'BLU' then
			if not buffactive['Cocoon'] then
				add_to_chat(122,"--- [Cocoon] x ---")
			end
		end
	end

	if player.sub_job == 'DRK' then
		if not buffactive['Last Resort'] then
			add_to_chat(122,"--- [Last Resort] x ---")
		end
	end

	if not buffactive['Multi Strikes'] then
		add_to_chat(122,"--- [Temper] x ---")
	end
	
	if state.DefenseMode.value ~= 'None' and spell.type == 'WeaponSkill' then
		-- Don't gearswap for weaponskills when Defense is active.
		eventArgs.handled = true
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(2, 18)
	elseif player.sub_job == 'NIN' then
		set_macro_page(3, 18)
	elseif player.sub_job == 'SAM' then
		set_macro_page(4, 18)
	elseif player.sub_job == 'DNC' then
		set_macro_page(5, 18)
	elseif player.sub_job == 'DRK' then
		set_macro_page(6, 18)
	elseif player.sub_job == 'BLM' then
		set_macro_page(6, 18)
	else -- BLU
		set_macro_page(1, 18)
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
		if state.PartyAlertMode.value == 'true' then
			if state.Buff.Doom then
				send_command('input /p <------ Doomed ---- <call14>')
			end
		end
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.Buff.Doom then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
		if state.PartyAlertMode.value == 'true' then
			if state.Buff.Doom then
				send_command('input /p <------ Doomed ---- <call14>')
			end
		end
	end
	return meleeSet
end

function customize_defense_set(defenseSet)
	if state.Buff.Doom then
		defenseSet = set_combine(defenseSet, sets.buff.Doom)
		if state.PartyAlertMode.value == 'true' then
			if state.Buff.Doom then
				send_command('input /p <------ Doomed ---- <call14>')
			end
		end
	end
	return defenseSet
end