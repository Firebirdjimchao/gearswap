-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
	state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
	state.Buff.Convergence = buffactive.Convergence or false
	state.Buff.Diffusion = buffactive.Diffusion or false
	state.Buff.Efflux = buffactive.Efflux or false

	state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false

	state.CP = M(false, "Capacity Points Mode")
	state.Warp = M(false, "Warp Mode")
	state.Weapon = M(false, "Weapon Lock")
	state.Neck = M(false, "Neck Mode")
	state.TreasureMode = M(false, 'TH')
	state.EngagedDT = M(false, 'Engaged Damage Taken Mode')

	blue_magic_maps = {}

	-- Mappings for gear sets to use for various blue magic spells.
	-- While Str isn't listed for each, it's generally assumed as being at least
	-- moderately signficant, even for spells with other mods.

	-- Physical Spells --

	-- Physical spells with no particular (or known) stat mods
	blue_magic_maps.Physical = S{
		'Bilgestorm'
	}

	-- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
	blue_magic_maps.PhysicalAcc = S{
		'Heavy Strike',
	}

	-- Physical spells with Str stat mod
	blue_magic_maps.PhysicalStr = S{
		'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
		'Empty Thrash','Quadrastrike','Saurian Slide','Sinker Drill','Spinal Cleave','Sweeping Gouge',
		'Uppercut','Vertical Cleave'
	}

	-- Physical spells with Dex stat mod
	blue_magic_maps.PhysicalDex = S{
		'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone','Disseverment',
		'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
		'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault',
		'Vanity Dive'
	}

	-- Physical spells with Vit stat mod
	blue_magic_maps.PhysicalVit = S{
		'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
		'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'
	}

	-- Physical spells with Agi stat mod
	blue_magic_maps.PhysicalAgi = S{
		'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
		'Pinecone Bomb','Spiral Spin','Wild Oats'
	}

	-- Physical spells with Int stat mod
	blue_magic_maps.PhysicalInt = S{
		'Mandibular Bite','Queasyshroom'
	}

	-- Physical spells with Mnd stat mod
	blue_magic_maps.PhysicalMnd = S{
		'Ram Charge','Screwdriver','Tourbillion'
	}

	-- Physical spells with Chr stat mod
	blue_magic_maps.PhysicalChr = S{
		'Bludgeon'
	}

	-- Physical spells with HP stat mod
	blue_magic_maps.PhysicalHP = S{
		'Final Sting'
	}

	-- Magical Spells --

	-- Magical spells with the typical Int mod
	blue_magic_maps.Magical = S{
		'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere',
		'Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
		'Ice Break','Leafstorm','Maelstrom','Regurgitation','Rending Deluge',
		'Subduction','Tem. Upheaval','Water Bomb',
		'Searing Tempest','Spectral Floe','Silent Storm'
	}

	-- Magical spells with a primary Mnd mod
	blue_magic_maps.MagicalMnd = S{
		'Acrid Stream','Magic Hammer','Mind Blast','Scouring Spate'
	}

	-- Magical spells with a primary Chr mod
	blue_magic_maps.MagicalChr = S{
		'Mysterious Light'
	}

	-- Magical spells with a Vit stat mod (on top of Int)
	blue_magic_maps.MagicalVit = S{
		'Thermal Pulse','Emtomb'
	}

	-- Magical spells with a Dex stat mod (on top of Int)
	blue_magic_maps.MagicalDex = S{
		'Charged Whisker','Gates of Hades','Anvil Lightning'
	}

	-- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
	-- Add Int for damage where available, though.
	blue_magic_maps.MagicAccuracy = S{
		'1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
		'Blank Gaze','Blistering Roar','Blood Drain','Blood Saber','Chaotic Eye',
		'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest',
		'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
		'Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
		'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Reaving Wind',
		'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
		'Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'
	}

	blue_magic_maps.MagicalDark = S{
		'Dark Orb','Death Ray','Eyes On Me','Evryone. Grudge','Palling Salvo','Tenebral Crush'
	}
	blue_magic_maps.MagicalLight = S{
		'Blinding Fulgor','Diffusion Ray','Radiant Breath','Rail Cannon','Retinal Glare'
	}

	-- Breath-based spells
	blue_magic_maps.Breath = S{
		'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath',
		'Hecatomb Wave','Magnetite Cloud','Poison Breath','Self-Destruct',
		'Thunder Breath','Vapor Spray','Wind Breath'
	}

	-- Stun spells
	blue_magic_maps.Stun = S{
		'Blitzstrahl','Frypan','Head Butt','Sudden Lunge','Tail slap','Temporal Shift',
		'Thunderbolt','Whirl of Rage'
	}

	-- Healing spells
	blue_magic_maps.Healing = S{
		'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral','White Wind',
		'Wild Carrot'
	}

	-- Buffs that depend on blue magic skill
	blue_magic_maps.SkillBasedBuff = S{
		'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body','Occultation','Plasma Charge',
		'Pyric Bulwark','Reactor Cool',
	}

	-- Other general buffs
	blue_magic_maps.Buff = S{
		'Amplification','Animating Wail','Battery Charge','Carcharian Verve','Cocoon',
		'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell',
		'Memento Mori','Nat. Meditation','Orcish Counterstance','Refueling',
		'Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promyvion',
		'Zephyr Mantle'
	}

	-- Spells that require Unbridled Learning to cast.
	unbridled_spells = S{
		'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve',
		'Crashing Thunder','Droning Whirlwind','Gates of Hades','Harden Shell','Polar Roar',
		'Pyric Bulwark','Thunderbolt','Tourbillion','Uproot','Mighty Guard'
	}
