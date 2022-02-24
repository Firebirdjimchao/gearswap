-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff.Sentinel = buffactive.sentinel or false
	state.Buff.Cover = buffactive.cover or false
	state.Buff.Doom = buffactive.Doom or false

	state.CP = M(false, "Capacity Points Mode")
	state.Warp = M(false, "Warp Mode")
	state.MP = M(false, "Mana Mode")
	state.Weapon = M(false, "Weapon Lock")
	state.Neck = M(false, "Neck Mode")
	state.TreasureMode = M(false, 'TH')
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Gear Modes
function user_setup()
	state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
	state.HybridMode:options('Normal', 'HIGH', 'MID', 'LOW')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'SIRD', 'HPBAL')    
	state.IdleMode:options('DT', 'Normal', 'Pulling')
	state.ShieldMode = M{'Ochain','Aegis', 'Srivatsa'}
	 
	-- Allows the use of Ctrl + ~ and Alt + ~ for 2 more macros of your choice.
	-- send_command('bind ^` input /ja "Cover" <stal>') --Ctrl'~'
	-- send_command('bind !` input /ja "Divine Emblem" <me>') --Alt'~'
	send_command('bind f9 gs c cycle OffenseMode') --F9
	send_command('bind ^f9 gs c cycle WeaponSkillMode') --Ctrl'F9'
	send_command('bind f10 gs c cycle HybridMode') --F10
	send_command('bind f11 gs c cycle CastingMode') --F11
	send_command('bind !f9 gs c cycle ShieldMode') --Alt 'F9'
	send_command('bind @c gs c toggle CP') --WindowKey'C'
	send_command('bind @r gs c toggle Warp') --Windowkey'R'
	send_command('bind @m gs c toggle MP') --Windowkey'M'
	send_command('bind @w gs c toggle Weapon') --Windowkey'W'
	send_command('bind @t gs c toggle Twilight') --Windowkey'T'
	send_command('bind @n gs c toggle Neck') --Windowkey'N'

	state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
	state.EquipShield = M(false, 'Equip Shield w/Defense')
	--send_command('lua l gearinfo')
 
	select_default_macro_book()
	--set_lockstyle()
 
	gear.PhalanxHead = {name="Valorous Mask", augments={'Magic dmg. taken -2%','Pet: DEX+15','Phalanx +4','Accuracy+3 Attack+3',}}
	gear.PhalanxBody = {name="Odyss. Chestplate", augments={'"Mag.Atk.Bns."+21','MND+6','Phalanx +3',}}
	gear.PDTCape = {name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Phys. dmg. taken-10%',}}
 
	Haste = 0
	DW_needed = 0
	DW = false
	moving = false
	update_combat_form()
	determine_haste_group()
end
 
-- Erases the Key Binds above when you switch to another job.
function user_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind !-')
	send_command('unbind ^=')
	send_command('unbind f11')
	send_command('unbind @c')
	send_command('unbind @r')
	send_command('unbind @m')   
	send_command('unbind @w')
	send_command('unbind @t')
	send_command('unbind @n')
	send_command('unbind ^f11')
	send_command('unbind !f11')
	send_command('unbind @f10')
	send_command('unbind @f11')
	send_command('gs enable all')   
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	------------------------------------------------------------------------------------------------
	---------------------------------------- Precast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	 
	sets.Enmity = {
		main="Brilliance", --14
		--ammo="Sapience Orb", --2
		--head="Loess Barbuta +1", --9~14
		-- 10 Enmity
		neck="Unmoving Collar +1",
		-- 4 Enmity
		ear1="Cryptic Earring",
		-- 5 Enmity
		ear2="Trux Earring",
		-- 10 Enmity
		body="Emet Harness +1",
		--body="Souveran Cuirass +1", --20
		--hands="Yorium Gauntlets", --12
		-- 5 Enmity
		ring1="Supershear Ring",
		-- 5 Enmity
		ring2="Pernicious Ring",
		--ring1="Apeile Ring", --5~9
    --ring2="Apeile Ring +1", --5~9
		--back=gear.PDTCape, --10
		-- 3 Enmity
		waist="Goading Belt",
		--waist="Creed Baudrier", --5
		--legs="Souveran Diechlings +1", --9
		--feet="Eschite Greaves", --15
	} --121~134

	sets.MAB = {
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
	 
	sets.precast.JA['Invincible'] = set_combine(sets.Enmity, {legs="Caballarius breeches +1"})
	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {sub="Aegis", ear1="Knightly earring"})   
	sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity, {feet="Reverence leggings +1"})
	sets.precast.JA['Sentinel'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Cover'] = set_combine(sets.Enmity, {head="Reverence coronet +1"})
	sets.precast.JA['Rampart'] = set_combine(sets.Enmity, {head="Caballarius coronet +1"})
	sets.precast.JA['Fealty'] = set_combine(sets.Enmity, {head="Caballarius surcoat +1"})
	sets.precast.JA['Chivalry'] = set_combine(sets.Enmity, {"Caballarius gauntlets +1"})
	sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity, {"Chevalier's sabatons +1"})
	sets.precast.JA['Sepulcher'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	 
	sets.precast.FC = {
		main="Sakpata's Sword", --10
		sub="Srivatsa",
		--ammo="Impatiens", --2QM
		head="Carmine Mask +1", --14
		neck="Voltsurge Torque", --4       
		-- 2%
		ear1="Loquac. Earring",
		ear2="Etiolation Earring", --1
		body="Reverence Surcoat +2", --5 -- +3=10
		-- 5% + 3%
		hands="Leyline Gloves",
		-- 2%
		ring1="Prolix Ring",
		-- 4%
		ring2="Kishar Ring",
		--back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10',}}, --10FC
		waist="Creed Baudrier", --40HP
		legs="Arjuna Breeches", --4
		feet="Carmine Greaves +1", --5 + AUG
	}
	 
	sets.precast.Cure = set_combine(sets.precast.FC, {
		--body="Jumalik Mail", --10
		--neck="Diemer Gorget", --4
		ear2="Mendi. Earring", --5
	})

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})
	 
	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {})

	------------------------------------------------------------------------------------------------
	-------------------------------------- Sub Job Specific ----------------------------------------
	------------------------------------------------------------------------------------------------
	--- Warrior
	sets.precast.JA['Provoke'] = sets.Enmity
	--- Dancer
	sets.precast.Waltz = {}
	sets.precast.WaltzSelf = set_combine(sets.precast.Waltz, {ring1="Asklepian Ring"})
	--- Rune Fencer
	 
	------------------------------------------------------------------------------------------------
	------------------------------------- Weapon Skill Sets ----------------------------------------
	------------------------------------------------------------------------------------------------

	sets.precast.WS = {
		--ammo="Aurgelmir Orb +1",
		head="Sakpata's Helm",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
		body="Sakpata's Breastplate",
		hands="Sakpata's Gauntlets",
		ring1="Hetairoi Ring",
		ring2="Regal Ring",
		--back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		waist="Fotia Belt",
		legs="Sakpata's Cuisses",
		feet="Sulevia's Leggings +2",
	}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.MAB = set_combine(sets.MAB, {
		head="Nyame Helm",
		neck="Fotia Gorget",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		--waist="Fotia Belt",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS.MaxTP = {
		ear1="Lugra Earring +1",
	}
		 
	sets.precast.WS['Atonement'] = {}
	sets.precast.WS['Atonement'].Acc = set_combine(sets.precast.WS['Atonement'], {})
	sets.precast.WS['Requiescat'] = {}
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {})
	sets.precast.WS['Chant du Cygne'] = {}
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {})
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Sanguine Blade'].Acc = set_combine(sets.precast.WS['Sanguine Blade'], {})
		 
	sets.precast.WS['Savage Blade'] = {
		--ammo="Aurgelmir Orb +1",
		head="Nyame Helm", --7
		neck="Caro Necklace",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
		body="Nyame Mail", --10
		hands="Nyame Gauntlets", --8
		--back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
		waist="Sailfi Belt +1",
		legs="Nyame Flanchard", --9
		feet="Nyame Sollerets",
	}
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {})
 
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB, {
	})

	------------------------------------------------------------------------------------------------
	---------------------------------------- Midcast Sets ------------------------------------------
	------------------------------------------------------------------------------------------------    
		 
	sets.midcast.FastRecast = sets.precast.FC
	sets.midcast.Utsusemi = sets.Enmity
	sets.midcast.Flash = sets.Enmity
	sets.midcast['Enhancing Magic'] = sets.Enmity
	sets.midcast.Reprisal = sets.Enmity
	sets.midcast.Crusade = sets.Enmity
	sets.midcast.Enlight = sets.Enmity
	sets.midcast['Blue Magic'] = sets.Enmity
		 
	sets.midcast.Cure = set_combine(sets.Enmity, {
		ammo="Impatiens", --10SIRD
		neck="Phalaina Locket", --4
		head="Souveran Schaller +1", --0/15 20SIRD
		ear1="Nourish. Earring +1",
		ear2="Mendi. Earring",
		body="Souveran cuirass +1", --15
		hands="Macabre Gauntlets +1",
		legs="Souveran Diechlings +1", --0/23
		feet="Odyssean Greaves", --7 --20SIRD
	}) --60SIRD, 10Merits, 37/30CurePot
		 
	sets.midcast.Phalanx = {
		main="Sakpata's Sword", --5
		sub="Priwen", --2
		ammo="Staunch Tathlum +1",
		head=gear.PhalanxHead, --4
		ear1="Mimir earring",
		neck="Incanter's Torque",
		body=gear.PhalanxBody, --3
		hands="Souveran Handschuhs +1", --5
		ring1="Stikini Ring",
		ring2="Stikini Ring +1",	
		Back="Weard Mantle", --4
		waist="Flume Belt",
		legs="Sakpata's Cuisses", --5
		feet="Souveran Schuhs +1", --5
	} --20 Need to DarkMatter Ody Head and Body!
		 
	sets.midcast.Protect = {sub="Srivatsa",ring1="Sheltered Ring"}
	sets.midcast.Shell = {ring1="Sheltered Ring"}
	 
	------------------------------------------------------------------------------------------------
	----------------------------------------- SIRD Sets --------------------------------------------
	------------------------------------------------------------------------------------------------    
	sets.midcast.SIRD = {--Merits 10SIRD
		ammo="Staunch tathlum +1", --10SIRD
		head="Souveran Schaller +1", --20SIRD
		neck="Moonlight Necklace", --15SIRD
		hands="Eschite Gauntlets", --15SIRD
		back=gear.PDTCape, --10SIRD
		-- waist="Rumination Sash", --10SIRD
		legs="Founder's Hose", --30SIRD
		feet="Odyssean Greaves", --20SIRD
	} --115SIRD
 
	sets.precast.FC.SIRD = {Main="Sakpata's Sword", --10
		ammo="Impatiens", --2QM
		kead="Carmine Mask +1", --14
		neck="Voltsurge Torque", --4       
		ear1="Loquacious Earring", --2
		ear2="Etiolation Earring", --1
		body="Reverence Surcoat +2", --5 -- +3=10
		hands="Leyline Gloves", --8
		ring1="Prolix Ring", -- 3
		ring2="Kishar Ring", --  4FC --70HP 
		back={ name="Rudianos's Mantle", augments={'"Fast Cast"+10',}}, --10FC
		waist="Creed Baudrier", --40HP
		legs="Arjuna Breeches", --4
		feet="Carmine Greaves +1", --5 + AUG
	}--115SIRD

	sets.midcast.Flash.SIRD = {--Merits 10SIRD
		main="Brilliance", --14 Enm
		-- sub="Ajax +1",
		ammo="Impatiens", --10SIRD Neg2Enm
		head="Souveran Schaller +1", --20SIRD Neg9~14Enm
		neck="Moonlight Necklace", --15SIRD
		ear1="Knightly Earring", --9 SIRD
		ear2="Odnowa Earring +1",
		body="Souveran Cuirass +1", --20
		hands="Yorium Gauntlets", --12 Enm
		ring1="Apeile Ring", --5~9 Enm
		ring2="Apeile Ring +1", --5~9 Enm
		back=gear.PDTCape, --10SIRD
		waist="Creed Baudrier", --5 Enm
		legs="Carmine Cuisses +1", --20SIRD Neg9Enm
		feet="Odyssean Greaves", --20SIRD Neg15Enm
	} --80~88, 105SIRD
	 
	sets.midcast.Cure.SIRD = set_combine(sets.midcast.Cure, sets.midcast.SIRD)
	sets.midcast.Phalanx.SIRD = set_combine(sets.midcast.Phalanx, sets.midcast.SIRD)
	sets.midcast.Reprisal.SIRD = set_combine(sets.midcast.Reprisal, sets.midcast.SIRD)
	sets.midcast.Crusade.SIRD = set_combine(sets.midcast.Crusade, sets.midcast.SIRD)
	sets.midcast.Utsusemi.SIRD = set_combine(sets.midcast.Utsusemi, sets.midcast.SIRD)
	sets.midcast['Blue Magic'].SIRD = set_combine(sets.midcast['Blue Magic'], sets.midcast.SIRD)
	 
	------------------------------------------------------------------------------------------------
	---------------------------------------- HPBAL Sets --------------------------------------------
	------------------------------------------------------------------------------------------------    
	sets.precast.FC.HPBAL = { --10SIRD Merits, 10DT Set Bonus
		main="Sakpata's Sword", --10FC
		ammo="Sapience Orb", --2FC, 0SIRD, 0DT
		head="Carmine Mask +1", --14FC
		neck="Voltsurge Torque", --5FC, 0SIRD, 0DT
		ear1="Tuisto Earring",
		ear2="Odnowa Earring +1",
		body="Reverence Surcoat +2", --5FC, 0SIRD, 10DT
		hands="Leyline Gloves", --8FC
		ring1="Moonlight Ring", --110HP
		ring2="Moonlight Ring", --110HP
		back="Moonlight Cape", --0FC, 0SIRD, 5DT --Rudios??
		waist="Creed Baudrier", --40HP
		legs="Souveran Diechlings +1", --0FC, 0SIRD, 4DT
		feet="Souveran Schuhs +1", --0FC, 0SIRD, 5DT
	} --42FC, 10SIRD, 38DT
		 
	sets.midcast.HPBAL = { --10SIRD Merits --4DT Set Bonus
		ammo="Staunch tathlum +1", --0FC, 11SIRD, 3DT
		head="Souveran Schaller +1", --0FC, 20SIRD, 0DT, 9Enm
		neck="Moonlight Necklace", --0FC, 15SIRD, 0DT
		ear1="Knightly Earring",
		ear2="Odnowa Earring +1", --9SIRD, -100HP
		body="Souveran Cuirass +1", --5FC, 0SIRD, 10DT, 9Enm
		hands="Souveran Handschuhs +1", --0FC, 0SIRD, 4DT, 9Enm
		ring1="Moonlight Ring", 
		ring2="Defending Ring", 
		back="Moonbeam Cape", --0FC, 0SIRD, 5DT
		waist="Creed Baudrier", --40 HP 5Enm
		-- waist="Rumination Sash", --0FC, 10SIRD, 0DT, -40HP
		legs="Founder's Hose", --0FC, 30SIRD, 0DT, -108HP
		-- feet="Souveran Schuhs +1", --0FC, 0SIRD, 5DT
		feet="Odyssean greaves", --20 SIRD, 5FC, 6Enm aug
	} --0FC, 105SIRD, 44DT, 62~70Enm
		 
	sets.midcast.Flash.HPBAL = {
		main="Brilliance", --14
		-- sub="Ajax +1", --11
		ammo="Sapience Orb", --2
		head="Loess Barbuta +1", --9~14
		neck="Moonlight Necklace", --15
		ear1="Tuisto Earring",
		ear2="Odnowa Earring +1",
		body="Souveran Cuirass +1", --20
		hands="Yorium Gauntlets", --12
		ring1="Apeile Ring", --5~9
		ring2="Apeile Ring +1", --5~9
		back=gear.PDTCape, --10
		waist="Creed Baudrier", --5
		legs="Souveran Diechlings +1", --9
		feet="Eschite Greaves", --15
	} --115~128
		 
	sets.midcast.Shell.HPBAL = set_combine(sets.midcast, sets.midcast.HPBAL)
	sets.midcast.Protect.HPBAL = set_combine(sets.midcast, sets.midcast.HPBAL)
	sets.midcast.Cure.HPBAL = set_combine(sets.midcast.Cure, sets.midcast.HPBAL)
	sets.midcast.Phalanx.HPBAL = set_combine(sets.midcast.Phalanx, sets.midcast.HPBAL)
	sets.midcast.Reprisal.HPBAL = set_combine(sets.midcast.Reprisal, sets.midcast.HPBAL)
	sets.midcast.Crusade.HPBAL = set_combine(sets.midcast.Crusade, sets.midcast.HPBAL)
	sets.midcast.Utsusemi.HPBAL = set_combine(sets.midcast.Utsusemi, sets.midcast.HPBAL)
	sets.midcast['Blue Magic'].HPBAL = set_combine(sets.midcast['Blue Magic'], sets.midcast.HPBAL)

	sets.precast.WS.HPBAL = {}
	 
	------------------------------------------------------------------------------------------------
	----------------------------------------- Idle Sets --------------------------------------------
	------------------------------------------------------------------------------------------------
 
	sets.idle = {
		--main="Sakpata's sword",
		ammo="Homiliary",
		head="Nyame Helm",
		neck="Loricate Torque +1",
		ear1="Ethereal Earring",
		ear2="Odnowa Earring +1",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Carmine Cuisses +1",
		feet="Nyame Sollerets",
	}

	sets.noprotect = {ring1="Sheltered Ring"}
 
	sets.idle.DT = set_combine(sets.DT, {
	})
	
	sets.idle.Pulling = set_combine(sets.idle, {
		--ammo="Eluder's Sachet",
		head="Sakpata's Helm",
		neck="Unmoving Collar +1",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		ring1="Warden's Ring",
		ring2="Fortified Ring",
		-- ring2="Gelatinous Ring +1",
		back="Moonbeam Cape",
		--waist="Carrier's Sash",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
	})
 
	sets.idle.Eva = set_combine(sets.idle, {
		head="Nyame Helm", --30
		body="Nyame Mail", --30
		hands="Nyame Gauntlets", --30
		legs="Nyame Flanchard", --30
		feet="Nyame Sollerets", --30    
	})
		 
	sets.idle.Town = set_combine(sets.idle, {
		body="Councilor's Garb",
	})

	sets.idle.Regen = set_combine(sets.idle, {
		neck="Bathy Choker +1",
		ring1="Sheltered Ring",
	})
 
	------------------------------------------------------------------------------------------------
	---------------------------------------- Engaged Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	-- This is a Set that would only be used when you are NOT Dual Wielding.
	-- There are no haste parameters set for this build, because you wouldn't be juggling DW gear, you would always use the same gear, other than Damage Taken and Accuracy sets which ARE included below.
	sets.engaged = sets.idle.Pulling
 
	------------------------------------------------------------------------------------------------
	-------------------------------------- Dual Wield Sets -----------------------------------------
	------------------------------------------------------------------------------------------------
	-- * NIN Sub Native DW Trait: 25% DW
	-- * DNC Sub Native DW Trait: 15% DW

	-- No Magic Haste (??% DW to cap)
	sets.engaged.DW = {
	} -- ??% ??Acc

	-- 15% Magic Haste (??% DW to cap)
	sets.engaged.DW.LowHaste = {
	} -- ??% ??Acc

	-- 30% Magic Haste (??% DW to cap)
	sets.engaged.DW.MidHaste = {
	} -- ??% ??Acc

	-- 40% Magic Haste (??% DW to cap)
	sets.engaged.DW.HighHaste = {
	} -- ??% ??Acc

	-- 45% Magic Haste (??% DW to cap)
	sets.engaged.DW.MaxHaste = {
	} -- ??% ??Acc
		 
	------------------------------------------------------------------------------------------------
	--------------------------------------- Accuracy Sets ------------------------------------------
	------------------------------------------------------------------------------------------------
	-- Define three tiers of Accuracy.  These sets are cycled with the F9 Button to increase accuracy in stages as desired.
	sets.engaged.Acc1 = {} --1118
	sets.engaged.Acc2 = {} --1151
	sets.engaged.Acc3 = {} --1203
	-- Base Shield
	sets.engaged.LowAcc = set_combine(sets.engaged, sets.engaged.Acc1)
	sets.engaged.MidAcc = set_combine(sets.engaged, sets.engaged.Acc2)
	sets.engaged.HighAcc = set_combine(sets.engaged, sets.engaged.Acc3)
	-- Base DW
	sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, sets.engaged.Acc1)
	sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW, sets.engaged.Acc2)
	sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW, sets.engaged.Acc3)
	-- LowHaste DW
	sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Acc1)
	sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Acc2)
	sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Acc3)
	-- MidHaste DW
	sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Acc1)
	sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Acc2)
	sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Acc3) 
	-- HighHaste DW
	sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Acc1)
	sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Acc2)
	sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Acc3)
	-- HighHaste DW
	sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.LowAcc)
	sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.MidAcc)
	sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.HighAcc)

	------------------------------------------------------------------------------------------------
	---------------------------------------- Hybrid Sets -------------------------------------------
	------------------------------------------------------------------------------------------------
	-- Define three tiers of Defense Taken.  These sets are cycled with the F10 Button.
	sets.engaged.DT1 = { -- 48%
		--ammo="Ginsen",
		ammo="Coiste Bodhar",
		head="Sakpata's Helm", --7
		ear1="Telos Earring",
		ear2="Brutal Earring",
		--neck="Vim Torque +1",
		neck="Lissome Necklace",
		body="Sakpata's Breastplate", --10
		hands="Sakpata's Gauntlets", --8
		ring1="Hetairoi Ring",      
		ring2="Petrov Ring",
		--back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		waist="Sailfi Belt +1",
		legs="Sakpata's Cuisses", --9
		feet="Sakpata's Leggings", --6
	} --40 
		 
	sets.engaged.DT2 = set_combine(sets.engaged.DT1, {
		ring2="Defending Ring", --10
	}) --50DT
 
	sets.engaged.DT3 = set_combine(sets.engaged.DT2, { --10 Set Bonus
		--ammo="Amar Cluster",
		head="Souveran Schaller +1",
		ear2="Odnowa Earring +1",
		body="Souveran Cuirass +1", --10DT
		hands="Souveran Handschuhs +1", --4DT
		ring1="Dark Ring",
		ring2="Defending Ring", --10DT
		--back={ name="Rudianos's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		--waist="Sarissaphoroi Belt",
		legs="Souveran Diechlings +1", --4DT
		feet="Souveran Schuhs +1", --5DT
	}) --50DT
 
	-- Shield Base
	sets.engaged.LOW = set_combine(sets.engaged, sets.engaged.DT1)
	sets.engaged.LowAcc.LOW = set_combine(sets.engaged.LowAcc, sets.engaged.DT1)
	sets.engaged.MidAcc.LOW = set_combine(sets.engaged.MidAcc, sets.engaged.DT1)
	sets.engaged.HighAcc.LOW = set_combine(sets.engaged.HighAcc, sets.engaged.DT1)
	 
	sets.engaged.MID = set_combine(sets.engaged, sets.engaged.DT2)
	sets.engaged.LowAcc.MID = set_combine(sets.engaged.LowAcc, sets.engaged.DT2)
	sets.engaged.MidAcc.MID = set_combine(sets.engaged.MidAcc, sets.engaged.DT2)
	sets.engaged.HighAcc.MID = set_combine(sets.engaged.HighAcc, sets.engaged.DT2)
	 
	sets.engaged.HIGH = set_combine(sets.engaged, sets.engaged.DT3)
	sets.engaged.LowAcc.HIGH = set_combine(sets.engaged.LowAcc, sets.engaged.DT3)
	sets.engaged.MidAcc.HIGH = set_combine(sets.engaged.MidAcc, sets.engaged.DT3)
	sets.engaged.HighAcc.HIGH = set_combine(sets.engaged.HighAcc, sets.engaged.DT3) 
	-- No Haste DW
	sets.engaged.DW.LOW = set_combine(sets.engaged.DW, sets.engaged.DT1)
	sets.engaged.DW.LowAcc.LOW = set_combine(sets.engaged.DW.LowAcc, sets.engaged.DT1)
	sets.engaged.DW.MidAcc.LOW = set_combine(sets.engaged.DW.MidAcc, sets.engaged.DT1)
	sets.engaged.DW.HighAcc.LOW = set_combine(sets.engaged.DW.HighAcc, sets.engaged.DT1)
	 
	sets.engaged.DW.MID = set_combine(sets.engaged.DW, sets.engaged.DT2)
	sets.engaged.DW.LowAcc.MID = set_combine(sets.engaged.DW.LowAcc, sets.engaged.DT2)
	sets.engaged.DW.MidAcc.MID = set_combine(sets.engaged.DW.MidAcc, sets.engaged.DT2)
	sets.engaged.DW.HighAcc.MID = set_combine(sets.engaged.DW.HighAcc, sets.engaged.DT2)

	sets.engaged.DW.HIGH = set_combine(sets.engaged.DW, sets.engaged.DT3)
	sets.engaged.DW.LowAcc.HIGH = set_combine(sets.engaged.DW.LowAcc, sets.engaged.DT3)
	sets.engaged.DW.MidAcc.HIGH = set_combine(sets.engaged.DW.MidAcc, sets.engaged.DT3)
	sets.engaged.DW.HighAcc.HIGH = set_combine(sets.engaged.DW.HighAcc, sets.engaged.DT3)   
	-- Low Haste DW
	sets.engaged.DW.LOW.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.DT1)
	sets.engaged.DW.LowAcc.LOW.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.DT1)
	sets.engaged.DW.MidAcc.LOW.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.DT1)
	sets.engaged.DW.HighAcc.LOW.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.DT1)
	 
	sets.engaged.DW.MID.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.DT2)
	sets.engaged.DW.LowAcc.MID.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.DT2)
	sets.engaged.DW.MidAcc.MID.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.DT2)
	sets.engaged.DW.HighAcc.MID.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.DT2)
	 
	sets.engaged.DW.HIGH.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.DT3)
	sets.engaged.DW.LowAcc.HIGH.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.DT3)
	sets.engaged.DW.MidAcc.HIGH.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.DT3)
	sets.engaged.DW.HighAcc.HIGH.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.DT3)
	-- Mid Haste
	sets.engaged.DW.LOW.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.DT1)
	sets.engaged.DW.LowAcc.LOW.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.DT1)
	sets.engaged.DW.MidAcc.LOW.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.DT1)
	sets.engaged.DW.HighAcc.LOW.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.DT1)
	 
	sets.engaged.DW.MID.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.DT2)
	sets.engaged.DW.LowAcc.MID.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.DT2)
	sets.engaged.DW.MidAcc.MID.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.DT2)
	sets.engaged.DW.HighAcc.MID.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.DT2)

	sets.engaged.DW.HIGH.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.DT3)
	sets.engaged.DW.LowAcc.HIGH.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.DT3)
	sets.engaged.DW.MidAcc.HIGH.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.DT3)
	sets.engaged.DW.HighAcc.HIGH.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.DT3)     
	-- High Haste
	sets.engaged.DW.LOW.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.DT1)
	sets.engaged.DW.LowAcc.LOW.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.DT1)
	sets.engaged.DW.MidAcc.LOW.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.DT1)
	sets.engaged.DW.HighAcc.LOW.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.DT1)
	 
	sets.engaged.DW.MID.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.DT2)
	sets.engaged.DW.LowAcc.MID.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.DT2)
	sets.engaged.DW.MidAcc.MID.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.DT2)
	sets.engaged.DW.HighAcc.MID.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.DT2)
	 
	sets.engaged.DW.HIGH.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.DT3)
	sets.engaged.DW.LowAcc.HIGH.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.DT3)
	sets.engaged.DW.MidAcc.HIGH.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.DT3)
	sets.engaged.DW.HighAcc.HIGH.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.DT3)
	-- Max Haste
	sets.engaged.DW.LOW.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.DT1)
	sets.engaged.DW.LowAcc.LOW.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.DT1)
	sets.engaged.DW.MidAcc.LOW.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.DT1)
	sets.engaged.DW.HighAcc.LOW.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.DT1)
	 
	sets.engaged.DW.MID.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.DT2)
	sets.engaged.DW.LowAcc.MID.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.DT2)
	sets.engaged.DW.MidAcc.MID.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.DT2)
	sets.engaged.DW.HighAcc.MID.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.DT2)
	 
	sets.engaged.DW.HIGH.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.DT3)
	sets.engaged.DW.LowAcc.HIGH.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.DT3)
	sets.engaged.DW.MidAcc.HIGH.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.DT3)
	sets.engaged.DW.HighAcc.HIGH.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.DT3) 

	------------------------------------------------------------------------------------------------
	---------------------------------------- Special Sets ------------------------------------------
	------------------------------------------------------------------------------------------------

	sets.buff.Doom = {ring1="Purity Ring",riing2="Eshmun's Ring",waist="Gishdubar sash"}
	sets.Warp = {ring1="Dim. Ring (Holla)",ring2="Warp Ring"}
	sets.CP = {back="Mecisto. Mantle"}
	sets.MP = {back="Rudianos's Mantle",Ear1="Ethereal Earring",Waist="Flume Belt",Ammo="Homiliary",}
	sets.Weapon = {}
	sets.Neck = {Neck=""} --Locks Dynamis Neck for Rank Point Farming
	sets.Aegis = {sub="Aegis"}
	sets.Ochain = {sub="Ochain"}
	sets.Srivatsa = {sub="Srivatsa"}

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

		if spellMap == 'Utsusemi' then
			if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
				cancel_spell()
				add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
				eventArgs.handled = true
				return
			elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
				send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
			end
		end

		if state.TreasureMode.value ~= false then
			equip(sets.sharedTH)
		end

		-- Don't gearswap for weaponskills when Defense is active and Hybrid Mode set to a specific state
		if state.DefenseMode.value ~= 'None' and state.HybridMode.value ~= 'Normal' then
			eventArgs.handled = true
		end
	end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
	if spell.type:lower() == 'weaponskill' then
		if state.DefenseMode.value == 'None' and state.HybridMode.value == 'Normal' then
			-- Replace Moonshade Earring if we're at cap TP
			if player.tp >= 2750 then
				equip(sets.precast.WS.MaxTP)
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
	if buff == "doom" then
		if gain then
			equip(sets.buff.Doom)
			send_command('@input /echo Doomed.')
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

