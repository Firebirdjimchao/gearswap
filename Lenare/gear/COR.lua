-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Melee', 'MidAcc', 'HighAcc', 'FullAcc', 'Ranged')
	state.RangedMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT', 'Refresh')
	
	gear.RAbullet = "Adlivun Bullet"
	gear.WSbullet = "Adlivun Bullet"
	--gear.MAbullet = "Bronze Bullet"
	gear.MAbullet = "Adlivun Bullet"
	gear.QDbullet = "Animikii Bullet"
	options.ammo_warning_limit = 15
	
	gear.pr_gunslinger = {name="Gunslinger's Cape",augments={'Enmity-1','"Phantom Roll" ability delay -1','Weapon skill damage +2%'}}
	
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
	sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes"}
	sets.precast.JA['Wild Card'] = {feet="Lanun Bottes"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac"}
	
	sets.precast.CorsairRoll = {
		head="Lanun Tricorne +1",
		--ring1="Luzaf's Ring",
		ring2="Barataria Ring",
		hands="Chasseur's Gants",
		--back=gear.pr_gunslinger,
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
	sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Navarch's Tricorne +2"})
	sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Navarch's Frac +2"})
	sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants"})
	
	sets.precast.FoldDoubleBust = {hands="Lanun Gants"}
	
	sets.precast.CorsairShot = {
	}
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Mummu Bonnet +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2"
	}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	-- Fast cast sets for spells
	
	sets.precast.FC = {
		--ammo="Impatiens",
		neck="Baetyl Pendant",
		ear1="Loquacious Earring",
		ear2="Etiolation Earring",
		hands="Leyline Gloves",
		ring1="Kishar Ring",
		ring2="Weather. Ring"
	}
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

  sets.precast.RA = {
		ammo=gear.RAbullet,
		head="Uk'uxkaj Cap",
		body="Laksamana's Frac",
		hands="Iuitl Wristband +1",
		--hands="Lanun Gants",
		--hands="Lanun Gants +1",
		back="Navarch's Mantle",
		waist="Impulse Belt",
		legs="Nahtirah Trousers",
		feet="Meg. Jam. +2",
	}
	   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head=gear.Adhemar_head_B,
		neck="Asperity Necklace",
		--neck=gear.ElementalGorget,
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		ring1="Rajas Ring",
		ring2="Apate Ring",
		back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		--legs="Samnuha Tights",
		legs=gear.Herculean_legs_WSD,
		feet="Mummu Gamash. +2",
	}
	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
	})
	sets.precast.WS.HighAcc = set_combine(sets.precast.WS, {
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		waist="Eschan Stone",
		--legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {
		head="Meghanada Visor +2",
		neck="Sanctity Necklace",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		waist="Eschan Stone",
		back="Canny Cape",
		--legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		head=gear.Herculean_head_mab,
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		body=gear.Herculean_body_mab,
		hands="Leyline Gloves",
		ring1="Acumen Ring",
		ring2="Arvina Ringlet +1",
		back=gear.pr_gunslinger,
		waist="Eschan Stone",
		--legs="Shned. Tights +1",
		legs=gear.Herculean_legs_WSD,
		feet="Lanun Boots"
		--feet="Lanun Boots +1"
	})

	sets.precast.WS.RA = set_combine(sets.precast.WS,{
		ammo=gear.WSbullet,
		head="Lanun Tricorne +1",
		neck="Sanctity Necklace",
		ear2="Telos Earring",
		body="Nisroch Jerkin",
		hands="Iuitl Wristband +1",
		ring1="Arewe Ring",
		ring2="Garuda Ring +1",
		back=gear.pr_gunslinger,
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
	})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		neck=gear.ElementalGorget
	})

	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		neck=gear.ElementalGorget,
	})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		neck=gear.ElementalGorget,
	})

	sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS.RA, {
		neck=gear.ElementalGorget,
		ring1="Garuda Ring +1",
		waist=gear.ElementalBelt,
	})

	sets.precast.WS['Last Stand'].HighAcc = set_combine(sets.precast.WS['Last Stand'], {
		hands="Buremte Gloves"
	})

	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS.MAB,{
		ammo=gear.MAbullet
	})

	sets.precast.WS['Wildfire'].Brew = set_combine(sets.precast.WS['Wildfire'], {
	})
	
	sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS.MAB,{
	  ammo=gear.MAbullet
	})

	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		head="Malignance Chapeau",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Mummu Kecks +2",
		feet="Malignance Boots",
	});
		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {
	})

	sets.midcast.CorsairShot = {
		ammo=gear.QDbullet,
		head=gear.Herculean_head_mab,
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		body=gear.Herculean_body_mab,
		hands="Leyline Gloves",
		ring1="Acumen Ring",
		ring2="Arvina Ringlet +1",
		back=gear.pr_gunslinger,
		waist="Eschan Stone",
		legs="Shned. Tights +1",
		feet="Lanun Bottes"
		--feet="Lanun Bottes +1"
	}

	sets.midcast.CorsairShot.HighAcc = set_combine(sets.midcast.CorsairShot, {
		ear1="Hermetic Earring",
		ring1="Crepuscular Ring",
		ring2="Stikini Ring",
	})

	sets.midcast.CorsairShot['Light Shot'] = set_combine(sets.midcast.CorsairShot.HighAcc, {
	})

	sets.midcast.CorsairShot['Dark Shot'] = set_combine(sets.midcast.CorsairShot.HighAcc, {
	})

	-- Ranged gear
	sets.midcast.RA = {
		ammo=gear.RAbullet,
		head="Lanun Tricorne +1",
		neck="Sanctity Necklace",
		ear1="Enervating Earring",
		ear2="Telos Earring",
		body="Nisroch Jerkin",
		hands="Meg. Gloves +2",
		ring1="Crepuscular Ring",
		ring2="Hajduk Ring",
		back=gear.pr_gunslinger,
		waist="Kwahu Kachina Belt",
		legs="Meg. Chausses +2",
		feet="Iuitl Gaiters"
	}

	sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA, {
		ammo=gear.RAbullet,
		neck="Sanctity Necklace",
		hands="Buremte Gloves"
	})

	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {
		ammo=gear.RAbullet,
		head="Malignance Chapeau",
		neck="Twilight Torque",
		ear1="Novia Earring",
		ear2="Etiolation Earring",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		--back="Moonbeam Cape",
		back="Mecisto. Mantle",
		waist="Gishdubar Sash",
		legs="Mummu Kecks +2",
		feet="Skd. Jambeaux +1"
	 }

	sets.idle.Town = set_combine(sets.idle, {
		body="Councilor's Garb"
	})
	
	-- Defense sets
	
	-- Total: 41%
  -- <36%: use Shadow Mantle
	sets.defense.PDT = set_combine(sets.idle,{
		ammo="Crepuscular Pebble",
		back="Moonbeam Cape",
		feet="Malignance Boots",
	})

	-- MDT: 18%
	-- MDB: 26
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.defense.MDT = set_combine(sets.idle,{
		ammo="Crepuscular Pebble",
		back="Moonbeam Cape",
		feet="Malignance Boots",
	})
	
	sets.Kiting = {feet="Skd. Jambeaux +1"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.HighAccuracy.Evasion

	-- Normal melee group
	sets.engaged.Melee = {
		ammo=gear.RAbullet,
		head=gear.Adhemar_head_B,
		neck="Asperity Necklace",
		ear1="Sherida Earring",
		ear2="Suppanomimi",
		body="Mummu Jacket +2",
		hands="Mummu Wrists +2",
		ring1="Rajas Ring",
		ring2="Chirich Ring",
		back="Canny Cape",
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet="Mummu Gamash. +2",
	}

	sets.engaged.HighAcc = set_combine(sets.engaged.Melee,{
		head="Malignance Chapeau",
		ear1="Zennaroi Earring",
		neck="Sanctity Necklace",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring2="Cacoethic Ring",
		waist="Eschan Stone",
		legs="Meg. Chausses +2",
		feet="Malignance Boots",
	})

	sets.engaged.Melee.DW = set_combine(sets.engaged.Melee,{
		ear1="Sherida Earring",
		ear2="Suppanomimi",
	})

	sets.engaged.HighAcc.DW = set_combine(sets.engaged.HighAcc,{
		ear1="Zennaroi Earring",
	})

	sets.engaged.Ranged = set_combine(sets.defense.PDT,{
	})

	sets.engaged.PDT = set_combine(sets.engaged.Evasion,{
		head="Malignance Chapeau",
		neck="Twilight Torque",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Mummu Kecks +2",
		feet="Malignance Boots",
	})
	sets.engaged.PDT.MidAcc = set_combine(sets.engaged.PDT,{
	})
	sets.engaged.PDT.HighAcc = set_combine(sets.engaged.PDT,{
	})
	sets.engaged.PDT.FullAcc = set_combine(sets.engaged.PDT,{
	})

	sets.engaged.MDT = set_combine(sets.engaged.Evasion,{
		head="Malignance Chapeau",
		neck="Twilight Torque",
		ear2="Etiolation Earring",
		body="Meg. Cuirie +2",
		hands="Malignance Gloves",
		ring1="Shadow Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		legs="Mummu Kecks +2",
		feet="Malignance Boots",
	})
	sets.engaged.MDT.MidAcc = set_combine(sets.engaged.MDT,{
	})
	sets.engaged.MDT.HighAcc = set_combine(sets.engaged.MDT,{
	})
	sets.engaged.MDT.FullAcc = set_combine(sets.engaged.MDT,{
	})

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(1, 10)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 10)
	elseif player.sub_job == 'RUN' then
		set_macro_page(1, 10)
	else
		set_macro_page(1, 10)
	end
end