end

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'MidAcc', 'Acc', 'Refresh', 'Learning')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'Acc')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT', 'Learning')
	state.BuffReminderMode = M('Normal', 'Full', 'None')

	gear.default.obi_waist = "Eschan Stone"
	gear.Rosmerta_DexSTP = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10',}}
	gear.Rosmerta_StrWSD = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

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

	send_command('bind @b gs c cycle BuffReminderMode') --WindowKey'B'
	send_command("bind @p gs equip sets.TaeonPhalanx; input /echo --- Phalanx set on ---") -- WindowKey'P'

	send_command('bind @c gs c toggle CP') --WindowKey'C'
	send_command('bind @e gs c toggle EngagedDT') --Windowkey'E'
	send_command('bind @h gs c toggle TreasureMode') --Windowkey'H'
	send_command('bind @n gs c toggle Neck') --Windowkey'N'
	send_command('bind @r gs c toggle Warp') --Windowkey'R'
	send_command('bind @w gs c toggle Weapon') --Windowkey'W'

	update_combat_form()
	select_default_macro_book()

	global_aliases()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind @b')
	send_command('unbind @p')

	send_command('unbind @c')
	send_command('unbind @e')
	send_command('unbind @h')
	send_command('unbind @n')
	send_command('unbind @r')
	send_command('unbind @w')
end


