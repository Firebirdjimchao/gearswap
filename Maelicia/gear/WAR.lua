function user_setup()
	state.OffenseMode:options('Normal', 'AccLow', 'AccHigh', 'Crit')
	state.RangedMode:options('Normal')
	state.HybridMode:options('Normal', 'PDT')
	state.WeaponskillMode:options('Normal', 'AccLow', 'AccHigh')
	state.CastingMode:options('Normal')
	state.IdleMode:options('Normal', 'Regen', 'CP', 'CPPDT', 'CPMDT')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.MagicalDefenseMode:options('MDT', 'Reraise')

	state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}
	state.EnmityMode = M{['description']='Enmity Mode', 'None', 'Down', 'Up'}
	state.SakpataMode = M(false, 'Sakpata')
	state.TreasureMode = M(false, 'TH')

	--Augmented Gear Definitions--
	gear.Cichol_StrWSD = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	gear.Cichol_VitWSD = { name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}}
	gear.Cichol_AccDA = { name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
 
	update_combat_weapon()
	update_melee_groups()
	select_default_macro_book()

	send_command('bind @` gs c cycle HasteMode')
	send_command('bind ^` gs equip sets.Twilight; input /echo --- Twilight Set Equipped ---')
	send_command('bind ^- gs c cycle enmitymode')
	send_command('bind ^= gs c toggle TreasureMode; input /echo --- TreasureMode ---')
	send_command('bind != gs c toggle SakpataMode; input /echo --- SakpataMode ---')

	global_aliases()
end

function file_unload()
	send_command('unbind @`')
	send_command('unbind ^`')
	send_command('unbind ^-')
	send_command('unbind ^=')
	send_command('unbind !=')
end

function init_gear_sets()

	--------------------------------------
	-- Base sets
	--------------------------------------

	-- Total:
	-- 41% DT
	-- 24% PDT
	-- 18% MDT
	-- 31 MDB
	-- 590 MEVA
	-- To cap MDT: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.DT = {
		-- 3% DT
		ammo="Staunch Tathlum +1",
		-- 3% PDT
		-- 7% MDT
		-- 6 MDB
		-- 99 MEVA
		-- 6% Haste
		--head="Volte Salade",
		-- 10% DT
		-- 8 MDB
		-- 53 MEVA
		--head="Hjarrandi Helm",
		-- 7% DT
		-- 7 MDB
		-- 123 MEVA
		-- 4% Haste
		head="Sakpata's Helm",
		-- 6% DT
		neck="Loricate Torque +1",
		-- 2% MDT
		ear1="Odnowa Earring +1",
		-- 3% MDT
		ear2="Etiolation Earring",
		-- 12% DT 
		-- 10 MDB
		-- 69 MEVA
		--body="Hjarrandi Breast.",
		-- 12 MDB
		-- 129 MEVA
		-- 5% Haste
		--body="Sacro Breastplate",
		-- 10% DT
		-- 10 MDB
		-- 139 MEVA
		-- 2% Haste
		body="Sakpata's Breastplate",
		-- 6% PDT 
		-- 2% MDT 
		-- 4 MDB
		-- 91 MEVA
		-- 4% Haste
		--hands="Volte Moufles",
		-- 8% DT 
		-- 6 MDB
		-- 112 MEVA
		-- 4% Haste
		hands="Sakpata's Gauntlets",
		-- 5% PDT
		-- 5% MDT
		ring1="Dark Ring",
		-- 10% DT
		ring2="Defending Ring",
		-- 5% DT
		back="Moonbeam Cape",
		-- 4% PDT
		waist="Flume Belt +1",
		-- 5% PDT 
		-- 4 MDB
		-- 100 MEVA
		-- 6% Haste
		--legs="Pumm. Cuisses +3",
		-- 9% DT 
		-- 9 MDB
		-- 150 MEVA
		-- 4% Haste
		legs="Sakpata's Cuisses",
		-- 4% PDT 
		-- 6% MDT 
		-- 6 MDB
		-- 137 MEVA
		-- 3% Haste
		--feet="Volte Sollerets",
		-- 6% DT 
		-- 7 MDB
		-- 150 MEVA
		-- 2% Haste
		feet="Sakpata's Leggings",
	}

	sets.MAB = {
		head="Nyame Helm",
		--neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Acumen Ring",
		back="Toro Cape",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}

	sets.EnmityUp = {
		-- 12 Enmity
		head="Pummeler's Mask +3",
		-- 10 Enmity
		neck="Unmoving Collar +1",
		-- 2 Enmity
		ear1="Friomisi Earring",
		-- 10 Enmity
		body="Emet Harness +1",
		-- 15 Enmity
		--hands="Pumm. Mufflers +3",
		-- 5 Enmity
		ring1="Supershear Ring",
		-- 5 Enmity
		ring2="Pernicious Ring",
		-- 3 Enmity
		waist="Goading Belt",
		-- 3 Enmity
		feet="Hermes' Sandals",
	}

	sets.EnmityDown = {
		ear2="Schere Earring",
	}
			 
	--------------------------------------
	-- Precast sets
	--------------------------------------
 
	-- Sets to apply to arbitrary JAs
	sets.precast.JA.Berserk = {
		body="Pumm. Lorica +3",
		back=gear.Cichol_AccDA,
		feet="Agoge Calligae +3",
	}
	sets.precast.JA['Aggressor'] = {
		head="Pummeler's Mask +3",
		body="Agoge Lorica +1",
	}
	sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers +1"}
	sets.precast.JA['Blood Rage'] = {
		body="Boii Lorica +1",
	}
	sets.precast.JA['Warcry'] = {
		head="Agoge Mask +3",
	}
	sets.precast.JA['Tomahawk'] = {
		ammo="Thr. Tomahawk",
		feet="Agoge Calligae +3",
	}
	-- Sets to apply to any actions of spell.type
	sets.precast.Waltz = {
		body="Pumm. Lorica +3",
		back="Tantalic Cape",
		waist="Flume Belt +1"
	}
	sets.precast.JA['Provoke'] = set_combine(sets.EnmityUp,{ 
	})
				 
	-- Sets for specific actions within spell.type
	sets.precast.Waltz['Healing Waltz'] = {}
 
	-- Sets for fast cast gear for spells
	-- 35%/17% Total
	sets.precast.FC = {
		-- 8%
		head="Sakpata's Helm",
		--ammo="Impatiens",
		-- 2%
		--ammo="Sapience Orb",
		-- 4%
		neck="Voltsurge Torque",
		-- 2%
		ear1="Loquac. Earring",
		-- 1%
		ear2="Etiolation Earring",
		-- 10%
		body="Sacro Breastplate",
		-- 5% + 3%
		hands="Leyline Gloves",
		-- 2%
		ring1="Prolix Ring",
		-- 2%
		--ring2="Rahab Ring",
		-- 3%
		--legs="Limbo Trousers",
		-- 4%
		--legs="Arjuna Breeches",
		-- 5%
		--feet="Odyssean Greaves",
	}
 
	-- Fast cast gear for specific spells or spell maps
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS = {
		ammo="Knobkierrie",
		--head="Flam. Zucchetto +2",
		head="Agoge Mask +3",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Brutal Earring",
		body="Pumm. Lorica +3",
		hands=gear.Argosy_hands_hq_D,
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.Cichol_StrWSD,
		waist="Fotia Belt",
		--legs="Pumm. Cuisses +3",
		legs=gear.Argosy_legs_hq_D,
		--feet="Pumm. Calligae +3"
		feet="Nyame Sollerets",
	}
	sets.precast.WS.AccLow = set_combine(sets.precast.WS, {
		head=gear.Argosy_head_hq_A,
		back=gear.Cichol_AccDA,
	})
	sets.precast.WS.AccHigh = set_combine(sets.precast.WS.AccLow, {
		head="Pummeler's Mask +3",
		body="Pumm. Lorica +3",
		back=gear.Cichol_AccDA,
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})
	sets.precast.WS.MS = set_combine(sets.precast.WS, {
		ammo="Yetshila",
		body="Pumm. Lorica +3",
		feet="Boii Calligae +1",
	})
	
	sets.precast.WS.MAB = set_combine(sets.precast.WS, sets.MAB, {
		ring1="Beithir Ring",
	})

	sets.precast.WS.MaxTP = {
		ear1="Lugra Earring +1",
	}
			 
	----- Specific weaponskill sets. -----

	-- GAXE --
	sets.precast.WS["Upheaval"] = set_combine(sets.precast.WS,{
		ammo="Knobkierrie",
		head="Agoge Mask +3",
		neck="War. Beads +2",
		ear1="Moonshade Earring",
		--ear2="Ishvara Earring",
		--ear2="Brutal Earring",
		ear2="Thrud Earring",
		body="Pumm. Lorica +3",
		hands="Nyame Gauntlets",
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.Cichol_VitWSD,
		waist="Ioskeha Belt +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS["Upheaval"].AccLow = set_combine(sets.precast.WS['Upheaval'], {
		hands="Tatena. Gote +1",
	})
	sets.precast.WS["Upheaval"].AccHigh = set_combine(sets.precast.WS['Upheaval'], {
		ear1="Telos Earring",
		ear2="Moonshade Earring",
		back=gear.Cichol_AccDA,
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3"
	})
	sets.precast.WS["Upheaval"].MS = set_combine(sets.precast.WS['Upheaval'], {
		ammo="Yetshila",
		body="Pumm. Lorica +3",
		feet="Boii Calligae +1",
	})

	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS,{
		ammo="Yetshila",
		head="Flam. Zucchetto +2",
		neck="War. Beads +2",
		ear1="Moonshade Earring",
		ear2="Brutal Earring",
		--body="Dagon Breastplate",
		body="Tatena. Harama. +1",
		hands=gear.Argosy_hands_hq_D,
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.Cichol_StrWSD,
		waist="Sailfi Belt +1",
		legs=gear.Argosy_legs_hq_D,
		--feet="Pumm. Calligae +3",
		--feet="Nyame Sollerets",
		feet="Boii Calligae +1",
	})
	sets.precast.WS["Ukko's Fury"].AccLow = set_combine(sets.precast.WS["Ukko's Fury"], {
		head="Flam. Zucchetto +2",
		body="Pumm. Lorica +3",
	})
	sets.precast.WS["Ukko's Fury"].AccHigh = set_combine(sets.precast.WS["Ukko's Fury"], {
		head="Pummeler's Mask +3",
		body="Pumm. Lorica +3",
		back=gear.Cichol_AccDA,
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})
	sets.precast.WS["Ukko's Fury"].MS = set_combine(sets.precast.WS["Ukko's Fury"], {
		ammo="Yetshila",
		body="Pumm. Lorica +3",
		feet="Boii Calligae +1",
	})
			 
	sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Brutal Earring",
		body=gear.Argosy_body_hq_D,
		hands=gear.Argosy_hands_hq_D,
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.Cichol_StrWSD,
		waist="Sailfi Belt +1",
		legs=gear.Argosy_legs_hq_D,
		--feet="Pumm. Calligae +3"
		feet="Nyame Sollerets",
	})
	sets.precast.WS["King's Justice"].AccLow = set_combine(sets.precast.WS["King's Justice"], {
		head=gear.Argosy_head_hq_A,
		--head="Agoge Mask +3",
	})
	sets.precast.WS["King's Justice"].AccHigh = set_combine(sets.precast.WS["King's Justice"], {
		head="Pummeler's Mask +3",
		body="Pumm. Lorica +3",
		back=gear.Cichol_AccDA,
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})
	sets.precast.WS["King's Justice"].MS = set_combine(sets.precast.WS["King's Justice"], {
		ammo="Yetshila",
		head="Agoge Mask +3",
		body=gear.Argosy_body_hq_D,
		feet="Boii Calligae +1",
	})
			 
	-- 60% STR
	sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Agoge Mask +3",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
		body="Pumm. Lorica +3",
		hands="Nyame Gauntlets",
		ring1="Beithir Ring",
		ring2="Regal Ring",
		back=gear.Cichol_StrWSD,
		waist="Sailfi Belt +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Fell Cleave'].AccLow = set_combine(sets.precast.WS['Fell Cleave'], {
	})
	sets.precast.WS['Fell Cleave'].AccHigh = set_combine(sets.precast.WS['Fell Cleave'], {
	})
	sets.precast.WS['Fell Cleave'].MS = set_combine(sets.precast.WS['Fell Cleave'], {
		ammo="Yetshila",
		feet="Boii Calligae +1",
	})

	-- GSWORD --
	sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Agoge Mask +3",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Brutal Earring",
		body=gear.Argosy_body_hq_D,
		hands=gear.Argosy_hands_hq_D,
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.Cichol_StrWSD,
		waist="Fotia Belt",
		legs=gear.Argosy_legs_hq_D,
		feet="Pumm. Calligae +3",
	})
	sets.precast.WS['Resolution'].AccLow = set_combine(sets.precast.WS['Resolution'], {
		head="Agoge Mask +3",
		feet=gear.Argosy_feet_hq_A,
	})
	sets.precast.WS['Resolution'].AccHigh = set_combine(sets.precast.WS['Resolution'], {
		head="Pummeler's Mask +3",
		body="Pumm. Lorica +3",
		back=gear.Cichol_AccDA,
		legs="Pumm. Cuisses +3",
	})
	sets.precast.WS['Resolution'].MS = set_combine(sets.precast.WS['Resolution'], {
		ammo="Yetshila",
		head="Agoge Mask +3",
		body=gear.Argosy_body_hq_D,
		feet="Boii Calligae +1",
	})

	sets.precast.WS['Scourge'] = set_combine(sets.precast.WS, {
		ammo="Knobkierrie",
		head="Agoge Mask +3",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Brutal Earring",
		body="Pumm. Lorica +3",
		hands="Nyame Gauntlets",
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.Cichol_StrWSD,
		waist="Fotia Belt",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Scourge'].AccLow = set_combine(sets.precast.WS['Scourge'], {
	})
	sets.precast.WS['Scourge'].AccHigh = set_combine(sets.precast.WS['Scourge'], {
		head="Pummeler's Mask +3",
		body="Pumm. Lorica +3",
		back=gear.Cichol_AccDA,
	})
	sets.precast.WS['Scourge'].MS = set_combine(sets.precast.WS['Scourge'], {
		ammo="Yetshila",
		body="Pumm. Lorica +3",
		feet="Boii Calligae +1",
	})	

	-- AXE --

	-- 73~85% STR
	sets.precast.WS["Ruinator"] = set_combine(sets.precast.WS,{
	})
	sets.precast.WS["Ruinator"].AccLow = set_combine(sets.precast.WS.AccLow, {
	})
	sets.precast.WS["Ruinator"].AccHigh = set_combine(sets.precast.WS.AccHigh, {
	})
	sets.precast.WS["Ruinator"].MS = set_combine(sets.precast.WS.MS, {
	})

	-- 50% STR, Acc varies with TP
	sets.precast.WS["Decimation"] = set_combine(sets.precast.WS,{
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Thrud Earring",
		body=gear.Argosy_body_hq_D,
		hands=gear.Argosy_hands_hq_D,
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.Cichol_StrWSD,
		waist="Fotia Belt",
		legs=gear.Argosy_legs_hq_D,
		feet="Pumm. Calligae +3",
		--feet="Flam. Gambieras +2",
	})
	sets.precast.WS['Decimation'].AccLow = set_combine(sets.precast.WS['Decimation'], {
	})
	sets.precast.WS['Decimation'].AccHigh = set_combine(sets.precast.WS['Decimation'], {
		head="Pummeler's Mask +3",
		body="Pumm. Lorica +3",
		back=gear.Cichol_AccDA,
		legs="Pumm. Cuisses +3",
	})
	sets.precast.WS['Decimation'].MS = set_combine(sets.precast.WS['Decimation'], {
		ammo="Yetshila",
		head="Agoge Mask +3",
		body=gear.Argosy_body_hq_D,
		feet="Boii Calligae +1",
	})
	
	-- Magical WS
	
	-- 40% STR / 40% MND
	sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS.MAB, {
		ammo="Knobkierrie",
		head="Nyame Helm",
		ear2="Thrud Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Beithir Ring",
		ring2="Regal Ring",
		back=gear.Cichol_StrWSD,
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Cloudsplitter'].AccLow = set_combine(sets.precast.WS['Cloudsplitter'], {
	})
	sets.precast.WS['Cloudsplitter'].AccHigh = set_combine(sets.precast.WS['Cloudsplitter'], {
	})
	sets.precast.WS['Cloudsplitter'].MS = set_combine(sets.precast.WS['Cloudsplitter'], {
	})

	-- SWORD

	-- 50% STR / 50% MND, Damage varies with TP
	sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS,{
		ammo="Knobkierrie",
		head="Agoge Mask +3",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
		body="Pumm. Lorica +3",
		hands="Nyame Gauntlets",
		ring1="Niqmaddu Ring",
		--ring1="Beithir Ring",
		--ring2="Epaminonda's Ring",
		ring2="Regal Ring",
		back=gear.Cichol_StrWSD,
		waist="Sailfi Belt +1",
		--legs="Pumm. Cuisses +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Savage Blade'].AccLow = set_combine(sets.precast.WS['Savage Blade'], {
		legs="Nyame Flanchard",
	})
	sets.precast.WS['Savage Blade'].AccHigh = set_combine(sets.precast.WS['Savage Blade'], {
	})
	sets.precast.WS['Savage Blade'].MS = set_combine(sets.precast.WS['Savage Blade'], {
		ammo="Yetshila",
		feet="Boii Calligae +1",
	})
	
	sets.precast.WS['Infernal Scythe'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Infernal Scythe'].AccLow = set_combine(sets.precast.WS['Infernal Scythe'], {
	})
	sets.precast.WS['Infernal Scythe'].AccHigh = set_combine(sets.precast.WS['Infernal Scythe'], {
	})
	sets.precast.WS['Infernal Scythe'].MS = set_combine(sets.precast.WS['Infernal Scythe'], {
	})
	
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Aeolian Edge'].AccLow = set_combine(sets.precast.WS['Aeolian Edge'], {
	})
	sets.precast.WS['Aeolian Edge'].AccHigh = set_combine(sets.precast.WS['Aeolian Edge'], {
	})
	sets.precast.WS['Aeolian Edge'].MS = set_combine(sets.precast.WS['Aeolian Edge'], {
	})
	
	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Flash Nova'].AccLow = set_combine(sets.precast.WS['Flash Nova'], {
	})
	sets.precast.WS['Flash Nova'].AccHigh = set_combine(sets.precast.WS['Flash Nova'], {
	})
	sets.precast.WS['Flash Nova'].MS = set_combine(sets.precast.WS['Flash Nova'], {
	})
	
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS.MAB, {
		head="Pixie Hairpin +1",
	})
	sets.precast.WS['Cataclysm'].AccLow = set_combine(sets.precast.WS['Cataclysm'], {
	})
	sets.precast.WS['Cataclysm'].AccHigh = set_combine(sets.precast.WS['Cataclysm'], {
	})
	sets.precast.WS['Cataclysm'].MS = set_combine(sets.precast.WS['Cataclysm'], {
	})

	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.MAB, {
		head="Pixie Hairpin +1",
	})
	sets.precast.WS['Sanguine Blade'].AccLow = set_combine(sets.precast.WS['Sanguine Blade'], {
	})
	sets.precast.WS['Sanguine Blade'].AccHigh = set_combine(sets.precast.WS['Sanguine Blade'], {
	})
	sets.precast.WS['Sanguine Blade'].MS = set_combine(sets.precast.WS['Sanguine Blade'], {
	})

	sets.precast.WS["Raging Fists"] = set_combine(sets.precast.WS,{
		ammo="Seeth. Bomblet +1",
		head="Flam. Zucchetto +2",
		neck="Fotia Gorget",
		ear1="Thrud Earring",
		ear2="Brutal Earring",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.Cichol_StrWSD,
		waist="Fotia Belt",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
	})
	sets.precast.WS['Raging Fists'].AccLow = set_combine(sets.precast.WS['Raging Fists'], {
	})
	sets.precast.WS['Raging Fists'].AccHigh = set_combine(sets.precast.WS['Raging Fists'], {
	})
	sets.precast.WS['Raging Fists'].MS = set_combine(sets.precast.WS['Raging Fists'], {
	})

	-- 15% STR / 15% VIT, Acc varies with TP
	sets.precast.WS["Asuran Fists"] = set_combine(sets.precast.WS,{
		ammo="Knobkierrie",
		head="Agoge Mask +3",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
		body="Pumm. Lorica +3",
		hands="Nyame Gauntlets",
		back=gear.Cichol_StrWSD,
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Asuran Fists'].AccLow = set_combine(sets.precast.WS['Asuran Fists'], {
	})
	sets.precast.WS['Asuran Fists'].AccHigh = set_combine(sets.precast.WS['Asuran Fists'], {
	})
	sets.precast.WS['Asuran Fists'].MS = set_combine(sets.precast.WS['Asuran Fists'], {
	})

	-- 30% STR / 30% MND, Crit varies with TP
	sets.precast.WS["Hexa Strike"] = set_combine(sets.precast.WS,{
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		neck="Fotia Gorget",
		ear2="Brutal Earring",
		body=gear.Argosy_body_hq_D,
		hands=gear.Argosy_hands_hq_D,
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.Cichol_StrWSD,
		waist="Fotia Belt",
		legs=gear.Argosy_legs_hq_D,
		feet="Pumm. Calligae +3",
		--feet="Flam. Gambieras +2",
	})
	sets.precast.WS['Hexa Strike'].AccLow = set_combine(sets.precast.WS['Hexa Strike'], {
	})
	sets.precast.WS['Hexa Strike'].AccHigh = set_combine(sets.precast.WS['Hexa Strike'], {
		head="Pummeler's Mask +3",
		body="Pumm. Lorica +3",
		back=gear.Cichol_AccDA,
		legs="Pumm. Cuisses +3",
	})
	sets.precast.WS['Hexa Strike'].MS = set_combine(sets.precast.WS['Hexa Strike'], {
		ammo="Yetshila",
		head="Agoge Mask +3",
		body=gear.Argosy_body_hq_D,
		feet="Boii Calligae +1",
	})

	-- 100% STR, Acc varies with TP
	sets.precast.WS["True Strike"] = set_combine(sets.precast.WS,{
	})
	sets.precast.WS['True Strike'].AccLow = set_combine(sets.precast.WS['True Strike'], {
	})
	sets.precast.WS['True Strike'].AccHigh = set_combine(sets.precast.WS['True Strike'], {
	})
	sets.precast.WS['True Strike'].MS = set_combine(sets.precast.WS['True Strike'], {
	})

		-- 50% STR / 50% MND, Damage varies with TP
	sets.precast.WS["Judgment"] = set_combine(sets.precast.WS,{
		ammo="Knobkierrie",
		head="Agoge Mask +3",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
		body="Pumm. Lorica +3",
		hands="Nyame Gauntlets",
		ring1="Beithir Ring",
		back=gear.Cichol_StrWSD,
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Judgment'].AccLow = set_combine(sets.precast.WS['Judgment'], {
	})
	sets.precast.WS['Judgment'].AccHigh = set_combine(sets.precast.WS['Judgment'], {
	})
	sets.precast.WS['Judgment'].MS = set_combine(sets.precast.WS['Judgment'], {
	})

	-- 100% STR, Damage varies with TP
	sets.precast.WS["Impulse Drive"] = set_combine(sets.precast.WS,{
		ammo="Knobkierrie",
		head="Agoge Mask +3",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
		body="Pumm. Lorica +3",
		hands=gear.Argosy_hands_hq_D,
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		--ring2="Beithir Ring",
		back=gear.Cichol_StrWSD,
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS["Impulse Drive"].AccLow = set_combine(sets.precast.WS["Impulse Drive"], {
	})
	sets.precast.WS["Impulse Drive"].AccHigh = set_combine(sets.precast.WS["Impulse Drive"], {
	})
	sets.precast.WS["Impulse Drive"].MS = set_combine(sets.precast.WS["Impulse Drive"], {
	})

	-- 73-85% STR, Damage varies with TP
	sets.precast.WS["Stardiver"] = set_combine(sets.precast.WS,{
		ammo="Knobkierrie",
		head="Agoge Mask +3",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
		body="Pumm. Lorica +3",
		hands="Nyame Gauntlets",
		back=gear.Cichol_StrWSD,
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS["Stardiver"].AccLow = set_combine(sets.precast.WS["Stardiver"], {
	})
	sets.precast.WS["Stardiver"].AccHigh = set_combine(sets.precast.WS["Stardiver"], {
	})
	sets.precast.WS["Stardiver"].MS = set_combine(sets.precast.WS["Stardiver"], {
	})
 
	--------------------------------------
	-- Midcast sets
	--------------------------------------
 
	-- Generic spell recast set
	-- 27% Haste
	sets.midcast.FastRecast = set_combine(sets.precast.FC,sets.DT,{
		waist="Ioskeha Belt +1",
	})
							 
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast,{
	})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
 
	-- Resting sets
	sets.resting = {}

	sets.Twilight = {
		head="Twilight Helm",
		body="Twilight Mail"
	}

	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		--body="Hjarrandi Breast.",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Nyame Flanchard",
		feet="Hermes' Sandals"
	}
	
	sets.noprotect = {ring1="Sheltered Ring"}
 
	sets.idle.Town = set_combine(sets.idle, {
		head="Sakpata's Helm",
		neck="War. Beads +2",
		ear1="Telos Earring",
		--body="Councilor's Garb",
		--body="Dagon Breastplate",
		body="Tatena. Harama. +1",
		--body=gear.Argosy_body_hq_D,
		--hands=gear.Argosy_hands_hq_D,
		hands="Tatena. Gote +1",
		waist="Sailfi Belt +1",
		--legs=gear.Argosy_legs_hq_D,
		legs="Tatena. Haidate +1",
	})
			 
	sets.idle.Regen = set_combine(sets.idle,{
		head="Volte Salade",
		neck="Bathy Choker +1",
		body="Sacro Breastplate",
		hands="Volte Moufles",
		ring1="Sheltered Ring",
		feet="Volte Sollerets",
	})
			 
	sets.idle.Weak = set_combine(sets.idle,sets.Twilight,{
	})
	
	sets.idle.CP = set_combine(sets.idle,{
		--back="Mecisto. Mantle"
	})
	
	sets.idle.CPPDT = set_combine(sets.defense.PDT,{
		--back="Mecisto. Mantle"
	})
	
	sets.idle.CPMDT = set_combine(sets.defense.MDT,{
		--back="Mecisto. Mantle"
	})

	sets.defense.PDT = set_combine(sets.idle,sets.DT,{
	})
	sets.defense.Reraise = set_combine(sets.defense.PDT,sets.Twilight,{
	})
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.defense.MDT = set_combine(sets.idle,sets.DT,{
	})
 
	-- Gear to wear for kiting
	sets.Kiting = {feet="Hermes' Sandals"}
 
	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes. Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	-- If using a weapon that isn't specified later, the basic engaged sets should automatically be used.
	-- Equip the weapon you want to use and engage, disengage, or force update with f12, the correct gear will be used; default weapon is whats equip when file loads.
	--
	-- Use Duplus Grip
	--
	-- Gear: 36 STP
	sets.engaged = set_combine(sets.idle,{
		-- 3 STP
		ammo="Ginsen",
		-- 6 STP
		head="Flam. Zucchetto +2",
		-- 3 STP
		--neck="Asperity Necklace",
		neck="War. Beads +2",
		-- 5 STP
		ear1="Telos Earring",
		-- 1 STP
		ear2="Brutal Earring",
		-- 6 STP
		body=gear.Argosy_body_hq_D,
		-- 6 STP
		hands=gear.Argosy_hands_hq_D,
		ring1="Niqmaddu Ring",
		-- 5 STP
		ring2="Petrov Ring",
		back=gear.Cichol_AccDA,
		waist="Sailfi Belt +1",
		legs="Pumm. Cuisses +3",
		-- 4 STP
		feet="Pumm. Calligae +3"
	})
	
	-- Use Utu Grip
	--
	-- Gear: 24 STP
	sets.engaged.AccLow = set_combine(sets.engaged, {
		-- 4 STP
		--neck="Lissome Necklace",
		-- 6 STP
		--body=gear.Argosy_body_hq_D,
		body="Tatena. Harama. +1",
		-- 6 STP
		--hands="Flam. Manopolas +2",
		-- 6 STP
		--hands=gear.Argosy_hands_hq_D,
		hands="Tatena. Gote +1",
		-- 5 STP
		ring2="Flamma Ring",
	})
	-- Use Utu Grip
	sets.engaged.AccHigh = set_combine(sets.engaged.AccLow, {
		--head="Pummeler's Mask +3",
		--body="Pumm. Lorica +3",
		ear1="Telos Earring",
		ear2="Crep. Earring",
		ring1="Flamma Ring",
		ring2="Regal Ring",
		waist="Ioskeha Belt +1",
	})

	-- Haste Mode used when Dual Wielding. See job_buff_change() below for specific conditions
	sets.engaged.Haste_15 = set_combine(sets.engaged,{
		ear1="Suppanomimi",
		ring2="Haverton Ring",
		waist="Reiki Yotai",
	})
	sets.engaged.Haste_30 = set_combine(sets.engaged,{
		ear1="Suppanomimi",
		ring2="Haverton Ring",
		waist="Reiki Yotai",
	})
	sets.engaged.Haste_35 = set_combine(sets.engaged,{
		ear1="Suppanomimi",
		ring2="Haverton Ring",
		waist="Reiki Yotai",
	})
	sets.engaged.MaxHaste = set_combine(sets.engaged,{
		ear1="Suppanomimi",
		waist="Reiki Yotai",
	})

	sets.engaged.AccLow.Haste_15 = set_combine(sets.engaged.AccLow,{
		ammo="Seeth. Bomblet +1",
		ear1="Suppanomimi",
		ring2="Haverton Ring",
		waist="Reiki Yotai",
	})
	sets.engaged.AccLow.Haste_30 = set_combine(sets.engaged.AccLow,{
		ammo="Seeth. Bomblet +1",
		ear1="Suppanomimi",
		ring2="Haverton Ring",
		waist="Reiki Yotai",
	})
	sets.engaged.AccLow.Haste_35 = set_combine(sets.engaged.AccLow,{
		ammo="Seeth. Bomblet +1",
		ear1="Suppanomimi",
		ring2="Haverton Ring",
		waist="Reiki Yotai",
	})
	sets.engaged.AccLow.MaxHaste = set_combine(sets.engaged.AccLow,{
		ammo="Seeth. Bomblet +1",
		ear1="Suppanomimi",
		waist="Reiki Yotai",
	})

	sets.engaged.AccHigh.Haste_15 = set_combine(sets.engaged.AccHigh,{
		ammo="Seeth. Bomblet +1",
		ear1="Suppanomimi",
		ring2="Haverton Ring",
		waist="Reiki Yotai",
	})
	sets.engaged.AccHigh.Haste_30 = set_combine(sets.engaged.AccHigh,{
		ammo="Seeth. Bomblet +1",
		ear1="Suppanomimi",
		ring2="Haverton Ring",
		waist="Reiki Yotai",
	})
	sets.engaged.AccHigh.Haste_35 = set_combine(sets.engaged.AccHigh,{
		ammo="Seeth. Bomblet +1",
		ear1="Suppanomimi",
		ring2="Haverton Ring",
		waist="Reiki Yotai",
	})
	sets.engaged.AccHigh.MaxHaste = set_combine(sets.engaged.AccHigh,{
		ammo="Seeth. Bomblet +1",
		ear1="Suppanomimi",
		waist="Reiki Yotai",
	})
	
	-- Total: 
	-- 50% DT 
	-- 10% PDT 
	-- 0% MDT
	-- 38 MDB
	-- 674 MEVA
	-- 24% Haste
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.engaged.PDT = set_combine(sets.engaged, {
		-- 7% DT
		-- 7 MDB
		-- 123 MEVA
		-- 4% Haste
		head="Sakpata's Helm",
		-- 10% DT
		-- 10 MDB
		-- 139 MEVA
		-- 2% Haste
		body="Sakpata's Breastplate",
		-- 6% PDT 
		-- 2% MDT 
		-- 4 MDB
		-- 91 MEVA
		-- 4% Haste
		--hands="Volte Moufles",
		-- 8% DT 
		-- 6 MDB
		-- 112 MEVA
		-- 4% Haste
		hands="Sakpata's Gauntlets",
		-- 10% DT
		ring2="Defending Ring",
		-- 10% PDT
		back=gear.Cichol_AccDA,
		-- 8% Haste
		waist="Ioskeha Belt +1",
		-- 5% PDT 
		-- 4 MDB
		-- 100 MEVA
		-- 6% Haste
		--legs="Pumm. Cuisses +3",
		-- 9% DT 
		-- 9 MDB
		-- 150 MEVA
		-- 4% Haste
		legs="Sakpata's Cuisses",
		-- 4% PDT 
		-- 6% MDT 
		-- 6 MDB
		-- 137 MEVA
		-- 3% Haste
		--feet="Volte Sollerets",
		-- 6% DT 
		-- 7 MDB
		-- 150 MEVA
		-- 2% Haste
		feet="Sakpata's Leggings",
	})
	sets.engaged.AccLow.PDT = set_combine(sets.engaged.PDT, {})
	sets.engaged.AccHigh.PDT = set_combine(sets.engaged.AccLow.PDT, {
		ear1="Telos Earring",
		ear2="Crep. Earring",
		ring1="Flamma Ring",
	})

	sets.engaged.MDT = set_combine(sets.engaged.PDT, {
	})
	sets.engaged.AccLow.MDT = set_combine(sets.engaged.MDT, {})
	sets.engaged.AccHigh.MDT = set_combine(sets.engaged.AccLow.MDT, {
		ear1="Telos Earring",
		ear2="Crep. Earring",
		ring1="Flamma Ring",
	})
			 
	sets.engaged.Conqueror = {}
	sets.engaged.Conqueror.AccLow = set_combine(sets.engaged.Conqueror, {})
	sets.engaged.Conqueror.AccHigh = set_combine(sets.engaged.Conqueror.AccLow, {})
	sets.engaged.Conqueror.PDT = set_combine(sets.engaged.Conqueror,sets.engaged.PDT,{})
	sets.engaged.Conqueror.AccLow.PDT = set_combine(sets.engaged.Conqueror.PDT, {})
	sets.engaged.Conqueror.AccHigh.PDT = set_combine(sets.engaged.Conqueror.AccLow.PDT, {})
	-- Conqueror Aftermath Lv.3 sets
	sets.engaged.Conqueror.AM3 = {}
	sets.engaged.Conqueror.AccLow.AM3 = set_combine(sets.engaged.Conqueror.AM3, {})
	sets.engaged.Conqueror.AccHigh.AM3 = set_combine(sets.engaged.Conqueror.AccLow.AM3, {})
	sets.engaged.Conqueror.PDT.AM3 = set_combine(sets.engaged.Conqueror.AM3,sets.engaged.PDT,{})
	sets.engaged.Conqueror.AccLow.PDT.AM3 = set_combine(sets.engaged.Conqueror.PDT.AM3, {})
	sets.engaged.Conqueror.AccHigh.PDT.AM3 = set_combine(sets.engaged.Conqueror.AccLow.PDT.AM3, {})
			 
	sets.engaged.Ukonvasara = {}
	sets.engaged.Ukonvasara.AccLow = set_combine(sets.engaged.Ukonvasara, {})
	sets.engaged.Ukonvasara.AccHigh = set_combine(sets.engaged.Ukonvasara.AccLow, {})
	sets.engaged.Ukonvasara.PDT = set_combine(sets.engaged.Ukonvasara,sets.engaged.PDT,{})
	sets.engaged.Ukonvasara.AccLow.PDT = set_combine(sets.engaged.Ukonvasara.PDT, {})
	sets.engaged.Ukonvasara.AccHigh.PDT = set_combine(sets.engaged.Ukonvasara.AccLow.PDT, {})
 
	sets.engaged.Bravura = {}
	sets.engaged.Bravura.AccLow = set_combine(sets.engaged.Bravura, {})
	sets.engaged.Bravura.AccHigh = set_combine(sets.engaged.Bravura.AccLow, {})
	sets.engaged.Bravura.PDT = set_combine(sets.engaged.Bravura,sets.engaged.PDT,{})
	sets.engaged.Bravura.AccLow.PDT = set_combine(sets.engaged.Bravura.PDT, {})
	sets.engaged.Bravura.AccHigh.PDT = set_combine(sets.engaged.Bravura.AccLow.PDT, {})
	-- Bravura Aftermath sets, will only apply if aftermath, bravura, and hybridmode are on
	sets.engaged.Bravura.PDT.AM = set_combine(sets.engaged.Bravura,sets.engaged.PDT,{})
	sets.engaged.Bravura.AccLow.PDT.AM = set_combine(sets.engaged.Bravura.PDT.AM , {})
	sets.engaged.Bravura.AccHigh.PDT.AM = set_combine(sets.engaged.Bravura.AccLow.PDT.AM , {})
			 
	sets.engaged.Ragnarok = {}
	sets.engaged.Ragnarok.AccLow = set_combine(sets.engaged.Ragnarok, {})
	sets.engaged.Ragnarok.AccHigh = set_combine(sets.engaged.Ragnarok.AccLow, {})
	sets.engaged.Ragnarok.PDT = set_combine(sets.engaged.Ragnarok,sets.engaged.PDT,{})
	sets.engaged.Ragnarok.AccLow.PDT = set_combine(sets.engaged.Ragnarok.PDT, {})
	sets.engaged.Ragnarok.AccHigh.PDT = set_combine(sets.engaged.Ragnarok.AccLow.PDT, {})

	sets.engaged.Crit = set_combine(sets.engaged, {
		ammo="Yetshila",
		body="Tatena. Harama. +1",
		hands="Flam. Manopolas +2",
		legs="Jokushu Haidate",
	})

	sets.Sakpata = {
		head="Sakpata's Helm",
		body="Sakpata's Breastplate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
	}
			 
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	-- Mighty Strikes TP Gear, combines with current melee set.
	sets.buff.MS = {}
	sets.buff.Madrigal = {
		--hands="Composer's Mitts",
	}
	
	-- Day/Element Helm, if helm is not in inventory or wardrobe, this will not fire, for those who do not own one
	sets.WSDayBonus = {head="Gavialis Helm"}
	
	-- Earrings to use with Upheaval when TP is 3000
	sets.VIT_earring = {}
	
	-- Earrings to use with all other weaponskills when TP is 3000
	sets.STR_earring = {}
	
	-- Mantle to use with Upheaval on Darksday
	sets.Upheaval_shadow = {back="Shadow Mantle"}

	sets.slept = {neck="Vim Torque +1"}

end

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

		if state.TreasureMode.value ~= false then
			equip(sets.sharedTH)
		end

		-- Don't gearswap for weaponskills when Defense is active and Hybrid Mode set to a specific state
		if state.DefenseMode.value ~= 'None' and state.HybridMode ~= 'Normal' then
			eventArgs.handled = true
		end
	end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if state.Buff.Sekkanoki then
			equip(sets.buff.Sekkanoki)
		end

		if state.DefenseMode.value == 'None' and state.HybridMode == 'Normal' then
			-- Replace Moonshade Earring if we're at cap TP
			if player.tp >= 2750 then
				equip(sets.precast.WS.MaxTP)
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'NIN' then
		set_macro_page(1, 1)
	elseif player.sub_job == 'DNC' then
		set_macro_page(2, 1)
	elseif player.sub_job == 'SAM' then
		set_macro_page(3, 1)
	else
		set_macro_page(2, 1)
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
	if not buffactive['Protect'] then
		idleSet = set_combine(idleSet, sets.noprotect)
	end
	if buffactive['Doom'] then
		idleSet = set_combine(idleSet, sets.buff.Doom)
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.EnmityMode.value == 'Down' then
		meleeSet = set_combine(meleeSet, sets.EnmityDown)
	elseif state.EnmityMode.value == 'Up' then
		meleeSet = set_combine(meleeSet, sets.EnmityUp)
	end
	if buffactive['*Madrigal'] then
		meleeSet = set_combine(meleeSet, sets.buff.Madrigal)
	end
	if state.SakpataMode.value ~= false then
		meleeSet = set_combine(meleeSet, sets.Sakpata)
	end
	if state.TreasureMode.value ~= false then
		meleeSet = set_combine(meleeSet, sets.sharedTH)
	end
	if buffactive['Doom'] then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
	end
	return meleeSet
end

function customize_defense_set(defenseSet)		
	if buffactive['Doom'] then
		defenseSet = set_combine(defenseSet, sets.buff.Doom)
	end
	return defenseSet
end

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)
	--update_combat_weapon()
	--update_melee_groups()
end

function job_buff_change(buff, gain)
	if buff == "Aftermath: Lv.3" or buff == "Aftermath" then
		classes.CustomMeleeGroups:clear()
		if (buff == "Aftermath: Lv.3" and gain) or buffactive["Aftermath: Lv.3"] then
			if player.equipment.main == "Conqueror" then
				classes.CustomMeleeGroups:append('AM3')
				if gain then
					send_command('timers create "Aftermath: Lv.3" 180 down;wait 120;input /echo Aftermath: Lv.3 [WEARING OFF IN 60 SEC.];wait 30;input /echo Aftermath: Lv.3 [WEARING OFF IN 30 SEC.];wait 20;input /echo Aftermath: Lv.3 [WEARING OFF IN 10 SEC.]')
				else
					send_command('timers delete "Aftermath: Lv.3"')
					add_to_chat(123,'AM3: [OFF]')
				end
			end
		end
		if (buff == "Aftermath" and gain) or buffactive.Aftermath then
			if player.equipment.main == "Bravura" and state.HybridMode.value == 'PDT' then
				classes.CustomMeleeGroups:append('AM')
			end
		end
	end
	if buff == "Aftermath: Lv.3" or buff == "Aftermath" then
		handle_equipping_gear(player.status)
	end
	if buff == 'Blood Rage' and gain then
		send_command('timers create "Blood Rage" 60 down abilities/00255.png')
		else
		send_command('timers delete "Blood Rage"')
	end
	if buff == 'Warcry' and gain then
		send_command('timers create "Warcry" 60 down abilities/00255.png')
		else
		send_command('timers delete "Warcry"')
	end
	if buff == "sleep" and gain and player.hp > 200 and player.status == "Engaged" then
		equip(sets.slept)
		else
		handle_equipping_gear(player.status)
	end
	-- Haste mode is only relevant for Dual Wield subjobs
	if S{'NIN','DNC'}:contains(player.sub_job) then
		-- This should only apply if we are truly Dual Wielding
		if not S{'grip','strap'}:contains(player.equipment.sub:lower()) then
			-- If we gain or lose any haste buffs, adjust which gear set we target.
			if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
				determine_haste_group()
				if not midaction() then
					handle_equipping_gear(player.status)
				end
			end
		end
	end
end