-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job. Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function job_setup()
	state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
	state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false

	state.CP = M(false, "Capacity Points Mode")
	state.Warp = M(false, "Warp Mode")
	state.Weapon = M(false, "Weapon Lock")
	state.Neck = M(false, "Neck Mode")
	state.TreasureMode = M(false, 'TH')
	state.EngagedDT = M(false, 'Engaged Damage Taken Mode')
end

-- Setup vars that are user-dependent. Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('None', 'Normal')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT', 'MDT')
	gear.default.obi_waist = "Sacro Cord"

	-- Default macro set/book
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
	send_command('bind @c gs c toggle CP') --WindowKey'C'
	send_command('bind @e gs c toggle EngagedDT') --Windowkey'E'
	send_command('bind @h gs c toggle TreasureMode') --Windowkey'H'
	send_command('bind @n gs c toggle Neck') --Windowkey'N'
	send_command('bind @r gs c toggle Warp') --Windowkey'R'
	send_command('bind @w gs c toggle Weapon') --Windowkey'W'

	global_aliases()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
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
	-- Start defining the sets
	--------------------------------------

	sets.Nyame = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}

	-- Precast Sets

	-- Fast cast sets for spells
	
	-- 79%/39% + 1%~3% Total (80/40 cap) + 15% (if RDM sub)
	sets.precast.FC = {
		-- 6%
		main="Gada",
		sub="Genmei Shield",
		--ammo="Impatiens",
		-- 10%
		head="Nahtirah Hat",
		-- 4%
		neck="Voltsurge Torque",
		-- 2%
		ear1="Loquacious Earring",
		-- 4%
		ear2="Malignance Earring",
		-- 14%
		body="Inyanga Jubbah +2",
		-- 7%
		hands="Fanatic Gloves",
		-- 2%
		ring1="Prolix Ring",
		-- 4%
		ring2="Kishar Ring",
		-- 8%
		back="Fi Follet Cape +1",
		-- 3%
		--waist="Witful Belt",
		-- 5%
		waist="Embla Sash",
		-- 5%
		--legs="Lengo Pants",
		-- 6%
		legs="Aya. Cosciales +2",
		-- 4% + 1%~3%
		feet="Regal Pumps +1"
	}
	
	-- Cannot exceed 80/40 FC cap in combination with FC
	sets.precast.FC['Healing Magic'] = set_combine(sets.precast.FC, {
		-- 13%
		legs="Ebers Pant. +1"
	})
	
	-- Cannot exceed 80/40 FC cap in combination with FC
	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		main="Queller Rod",
		sub="Genmei Shield",
		head="Theo. Cap +1",
		-- 5%
		ear1="Mendi. Earring",
		ear2="Nourish. Earring +1",
		-- 13%
		legs="Ebers Pant. +1",
		-- 7%
		feet=gear.Vanya_feet_B
	})
	
	sets.precast.FC.StatusRemoval = sets.precast.FC['Healing Magic']

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"
	})

	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
		head="Umuthi Hat",
		hands="Carapacho Cuffs",
		legs="Doyen Pants",
	})
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head=empty,
		body="Twilight Cloak"
	})

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak"})
	
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	sets.precast.FC.CureSolace = sets.precast.FC.Cure
	-- CureMelee spell map should default back to Healing Magic.
	
	-- Precast sets to enhance JAs
	sets.precast.JA.Benediction = {
		body="Piety Bliaut +1"
	}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Theo. Cap +1",
		ear1="Roundel Earring",
		body="Vrikodara Jupon",
		hands="Inyan. Dastanas +2",
		legs="Gyve Trousers",
		feet="Chironic Slippers"
	}
	
	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	gear.default.weaponskill_neck = "Fotia Gorget"
	gear.default.weaponskill_waist = "Fotia Belt"
	sets.precast.WS = {
		head="Blistering Sallet +1",
		neck=gear.default.weaponskill_neck,
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		ring1="Rajas Ring",
		ring2="K'ayres Ring",
		back="Aurist's Cape +1",
		waist=gear.default.weaponskill_waist,
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
	}
	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		head="Nyame Helm",
		--neck="Sanctity Necklace",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Shamash Robe",
		hands="Nyame Gauntlets",
		ring1="Freke Ring",
		ring2="Strendu Ring",
		back="Toro Cape",
		--waist="Yamabuki-no-Obi",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	
	sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS,{
	})
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS,{
	})
	
	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS.MAB,{
	})
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS.MAB,{
	})

	-- Midcast Sets
	
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		-- 2% DT
		ammo="Staunch Tathlum +1",
		-- 8 MDB 5% MDT
		head="Inyanga Tiara +2",
		-- 6% DT
		neck="Loricate Torque +1",
		-- 3% MDT
		ear1="Etiolation Earring",
		-- 2% MDT
		ear2="Odnowa Earring +1",
		-- 11 MDB 7% MDT
		body="Inyanga Jubbah +2",
		-- 5 MDB 4% MDT
		hands="Inyan. Dastanas +2",
		-- 5% PDT, 5% MDT
		ring1="Dark Ring",
		-- 10% DT
		ring2="Defending Ring",
		-- 5% DT
		back="Moonbeam Cape",
		-- 9 MDB 6% MDT
		legs="Inyanga Shalwar +2",
		-- 8 MDB 3% MDT
		feet="Inyan. Crackows +2"
	})
		
	sets.midcast.MACC = {
		--main=gear.MaccStaff,
		--sub="Enki Strap",
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		range="Aureole",
		head="Chironic Hat",
		neck="Incanter's Torque",
		ear1="Crep. Earring",
		ear2="Malignance Earring",
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		--hands="Theophany Mitts +3",
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
		back="Aurist's Cape +1",
		waist="Luminary Sash",
		legs="Chironic Hose",
		feet="Inyan. Crackows +2"
	}
	
	sets.midcast.MAB = {
		--main=gear.MaccStaff,
		--sub="Enki Strap",
		--main="Daybreak",
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		ammo="Ombre Tathlum +1",
		head="Chironic Hat",
		neck="Sanctity Necklace",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Shamash Robe",
		hands=gear.Chironic_hands_nuke,
		ring1="Freke Ring",
		ring2="Strendu Ring",
		back=gear.ElementalCape,
		waist=gear.ElementalObi,
		legs="Chironic Hose",
		feet="Chironic Slippers"
	}
		
	-- Cure sets
	gear.default.obi_waist = "Luminary Sash"
	gear.default.obi_back = "Mending Cape"
		
	sets.midcast['Healing Magic'] = {
		main="Divinity",
		sub="Ammurapi Shield",
		head="Hyksos Khat",
		neck="Incanter's Torque",
		body="Ebers Bliaud +1",
		hands="Inyan. Dastanas +2",
		ring1="Menelaus's Ring",
		ring2="Sirona's Ring",
		back="Mending Cape",
		waist="Luminary Sash",
		legs="Piety Pantaln. +3",
		feet=gear.Vanya_feet_B
	}

	-- 52% (+3%~4%)+ 4% II Total
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'],{
		-- 10% 2% II
		main="Queller Rod",
		sub="Ammurapi Shield",
		-- 16%
		head="Ebers Cap +1",
		neck="Incanter's Torque",
		-- 5%
		-- neck="Nodens Gorget",
		-- 2% II
		ear1="Glorious Earring",
		-- 3% Unity: 3%~4%
		ear2="Nourish. Earring +1",
		body="Ebers Bliaud +1",
		-- 11%
		hands=gear.Kaykaus_hands_hq_A,
		-- 5%
		ring1="Menelaus's Ring",
		back="Aurist's Cape +1",
		waist=gear.ElementalObi,
		legs="Ebers Pant. +1",
		-- 5%
		feet=gear.Vanya_feet_B
	})
	
	-- 52% (+3%~4%)+ 4% II Total + 4% Afflatus Solace (2 x 2 JP)
	sets.midcast.CureSolace = set_combine(sets.midcast.Cure,{
		-- 14% Afflatus Solace
		body="Ebers Bliaud +1",
		-- 10% Afflatus Solace
		back="Alaunus's Cape"
	})

	sets.midcast.Curaga = set_combine(sets.midcast.Cure,{
		head="Hyksos Khat",
		ear1="Glorious Earring",
		ear2="Malignance Earring",
		-- 13%
		body="Vrikodara Jupon",
		back="Mending Cape",
	})

	sets.midcast.CureMelee = set_combine(sets.midcast.Cure,{
	})
	sets.midcast.CureSelf = set_combine(sets.midcast.Cure,{
		waist="Gishdubar Sash",
	})

	sets.midcast.Cursna = set_combine(sets.midcast['Healing Magic'],{
		-- +10
		neck="Malison Medallion",
		-- +15
		hands="Fanatic Gloves",
		-- +20
		ring1="Menelaus's Ring",
		-- +15
		ring2="Haoma's Ring",
		-- +25
		back="Alaunus's Cape",
		-- +15
		legs="Theo. Pant. +1",
		-- +10
		feet="Gende. Galosh +1"
	})
	sets.midcast.CursnaSelf = set_combine(sets.midcast.Cursna,{
		waist="Gishdubar Sash",
	})

	sets.midcast.StatusRemoval = set_combine(sets.midcast['Healing Magic'],{
		head="Ebers Cap +1",
		legs="Ebers Pant. +1"
	})

	-- 378 Base
	-- 16 merits
	-- 109 gear
	-- 507 Total
	-- 39% DUR
	sets.midcast['Enhancing Magic'] = {
		-- 18
		main="Gada",
		-- 10% DUR
		sub="Ammurapi Shield",
		-- 16
		head="Befouled Crown",
		-- 10
		neck="Incanter's Torque",
		ear1="Regal Earring",
		-- 5
		ear2="Andoaa Earring",
		-- 12 10% DUR
		body=gear.Telchine_body_pet,
		-- 18 5% DUR
		--hands="Dynasty Mitts",
		-- 9% DUR
		hands=gear.Telchine_hands_pet,
		-- 5
		ring1="Stikini Ring",
		-- 8
		ring2="Stikini Ring +1",
		-- 10
		back="Mending Cape",
		-- 10% DUR
		waist="Embla Sash",
		-- 8% DUR
		legs=gear.Telchine_legs_pet,
		-- 26
		--legs="Piety Pantaln. +3",
		-- 25
		feet="Ebers Duckbills +1"
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],{
		neck="Nodens Gorget",
		ear1="Earthcry Earring",
		waist="Siegel Sash",
		legs="Haven Hose"
	})

	sets.midcast.Auspice = {
		main="Gada",
		-- 10% DUR
		sub="Ammurapi Shield",
		-- 10% DUR
		body=gear.Telchine_body_pet,
		-- 5% DUR
		--hands="Dynasty Mitts",
		-- 9% DUR
		hands=gear.Telchine_hands_pet,
		-- 10% DUR
		waist="Embla Sash",
		-- 8% DUR
		legs=gear.Telchine_legs_pet,
		feet="Ebers Duckbills +1"
	}

	sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'],{
		--main="Serenity",
		main="Beneficus",
		sub="Ammurapi Shield",
		head="Ebers Cap +1",
		body="Ebers Bliaud +1",
		hands="Ebers Mitts +1",
		legs="Piety Pantaln. +3",
		feet="Ebers Duckbills +1"
	})
				
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{
		main="Bolelabunga",
		sub="Genmei Shield",
		head="Inyanga Tiara +2",
		body="Piety Bliaut +1",
		hands="Ebers Mitts +1",
		legs="Theo. Pant. +1"
	})
	
	sets.midcast.RefreshSelf = set_combine(sets.midcast['Enhancing Magic'],{
		waist="Gishdubar Sash",
		feet="Inspirited Boots"
	})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],{
		head="Chironic Hat",
		hands="Regal Cuffs",
	})

	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'],{
		ring1="Sheltered Ring",
	})

	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'],{
		ring1="Sheltered Ring",
	})

	sets.midcast.Erase = set_combine(sets.midcast['Enhancing Magic'],{
		neck="Cleric's Torque",
	})

	sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAB,{
		ring2="Stikini Ring +1",
		legs="Theo. Pant. +1"
	})

	sets.midcast.Banish = set_combine(sets.midcast['Divine Magic'],{
		--hands="Fanatic Gloves",
		hands="Piety Mitts +3",
	})

	sets.midcast['Dark Magic'] = set_combine(sets.midcast.MACC,{
		neck="Erra Pendant",
		hands="Inyan. Dastanas +2",
		--ring1="Stikini Ring +1",
		ring1="Metamor. Ring +1",
		ring2="Evanescence Ring",
	})

	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
	})
	
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		neck="Erra Pendant",
		ring2="Evanescence Ring",
		waist="Fucho-no-Obi",
	})
	
	sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.MACC,{
		head="Befouled Crown",
		neck="Incanter's Torque",
		body="Vanya Robe",
		--hands="Inyan. Dastanas +2",
		hands="Regal Cuffs",
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		ring2="Kishar Ring",
		--ring2="Stikini Ring +1",
		--waist="Rumination Sash",
		legs="Chironic Hose",
		feet="Skaoi Boots",
	})
	
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast.MAB,{
	})
	
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{
		body="Shamash Robe",
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
	})
			
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

	-- Custom spell classes
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'],{
	})

	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'],{
	})
		
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = set_combine(sets.sharedResting,{
	})

	-- Idle sets
	sets.idle = {
		main="Queller Rod",
		sub="Genmei Shield",
		--ammo="Staunch Tathlum +1",
		ammo="Homiliary",
		head="Befouled Crown",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
		body="Shamash Robe",
		hands="Nyame Gauntlets",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Fucho-no-Obi",
		legs="Lengo Pants",
		feet="Herald's Gaiters"
	}
	
	sets.noprotect = {ring1="Sheltered Ring"}

	-- PDT: 48%
	-- MDT: 58%
	-- MDB: 41 
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.idle.DT = set_combine(sets.idle,{
		-- 20% DT
		main=gear.Staff.DT,
		-- 2% DT
		ammo="Staunch Tathlum +1",
		-- 8 MDB 5% MDT
		head="Inyanga Tiara +2",
		-- 6% DT
		neck="Loricate Torque +1",
		-- 3% MDT
		ear1="Etiolation Earring",
		-- 2% MDT
		ear2="Odnowa Earring +1",
		-- 11 MDB 7% MDT
		body="Inyanga Jubbah +2",
		-- 5 MDB 4% MDT
		hands="Inyan. Dastanas +2",
		-- 5% PDT, 5% MDT
		ring1="Dark Ring",
		-- 10% DT
		ring2="Defending Ring",
		-- 5% DT
		back="Moonbeam Cape",
		-- 9 MDB 6% MDT
		legs="Inyanga Shalwar +2",
		-- 8 MDB 3% MDT
		feet="Inyan. Crackows +2"
	})

	sets.idle.PDT = set_combine(sets.idle.DT,{
	})
	sets.idle.MDT = set_combine(sets.idle.DT,{
	})
	
	sets.idle.Town = set_combine(sets.idle, {
		body="Councilor's Garb",
		hands="Regal Cuffs",
	})
	
	sets.idle.Weak = set_combine(sets.idle,{
	})
	
	sets.idle.Regen = set_combine(sets.idle,{
		neck="Bathy Choker +1",
		ring1="Sheltered Ring"
	})
		
	-- Defense sets

	sets.defense.PDT = set_combine(sets.idle.PDT,{
	})

	sets.defense.MDT = set_combine(sets.idle.MDT,{
	})

	sets.Kiting = {feet="Herald's Gaiters"}

	sets.latent_refresh = {waist="Fucho-no-obi"}

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.	Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Basic set for if no TP weapon is defined.
	sets.engaged = {
		head="Blistering Sallet +1",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Telos Earring",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		ring1="Rajas Ring",
		ring2="Petrov Ring",
		back="Aurist's Cape +1",
		waist="Goading Belt",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
	}

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff['Divine Caress'] = {
		hands="Ebers Mitts +1",
		back="Mending Cape"
	}

	-- not combining these with any specific engaged sets so it can 
	-- automatically combine with whichever current engaged set you are using
	sets.engaged.TH = set_combine(sets.sharedTH,{
	})
	sets.engaged.DT = set_combine(sets.Nyame,{
	})

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(stateField, newValue, oldValue)
	if state.Weapon.value == true then
		disable('main','sub','range','ammo')
	else
		enable('main','sub','range','ammo')
	end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
	if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
		equip(sets.buff['Divine Caress'])
	elseif spell.skill == 'Enhancing Magic' then
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
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
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

	if state.Weapon.current == 'on' then
		disable('main','sub')
	else
		enable('main','sub')
	end

	if state.Neck.current == 'on' then
		equip(sets.Neck)
		disable('neck')
	else
		enable('neck')
	end

	if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end

	if not buffactive['Protect'] then
		idleSet = set_combine(idleSet, sets.noprotect)
	end

	return idleSet
end

function customize_melee_set(meleeSet)
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

	if state.Weapon.current == 'on' then
		disable('main','sub')
	else
		enable('main','sub')
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
		meleeSet = set_combine(meleeSet, sets.engaged.TH)
	end

	return meleeSet
end