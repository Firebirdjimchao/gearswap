function user_setup()
	gear.AugMauler = {
		name="Mauler's Mantle",
		augments={
			"STR+2",
			"DEX+2",
			"Crit. hit damage +1%"
		}
	}

	state.OffenseMode:options('Normal', 'AccLow', 'AccHigh')
	state.RangedMode:options('Normal')
	state.HybridMode:options('Normal', 'PDT')
	state.WeaponskillMode:options('Normal', 'AccLow', 'AccHigh', 'Attack')
	state.CastingMode:options('Normal')
	state.IdleMode:options('Normal', 'Regen')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.MagicalDefenseMode:options('MDT')
 
	update_combat_weapon()
	update_melee_groups()
	--select_default_macro_book()
end

function init_gear_sets()
			 
	--------------------------------------
	-- Precast sets
	--------------------------------------
 
	-- Sets to apply to arbitrary JAs
	sets.precast.JA.Berserk = {body="Pumm. Lorica +1"}
	sets.precast.JA['Aggressor'] = {}
	sets.precast.JA['Mighty Strikes'] = {hands="Agoge Mufflers +1"}
	sets.precast.JA['Blood Rage'] = {}
	sets.precast.JA['Warcry'] = {}
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk"}
	-- Sets to apply to any actions of spell.type
	sets.precast.Waltz = {
		ear1="Roundel Earring",
		back="Iximulew Cape"
	}
				 
	-- Sets for specific actions within spell.type
	sets.precast.Waltz['Healing Waltz'] = {}
 
	-- Sets for fast cast gear for spells
	sets.precast.FC = {
		-- ?% FC
		head="Cizin Helm",
		-- 2% FC
		neck="Jeweled Collar",
		-- 2%
		ear1="Loquac. Earring"
	}
 
	-- Fast cast gear for specific spells or spell maps
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {})

	-- Weaponskill sets
	sets.precast.WS = {
		ammo="Ginsen",
		-- STR haste aug
		head="Otomi Helm",
		--neck="Asperity Necklace",
		neck=gear.ElementalGorget,
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Gorney Haubert +1",
		hands="Agoge Mufflers +1",
		ring1="Rajas Ring",
		ring2="Ifrit Ring",
		back=gear.AugMauler,
		waist="Windbuffet Belt +1",
		legs="Agoge Cuisses +1",
		feet="Pumm. Calligae +1"
	}
	sets.precast.WS.AccLow = set_combine(sets.precast.WS, {
		head="Yaoyotl Helm"
	})
	sets.precast.WS.AccHigh = set_combine(sets.precast.WS.AccLow, {
		ammo="Jukukik Feather",
		head="Yaoyotl Helm",
		-- DEX Haste Aug
		hands="Buremte Gloves",
		waist="Anguinus Belt",
		legs="Pumm. Cuisses +1",
		feet="Scamp's Sollerets"
	})
	sets.precast.WS.Attack = set_combine(sets.precast.WS, {
	})
	sets.precast.WS.MS = set_combine(sets.precast.WS, {
	})
	
	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		neck="Stoicheion Medal",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		ring1="Acumen Ring",
		back="Toro Cape",
	})
			 
	-- Specific weaponskill sets.
	sets.precast.WS["Upheaval"] = set_combine(sets.precast.WS,{
	})
	sets.precast.WS["Upheaval"].AccLow = set_combine(sets.precast.WS.AccLow, {
	})
	sets.precast.WS["Upheaval"].AccHigh = set_combine(sets.precast.WS.AccHigh, {
	})
	sets.precast.WS["Upheaval"].Attack = set_combine(sets.precast.WS.Attack, {
	})
	sets.precast.WS["Upheaval"].MS = set_combine(sets.precast.WS.MS, {
	})

	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS,{
	})
	sets.precast.WS["Ukko's Fury"].AccLow = set_combine(sets.precast.WS.AccLow, {
	})
	sets.precast.WS["Ukko's Fury"].AccHigh = set_combine(sets.precast.WS.AccHigh, {
	})
	sets.precast.WS["Ukko's Fury"].Attack = set_combine(sets.precast.WS.Attack, {
	})
	sets.precast.WS["Ukko's Fury"].MS = set_combine(sets.precast.WS.MS, {
	})
			 
	sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS["King's Justice"].AccLow = set_combine(sets.precast.WS.AccLow, {
	})
	sets.precast.WS["King's Justice"].AccHigh = set_combine(sets.precast.WS.AccHigh, {
	})
	sets.precast.WS["King's Justice"].Attack = set_combine(sets.precast.WS.Attack, {
	})
	sets.precast.WS["King's Justice"].MS = set_combine(sets.precast.WS.MS, {
	})
			 
	sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Fell Cleave'].AccLow = set_combine(sets.precast.WS.AccLow, {
	})
	sets.precast.WS['Fell Cleave'].AccHigh = set_combine(sets.precast.WS.AccHigh, {
	})
	sets.precast.WS['Fell Cleave'].Attack = set_combine(sets.precast.WS.Attack, {
	})
	sets.precast.WS['Fell Cleave'].MS = set_combine(sets.precast.WS.MS, {
	})
	
	-- Magical WS
	
	sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Cloudsplitter'].AccLow = set_combine(sets.precast.WS['Cloudsplitter'], {
	})
	sets.precast.WS['Cloudsplitter'].AccHigh = set_combine(sets.precast.WS['Cloudsplitter'], {
	})
	sets.precast.WS['Cloudsplitter'].Attack = set_combine(sets.precast.WS['Cloudsplitter'], {
	})
	sets.precast.WS['Cloudsplitter'].MS = set_combine(sets.precast.WS['Cloudsplitter'], {
	})
	
	sets.precast.WS['Infernal Scythe'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Infernal Scythe'].AccLow = set_combine(sets.precast.WS['Infernal Scythe'], {
	})
	sets.precast.WS['Infernal Scythe'].AccHigh = set_combine(sets.precast.WS['Infernal Scythe'], {
	})
	sets.precast.WS['Infernal Scythe'].Attack = set_combine(sets.precast.WS['Infernal Scythe'], {
	})
	sets.precast.WS['Infernal Scythe'].MS = set_combine(sets.precast.WS['Infernal Scythe'], {
	})
	
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Aeolian Edge'].AccLow = set_combine(sets.precast.WS['Aeolian Edge'], {
	})
	sets.precast.WS['Aeolian Edge'].AccHigh = set_combine(sets.precast.WS['Aeolian Edge'], {
	})
	sets.precast.WS['Aeolian Edge'].Attack = set_combine(sets.precast.WS['Aeolian Edge'], {
	})
	sets.precast.WS['Aeolian Edge'].MS = set_combine(sets.precast.WS['Aeolian Edge'], {
	})
	
	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Flash Nova'].AccLow = set_combine(sets.precast.WS['Flash Nova'], {
	})
	sets.precast.WS['Flash Nova'].AccHigh = set_combine(sets.precast.WS['Flash Nova'], {
	})
	sets.precast.WS['Flash Nova'].Attack = set_combine(sets.precast.WS['Flash Nova'], {
	})
	sets.precast.WS['Flash Nova'].MS = set_combine(sets.precast.WS['Flash Nova'], {
	})
	
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Cataclysm'].AccLow = set_combine(sets.precast.WS['Cataclysm'], {
	})
	sets.precast.WS['Cataclysm'].AccHigh = set_combine(sets.precast.WS['Cataclysm'], {
	})
	sets.precast.WS['Cataclysm'].Attack = set_combine(sets.precast.WS['Cataclysm'], {
	})
	sets.precast.WS['Cataclysm'].MS = set_combine(sets.precast.WS['Cataclysm'], {
	})
 
	--------------------------------------
	-- Midcast sets
	--------------------------------------
 
	-- Generic spell recast set
	sets.midcast.FastRecast = {
		-- ?% FC
		head="Cizin Helm",
		-- 2% FC
		neck="Jeweled Collar",
		-- 2%
		ear1="Loquac. Earring",
		-- 3% H
		body="Xaddi Mail",
		-- 5% H
		hands="Agoge Mufflers +1",
		ring2="Dark Ring",
		back="Shadow Mantle",
		-- 6%
		legs="Pumm. Cuisses +1",
		-- 5% H
		feet="Scamp's Sollerets"
	}
							 
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast,{
	})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
 
	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {
		head="Sulevia's Mask +1",
		neck="Twilight Torque",
		ear1="Ethereal Earring",
		ear2="Novia Earring",
		body="Sulevia's Plate. +1",
		hands="Sulev. Gauntlets +1",
		ring1=gear.DarkRing.physical,
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Gishdubar Sash",
		feet="Hermes' Sandals"
	}
 
	sets.idle.Town = set_combine(sets.idle,{
	})
			 
	sets.idle.Regen = set_combine(sets.idle,{
	})
			 
	sets.idle.Weak = set_combine(sets.idle,{
	})
			 
	-- Defense sets
	-- Total: 33%
	-- <36%: use Shadow Mantle
	sets.defense.PDT = set_combine(sets.idle,{
		head="Nocturnus Helm",
		-- 5%
		neck="Twilight Torque",
		-- 8%
		body="Mekira Meikogai",
		-- 4%
		hands="Agoge Mufflers +1",
		-- 5%
		ring1="Patricius Ring",
		-- 5%
		ring2="Dark Ring",
		back="Shadow Mantle",
		-- 4%
		waist="Flume Belt +1",
		-- 2%
		legs="Osmium Cuisses",
		feet="Scamp's Sollerets"
	})
	sets.defense.Reraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})
	
	-- MDT: 18%
	-- MDB: 14
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.defense.MDT = set_combine(sets.idle,{
		-- 2
		head="Yaoyotl Helm",
		-- 5%
		neck="Twilight Torque",
		-- 8%
		body="Mekira Meikogai",
		-- 2
		hands="Agoge Mufflers +1",
		ring1="Shadow Ring",
		-- 5%
		ring2="Dark Ring",
		-- 4
		back="Tuilha Cape",
		-- 4%
		waist="Flume Belt +1",
		-- 4
		legs="Osmium Cuisses",
		-- 2
		feet="Scamp's Sollerets"
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
	sets.engaged = set_combine(sets.idle,{
		ammo="Ginsen",
		head="Flam. Zucchetto +1",
		neck="Asperity Necklace",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
		body="Uac Jerkin",
		hands="Sulev. Gauntlets +1",
		ring1="Rajas Ring",
		ring2="Apate Ring",
		back="Mauler's Mantle",
		waist="Cetl Belt",
		legs="Sulevi. Cuisses +1",
		feet="Flam. Gambieras +1",
	})
	
	sets.engaged.AccLow = set_combine(sets.engaged, {
	})
	sets.engaged.AccHigh = set_combine(sets.engaged, {
		ammo="Jukukik Feather",
		head="Yaoyotl Helm",
		neck="Iqabi Necklace",
		body="Gorney Haubert +1",
		-- DEX Haste Aug
		hands="Buremte Gloves",
		ring2="Patricius Ring",
		waist="Olseni Belt",
		legs="Pumm. Cuisses +1",
		feet="Scamp's Sollerets"
	})
	sets.engaged.PDT = set_combine(sets.defense.PDT, {
	})
	sets.engaged.AccLow.PDT = set_combine(sets.engaged.PDT, {})
	sets.engaged.AccHigh.PDT = set_combine(sets.engaged.AccLow.PDT, {})
			 
	sets.engaged.Conqueror = {}
	sets.engaged.Conqueror.AccLow = set_combine(sets.engaged.Conqueror, {})
	sets.engaged.Conqueror.AccHigh = set_combine(sets.engaged.Conqueror.AccLow, {})
	sets.engaged.Conqueror.PDT = set_combine(sets.engaged.Conqueror, {})
	sets.engaged.Conqueror.AccLow.PDT = set_combine(sets.engaged.Conqueror.PDT, {})
	sets.engaged.Conqueror.AccHigh.PDT = set_combine(sets.engaged.Conqueror.AccLow.PDT, {})
	-- Conqueror Aftermath Lv.3 sets
	sets.engaged.Conqueror.AM3 = {}
	sets.engaged.Conqueror.AccLow.AM3 = set_combine(sets.engaged.Conqueror.AM3, {})
	sets.engaged.Conqueror.AccHigh.AM3 = set_combine(sets.engaged.Conqueror.AccLow.AM3, {})
	sets.engaged.Conqueror.PDT.AM3 = set_combine(sets.engaged.Conqueror.AM3, {})
	sets.engaged.Conqueror.AccLow.PDT.AM3 = set_combine(sets.engaged.Conqueror.PDT.AM3, {})
	sets.engaged.Conqueror.AccHigh.PDT.AM3 = set_combine(sets.engaged.Conqueror.AccLow.PDT.AM3, {})
			 
	sets.engaged.Ukonvasara = {}
	sets.engaged.Ukonvasara.AccLow = set_combine(sets.engaged.Ukonvasara, {})
	sets.engaged.Ukonvasara.AccHigh = set_combine(sets.engaged.Ukonvasara.AccLow, {})
	sets.engaged.Ukonvasara.PDT = set_combine(sets.engaged.Ukonvasara, {})
	sets.engaged.Ukonvasara.AccLow.PDT = set_combine(sets.engaged.Ukonvasara.PDT, {})
	sets.engaged.Ukonvasara.AccHigh.PDT = set_combine(sets.engaged.Ukonvasara.AccLow.PDT, {})
 
	sets.engaged.Bravura = {}
	sets.engaged.Bravura.AccLow = set_combine(sets.engaged.Bravura, {})
	sets.engaged.Bravura.AccHigh = set_combine(sets.engaged.Bravura.AccLow, {})
	sets.engaged.Bravura.PDT = set_combine(sets.engaged.Bravura, {})
	sets.engaged.Bravura.AccLow.PDT = set_combine(sets.engaged.Bravura.PDT, {})
	sets.engaged.Bravura.AccHigh.PDT = set_combine(sets.engaged.Bravura.AccLow.PDT, {})
	-- Bravura Aftermath sets, will only apply if aftermath, bravura, and hybridmode are on
	sets.engaged.Bravura.PDT.AM = set_combine(sets.engaged.Bravura, {})
	sets.engaged.Bravura.AccLow.PDT.AM = set_combine(sets.engaged.Bravura.PDT.AM , {})
	sets.engaged.Bravura.AccHigh.PDT.AM = set_combine(sets.engaged.Bravura.AccLow.PDT.AM , {})
			 
	sets.engaged.Ragnarok = {}
	sets.engaged.Ragnarok.AccLow = set_combine(sets.engaged.Ragnarok, {})
	sets.engaged.Ragnarok.AccHigh = set_combine(sets.engaged.Ragnarok.AccLow, {})
	sets.engaged.Ragnarok.PDT = set_combine(sets.engaged.Ragnarok, {})
	sets.engaged.Ragnarok.AccLow.PDT = set_combine(sets.engaged.Ragnarok.PDT, {})
	sets.engaged.Ragnarok.AccHigh.PDT = set_combine(sets.engaged.Ragnarok.AccLow.PDT, {})
			 
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	-- Mighty Strikes TP Gear, combines with current melee set.
	sets.buff.MS = {}
	
	-- Day/Element Helm, if helm is not in inventory or wardrobe, this will not fire, for those who do not own one
	sets.WSDayBonus = {head="Gavialis Helm"}
	
	-- Earrings to use with Upheaval when TP is 3000
	sets.VIT_earring = {}
	
	-- Earrings to use with all other weaponskills when TP is 3000
	sets.STR_earring = {}
	
	-- Mantle to use with Upheaval on Darksday
	sets.Upheaval_shadow = {back="Shadow Mantle"}

end