function job_handle_equipping_gear(playerStatus, eventArgs)
	update_combat_form()
	determine_haste_group()
end
 
function job_update(cmdParams, eventArgs)
	handle_equipping_gear(player.status)
end
 
function update_combat_form()
	if DW == true then
		state.CombatForm:set('DW')
	elseif DW == false then
		state.CombatForm:reset()
	end
end
 
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
	 
	if state.MP.current == 'on' then
		equip(sets.MP)
		disable('waist','ear1','back')
	else
		enable('waist','ear1','back')
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
	
	if state.ShieldMode.value == 'Aegis' then
		equip(sets.Aegis)
	end
	
	if state.ShieldMode.value == 'Ochain' then
		equip(sets.Ochain)
	end
	
	if state.ShieldMode.value == 'Srivatsa' then
		equip(sets.Srivatsa)
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
	 
	if state.MP.current == 'on' then
		equip(sets.MP)
		disable('waist','ear1','back')
	else
		enable('waist','ear1','back')
	end
	 
	if state.Weapon.current == 'on' then
		disable('main')
	else
		enable('main')
	end
	 
	if state.Neck.current == 'on' then
		equip(sets.Neck)    
		disable('neck')
	else
		enable('neck')
	end 
	
	if state.ShieldMode.value == 'Aegis' then
		equip(sets.Aegis)
	end
	
	if state.ShieldMode.value == 'Ochain' then
		equip(sets.Ochain)
	end
	
	if state.ShieldMode.value == 'Srivatsa' then
		equip(sets.Srivatsa)
	end
 
	return meleeSet
