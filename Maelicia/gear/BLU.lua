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
	state.CastingMode:options('Normal', 'Resistant', 'TH')
	state.IdleMode:options('Normal', 'PDT', 'Learning')
	state.BuffReminderMode = M('Normal', 'Full', 'None')

	gear.default.obi_waist = "Sacro Cord"
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

	-- Win-`
	send_command('bind ^` input /ja "Chain Affinity" <me>')
	send_command('bind !` input /ja "Burst Affinity" <me>')

	update_combat_form()
	select_default_macro_book()

	global_aliases()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
end


-- Set up gear sets.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.buff['Burst Affinity'] = {legs="Assim. Shalwar +2",feet="Hashi. Basmak +1"}
	sets.buff['Chain Affinity'] = {head="Hashishin Kavuk +1", feet="Assim. Charuqs +2"}
	sets.buff.Convergence = {head="Luh. Keffiyeh +3"}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs +3"}
	sets.buff.Enchainment = {body="Luhlaza Jubbah +3"}
	sets.buff.Efflux = {legs="Hashishin Tayt +1"}

	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {hands="Luh. Bazubands +3"}


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Herculean Helm",
		body="Telchine Chas.",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Sirona's Ring",
		back="Tantalic Cape",
		waist="Chaac Belt",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
	}
			
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Fast cast sets for spells
	-- 65/32
	sets.precast.FC = {
		--ammo="Impatiens",
		-- 7%
		head="Herculean Helm",
		-- 14%
		--head=gear.Carmine_head_hq_D,
		-- 4%
		neck="Voltsurge Torque",
		-- 2%
		ear1="Loquac. Earring",
		-- 1%
		ear2="Etiolation Earring",
		-- 9%
		body="Luhlaza Jubbah +3",
		-- 5% + 3%
		hands="Leyline Gloves",
		-- 2%
		ring1="Prolix Ring",
		-- 4%
		ring2="Kishar Ring",
		-- 10%
		back="Fi Follet Cape +1",
		-- 3%
		waist="Witful Belt",
		-- 7%
		legs="Psycloth Lappas",
		-- 8%
		feet="Carmine greaves +1",
	}
				
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {
		body="Hashishin Mintan +1",
	})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"
	})

			 
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Ginsen",
		head=gear.Adhemar_head_hq_B,
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body=gear.Adhemar_body_hq_B,
		hands=gear.Adhemar_hands_hq_B,
		ring1="Ilabrat Ring",
		ring2="Epona's Ring",
		back=gear.Rosmerta_StrWSD,
		waist="Fotia Belt",
		legs="Samnuha Tights",
		feet="Nyame Sollerets",
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
		ammo="Pemphredo Tathlum",
		head="Nyame Helm",
		--neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Regal Earring",
		body="Nyame Mail",
		hands="Jhakri Cuffs +2",
		ring1="Acumen Ring",
		ring2="Strendu Ring",
		back="Cornflower Cape",
		--waist="Yamabuki-no-Obi",
		legs="Luhlaza Shalwar +3",
		feet="Nyame Sollerets",
	})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		head="Nyame Helm",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body="Nyame Mail",
		hands="Jhakri Cuffs +2",
		back=gear.Rosmerta_StrWSD,
		waist="Sailfi Belt +1",
		legs="Luhlaza Shalwar +3",
		feet="Nyame Sollerets",
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
		head="Jhakri Coronal +2",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		ring1="Metamor. Ring +1",
		ring2="Epona's Ring",
		waist="Fotia Belt",
		legs="Jhakri Slops +2",
		--feet="Jhakri Pigaches +2",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Requiescat'].MidAcc = set_combine(sets.precast.WS['Requiescat'], {
	})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {
		ear1="Telos Earring",
		ear2="Cessance Earring",
	})

	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.MAB, {
		head="Pixie Hairpin +1",
		back=gear.Rosmerta_StrWSD,
	})
		
	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {
	})

	sets.midcast.FastRecast['Blue Magic'] = set_combine(sets.midcast.FastRecast, {
		hands="Hashi. Bazu. +1",
	})

	sets.midcast.MAB = {
		ammo="Pemphredo Tathlum",
		--head="Jhakri Coronal +2",
		--head="Nyame Helm",
		head=empty,
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Regal Earring",
		--body="Amalric Doublet",
		--body="Shamash Robe",
		body="Cohort Cloak +1",
		hands=gear.Amalric_hands_hq_D,
		ring1="Acumen Ring",
		ring2="Strendu Ring",
		back="Cornflower Cape",
		waist=gear.ElementalObi,
		--legs=gear.Amalric_legs_D,
		legs="Luhlaza Shalwar +3",
		feet=gear.Amalric_feet_hq_D,
	}

	sets.buffDuration = {
		body=gear.Telchine_body_pet,
		hands=gear.Telchine_hands_pet,
		legs=gear.Telchine_legs_pet,
	}

	sets.midcast['Enhancing Magic'] = set_combine(sets.buffDuration,{
		ammo="Pemphredo Tathlum",
		neck="Incanter's Torque",
		ear2="Andoaa Earring",
	})

	sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
		body=gear.Taeon_Phalanx_body,
		hands=gear.Taeon_Phalanx_hands,
		legs=gear.Taeon_Phalanx_legs,
		feet=gear.Taeon_Phalanx_feet,
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
		head="Luh. Keffiyeh +3",
		neck="Incanter's Torque",
		body="Assim. Jubbah +2",
		ring1="Stikini Ring",
		ring2="Stikini Ring +1",
		back="Cornflower Cape",
		legs="Hashishin Tayt +1",
		feet="Luhlaza Charuqs +3",
	}
		
	-- Physical Spells --
	
	sets.midcast['Blue Magic'].Physical = set_combine(sets.midcast['Blue Magic'], {
		ammo="Ginsen",
		head="Luh. Keffiyeh +3",
		neck="Incanter's Torque",
		ear1="Telos Earring",
		ear2="Crep. Earring",
		body="Luhlaza Jubbah +3",
		hands="Luh. Bazubands +3",
		ring1="Ilabrat Ring",
		ring2="Rajas Ring",
		back=gear.Rosmerta_StrWSD,
		waist="Prosilio Belt +1",
		legs="Luhlaza Shalwar +3",
		feet="Luhlaza Charuqs +3",
	})

	sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {
		waist="Grunfeld Rope",
		legs=gear.Carmine_legs_hq_D,
	})

	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {
	})

	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
	})

	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {
	})

	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical,	{
		hands=gear.Adhemar_hands_hq_B,
		ring1="Ilabrat Ring",
	})

	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical,	{
		ear2="Regal Earring",
		back="Aurist's Cape +1",
	})

	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical,	{
		ear2="Regal Earring",
		back="Aurist's Cape +1",
	})

	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {
	})

	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {
	})


	-- Magical Spells --
	
	sets.midcast['Blue Magic'].Magical = set_combine(sets.midcast.MAB, {
		ring1="Metamor. Ring +1",
	})

	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {
		ring1="Stikini Ring",
		ring2="Stikini Ring +1",
		waist="Sacro Cord",
	})

	sets.midcast['Blue Magic'].Magical.TH = set_combine(sets.midcast['Blue Magic'].Magical, sets.sharedTH, {
	})
	
	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {
		back="Aurist's Cape +1",
	})

	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {
	})

	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {
	})

	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {
	})

	sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {
		head="Pixie Hairpin +1",
		body="Shamash Robe",
	})

	sets.midcast['Blue Magic'].MagicalLight = set_combine(sets.midcast['Blue Magic'].Magical, {
	})

	sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical, {
		ammo="Pemphredo Tathlum",
		head="Luh. Keffiyeh +3",
		neck="Incanter's Torque",
		ear1="Crep. Earring",
		ear2="Regal Earring",
		body="Shamash Robe",
		hands="Regal Cuffs",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
		back="Aurist's Cape +1",
		waist="Eschan Stone",
	})

	-- Breath Spells --
	
	sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical, {
		ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +3",
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
		-- 13%
		body="Vrikodara Jupon",
		-- 10%
		hands="Telchine Gloves",
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
		body=gear.Taeon_Phalanx_body,
		hands=gear.Taeon_Phalanx_hands,
		legs=gear.Taeon_Phalanx_legs,
		feet=gear.Taeon_Phalanx_feet,
	})

	-- Sets to return to when not performing an action.

	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {
		hands="Assim. Bazu. +1",
	}

	sets.latent_refresh = {
		waist="Fucho-no-obi"
	}

	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum +1",
		--ammo="Homiliary",
		head="Rawhide mask",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Ethereal Earring",
		body="Jhakri Robe +2",
		hands="Nyame Gauntlets",
		ring1="Dark Ring",
		ring2="Defending Ring",
		--back="Moonbeam Cape",
		back="Mecisto. Mantle",
		waist="Flume Belt +1",
		--legs="Lengo Pants",
		legs="Carmine cuisses +1",
		--feet="Malignance Boots",
		feet="Nyame Sollerets",
	}

	-- DT: 58%
	--
	sets.idle.PDT = {
		-- DT 2%
		ammo="Staunch Tathlum +1",
		-- DT 7%
		head="Nyame Helm",
		-- DT 6%
		neck="Loricate Torque +1",
		-- MDT 2%
		ear1="Odnowa earring +1",
		ear2="Ethereal earring",
		-- DT 9%
		body="Nyame Mail",
		-- DT 7%
		hands="Nyame Gauntlets",
		-- PDT 5% MDT 5%
		ring1="Dark Ring",
		-- DT 10%
		ring2="Defending Ring",
		-- DT 5%
		back="Moonbeam Cape",
		-- PDT 4%
		waist="Flume Belt +1",
		-- DT 5%
		--legs="Aya. Cosciales +2",
		legs="Carmine cuisses +1",
		-- DT 4%
		--feet="Malignance Boots",
		-- DT 7%
		feet="Nyame Sollerets",
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

	sets.Kiting = {legs="Blood Cuisses"}

	-- Engaged sets

	-- Normal melee group
	sets.engaged = {
		ammo="Ginsen",
		head=gear.Adhemar_head_hq_B,
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Suppanomimi",
		body=gear.Adhemar_body_hq_B,
		hands=gear.Adhemar_hands_hq_B,
		ring1="Ilabrat Ring",
		ring2="Epona's Ring",
		back=gear.Rosmerta_DexSTP,
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet=gear.Carmine_feet_hq_B,
	}

	sets.engaged.MidAcc = set_combine(sets.engaged, {
		neck="Lissome Necklace",
		ear1="Telos Earring",
		waist="Eschan Stone",
	})

	sets.engaged.Acc = set_combine(sets.engaged.MidAcc, {
		head="Malignance Chapeau",
		--body="Malignance Tabard",
		body=gear.Adhemar_body_hq_B,
		--hands="Malignance Gloves",
		hands=gear.Adhemar_hands_hq_B,
		legs="Malignance Tights",
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
		body=gear.Adhemar_body_hq_B,
		ring2="Haverton Ring",
		waist="Reiki Yotai",
		legs=gear.Carmine_legs_hq_D,
	})

	sets.engaged.DW.MidAcc = set_combine(sets.engaged.MidAcc, {
		ear1="Telos Earring",
		ear2="Suppanomimi",
		waist="Reiki Yotai",
	})

	sets.engaged.DW.Acc = set_combine(sets.engaged.Acc, {
		ear1="Telos Earring",
		ear2="Suppanomimi",
		ring2="Haverton Ring",
		waist="Reiki Yotai",
		legs=gear.Carmine_legs_hq_D,
		feet=gear.Carmine_feet_hq_B,
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

	if state.CastingMode.value == 'TH' then
		equip(sets.sharedTH)
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
	if player.mpp < 51 then
		set_combine(idleSet, sets.latent_refresh)
	end
	if buffactive['Doom'] then
				idleSet = set_combine(idleSet, sets.buff.Doom)
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
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

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 19)
	elseif player.sub_job == 'RDM' then
		set_macro_page(3, 19)
	else
		set_macro_page(1, 19)
	end
end
