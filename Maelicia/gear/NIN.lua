-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
	state.OffenseMode:options('Normal', 'Low', 'Mid', 'Acc')
	state.HybridMode:options('Normal', 'PDT')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Low', 'Mid', 'Acc')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.CastingMode:options('Normal', 'Resistant')
	state.TreasureMode:set('None')

	gear.RegularAmmo = 'Togakushi Shuriken'
	--gear.RegularAmmo = 'Seki Shuriken'
	gear.SangeAmmo = 'Happo Shuriken'

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
	send_command('bind ^= gs c cycle treasuremode')
	send_command('bind != gs c toggle CapacityMode')
	send_command('bind @` gs c cycle HasteMode')
	send_command('bind @[ gs c cycle Runes')
	send_command('bind ^] gs c toggle UseRune')

	global_aliases()
end


function file_unload()
	send_command('unbind ^=')
	send_command('unbind !=')
	send_command('unbind @`')
	send_command('unbind @[')
	send_command('unbind ^]')
end


-- Define sets and vars used by this job file.
-- visualized at http://www.ffxiah.com/node/194 (not currently up to date 10/29/2015)
-- Happo
-- Hachiya
-- sets.engaged[state.CombatForm][state.CombatWeapon][state.OffenseMode][state.HybridMode][classes.CustomMeleeGroups (any number)

-- Ninjutsu tips
-- To stick Slow (Hojo) lower earth resist with Raiton: Ni
-- To stick poison (Dokumori) or Attack down (Aisha) lower resist with Katon: Ni
-- To stick paralyze (Jubaku) lower resistence with Huton: Ni

function init_gear_sets()
	--------------------------------------
	-- Augments
	--------------------------------------
	Andartia = {}
	Andartia.DEX = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10',}}
	Andartia.AGI = { name="Andartia's Mantle", augments={'AGI+20','Accuracy+20 Attack+20','AGI+10','Weapon skill damage +10%',}}

	--------------------------------------
	-- Job Abilties
	--------------------------------------
	sets.precast.JA['Mijin Gakure'] = { legs="Mochi. Hakama +1" }
	sets.precast.JA['Futae'] = { hands="Hattori Tekko +1" }
	sets.precast.JA['Provoke'] = { 
		-- 10 Enmity
		neck="Unmoving Collar +1",
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
		-- 7 Enmity
		feet="Ahosi Leggings"
	}
	sets.precast.JA.Sange = { ammo=gear.SangeAmmo, body="Mochi. Chainmail +3" }

	-- Waltz (chr and vit)
	sets.precast.Waltz = {
		head="Malignance Chapeau",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
		ring1="Dark Ring",
		ring2="Sirona's Ring",
		back="Tantalic Cape",
		waist="Chaac Belt",
		--legs="Hiza. Hizayoroi +2",
		legs="Mochi. Hakama +3",
		--feet="Hiza. Sune-Ate +2",
		--feet="Rawhide Boots",
		feet="Malignance Boots",
	}
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	sets.precast.Waltz.Self = set_combine(sets.precast.Waltz,{
		head="Mummu Bonnet +2",
	})
	-- Set for acc on steps, since Yonin drops acc a fair bit
	sets.precast.Step = {
		head="Malignance Chapeau",
		neck="Moonbeam Nodowa",
		body="Malignance Tabard",
		ear1="Digni. Earring",
		ear2="Telos Earring",
		hands="Malignance Gloves",
		ring1="Patricius Ring",
		ring2="Cacoethic Ring +1",
		back=Andartia.DEX,
		waist="Eschan Stone",
		legs="Malignance Tights",
		--legs="Herculean Trousers",
		feet="Malignance Boots"
	}
	sets.midcast.Trust =  set_combine(sets.defense.Evasion,{
	})
	sets.midcast["Apururu (UC)"] = set_combine(sets.midcast.Trust, {
		body="Apururu Unity shirt",
	})
	sets.Warp = { ring1="Warp Ring" }

	--------------------------------------
	-- Utility Sets for rules below
	--------------------------------------
	sets.TreasureHunter = {
		head="Wh. Rarab Cap +1",
		waist="Chaac Belt",
	}
	sets.CapacityMantle = { back="Mecistopins Mantle" }
	sets.WSDayBonus	 = { head="Gavialis Helm" }
	sets.WSBack		 = { back="Trepidity Mantle" }
	sets.BrutalLugra	= { ear1="Cessance Earring", ear2="Lugra Earring +1" }
	sets.BrutalTrux	 = { ear1="Cessance Earring", ear2="Trux Earring" }
	sets.BrutalMoon	 = { ear1="Brutal Earring", ear2="Moonshade Earring" }

	sets.RegularAmmo	= { ammo=gear.RegularAmmo }
	sets.SangeAmmo	  = { ammo=gear.SangeAmmo }

	sets.NightAccAmmo   = { ammo="Yamarang" }
	sets.DayAccAmmo	 = { ammo="Yamarang" }

	--------------------------------------
	-- Ranged
	--------------------------------------

	sets.precast.RA = {
		head="Uk'uxkaj Cap",
		hands="Buremte Gloves",
		-- 6% SS
		ring1="Haverton Ring",
		-- 9% SS + 10% RS
		legs=gear.Adhemar_legs_D,
		feet="Wurrukatte Boots"
	}
	sets.midcast.RA = {
		head=gear.Herculean_head_RA,
		neck="Iskur Gorget",
		ear1="Enervating Earring",
		ear2="Telos Earring",
		--body=gear.Herculean_body_RA,
		body="Mochi. Chainmail +3",
		--hands="Hachiya Tekko +1",
		hands="Malignance Gloves",
		ring1="Haverton Ring",
		--ring2="Cacoethic Ring +1",
		ring1="Dingir Ring",
		back="Yokaze Mantle",
		waist="Yemaya Belt",
		legs=gear.Herculean_legs_RA,
		feet=gear.Herculean_feet_RA
	}
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
	})
	sets.midcast.RA.TH = set_combine(sets.midcast.RA, set.TreasureHunter)

	-- Fast cast sets for spells
	sets.precast.FC = {
		--ammo="Impatiens",
		head="Herculean Helm",
		neck="Voltsurge Torque",
		ear1="Loquac. Earring",
		ear2="Etiolation Earring",
		body="Taeon Tabard",
		hands="Leyline Gloves",
		ring1="Prolix Ring",
		ring2="Kishar Ring",
		--legs="Gyve Trousers",
		legs=gear.Herculean_legs_Magic,
	}
	sets.precast.FC.Ninjutsu = set_combine(sets.precast.FC, {})
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { neck="Magoraga Beads", body="Mochi. Chainmail +3" })
	sets.precast.FC.Monomi = {
    hands="Mochizuki Tekko +3",
  }

	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		--ammo="Impatiens",
		back="Grounded Mantle +1",
		ear1="Loquacious Earring",
		ring1="Prolix Ring",
	})

	-- MACC & skill ++ 
	sets.midcast.Ninjutsu = {
		ammo="Yamarang",
		--head="Hachi. Hatsu. +1",
		head=gear.Herculean_head_Magic,
		ear1="Digni. Earring",
		ear2="Hermetic Earring",
		neck="Incanter's Torque",
		body="Malignance Tabard",
		--hands="Mochizuki Tekko +3",
		hands="Malignance Gloves",
		--ring1="Haverton Ring",
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring",
		back="Yokaze Mantle",
		waist="Eschan Stone",
		legs="Malignance Tights",
		feet="Mochi. Kyahan +3",
	}
	-- any ninjutsu cast on self
	sets.midcast.SelfNinjutsu = set_combine(sets.midcast.Ninjutsu, {
		hands="Mochizuki Tekko +3",
	})
	sets.midcast.Utsusemi = set_combine(sets.midcast.Ninjutsu, {
		hands="Mochizuki Tekko +3", 
		back=Andartia.AGI,
		feet="Hattori Kyahan +1",
	})
	sets.midcast.Migawari = set_combine(sets.midcast.Ninjutsu, {
		body="Hattori Ningi +1",
		-- Migawari +5, not Mikage +5 (translation error)
		back=Andartia.AGI,
	})

	-- Nuking Ninjutsu (skill & magic attack)
	sets.midcast.ElementalNinjutsu = {
		ammo="Pemphredo Tathlum",
		--head="Mummu Bonnet +2",
		head=gear.Herculean_head_Magic,
		--head="Mochi. Hatsuburi +1",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		neck="Sanctity Necklace",
		--neck="Incanter's Torque",
		body=gear.Herculean_body_Magic,
		--hands="Hattori Tekko +1",
		hands="Leyline Gloves",
		back="Toro Cape",
		ring1="Acumen Ring",
		ring2="Dingir Ring",
		waist="Eschan Stone",
		legs=gear.Herculean_legs_Magic,
		--feet="Adhemar Gamashes",
		feet="Mochi. Kyahan +3",
	}

	sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ear1="Digni. Earring",
		ear2="Hermetic Earring",
		back="Yokaze Mantle",
		legs="Malignance Tights",
		feet="Mochi. Kyahan +3",
	})

	sets.magic_burst = set_combine(sets.midcast.ElementalNinjutsu, {
		hands="Hattori Tekko +1",
		ring1="Mujin Band",
		waist=gear.ElementalObi,
		--"Hachiya Kyahan +2",
	})

	-- Effusions
	sets.precast.Effusion = {}
	sets.precast.Effusion.Lunge = sets.midcast.ElementalNinjutsu
	sets.precast.Effusion.Swipe = sets.midcast.ElementalNinjutsu

	sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		--body="Mekosu. Harness",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		--back="Shadow Mantle",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Malignance Tights",
		feet="Danzo Sune-ate"
	}

	sets.noprotect = {ring1="Sheltered Ring"}

	sets.idle.Regen = set_combine(sets.idle, {
		head="Rao Kabuto +1",
		neck="Bathy Choker +1",
		--body="Hiza. Haramaki +2",
		ring1="Sheltered Ring"
	})
	sets.Adoulin = {
		body="Councilor's Garb",
	}
	sets.idle.Town = set_combine(sets.idle, {
	})
	--sets.idle.Town.Adoulin = set_combine(sets.idle.Town, {
	--	body="Councilor's Garb"
	--})
	
	sets.idle.Weak = sets.idle

	-- Defense sets
	sets.defense.PDT = {
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Patricius Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Malignance Tights",
		feet="Malignance Boots"
	}

	sets.defense.MDT = set_combine(sets.defense.PDT, {
		head="Malignance Chapeau",
		--neck="Inq. Bead Necklace",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Malignance Tights",
		feet="Malignance Boots"
	})

	sets.DayMovement = {feet="Danzo sune-ate"}
	sets.NightMovement = {feet="Hachiya Kyahan +1"}

	-- Normal melee group without buffs
	-- DW needed: 39
	sets.engaged = {
		ammo=gear.RegularAmmo,
		head=gear.Ryuo_head_A,
		neck="Moonbeam Nodowa",
		ear1="Brutal Earring",
		ear2="Suppanomimi",
		body="Mochi. Chainmail +3",
		hands=gear.Adhemar_hands_B,
		ring1="Haverton Ring",
		ring2="Epona's Ring",
		back=Andartia.DEX,
		waist="Reiki Yotai",
		legs="Ken. Hakama +1",
		feet="Hiza. Sune-Ate +2",
	}
	-- assumptions made about target
	sets.engaged.Low = set_combine(sets.engaged, {
	})

	sets.engaged.Mid = set_combine(sets.engaged.Low, {
		head=gear.Ryuo_head_A,
		hands="Mummu Wrists +2",
	})

	sets.engaged.Acc = set_combine(sets.engaged.Mid, {
		ear1="Suppanomimi",
		ear2="Telos Earring",
		ring2="Cacoethic Ring +1",
	})

	-- set for fooling around without dual wield
	sets.NoDW = set_combine(sets.engaged, {
	})

	sets.engaged.Innin = set_combine(sets.engaged, {
	})
	sets.engaged.Innin.Low = sets.engaged.Low
	sets.engaged.Innin.Mid = sets.engaged.Mid
	sets.engaged.Innin.Acc = sets.engaged.Acc

	-- Defenseive sets
	sets.NormalPDT = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		legs="Malignance Tights",
		feet="Malignance Boots"
	}
	sets.AccPDT = set_combine(sets.NormalPDT,{
	})

	sets.engaged.PDT = set_combine(sets.engaged, sets.NormalPDT)
	sets.engaged.Low.PDT = set_combine(sets.engaged.Low, sets.NormalPDT)
	sets.engaged.Mid.PDT = set_combine(sets.engaged.Mid, sets.NormalPDT)
	sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, sets.AccPDT)

	sets.engaged.Innin.PDT = set_combine(sets.engaged.Innin, sets.NormalPDT, {
	})
	sets.engaged.Innin.Low.PDT = sets.engaged.Low.PDT
	sets.engaged.Innin.Mid.PDT = sets.engaged.Mid.PDT
	sets.engaged.Innin.Acc.PDT = sets.engaged.Acc.PDT

	sets.engaged.HastePDT = {
	}

	-- (1 - Dual Wield %) × (1 - Haste %)  ≥  0.2
	--
	--					Magic Haste
	--				 	0%		10%		15%		30%		35%		Cap
	-- T1 (10)			64		60		57		46		31		26
	-- T2 (15)			59		55		52		41		36		21
	-- T3 (25)			49		45		42		31		26		11
	-- T4 (30)			44		40		37		26		21		6
	-- T5 (35)			39		35		32		21		16		1	(NIN85)
	-- T6 (37)			37		33		30		19		14		0
	--
	-- Delay Cap from spell + songs alone (43.75% Magic Haste cap)
	-- DW needed: 1
	sets.engaged.MaxHaste = set_combine(sets.engaged, {
		head=gear.Adhemar_head_B,
		ear2="Telos Earring",
		body="Ken. Samue +1",
		ring1="Gere Ring",
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		--feet="Mummu Gamash. +2",
		feet="Mochi. Kyahan +3",
	})
	-- Base set for hard content
	sets.engaged.Low.MaxHaste = set_combine(sets.engaged.MaxHaste, {
	})
	sets.engaged.Mid.MaxHaste = set_combine(sets.engaged.Low.MaxHaste, {
		head="Mummu Bonnet +2",
		hands="Mummu Wrists +2",
		legs="Ken. Hakama +1",
	})
	sets.engaged.Acc.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, {
		head="Malignance Chapeau",
		ear1="Digni. Earring",
		body="Mochi. Chainmail +3",
		hands="Malignance Gloves",
		ring1="Patricius Ring",
		ring2="Cacoethic Ring +1",
		waist="Eschan Stone",
		feet="Malignance Boots",
	})
	sets.engaged.Innin.MaxHaste	 = set_combine(sets.engaged.MaxHaste, {
	})
	sets.engaged.Innin.Low.MaxHaste = sets.engaged.Low.MaxHaste
	sets.engaged.Innin.Mid.MaxHaste = sets.engaged.Mid.MaxHaste
	sets.engaged.Innin.Acc.MaxHaste = sets.engaged.Acc.MaxHaste

	-- Defensive sets
	sets.engaged.PDT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.HastePDT)
	sets.engaged.Low.PDT.MaxHaste = set_combine(sets.engaged.Low.MaxHaste, sets.engaged.HastePDT)
	sets.engaged.Mid.PDT.MaxHaste = set_combine(sets.engaged.Mid.MaxHaste, sets.engaged.HastePDT)
	sets.engaged.Acc.PDT.MaxHaste = set_combine(sets.engaged.Acc.MaxHaste, sets.AccPDT)

	sets.engaged.Innin.PDT.MaxHaste = set_combine(sets.engaged.Innin.MaxHaste, sets.NormalPDT)
	sets.engaged.Innin.Low.PDT.MaxHaste = sets.engaged.Low.PDT.MaxHaste
	sets.engaged.Innin.Mid.PDT.MaxHaste = sets.engaged.Mid.PDT.MaxHaste
	sets.engaged.Innin.Acc.PDT.MaxHaste = sets.engaged.Acc.PDT.MaxHaste

	-- 35% Haste 
	-- DW needed: 16
	sets.engaged.Haste_35 = set_combine(sets.engaged.MaxHaste, {
		body="Mochi. Chainmail +3",
		waist="Reiki Yotai",
		legs="Ken. Hakama +1",
	})
	sets.engaged.Low.Haste_35 = set_combine(sets.engaged.Low.MaxHaste, {
	})
	sets.engaged.Mid.Haste_35 = set_combine(sets.engaged.Mid.MaxHaste, {
		body="Mochi. Chainmail +3",
		waist="Reiki Yotai",
	})
	sets.engaged.Acc.Haste_35 = set_combine(sets.engaged.Acc.MaxHaste, {
		waist="Reiki Yotai",
	})

	sets.engaged.Innin.Haste_35 = set_combine(sets.engaged.Haste_35, {
	})
	sets.engaged.Innin.Low.Haste_35 = sets.engaged.Low.Haste_35
	sets.engaged.Innin.Mid.Haste_35 = sets.engaged.Mid.Haste_35
	sets.engaged.Innin.Acc.Haste_35 = sets.engaged.Acc.Haste_35

	sets.engaged.PDT.Haste_35 = set_combine(sets.engaged.Haste_35, sets.engaged.HastePDT)
	sets.engaged.Low.PDT.Haste_35 = set_combine(sets.engaged.Low.Haste_35, sets.engaged.HastePDT)
	sets.engaged.Mid.PDT.Haste_35 = set_combine(sets.engaged.Mid.Haste_35, sets.engaged.HastePDT)
	sets.engaged.Acc.PDT.Haste_35 = set_combine(sets.engaged.Acc.Haste_35, sets.engaged.AccPDT)

	sets.engaged.Innin.PDT.Haste_35 = set_combine(sets.engaged.Innin.Haste_35, sets.engaged.HastePDT)
	sets.engaged.Innin.Low.PDT.Haste_35 = sets.engaged.Low.PDT.Haste_35
	sets.engaged.Innin.Mid.PDT.Haste_35 = sets.engaged.Mid.PDT.Haste_35
	sets.engaged.Innin.Acc.PDT.Haste_35 = sets.engaged.Acc.PDT.Haste_35

	-- 30% Haste 1626 / 798
	-- DW needed: 21
	sets.engaged.Haste_30 = set_combine(sets.engaged.Haste_35, {
		ring1="Haverton Ring",
		legs="Ken. Hakama +1",
	})
	-- This can alternatively be used for high-def targets. 
	sets.engaged.Low.Haste_30 = set_combine(sets.engaged.Haste_30, {
	})
	sets.engaged.Mid.Haste_30 = set_combine(sets.engaged.Low.Haste_30, {
		head="Mummu Bonnet +2",
		hands="Mummu Wrists +2",
	})
	sets.engaged.Acc.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, {
		ear1="Digni. Earring",
	})

	sets.engaged.Innin.Haste_30 = set_combine(sets.engaged.Haste_30, {
	})
	sets.engaged.Innin.Low.Haste_30 = sets.engaged.Low.Haste_30
	sets.engaged.Innin.Mid.Haste_30 = sets.engaged.Mid.Haste_30
	sets.engaged.Innin.Acc.Haste_30 = sets.engaged.Acc.Haste_30

	sets.engaged.PDT.Haste_30 = set_combine(sets.engaged.Haste_30, sets.engaged.HastePDT)
	sets.engaged.Low.PDT.Haste_30 = set_combine(sets.engaged.Low.Haste_30, sets.engaged.HastePDT)
	sets.engaged.Mid.PDT.Haste_30 = set_combine(sets.engaged.Mid.Haste_30, sets.engaged.HastePDT)
	sets.engaged.Acc.PDT.Haste_30 = set_combine(sets.engaged.Acc.Haste_30, sets.engaged.AccPDT)

	sets.engaged.Innin.PDT.Haste_30 = set_combine(sets.engaged.Innin.Haste_30, sets.engaged.HastePDT)
	sets.engaged.Innin.Low.PDT.Haste_30 = sets.engaged.Low.PDT.Haste_30
	sets.engaged.Innin.Mid.PDT.Haste_30 = sets.engaged.Mid.PDT.Haste_30
	sets.engaged.Innin.Acc.PDT.Haste_30 = sets.engaged.Acc.PDT.Haste_30


	-- DW needed: 32
	sets.engaged.Haste_15 = set_combine(sets.engaged.Haste_30, {
		head=gear.Ryuo_head_A,
		ring1="Gere Ring",
		feet="Hiza. Sune-Ate +2",
	})
	sets.engaged.Low.Haste_15 = set_combine(sets.engaged.Haste_15, {
	})
	sets.engaged.Mid.Haste_15 = set_combine(sets.engaged.Low.Haste_15, {
		hands="Mummu Wrists +2",
	})
	sets.engaged.Acc.Haste_15 = set_combine(sets.engaged.Acc.Haste_30, {
		head=gear.Ryuo_head_A,
		ring1="Gere Ring",
		feet="Hiza. Sune-Ate +2",
	})
	
	sets.engaged.Innin.Haste_15 = set_combine(sets.engaged.Haste_15, {
	})
	sets.engaged.Innin.Low.Haste_15 = sets.engaged.Low.Haste_15
	sets.engaged.Innin.Mid.Haste_15 = sets.engaged.Mid.Haste_15
	sets.engaged.Innin.Acc.Haste_15 = sets.engaged.Acc.Haste_15
	
	sets.engaged.PDT.Haste_15 = set_combine(sets.engaged.Haste_15, sets.engaged.HastePDT)
	sets.engaged.Low.PDT.Haste_15 = set_combine(sets.engaged.Low.Haste_15, sets.engaged.HastePDT)
	sets.engaged.Mid.PDT.Haste_15 = set_combine(sets.engaged.Mid.Haste_15, sets.engaged.HastePDT)
	sets.engaged.Acc.PDT.Haste_15 = set_combine(sets.engaged.Acc.Haste_15, sets.engaged.AccPDT)
	
	sets.engaged.Innin.PDT.Haste_15 = set_combine(sets.engaged.Innin.Haste_15, sets.engaged.HastePDT)
	sets.engaged.Innin.Low.PDT.Haste_15 = sets.engaged.Low.PDT.Haste_15
	sets.engaged.Innin.Mid.PDT.Haste_15 = sets.engaged.Mid.PDT.Haste_15
	sets.engaged.Innin.Acc.PDT.Haste_15 = sets.engaged.Acc.PDT.Haste_15

	-- Weaponskills 
	sets.precast.WS = {
		ammo="Seeth. Bomblet +1",
		head=gear.Adhemar_head_B,
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body=gear.Adhemar_body_B,
		--hands=gear.Adhemar_hands_B,
		hands="Mummu Wrists +2",
		ring1="Gere Ring",
		ring2="Regal Ring",
		back=Andartia.DEX,
		waist="Fotia Belt",
		legs="Mochi. Hakama +3",
		feet="Mummu Gamash. +2",
	}
	sets.precast.WS.Mid = set_combine(sets.precast.WS, {
	})
	sets.precast.WS.Low = set_combine(sets.precast.WS, {
	})
	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
	})
	sets.precast.WS.MAB = set_combine(sets.precast.WS, {
		ammo="Pemphredo Tathlum",
		--head="Mochi. Hatsuburi +1",
		--neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		body=gear.Herculean_body_Magic,
		hands="Leyline Gloves",
		ring1="Acumen Ring",
		ring2="Dingir Ring",
		back="Toro Cape",
		--waist="Eschan Stone",
		legs=gear.Herculean_legs_Magic,
		feet="Adhemar Gamashes",
	})
	
	sets.Kamu = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, sets.Kamu)
	sets.precast.WS['Blade: Kamu'].Low = set_combine(sets.precast.WS.Low, sets.Kamu)
	sets.precast.WS['Blade: Kamu'].Mid = set_combine(sets.precast.WS.Mid, sets.Kamu)
	sets.precast.WS['Blade: Kamu'].Acc = set_combine(sets.precast.WS.Acc, sets.Kamu, {})
	
	-- BLADE: HI AGI 80%
	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
		ammo="Yetshila",
		head="Mummu Bonnet +2",
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body="Ken. Samue +1",
		hands="Mummu Wrists +2",
		ring1="Gere Ring",
		ring2="Regal Ring",
		back=Andartia.AGI,
		waist="Windbuffet Belt +1",
		--legs="Mummu Kecks +2",
		legs="Mochi. Hakama +3",
		feet="Mummu Gamash. +2",
	})
	
	sets.precast.WS['Blade: Hi'].Low = set_combine(sets.precast.WS['Blade: Hi'], {
	})
	sets.precast.WS['Blade: Hi'].Mid = set_combine(sets.precast.WS['Blade: Hi'], {
	})
	
	sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'].Mid, {
	})
	
	-- BLADE: SHUN DEX 73~80%
	sets.Shun = set_combine(sets.precast.WS, {
		ammo="Seeth. Bomblet +1",
		head=gear.Adhemar_head_B,
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Ken. Samue +1",
		hands=gear.Adhemar_hands_B,
		ring1="Gere Ring",
		ring2="Regal Ring",
		back=Andartia.DEX,
		waist="Fotia Belt",
		legs="Jokushu Haidate",
		feet="Hiza. Sune-Ate +2",
	})
	
	sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, sets.Shun)
	sets.precast.WS['Blade: Shun'].Low = set_combine(sets.precast.WS.Low, sets.Shun)
	sets.precast.WS['Blade: Shun'].Mid = set_combine(sets.precast.WS.Mid, sets.Shun)
	sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS.Acc, sets.Shun)
	
	-- BLADE: TEN STR 30% / DEX 30%
	sets.Ten = set_combine(sets.precast.WS, {
		ammo="Seeth. Bomblet +1",
		head=gear.Adhemar_head_B,
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body=gear.Adhemar_body_B,
		hands=gear.Adhemar_hands_B,
		ring1="Gere Ring",
		ring2="Regal Ring",
		back=Andartia.DEX,
		waist="Grunfeld Rope",
		legs="Mochi. Hakama +3",
		feet=gear.Adhemar_feet_B,
	})
	
	sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, sets.Ten)
	sets.precast.WS['Blade: Ten'].Low = set_combine(sets.precast.WS['Blade: Ten'], {
	})
	sets.precast.WS['Blade: Ten'].Mid = set_combine(sets.precast.WS['Blade: Ten'].Low, {
	})
	sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS['Blade: Ten'].Mid, {
	})
	
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Blade: Chi'] = set_combine(sets.precast.WS['Aeolian Edge'], {
	})
	sets.precast.WS['Blade: To'] = sets.precast.WS['Blade: Chi']

	sets.precast.WS['Blade: Yu'] = set_combine(sets.precast.WS.MAB,{
		back=Andartia.DEX,
	})
	
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	
	sets.buff.Migawari = {body="Hattori Ningi +1"}
	sets.buff.Yonin = {}
	sets.buff.Innin = {}
	sets.buff.Madrigal = {
		hands="Composer's Mitts",
	}
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 6)
	elseif player.sub_job == 'DNC' then
		set_macro_page(2, 6)
	elseif player.sub_job == 'RUN' then
		set_macro_page(4, 6)
	else
		set_macro_page(1, 6)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if player.hpp < 80 then
		idleSet = set_combine(idleSet, sets.idle.Regen)
	end
	if state.HybridMode.value == 'PDT' then
		if state.Buff.Migawari then
			idleSet = set_combine(idleSet, sets.buff.Migawari)
		else 
			idleSet = set_combine(idleSet, sets.defense.PDT)
		end
	else
		idleSet = set_combine(idleSet, select_movement())
	end
	--local res = require('resources')
	--local info = windower.ffxi.get_info()
	--local zone = res.zones[info.zone].name
	--if zone:match('Adoulin') then
	--	idleSet = set_combine(idleSet, sets.Adoulin)
	--end
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
	if state.TreasureMode.value == 'Fulltime' then
		meleeSet = set_combine(meleeSet, sets.TreasureHunter)
	end
	if state.CapacityMode.value then
		meleeSet = set_combine(meleeSet, sets.CapacityMantle)
	end
	if state.Buff.Migawari and state.HybridMode.value == 'PDT' then
		meleeSet = set_combine(meleeSet, sets.buff.Migawari)
	end
	if player.equipment.sub == 'empty' then
		meleeSet = set_combine(meleeSet, sets.NoDW)
	end
	meleeSet = set_combine(meleeSet, select_ammo())
	if state.Buff.Doom then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
	end
	return meleeSet
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.english == "Monomi: Ichi" and buffactive['Sneak'] then
    	cast_delay(1.7)
      send_command('@wait 1.7;cancel sneak')
    end
end