-- Set up gear sets.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.buff['Burst Affinity'] = {legs="Assim. Shalwar +2",feet="Mavi Basmak +2"}
	sets.buff['Chain Affinity'] = {head="Mavi Kavuk +2", feet="Assim. Charuqs +2"}
	sets.buff.Convergence = {head="Luh. Keffiyeh +2"}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs +2"}
	sets.buff.Enchainment = {body="Luhlaza Jubbah +3"}
	sets.buff.Efflux = {legs="Mavi Tayt +2"}

	sets.Malignance = {
		head="Malignance Chapeau",
		--body="Malignance Tabard",
		hands="Malignance Gloves",
		--legs="Malignance Tights",
		feet="Malignance Boots",
	}
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {hands="Luh. Bazubands +2"}


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Assim. Keffiyeh +2",
		body="Assim. Jubbah +2",
		hands="Assim. Bazu. +2",
		ring1="Dark Ring",
		ring2="Sirona's Ring",
		waist="Chaac Belt",
		legs="Assim. Shalwar +2",
		feet="Assim. Charuqs +2",
	}
			
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	-- 45/22
	sets.precast.FC = {
		--ammo="Impatiens",
		-- 7%
		head="Herculean Helm",
		-- 14%
		--head=gear.Carmine_head_hq_D,
		-- 4%
		neck="Baetyl Pendant",
		-- 2%
		ear1="Loquac. Earring",
		-- 1%
		ear2="Etiolation Earring",
		-- 9%
		body="Luhlaza Jubbah +3",
		-- 5% + 1%
		hands="Leyline Gloves",
		-- 4%
		ring1="Kishar Ring",
		-- 5%
		ring2="Weather. Ring",
		-- 10%
		--back="Fi Follet Cape +1",
		-- 7%
		legs="Psycloth Lappas",
		-- 8%
		--feet="Carmine greaves +1",
	}
				
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {
		body="Mavi Mintan +2",
	})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"
	})

			 
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Ginsen",
		head=gear.Adhemar_head_B,
		neck="Defiant Collar",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Assim. Jubbah +2",
		hands="Jhakri Cuffs +2",
		ring1="Ilabrat Ring",
		ring2="Epona's Ring",
		back=gear.Rosmerta_StrWSD,
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet="Luhlaza Charuqs +2",
	}

	sets.precast.WS.MaxTP = {
		ear2="Odr. Earring",
	}

	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
		ear1="Telos Earring",
		ring1="Cacoethic Ring +1",
		waist="Eschan Stone"
	})

	sets.precast.WS.Acc = set_combine(sets.precast.WS.MidAcc, {
		body="Jhakri Robe +2",
	})

	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		ammo="Ghastly Tathlum",
		head=gear.Herculean_head_mab,
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		--body="Assim. Jubbah +2",
		body="Shamash Robe",
		hands="Jhakri Cuffs +2",
		ring1="Acumen Ring",
		ring2="Jhakri Ring",
		back="Toro Cape",
		waist="Eschan Stone",
		legs="Luhlaza Shalwar +3",
		feet="Jhakri Pigaches +2",
	})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		neck="Breeze Gorget",
		ear1="Telos Earring",
		ear2="Moonshade Earring",
		body="Assim. Jubbah +2",
		hands="Jhakri Cuffs +2",
		back=gear.Rosmerta_StrWSD,
		legs="Luhlaza Shalwar +3",
		feet="Luhlaza Charuqs +2",
	})
	sets.precast.WS['Savage Blade'].MidAcc = set_combine(sets.precast.WS['Savage Blade'], {
	})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
	})

	sets.precast.WS['Expiacion'] = set_combine(sets.precast.WS['Savage Blade'], {
	})
	sets.precast.WS['Expiacion'].MidAcc = set_combine(sets.precast.WS['Savage Blade'].MidAcc, {
	})
	sets.precast.WS['Expiacion'].Acc = set_combine(sets.precast.WS['Savage Blade'].Acc, {
	})

	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
		head="Luh. Keffiyeh +2",
		neck="Shadow Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Luhlaza Jubbah +3",
		hands="Luh. Bazubands +2",
		waist="Shadow Belt",
		legs="Luhlaza Shalwar +2",
		feet="Luhlaza Charuqs +2",
	})
	sets.precast.WS['Requiescat'].MidAcc = set_combine(sets.precast.WS['Requiescat'], {
	})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {
		ear1="Telos Earring",
		ear2="Odr Earring",
	})

	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.MAB, {
		back=gear.Rosmerta_StrWSD,
	})
		
	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {
	})

	sets.midcast.FastRecast['Blue Magic'] = set_combine(sets.midcast.FastRecast, {
		hands="Mv. Bazubands +2",
	})

	sets.midcast.MAB = {
		ammo="Ghastly Tathlum",
		head=gear.Herculean_head_mab,
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		body="Shamash Robe",
		hands="Jhakri Cuffs +2",
		ring1="Acumen Ring",
		ring2="Jhakri Ring",
		back="Toro Cape",
		waist="Eschan Stone",
		legs="Luhlaza Shalwar +3",
		feet="Jhakri Pigaches +2",
	}

	sets.buffDuration = {
		body=gear.Telchine_body_pet,
		hands=gear.Telchine_hands_pet,
		legs=gear.Telchine_legs_pet,
	}

	sets.midcast['Enhancing Magic'] = set_combine(sets.buffDuration,{
		neck="Incanter's Torque",
	})

	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
	})


	-- Static value (Use Duration+ and Potency+ gear) --
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{
		head="Amalric Coif",
	})

	-- Static value (Use Duration+ and Potency+ gear) --
	sets.midcast.RefreshSelf = set_combine(sets.midcast.Refresh,{
		waist="Gishdubar Sash",
	})

	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],{
		head="Amalric Coif",
		hands="Regal Cuffs",
	})
				
	sets.midcast['Blue Magic'] = {
		ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +2",
		neck="Incanter's Torque",
		body="Assim. Jubbah +2",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		--back="Cornflower Cape",
		legs="Mavi Tayt +2",
		feet="Luhlaza Charuqs +2",
	}
		
	-- Physical Spells --
	
	sets.midcast['Blue Magic'].Physical = set_combine(sets.midcast['Blue Magic'], {
		ammo="Ginsen",
		head="Luh. Keffiyeh +2",
		neck="Incanter's Torque",
		ear1="Telos Earring",
		body="Luhlaza Jubbah +3",
		hands="Luh. Bazubands +2",
		ring1="Petrov Ring",
		ring2="Rajas Ring",
		back=gear.Rosmerta_StrWSD,
		legs="Luhlaza Shalwar +3",
		feet="Luhlaza Charuqs +2",
	})

	sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {
		legs=gear.Carmine_legs_hq_D,
	})

	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {
	})

	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
	})

	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {
	})

	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,	{
	})

	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,	{
	})

	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,	{
	})

	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {
	})

	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {
	})


	-- Magical Spells --
	
	sets.midcast['Blue Magic'].Magical = set_combine(sets.midcast.MAB, {
	})

	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {
		ring1="Stikini Ring",
		ring2="Stikini Ring",
	})

	sets.midcast['Blue Magic'].Magical.TH = set_combine(sets.midcast['Blue Magic'].Magical, sets.sharedTH, {
		ammo="Per. Lucky Egg",
		body="Shamash Robe",
		waist="Chaac Belt",
		legs=gear.Herculean_legs_TA,
	})
	
	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {
	})

	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {
	})

	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {
	})

	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {
	})

	sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {
	})

	sets.midcast['Blue Magic'].MagicalLight = set_combine(sets.midcast['Blue Magic'].Magical, {
	})

	sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical, {
		ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +2",
		neck="Incanter's Torque",
		ear2="Hermetic Earring",
		body="Shamash Robe",
		hands="Regal Cuffs",
		ring1="Crepuscular Ring",
		ring2="Weather. Ring",
		back="Aurist's Cape +1",
		waist="Eschan Stone",
		legs="Assim. Shalwar +2",
		feet="Luhlaza Charuqs +2",
	})

	-- Breath Spells --
	
	sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical, {
		ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +2",
	})

	-- Other Types --
	
	sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
	})

	sets.midcast['Blue Magic']['Bludgeon'] = set_combine(sets.precast.FC, {
	})

	sets.midcast['Blue Magic'].Healing = set_combine(sets.midcast['Blue Magic'], {
		-- 5%
		ear2="Mendi. Earring",
		neck="Incanter's Torque",
		-- 10% + 6%
		hands=gear.Telchine_hands_cure,
		back="Aurist's Cape +1",
		waist="Luminary Sash",
		-- 10%
		legs="Gyve Trousers",
	})

	sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.midcast['Blue Magic'].Healing, {
	})

	sets.midcast['Blue Magic'].SkillBasedBuff = set_combine(sets.midcast['Blue Magic'], {
	})

	sets.midcast['Blue Magic'].Buff = set_combine(sets.midcast['Blue Magic'],sets.buffDuration,{
	})

	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'], {
	})

	-- Sets to return to when not performing an action.

	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {
		hands="Assim. Bazu. +2",
	}

	sets.latent_refresh = {
		waist="Fucho-no-obi"
	}

	-- Idle sets
	sets.idle = {
		ammo="Crepuscular Pebble",
		--ammo="Homiliary",
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Ethereal Earring",
		body="Jhakri Robe +2",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		--back="Moonbeam Cape",
		back="Mecisto. Mantle",
		waist="Fucho-no-Obi",
		--waist="Flume Belt +1",
		--legs="Lengo Pants",
		legs="Carmine cuisses +1",
		feet="Malignance Boots",
	}

	-- DT: 47%
	-- PDT: 4%
	-- MDT: 5%
	sets.idle.PDT = {
		-- DT 3%
		ammo="Crepuscular Pebble",
		-- DT 6%
		head="Malignance Chapeau",
		-- DT 5%
		neck="Loricate Torque +1",
		-- MDT 2%
		ear1="Odnowa earring +1",
		ear2="Ethereal earring",
		-- DT 9%
		body="Nyame Mail",
		-- DT 5%
		hands="Malignance Gloves",
		-- PDT 4% MDT 3%
		ring1="Dark Ring",
		-- DT 10%
		ring2="Defending Ring",
		-- DT 5%
		back="Moonbeam Cape",
		-- PDT 4%
		--waist="Flume Belt +1",
		-- DT 5%
		--legs="Aya. Cosciales +2",
		legs="Carmine cuisses +1",
		-- DT 4%
		feet="Malignance Boots",
	}


	sets.idle.MDT = set_combine(sets.idle.PDT, {
	})

	sets.idle.Town = set_combine(sets.idle, {
		body="Councilor's Garb",
		hands="Regal Cuffs",
	})

	sets.idle.Learning = set_combine(sets.idle, sets.Learning)

	-- Defense sets
	sets.defense.PDT = set_combine(sets.idle.PDT, {
	})
	sets.defense.MDT = set_combine(sets.idle.MDT, {
	})

	sets.Kiting = {legs="Carmine cuisses +1",}

	-- Engaged sets

	-- Normal melee group
	sets.engaged = {
		ammo="Ginsen",
		head=gear.Adhemar_head_B,
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Suppanomimi",
		body=gear.Adhemar_body_B,
		hands=gear.Adhemar_hands_B,
		ring1="Petrov Ring",
		ring2="Epona's Ring",
		back=gear.Rosmerta_DexSTP,
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet="Luhlaza Charuqs +2",
	}

	-- not combining these with any specific engaged sets so it can 
	-- automatically combine with whichever current engaged set you are using
	sets.engaged.TH = set_combine(sets.sharedTH,{
	})
	sets.engaged.DT = set_combine(sets.Malignance,{
		body="Nyame Mail",
		legs="Nyame Flanchard",
	})

	sets.engaged.MidAcc = set_combine(sets.engaged, {
		neck="Lissome Necklace",
		ear1="Telos Earring",
		waist="Eschan Stone",
	})

	sets.engaged.Acc = set_combine(sets.engaged.MidAcc, {
		head="Malignance Chapeau",
		body="Assim. Jubbah +2",
		hands="Malignance Gloves",
		legs="Luhlaza Shalwar +3",
		feet="Malignance Boots",
	})

	sets.engaged.Refresh = set_combine(sets.engaged, {
	})
	sets.engaged.Refresh.MidAcc = set_combine(sets.engaged.MidAcc, {
	})
	sets.engaged.Refresh.Acc = set_combine(sets.engaged.Acc, {
	})

	sets.engaged.DW = set_combine(sets.engaged, {
		ear1="Brutal Earring",
		ear2="Suppanomimi",
		body=gear.Adhemar_body_B,
		legs=gear.Carmine_legs_hq_D,
	})

	sets.engaged.DW.MidAcc = set_combine(sets.engaged.MidAcc, {
		ear1="Telos Earring",
		ear2="Suppanomimi",
	})

	sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {
		ear1="Telos Earring",
		ear2="Suppanomimi",
		legs=gear.Carmine_legs_hq_D,
	})

	sets.engaged.DW.Refresh = set_combine(sets.engaged.Refresh, sets.engaged.DW, {
	})
	sets.engaged.DW.Refresh.MidAcc = set_combine(sets.engaged.Refresh.MidAcc, sets.engaged.DW.MidAcc, {
	})
	sets.engaged.DW.Refresh.Acc = set_combine(sets.engaged.Refresh.Acc, sets.engaged.DW.Acc, {
	})

	sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
	sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)
	sets.engaged.MidAcc.Learning = set_combine(sets.engaged.MidAcc, sets.Learning)
	sets.engaged.DW.MidAcc.Learning = set_combine(sets.engaged.DW.MidAcc, sets.Learning)
	sets.engaged.Acc.Learning = set_combine(sets.engaged.Acc, sets.Learning)
	sets.engaged.DW.Acc.Learning = set_combine(sets.engaged.DW.Acc, sets.Learning)


	sets.self_healing = {
		waist="Gishdubar Sash",
	}

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
	end

	if state.BuffReminderMode.value ~= 'None' then
		-- alert for missing buffs
		if not buffactive['Haste'] then
			add_to_chat(122,"--- [Haste] x ---")
		end
		if not buffactive['Refresh'] then
			add_to_chat(122,"--- [Refresh] x ---")
		end

		if state.BuffReminderMode.value == 'Full' then
			if not buffactive['Aquaveil'] then
				add_to_chat(122,"--- [Aquaveil] x ---")
			end
			if not buffactive['Phalanx'] then
				add_to_chat(122,"--- [Phalanx] x ---")
			end
			if not buffactive['Ice Spikes'] and not buffactive['Shock Spikes'] then
				add_to_chat(122,"--- [Ice Spikes or Shock Spikes] x ---")
			end
			if not buffactive['Cocoon'] then
					add_to_chat(122,"--- [Cocoon] x ---")
			end
			if not buffactive['Stoneskin'] then
					add_to_chat(122,"--- [Stoneskin] x ---")
			end

		end
	end

