-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job. Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent. Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('None', 'Normal')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT')

	state.WeaponLock = M(false, 'Weapon Lock')

	set_macro_page(1, 2)

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
	send_command('bind !` gs c toggle WeaponLock; input /echo --- Weapons Lock ---')

	global_aliases()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind !`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Precast Sets

	-- Fast cast sets for spells
	
	--80%/40% Total (80/40 cap) + 15% (if RDM sub) 
	sets.precast.FC = {
		-- 4%
		main=gear.default.fastcast_staff,
		ammo="Impatiens",
		-- 10%
		head="Nahtirah Hat",
		-- 4%
		--neck="Baetyl Pendant",
		-- 6%
		neck="Cleric's Torque",
		-- 2%
		ear1="Loquacious Earring",
		-- 4%
		ear2="Malignance Earring",
		-- 14%
		body="Inyanga Jubbah +2",
		-- 7%
		hands="Gendewitha Gages",
		-- 4%
		ring1="Kishar Ring",
		-- 5%
		ring2="Weather. Ring",
		-- 10%
		back="Alaunus's Cape",
		-- 3%
		--waist="Witful Belt",
		-- 5%
		waist="Embla Sash",
		-- 5%
		--legs="Lengo Pants",
		-- 6%
		legs="Aya. Cosciales +2",
		-- 3% + 1%~3%
		feet="Regal Pumps +1"
	}
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head=empty,
		body="Twilight Cloak"
	})
			
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"
	})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
		head="Umuthi Hat"
	})

	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
		main="Divinity",
		legs="Ebers Pant. +1"
	})

	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		main="Queller Rod",
		sub="Culminus",
		head="Theo. Cap +2",
		ear1="Nourish. Earring +1",
		ear2="Mendi. Earring",
		legs="Ebers Pant. +1",
		feet=gear.Vanya_feet_B
	})
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC.CureSolace = sets.precast.FC.Cure
	-- CureMelee spell map should default back to Healing Magic.
	
	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = {
		body="Piety Briault +3"
	}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Theo. Cap +2",
		ear1="Roundel Earring",
		body="Count's Garb",
		hands="Dynasty Mitts",
		legs="Chironic Hose",
		feet="Aya. Gambieras +2",
	}
	
	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	gear.default.weaponskill_neck = "Asperity Necklace"
	gear.default.weaponskill_waist = "Windbuffet Belt +1"
	sets.precast.WS = {
		head="Blistering Sallet +1",
		neck=gear.default.weaponskill_neck,
		--neck=gear.ElementalGorget,
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Count's Garb",
		hands="Dynasty Mitts",
		ring1="Rajas Ring",
		ring2="Cacoethic Ring",
		back="Aurist's Cape +1",
		waist=gear.default.weaponskill_waist,
		--waist=gear.ElementalBelt,
		legs="Telchine Braconi",
		feet="Aya. Gambieras +2",
	}
	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		head="Buremte Hat",
		neck="Baetyl Pendant",
		ear1="Friomisi Earring",
		ear2="Malignance Earring",
		body="Count's Garb",
		hands="Otomi Gloves",
		ring1="Acumen Ring",
		ring2="Arvina Ringlet +1",
		back="Toro Cape",
		waist=gear.ElementalObi,
		legs=gear.Chironic_legs_nuke,
		feet=gear.Chironic_feet_nuke,
	})
	
	sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS,{
		neck=gear.ElementalGorget,
	})
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS,{
		neck=gear.ElementalGorget,
	})
	
	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS.MAB,{
	})
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS.MAB,{
	})

	-- Midcast Sets
	
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		head="Nahtirah Hat",
		ear1="Loquacious Earring",
		body="Inyanga Jubbah +2",
		back="Swith Cape",
		waist="Embla Sash",
		feet="Regal Pumps +1"
	});

	sets.midcast.MACC = {
		main=gear.MainStaff,
		sub="Enki Strap",
		range="Aureole",
		head="Theophany Cap +2",
		neck="Erra Pendant",
		ear1="Hermetic Earring",
		ear2="Malignance Earring",
		body="Theo. Briault +2",
		--hands="Inyan. Dastanas +2",
		hands="Theophany Mitts +2",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back="Aurist's Cape +1",
		waist="Luminary Sash",
		--legs="Chironic Hose",
		legs="Th. Pant. +3",
		feet="Theo. Duckbills +2",
	}
	
	sets.midcast.MAB = {
		main=gear.MainStaff,
		--sub="Niobid Strap",
		sub="Enki Strap",
		ammo="Ghastly Tathlum",
		head="Buremte Hat",
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Malignance Earring",
		body="Count's Garb",
		hands="Otomi Gloves",
		ring1="Acumen Ring",
		ring2="Arvina Ringlet +1",
		back="Toro Cape",
		waist=gear.ElementalObi,
		legs=gear.Chironic_legs_nuke,
		feet=gear.Chironic_feet_nuke,
	}
		
	-- Cure sets
	gear.default.obi_waist = "Luminary Sash"
	gear.default.obi_back = "Mending Cape"
		
	sets.midcast['Healing Magic'] = {
		main="Divinity",
		sub="Culminus",
		head="Hyksos Khat",
		neck="Incanter's Torque",
		body="Ebers Bliaud +1",
		hands="Inyan. Dastanas +2",
		ring1="Sirona's Ring",
		ring2="Ephedra Ring",
		back="Mending Cape",
		waist="Luminary Sash",
		legs="Piety Pantaln. +1",
		feet=gear.Vanya_feet_B
	}

	-- 47% + 4% II Total + 10% gift
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'],{
		-- 10% + 2% II
		main="Queller Rod",
		sub="Culminus",
		-- 16%
		head="Ebers Cap +1",
		-- 2% II
		ear1="Glorious Earring",
		-- 3%
		--ear2="Nourish. Earring +1",
		ear2="Malignance Earring",
		body="Ebers Bliaud +1",
		-- 16%
		hands=gear.Telchine_hands_cure,
		-- 2% II
		--hands="Theophany Mitts +2",
		waist=gear.ElementalObi,
		legs="Ebers Pant. +1",
		-- 5%
		feet=gear.Vanya_feet_B
	})
	
	-- 31% + 4% II Total + 10% gift + 28% Afflatus Solace (2 x 14 JP)
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure,{
		-- 14% Afflatus Solace
		body="Ebers Bliaud +1",
		hands="Inyan. Dastanas +2",
		-- 10% Afflatus Solace
		back="Alaunus's Cape"
	})

	sets.midcast.Curaga = set_combine(sets.midcast.Cure,{
		body="Annoint. Kalasiris"
	})
	sets.midcast.CureSelf = set_combine(sets.midcast.Cure,{
		waist="Gishdubar Sash",
	})

	sets.midcast.CureMelee = set_combine(sets.midcast.Cure,{
	})

	sets.midcast.Cursna = set_combine(sets.midcast['Healing Magic'],{
		neck="Malison Medallion",
		hands="Fanatic Gloves",
		ring1="Ephedra Ring",
		ring2="Ephedra Ring",
		back="Alaunus's Cape",
		legs="Th. Pant. +3",
		feet="Gende. Galoshes"
	})
	sets.midcast.CursnaSelf = set_combine(sets.midcast.Cursna,{
		waist="Gishdubar Sash",
	})

	sets.midcast.StatusRemoval = set_combine(sets.midcast['Healing Magic'],{
		head="Ebers Cap +1",
		legs="Ebers Pant. +1"
	})
				
	sets.midcast['Enhancing Magic'] = {
		--main="Ababinili +1",
		-- 5 DUR
		main="Grioavolr",
		sub="Enki Strap",
		head="Befouled Crown",
		neck="Incanter's Torque",
		--ear2="Andoaa Earring",
		body="Telchine Chas.",
		hands="Dynasty Mitts",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		waist="Embla Sash",
		back="Fi Follet Cape +1",
		legs="Piety Pantaln. +1",
		feet="Ebers Duckbills +1"
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],{
		neck="Stone Gorget",
		ear1="Earthcry Earring",
		waist="Siegel Sash",
		legs="Haven Hose",
	})

	sets.midcast.Auspice = {
		hands="Dynasty Mitts",
		feet="Ebers Duckbills +1"
	}

	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],{
		head="Ebers Cap +1",
		body="Ebers Bliaud +1",
		hands="Ebers Mitts +1",
		legs="Piety Pantaln. +1",
		feet="Ebers Duckbills +1"
	})
				
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{
		main="Bolelabunga",
		sub="Culminus",
		head="Inyanga Tiara +2",
		body="Piety Briault +3",
		hands="Ebers Mitts +1",
		legs="Th. Pant. +3"
	})

	sets.midcast.RefreshSelf = set_combine(sets.midcast['Enhancing Magic'],{
		waist="Gishdubar Sash",
		feet="Inspirited Boots",
	})

	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'],{
	})

	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'],{
	})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],{
		main="Vadose Rod"
	})

	sets.midcast.Erase = set_combine(sets.midcast['Enhancing Magic'],{
		neck="Cleric's Torque",
	})

	sets.midcast['Divine Magic'] = set_combine(sets.midcast.MACC,{
		neck="Incanter's Torque",
		--neck="Imbodla Necklace",
		hands="Piety Mitts",
		ring2="Weather. Ring",
	})

	sets.midcast['Banish*'] = set_combine(sets.midcast.MAB,{
		ring2="Weather. Ring",
	})

	sets.midcast['Holy*'] = set_combine(sets.midcast.MAB,{
		ring2="Weather. Ring",
	})

	sets.midcast['Dark Magic'] = set_combine(sets.midcast.MACC,{
		neck="Erra Pendant",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
	})

	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.MACC,{
		sub="Enki Strap",
		head="Befouled Crown",
		neck="Incanter's Torque",
		ring1="Kishar Ring",
		--ring1="Stikini Ring",
		ring2="Stikini Ring",
		waist="Rumination Sash",
		legs="Chironic Hose"
	})

	-- Custom spell classes
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'],{
	})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'],{
	})
		
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = set_combine(sets.sharedResting,{
	})

	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		main="Bolelabunga",
		sub="Culminus",
		ammo="Homiliary",
		head="Befouled Crown",
		neck="Twilight Torque",
		ear1="Ethereal Earring",
		ear2="Etiolation Earring",
		body="Piety Briault +3",
		hands="Inyan. Dastanas +2",
		ring1=gear.DarkRing.physical,
		ring2="Defending Ring",
		--back="Moonbeam Cape",
		back="Mecisto. Mantle",
		waist="Fucho-no-Obi",
		legs="Lengo Pants",
		feet="Herald's Gaiters"
		--feet="Inyan. Crackows +2"
	}

	-- Total: 35% + 20% (DT Staff)
	-- <36%: use Shadow Mantle
	sets.idle.PDT = set_combine(sets.idle,{
		main=gear.Staff.DT,
		sub="Enki Strap",
		-- 2%
		ammo="Staunch Tathlum",
		-- 3%
		head="Blistering Sallet +1",
		-- 5%
		neck="Twilight Torque",
		ear1="Ethereal Earring",
		ear2="Etiolation Earring",
		-- 6%
		body="Ayanmo Corazza +2",
		hands="Inyan. Dastanas +2",
		-- 4%
		ring1=gear.DarkRing.physical,
		-- 10%
		ring2="Defending Ring",
		-- 5%
		back="Moonbeam Cape",
		legs="Inyanga Shalwar +2",
		feet="Inyan. Crackows +2"
	})
	
	-- MDT: 54%
	-- MDB: 41
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.idle.MDT = set_combine(sets.idle,{
		main=gear.Staff.DT,
		sub="Enki Strap",
		-- 2%
		ammo="Staunch Tathlum",
		-- 5% 8
		head="Inyanga Tiara +2",
		-- 5%
		neck="Twilight Torque",
		ear1="Ethereal Earring",
		-- 3%
		ear2="Etiolation Earring",
		-- 8% 11
		body="Inyanga Jubbah +2",
		-- 4% 5
		hands="Inyan. Dastanas +2",
		-- 3%
		ring1=gear.DarkRing.physical,
		-- 10%
		ring2="Defending Ring",
		-- 5%
		back="Moonbeam Cape",
		-- 6% 9
		legs="Inyanga Shalwar +2",
		-- 3% 8
		feet="Inyan. Crackows +2"
	})
	
	sets.idle.Town = set_combine(sets.idle,{
		body="Councilor's Garb"
	})
	
	sets.idle.Weak = set_combine(sets.idle,{
	})
		
	-- Defense sets

	sets.defense.PDT = set_combine(sets.idle.PDT,{
	})

	sets.defense.MDT = set_combine(sets.idle.MDT,{
	})

	sets.Kiting = {feet="Herald's Gaiters"}

	sets.latent_refresh = {waist="Fucho-no-obi"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.	Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Basic set for if no TP weapon is defined.
	sets.engaged = {
		ammo="Amar Cluster",
		head="Aya. Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		ring1="Rajas Ring",
		ring2="Cacoethic Ring",
		back="Moonbeam Cape",
		waist="Cetl Belt",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2"
	}

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Divine Caress'] = {
		hands="Ebers Mitts +1",
		back="Mending Cape"
	}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(stateField, newValue, oldValue)
	if state.WeaponLock.value == true then
		disable('main','sub','range','ammo')
	else
		enable('main','sub','range','ammo')
	end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Enhancing Magic' then
		if spellMap == 'Refresh' and spell.target.type == 'SELF' then
			equip(sets.midcast.RefreshSelf)
		end
	elseif spellMap == 'Cursna' and spell.target.type == 'SELF' then
		equip(sets.midcast.CursnaSelf)
	elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
		equip(sets.midcast.CureSelf)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if pet.isvalid then
		idleSet = set_combine(idleSet, sets.idle.Pet)
	elseif not buffactive['Protect'] then
		idleSet = set_combine(idleSet, sets.noprotect)
	elseif not pet.isvalid and (player.mpp < 51) then
		idleSet = set_combine(idleSet, sets.latent_refresh)
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