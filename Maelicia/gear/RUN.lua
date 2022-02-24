-- Setup vars that are user-independent.
function job_setup()
	-- Table of entries
	rune_timers = T{}
	-- entry = rune, index, expires
	
	if player.main_job_level >= 65 then
		max_runes = 3
	elseif player.main_job_level >= 35 then
		max_runes = 2
	elseif player.main_job_level >= 5 then
		max_runes = 1
	else
		max_runes = 0
	end

	state.CP = M(false, "Capacity Points Mode")
	state.Warp = M(false, "Warp Mode")
	state.Neck = M(false, "Neck Mode")
	state.TreasureMode = M(false, 'TH')
	state.EngagedDT = M(false, 'Engaged Damage Taken Mode')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
	state.OffenseMode:options('Normal', 'Ailments', 'Hybrid', 'Melee', 'MeleeMidAcc', 'MeleeAcc')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'Acc', 'PDT')
	state.PhysicalDefenseMode:options('PDT', 'MDT', 'Ailments', 'Charm')
	state.IdleMode:options('Normal', 'DT', 'Refresh', 'Regain', 'Regen')

	state.PartyAlertMode = M('true', 'false')

	--gear.aug_ogma_dt = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Damage taken-5%',}}
	gear.aug_ogma_dt = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Magic dmg. taken-10%',}}
	gear.aug_ogma_dex_da = { name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}}
	gear.aug_ogma_ws = { name="Ogma's Cape", augments={}}
	gear.aug_ogma_fc = { name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10',}}

	select_default_macro_book()

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
	send_command("bind @p gs equip sets.midcast['Phalanx']; input /echo --- Phalanx set on ---") -- WindowKey'P'

	send_command('bind @c gs c toggle CP') --WindowKey'C'
	send_command('bind @h gs c toggle TreasureMode') --Windowkey'H'
	send_command('bind @n gs c toggle Neck') --Windowkey'N'
	send_command('bind @r gs c toggle Warp') --Windowkey'R'

	global_aliases()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind @p')

	send_command('unbind @c')
	send_command('unbind @h')
	send_command('unbind @n')
	send_command('unbind @r')
end

function init_gear_sets()
	sets.enmity = {
		-- 2 Enmity
		--ammo="Sapience Orb",
		-- 8 Enmity
		head="Halitus helm",
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
		head="Nyame Helm",
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		body="Nyame Mail",
		hands=gear.Carmine_hands_hq_D,
		ring1="Acumen Ring",
		--ring2="Arvina Ringlet +1",
		ring2="Mujin Band",
		back="Toro Cape",
		waist="Eschan Stone",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}

	-- Defense sets
	-- DT: 56%
	-- PDT: 9% (11% with Alber Strap)
	-- MDT: 12%
	-- Eva: 497
	-- Meva: 704
	-- Ailment resist: 11
	sets.DT = {
		-- DT 3% Ailment 11
		ammo="Staunch Tathlum +1",
		-- DT 7% Eva 91 Meva 123
		head="Nyame Helm",
		-- DT 6%
		neck="Futhark Torque +1",
		-- MDT 2%
		ear1="Odnowa earring +1",
		ear2="Ethereal earring",
		-- DT 9% Eva 69 Meva 84
		--body="Futhark Coat +3",
		-- DT 9% Eva 102 Meva 139
		body="Nyame Mail",
		-- DT 3% Eva 19 Meva 37
		--hands="Aya. Manopolas +2",
		-- DT 2% Eva 44 Meva 57
		--hands="Kurys Gloves",
		-- DT 7% Eva 80 Meva 112
		hands="Nyame Gauntlets",
		-- PDT 5% MDT 5%
		ring1="Dark Ring",
		-- DT 10%
		ring2="Defending Ring",
		-- MDT 10% Eva 20 Meva 30
		back=gear.aug_ogma_dt,
		-- PDT 4%
		waist="Audumbla Sash",
		-- 5% PDT Eva 58 Meva 99 Ailment 10
		--legs="Rune. Trousers +3",
		-- DT 7% Eva 85 Meva 150
		legs="Nyame Flanchard",
		-- PDT 4% Eva 77 Meva 107 Ailment 15
		--feet="Ahosi Leggings",
		-- DT 7% Eva 119 Meva 150
		feet="Nyame Sollerets",
	}
	-- Defense sets
	-- DT: 31%
	-- PDT: 18% (20% with Alber Strap)
	-- MDT: 15%
	-- Eva: 295
	-- Meva: 428
	-- Ailment resist: 47
	sets.Ailments = set_combine(sets.DT, {
		-- 11
		ammo="Staunch Tathlum +1",
		-- 5
		ear1="Hearty Earring",
		-- 39 Elemental Resist
		body="Runeist's coat +3",
		-- 6
		hands="Erilaz Gauntlets +1",
		-- 10 5% PDT
		legs="Rune. Trousers +3",
		-- 15 4% PDT
		feet="Ahosi Leggings",
	})
	-- 24
	sets.Charm = set_combine(sets.DT, {
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
	sets.precast.JA['Pflug'] = {feet="Runeist's Boots +2"} 
	sets.precast.JA['Battuta'] = {head="Fu. Bandeau +3"}
	sets.precast.JA['Liement'] = {body="Futhark Coat +3"}
	sets.precast.JA['Gambit'] = {hands="Runeist's Mitons +2"} 
	sets.precast.JA['Rayke'] = {feet="Futhark Boots +1"} 
	sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat +3"} 
	sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +1"} 
	sets.precast.JA['Embolden'] = {back="Evasionist's cape"} 
	-- Divine Magic Skill
	-- Tenebrae restores MP, rest of runes restores HP
	sets.precast.JA['Vivacious Pulse'] = {
		head="Erilaz galea +1",
		neck="Incanter's Torque",
		ring1="Stikini Ring +1",
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
		-- 75 HP
		hands="Runeist's Mitons +2",
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
		-- 64 HP
		feet="Runeist's Boots +2"
	}
		
	sets.precast.JA['Provoke'] = set_combine(sets.enmity,{
	})
	
	sets.precast.JA['Lunge'] = set_combine(sets.MAB,{
		-- MBD 7%
		body="Nyame Mail",
		-- MBD 5%
		hands="Nyame Gauntlets",
	})
	
	sets.precast.JA['Swipe'] = set_combine(sets.MAB,{
		-- MBD 7%
		body="Nyame Mail",
		-- MBD 5%
		hands="Nyame Gauntlets",
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
	-- 68/34
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
		-- 8%
		feet="Carmine greaves +1",
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

	-- Cannot exceed 80/40 FC cap in combination with FC
	sets.precast.FC.Cure = set_combine(sets.precast.FC['Healing Magic'], {
		-- 5%
		ear2="Mendi. Earring",
		-- 15%
		legs="Doyen Pants",
	})

	-- Weaponskill sets
	sets.precast.WS = {
		ammo="Knobkierrie",
		head=gear.Adhemar_head_hq_B,
		neck="Fotia Gorget",
		--ear1="Brutal Earring",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body=gear.Adhemar_body_hq_B,
		hands="Meg. Gloves +2",
		ring1="Niqmaddu Ring",
		ring2="Epona Ring",
		back=gear.aug_ogma_dex_da,
		waist="Fotia Belt",
		legs="Meg. Chausses +2",
		feet="Nyame Sollerets",
	}
	sets.precast.WS.MaxTP = {
		--ear2="Crep. Earring",
		ear2="Ishvara Earring",
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
		head="Nyame Helm",
		neck="Fotia Gorget",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		--waist="Fotia Belt",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})

	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS,{
	})
	sets.precast.WS['Resolution'].MidAcc = set_combine(sets.precast.WS['Resolution'], {
		--head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		ring2="Regal Ring",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].MidAcc, {
		ammo="Yamarang",
	})
 
	-- 80% DEX, damage varies with TP
	sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS,{
		ammo="Knobkierrie",
		head="Nyame Helm",
		neck="Fotia Gorget",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body=gear.Adhemar_body_hq_B,
		hands="Meg. Gloves +2",
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.aug_ogma_dex_da,
		waist="Sailfi Belt +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Dimidiation'].MidAcc = set_combine(sets.precast.WS['Dimidiation'], {
	})
	sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'].MidAcc, {
	})
	-- DT 43%
	-- PDT 4%
	sets.precast.WS['Dimidiation'].PDT = set_combine(sets.precast.WS['Dimidiation'], {
		-- DT 7%
		head="Nyame Helm",
		-- DT 6%
		neck="Futhark Torque +1",
		-- PDT 4%
		hands="Meg. Gloves +2",
		-- DT 5%
		back=gear.aug_ogma_dex_da,
		-- DT 10%
		ring2="Defending Ring",
		-- DT 8%
		legs="Nyame Flanchard",
		-- DT 7%
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Dimidiation'].MDT = set_combine(sets.precast.WS['Dimidiation'].PDT, {
	})
	sets.precast.WS['Dimidiation'].Ailments = set_combine(sets.precast.WS['Dimidiation'].PDT, {
	})
	sets.precast.WS['Dimidiation'].Charm = set_combine(sets.precast.WS['Dimidiation'].PDT, {
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
	
	-- 26% Haste
	sets.midcast.FastRecast = set_combine(sets.DT, {
		--hands="Turms Mittens +1",
		--hands="Kurys Gloves",
		hands="Nyame Gauntlets",
		back=gear.aug_ogma_dt,
		-- SIRD 10%
		waist="Audumbla Sash",
		--legs="Eri. Leg Guards +1",
		-- SIRD 20%
		legs="Carmine cuisses +1",
		--feet="Turms leggings",
	})

	sets.midcast.SIRD = {
		-- SIRD 11%
		ammo="Staunch Tathlum +1",
		-- SIRD 10%
		waist="Audumbla Sash",
		-- SIRD 20%
		legs="Carmine cuisses +1",
		-- SIRD 10%
		feet=gear.Taeon_SIRD_feet,
	}

	-- 388 Base (RUN: B-, Lv. 99)
	-- 16 (Merits)
	-- 36 (Gifts)
	-- 63 Gear
	-- 503 Total
	sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.FastRecast, {
		-- 11
		--head="Carmine Mask +1",
		-- 10
		neck="Incanter's Torque",
		-- 5
		ear1="Andoaa Earring",
		-- 17
		hands="Runeist's Mitons +2",
		-- 8
		ring1="Stikini Ring +1",
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
	
	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], sets.TaeonPhalanx, {
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
	sets.midcast['Aquaveil'] = set_combine(sets.midcast.EnhancingDuration, sets.midcast.SIRD,{
		neck="Futhark Torque +1",
		hands="Nyame Gauntlets",
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
		hands="Nyame Gauntlets",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back=gear.aug_ogma_dt,
		waist="Audumbla Sash",
		legs="Carmine cuisses +1",
		feet="Nyame Sollerets",
	}

	sets.noprotect = {ring1="Sheltered Ring"}

	sets.idle.Town = set_combine(sets.idle, {
		body="Councilor's Garb",
	})

	sets.idle.DT = set_combine(sets.DT, {
	})

	sets.idle.Refresh = set_combine(sets.idle, {
		ammo="Homiliary",
		head="Rawhide mask",
		body="Runeist's coat +3",
		waist="Fucho-no-obi"
	})

	sets.idle.Regain = set_combine(sets.idle, {
		head="Turms Cap",
	})

	sets.idle.Regen = set_combine(sets.idle, {
		neck="Bathy Choker +1",
		ring1="Sheltered Ring",
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
		ammo="Crepuscular Pebble",
		head="Fu. Bandeau +3",
		ear2="Sherida earring",
		hands="Turms Mittens +1",
		back=gear.aug_ogma_dex_da,
		waist="Ioskeha Belt +1",
		legs="Meg. Chausses +2",
	})
		 
	-- Use Duplus Grip
	sets.engaged.Melee = {
		ammo="Yamarang",
		head=gear.Adhemar_head_hq_B,
		neck="Anu Torque",
		ear1="Telos Earring",
		ear2="Sherida earring",
		body=gear.Adhemar_body_hq_B,
		hands=gear.Adhemar_hands_hq_B,
		ring1="Niqmaddu Ring",
		ring2="Epona's Ring",
		back=gear.aug_ogma_dex_da,
		waist="Ioskeha Belt +1",
		legs="Samnuha tights",
		feet="Aya. Gambieras +2",
	}

	-- Use Utu Grip
	sets.engaged.MeleeMidAcc = set_combine(sets.engaged.Melee, {
		neck="Lissome Necklace",
		--body="Meg. Cuirie +2",
		--hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
	})
	
	-- Use Utu Grip
	sets.engaged.MeleeAcc = set_combine(sets.engaged.MeleeMidAcc, {
		head="Rune. Bandeau +3",
		neck="Subtlety Spec.",
		ear2="Crep. Earring",
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
	if spell.type == 'WeaponSkill' then
		if (spell.target.model_size + spell.range * 1.642276421172564) < spell.target.distance then	
			add_to_chat(7,"--- Target "..spell.target.type.." ["..player.target.name.."] out of range of ["..spell.name.."] [ Distance: "..spell.target.distance.."] ---")
			cancel_spell()
		end
	end

	-- alert for missing buffs
	if state.OffenseMode.value == 'Normal' or
		state.OffenseMode.value == 'Ailments' or
		state.OffenseMode.value == 'Hybrid' then
		state.CombatWeapon:set(player.equipment.range)

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
		if not buffactive['Ice Spikes'] and not buffactive['Shock Spikes'] then
			add_to_chat(122,"--- [Ice Spikes or Shock Spikes] x ---")
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

	if state.TreasureMode.value ~= false then
		equip(sets.sharedTH)
	end
	
	if state.DefenseMode.value ~= 'None' and spell.type == 'WeaponSkill' then
		-- Don't gearswap for weaponskills when Defense is active.
		eventArgs.handled = true
	end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then        
		-- Replace Moonshade Earring if we're at cap TP
		if player.tp >= 2750 then
			equip(sets.precast.WS.MaxTP)
		end
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
			send_command('@input /p <------ Doomed ---- <call14>')
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

	if state.Neck.current == 'on' then
		equip(sets.Neck)
		disable('neck')
	else
		enable('neck')
	end

	if state.TreasureMode.current == 'on' then
		meleeSet = set_combine(meleeSet, sets.sharedTH)
	end

	return meleeSet
end