end
 
-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
		
	local msg = '[ '
	-- local msg = '[ Melee'
 
	-- if state.CombatForm.has_value then
		-- msg = msg .. ' (' .. state.CombatForm.value .. ')'
	-- end

	-- msg = msg .. ': '

	-- msg = msg .. state.OffenseMode.value
	-- if state.HybridMode.value ~= 'Normal' then
		-- msg = msg .. '/' .. state.HybridMode.value
	-- end
	-- msg = msg .. ' ][ WS: ' .. state.WeaponskillMode.value .. ' ]'

	-- if state.DefenseMode.value ~= 'None' then
		-- msg = msg .. '[ Defense: ' .. state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ' ]'
	-- end

	if state.Kiting.value then
		msg = msg .. '[ Kiting Mode: ON ]'
	end
	
	if state.IdleMode.value == 'DT' then
		msg = msg .. '[ Idle: DT ] '
	elseif state.IdleMode.value == 'Pulling' then
		msg = msg .. '[ Idle: Pulling ] '
	else
		msg = msg .. '[ Idle: Normal ] '
	end
	
	if state.ShieldMode.value == 'Aegis' then
		msg = msg .. '[ Shield: Aegis ] '
	elseif state.ShieldMode.value == 'Ochain' then
		msg = msg .. '[ Shield: Ochain ] '
	else
		msg = msg .. '[ Shield: Srivatsa ] '
	end
	
	if state.CastingMode.value == 'SIRD' then
		msg = msg .. '[ Casting: SIRD ]'
	elseif state.CastingMode.value == 'HPBAL' then
		msg = msg .. '[ Casting: HPBAL ]'
	else
		msg = msg .. '[ Casting: Normal ]'
	end
	
	msg = msg .. ' ]'
 
	add_to_chat(060, msg)
 
	eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function determine_haste_group()
	classes.CustomMeleeGroups:clear()
	if DW == true then
		if DW_needed <= 1 then
			classes.CustomMeleeGroups:append('MaxHaste')
		elseif DW_needed > 1 and DW_needed <= 12 then
			classes.CustomMeleeGroups:append('HighHaste')
		elseif DW_needed > 12 and DW_needed <= 21 then
			classes.CustomMeleeGroups:append('MidHaste')
		elseif DW_needed > 21 and DW_needed <= 39 then
			classes.CustomMeleeGroups:append('LowHaste')
		elseif DW_needed > 39 then
			classes.CustomMeleeGroups:append('')
		end
	end
