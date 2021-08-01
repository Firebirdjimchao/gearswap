-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Melee', 'Acc', 'Ranged')
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT', 'Refresh')
	
	gear.RAbullet = "Adlivun Bullet"
	gear.WSbullet = "Adlivun Bullet"
	--gear.MAbullet = "Tin Bullet"
	gear.MAbullet = "Bullet"
	gear.QDbullet = "Animikii Bullet"
	options.ammo_warning_limit = 15

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
	send_command('bind ^` input /ja "Double-up" <me>')
	send_command('bind !` input /ja "Bolter\'s Roll" <me>')
	send_command('bind @` gs c cycle LuzafRing')
	
	select_default_macro_book()

	global_aliases()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind @`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA['Triple Shot'] = {body="Navarch's Frac +2"}
	sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes +1"}
	sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +1"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}
	
	sets.precast.CorsairRoll = {
		head="Lanun Tricorne +1",
		neck="Regal Necklace",
		--ring2="Barataria Ring",
		hands="Chasseur's Gants",
		-- Phantom Roll delay -3 Aug
		--back="Gunslinger's Cape",
		back="Camulus's Mantle",
	}
	sets.precast.LuzafRing = set_combine(sets.precast.CorsairRoll,{
	  ring1="Luzaf's Ring"
	})
	
	sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {
	  ring1="Dark Ring",
	  legs="Navarch's Culottes +2"
	})
	sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {
	  ring1="Dark Ring",
	  feet="Navarch's Bottes +2"
	})
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne"})
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Navarch's Frac +2"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants"})
	
	sets.precast.FoldDoubleBust = {hands="Lanun Gants +1"}
	
	sets.precast.CorsairShot = {
	}
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Mummu Bonnet +2",
		body=gear.Adhemar_body_hq_B,
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Sirona's Ring",
		back="Tantalic Cape",
		waist="Chaac Belt",
		feet="Malignance Boots"
	}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	-- Fast cast sets for spells
	
	sets.precast.FC = {
		--ammo="Impatiens",
		head=gear.Herculean_head_RA,
		neck="Voltsurge Torque",
		ear1="Loquacious Earring",
		ear2="Etiolation Earring",
		body="Taeon Tabard",
		hands="Leyline Gloves",
		ring1="Prolix Ring",
		ring2="Kishar Ring",
		legs=gear.Herculean_legs_Magic,
		feet="Carmine Greaves +1",
	}
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	sets.precast.RA = {
		ammo=gear.RAbullet,
		head="Uk'uxkaj Cap",
		body="Oshosi Vest",
		hands="Carmine Fin. Ga. +1",
		ring1="Haverton Ring",
		back="Navarch's Mantle",
		waist="Yemaya Belt",
		-- 9% RS + 10% RS
		--legs=gear.pursuer_legs_A,
		-- 9% SS + 10% RS
		legs=gear.Adhemar_legs_D,
		-- 10% SS
		feet="Meg. Jam. +2",
	}
	   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Nyame Helm",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Brutal Earring",
		body=gear.Adhemar_body_hq_B,
		hands=gear.Adhemar_hands_hq_B,
		ring1="Epona's Ring",
		ring2="Rajas Ring",
		back="Atheling Mantle",
		waist="Fotia Belt",
		legs="Samnuha Tights",
		feet="Nyame Sollerets",
	}
	
	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		head="Nyame Helm",
		--neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		body=gear.Herculean_body_Magic,
		hands="Nyame Gauntlets",
		ring1="Acumen Ring",
		ring2="Stikini Ring",
		back="Gunslinger's Cape",
		--waist="Eschan Stone",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})

	sets.precast.WS.RA = set_combine(sets.precast.WS,{
		ammo=gear.WSbullet,
		head="Pursuer's Beret",
		neck="Fotia Gorget",
		ear1="Telos Earring",
		ear2="Enervating Earring",
		body="Nisroch Jerkin",
		hands=gear.Herculean_hands_RA,
		ring1="Ilabrat Ring",
		ring2="Rajas Ring",
		back="Gunslinger's Cape",
		waist="Fotia Belt",
		legs=gear.Herculean_legs_RA,
		feet=gear.Herculean_feet_RA
	})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
	})

	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
	})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
	})

	sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS.RA, {
		head="Lanun Tricorne +1"
	})

	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
	})

	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS.MAB,{
		ammo=gear.MAbullet
	})

	sets.precast.WS['Wildfire'].Brew = set_combine(sets.precast.WS['Wildfire'], {
	})
	
	sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS.MAB,{
		ammo=gear.MAbullet,
		head="Pixie Hairpin +1"
	})

	-- Midcast Sets
	
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		feet="Herculean Boots"
	})
	
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {
	})

	sets.midcast.CorsairShot = {
		ammo=gear.QDbullet,
		head="Nyame Helm",
		neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		body=gear.Herculean_body_Magic,
		hands=gear.Carmine_hands_hq_D,
		ring1="Acumen Ring",
		ring2="Stikini Ring",
		back="Gunslinger's Cape",
		waist="Eschan Stone",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}

	sets.midcast.CorsairShot.Acc = set_combine(sets.midcast.CorsairShot, {
		ear1="Hermetic Earring",
		ear2="Digni. Earring",
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring",
	})

	sets.midcast.CorsairShot['Light Shot'] = set_combine(sets.midcast.CorsairShot.Acc, {
	})

	sets.midcast.CorsairShot['Dark Shot'] = set_combine(sets.midcast.CorsairShot.Acc, {
	})

	-- Ranged gear
	sets.midcast.RA = {
		ammo=gear.RAbullet,
		head="Pursuer's Beret",
		neck="Iskur Gorget",
		ear1="Telos Earring",
		ear2="Enervating Earring",
		body="Nisroch Jerkin",
		hands="Malignance Gloves",
		ring1="Haverton Ring",
		ring2="Cacoethic Ring +1",
		back="Gunslinger's Cape",
		waist="Eschan Stone",
		legs=gear.Herculean_legs_RA,
		feet=gear.Herculean_feet_RA
	}

	sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
		ammo=gear.RAbullet,
		neck="Marked Gorget"
	})
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {
		ammo=gear.RAbullet,
		head="Meghanada Visor +2",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Mummu Kecks +2",
		feet="Skd. Jambeaux +1"
	 }
	 
	 sets.noprotect = {ring1="Sheltered Ring"}

	sets.idle.Town = set_combine(sets.idle, {
		body="Councilor's Garb"
	})
  
  -- DT: 50% PDT: 9% MDT: 10%
	sets.defense.PDT = set_combine(sets.idle,{
		-- DT 6%
		head="Malignance Chapeau",
		-- 2% MDT
		ear1="Odnowa Earring +1",
		-- 3% MDT
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
		-- PDT 4%
		waist="Flume Belt +1",
		-- DT 7%
		legs="Malignance Tights",
		-- DT 4%
		feet="Malignance Boots",
	})

	-- DT: 50%
	-- PDT: 9%
	-- MDT: 10%
	-- MDB: 29
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.defense.MDT = set_combine(sets.idle,{
		-- DT 6% MDB 5
		head="Malignance Chapeau",
		-- 2% MDT
		ear1="Odnowa Earring +1",
		-- 3% MDT
		ear2="Etiolation Earring",
		-- MDB 8
		--neck="Inq. Bead Necklace",
		-- DT 6%
		neck="Loricate Torque +1",
		-- DT 9% MDB 8
		body="Malignance Tabard",
		-- DT 5% MDB 4
		hands="Malignance Gloves",
		-- PDT 5% MDT 5%
		ring1="Dark Ring",
		--ring1="Shadow Ring",
		-- DT 10%
		ring2="Defending Ring",
		-- DT 5%
		back="Moonbeam Cape",
		-- PDT 4%
		waist="Flume Belt +1",
		-- DT: 7% MDB 7
		legs="Malignance Tights",
		-- DT 4% MDB 5
		feet="Malignance Boots",
	})

	sets.Kiting = {feet="Skd. Jambeaux +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group
	sets.engaged.Melee = {
		ammo=gear.RAbullet,
		head=gear.Adhemar_head_hq_B,
		neck="Asperity Necklace",
		ear1="Telos Earring",
		ear2="Brutal Earring",
		body=gear.Adhemar_body_hq_B,
		hands=gear.Adhemar_hands_hq_B,
		ring1="Epona's Ring",
		ring1="Rajas Ring",
		back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet=gear.Carmine_feet_hq_B,
	}
	
	sets.engaged.Acc = set_combine(sets.engaged.Melee,{
		head="Malignance Chapeau",
		neck="Subtlety Spec.",
		ear1="Telos Earring",
		ear2="Digni. Earring",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring2="Cacoethic Ring +1",
		waist="Eschan Stone"
		legs="Malignance Tights",
		feet="Malignance Boots",
	})

	sets.engaged.Melee.DW = set_combine(sets.engaged.Melee,{
		ear1="Suppanomimi",
		ear2="Brutal Earring",
		ring2="Haverton Ring",
		legs=gear.Carmine_legs_hq_D,
	})
	
	sets.engaged.Acc.DW = set_combine(sets.engaged.Acc,{
		ear1="Suppanomimi",
		ear2="Brutal Earring",
		ring2="Haverton Ring",
		legs=gear.Carmine_legs_hq_D,
		feet=gear.Carmine_feet_hq_B,
	})

	sets.engaged.Ranged = set_combine(sets.defense.PDT,{
	})
	
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	set_macro_page(1, 15)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if not buffactive['Protect'] then
		idleSet = set_combine(idleSet, sets.noprotect)
	end
	return idleSet
end