-- @TODO: Figure out how to handle when Unbridled Wisdom is active
	--if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
		--eventArgs.cancel = true
		--windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
--	end

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

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	-- Add enhancement gear for Chain Affinity, etc.
	if spell.skill == 'Blue Magic' then
		for buff,active in pairs(state.Buff) do
			if active and sets.buff[buff] then
				equip(sets.buff[buff])
			end
		end
		if spellMap == 'Healing' and spell.target.type == 'SELF' and sets.self_healing then
			equip(sets.self_healing)
		end
	elseif spellMap == 'Refresh' and spell.target.type == 'SELF' then
		equip(sets.midcast.RefreshSelf)
	end

	-- If in learning mode, keep on gear intended to help with that, regardless of action.
	if state.OffenseMode.value == 'Learning' then
		equip(sets.Learning)
	end

	if state.TreasureMode.value ~= false and spell.target.type ~= 'SELF' and spell.target.type ~= 'PLAYER' then
		equip(sets.midcast['Blue Magic'].Magical.TH)
	end
end


function job_state_change(stateField, newValue, oldValue)
	if state.Weapon.value == true then
		disable('main','sub','range','ammo')
	else
		enable('main','sub','range','ammo')
	end
end

function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		state.Buff[buff] = gain
	end

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
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
        		-- debugging statements:
        		--add_to_chat(112, category)
        		--table.print(spell_list)
            if spell_list:contains(spell.english) then
            		-- for debugging:
            		--add_to_chat(152, spell.english)
                return category
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
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

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 12)
	elseif player.sub_job == 'RDM' then
		set_macro_page(1, 12)
	else
		set_macro_page(1, 12)
	end
end