end
 
function job_self_command(cmdParams, eventArgs)
	-- gearinfo(cmdParams, eventArgs)
end
 
-- function gearinfo(cmdParams, eventArgs)
	-- if cmdParams[1] == 'gearinfo' then
		-- if type(tonumber(cmdParams[2])) == 'number' then
			-- if tonumber(cmdParams[2]) ~= DW_needed then
			-- DW_needed = tonumber(cmdParams[2])
			-- DW = true
			-- end
		-- elseif type(cmdParams[2]) == 'string' then
			-- if cmdParams[2] == 'false' then
				-- DW_needed = 0
				-- DW = false
			-- end
		-- end
		-- if type(tonumber(cmdParams[3])) == 'number' then
			-- if tonumber(cmdParams[3]) ~= Haste then
					-- Haste = tonumber(cmdParams[3])
			-- end
		-- end
		-- if type(cmdParams[4]) == 'string' then
			-- if cmdParams[4] == 'true' then
				-- moving = true
			-- elseif cmdParams[4] == 'false' then
				-- moving = false
			-- end
		-- end
		-- if not midaction() then
			-- job_update()
		-- end
	-- end
-- end
 
-- Automatically loads a Macro Set by: (Pallet,Book)
function select_default_macro_book()
	if player.sub_job == 'BLU' then
		set_macro_page(1, 5)
	elseif player.sub_job == 'RUN' then
		set_macro_page(2, 5)
	elseif player.sub_job == 'WAR' then
		set_macro_page(3, 5)
	elseif player.sub_job == 'DRK' then
		set_macro_page(4, 5)
	elseif player.sub_job == 'DNC' then
		set_macro_page(5, 5)
	elseif player.sub_job == 'NIN' then
		set_macro_page(6, 5)
	elseif player.sub_job == 'SAM' then
		set_macro_page(7, 5)
	else
		set_macro_page(1, 5)
	end
end
 
function set_lockstyle()
	-- send_command('wait 2; input /lockstyleset ' .. lockstyleset)
end