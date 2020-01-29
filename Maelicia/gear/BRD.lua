function user_setup()
	gear.ExtraSongInstrument = "Daurdabla"	
	gear.AllSongs = "Gjallarhorn"
	gear.Ballad = "Gjallarhorn"
	gear.Carol = "Gjallarhorn"
	gear.Dirge = "Gjallarhorn"
	gear.Elegy = "Gjallarhorn"
	gear.Etude = "Gjallarhorn"
	gear.Finale = "Gjallarhorn"
	gear.HonorMarch = "Marsyas"
	gear.Hymnus = "Gjallarhorn"
	gear.Lullaby = "Gjallarhorn"
	gear.Madrigal = "Gjallarhorn"
	gear.Mambo = "Gjallarhorn"
	gear.March = "Gjallarhorn"
	gear.Mazurka = "Gjallarhorn"
	gear.Minne = "Gjallarhorn"
	gear.Minuet = "Gjallarhorn"
	gear.Nocturne = "Gjallarhorn"
	gear.Paeon = "Gjallarhorn"
	gear.Prelude = "Gjallarhorn"
	gear.Requiem = "Gjallarhorn"
	gear.Scherzo = "Gjallarhorn"
	gear.Sirvente = "Gjallarhorn"
	gear.Threnody = "Gjallarhorn"
	gear.Virelai = "Gjallarhorn"
	
	gear.AugRhapsode = {
		name="Rhapsode's Cape",
		augments={
			"HP+18",
			"Mag. Acc. +6",
			"Enmity-2"
		}
	}
	
	-- Options: Override default values
	state.CastingMode:options('Normal', 'Resistant')
	state.OffenseMode:options('None', 'Normal')
	state.WeaponskillMode:options('Normal')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.IdleMode:options('CP', 'Normal', 'PDT', 'MDT', 'MDTOnca', 'CPPDT', 'CPMDT')

	brd_daggers = S{'Taming Sari', 'Odium', 'Izhiikoh', 'Vanir Knife', 'Atoyac', 'Aphotic Kukri', 'Sabebus'}
	pick_tp_weapon()
	
	-- Adjust this if using the Terpander (new +song instrument)
	info.DaurdablaInstrument = gear.ExtraSongInstrument
	-- How many extra songs we can keep from Daurdabla/Terpander
	info.DaurdablaSongs = 1
	-- Whether to try to automatically use Daurdabla when an appropriate gap in current vs potential
	-- songs appears, and you haven't specifically changed state.DaurdablaMode.
	state.AutoDaurdabla = false
	
	-- Set this to false if you don't want to use custom timers.
	state.UseCustomTimers = true

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
	--send_command('bind ^` gs c cycle ExtraSongsMode')
	--send_command('bind f9 gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')

	-- Default macro set/book
	set_macro_page(1, 9)

	global_aliases()
end


-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
	--send_command('unbind ^`')
	--send_command('unbind f9')
	send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Fast cast sets for spells
	-- 70%/35% Total (80/40 cap) + 15% (if RDM sub)
	sets.precast.FC = {
		-- 7%
		main="Kali",
		sub="Genmei Shield",
		--ammo="Impatiens",
		-- 10%
		head="Nahtirah Hat",
		-- 4%
		neck="Voltsurge Torque",
		-- 2%
		ear1="Loquac. Earring",
		-- 4%
		ear2="Malignance Earring",
		-- 13%
		body="Inyanga Jubbah +2",
		-- 2%
		ring1="Prolix Ring",
		-- 4%
		ring2="Kishar Ring",
		-- 7%
		hands="Gendewitha Gages",
		-- 3%
		back="Swith Cape",
		-- 3%
		--waist="Witful Belt",
		-- 5%
		waist="Embla Sash",
		-- 5%
		--legs="Lengo Pants",
		-- 6%
		legs="Aya. Cosciales +2",
		-- 4%
		feet="Chelona Boots"
	}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		ear1="Mendi. Earring",
		back="Pahtli Cape",
		waist="Acerbic Sash +1",
		legs="Doyen Pants",
		feet=gear.Vanya_feet_B
	})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"
	})
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
		head="Umuthi Hat",
		hands="Carapacho Cuffs",
		legs="Doyen Pants",
	})

	-- Total:47%/28% (cap 80/40) + 24% FC gear + 15% (if RDM sub)
	sets.precast.FC.BardSong = set_combine(sets.precast.FC,{
		-- 7% FC
		main="Kali",
		sub="Genmei Shield",
		--range="Gjallarhorn",
		-- 12%
		head="Fili Calot +1",
		-- 3%
		neck="Aoidos' Matinee",
		-- 2%
		--ear1="Aoidos' Earring",
		-- 12%
		body="Sha'ir Manteel",
		-- 2% + 7% FC
		hands="Gendewitha Gages",
		-- 3% FC
		back="Swith Cape",
		-- 5% FC
		waist="Embla Sash",
		-- 6%
		legs="Doyen Pants",
		-- 8%
		feet="Bihu Slippers +1"
	})
	
	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.DaurdablaInstrument})
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
	sets.precast.JA.Troubadour = {body="Bihu Jstcorps +1"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}
	sets.precast.JA.Sublimination = {
		waist="Embla Sash"
	}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		range="Gjallarhorn",
		head="Inyanga Tiara +2",
		neck="Reti Pendant",
		body="Bihu Jstcorps +1",
		hands="Inyan. Dastanas +2",
		ring1="Sirona's Ring",
		ring2="Petrov Ring",
		back="Kumbira Cape",
		waist="Flume Belt +1",
		legs="Inyanga Shalwar +2",
		feet="Inyan. Crackows +2"
	}
			 
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Blistering Sallet +1",
		neck="Fotia Necklace",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		ring1="Ilabrat Ring",
		ring2="Petrov Ring",
		back="Atheling Mantle",
		waist="Fotia Belt",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
	}
	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		head=gear.Chironic_head_nuke,
		--neck="Sanctity Necklace",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body=gear.Chironic_body_nuke,
		hands=gear.Chironic_hands_nuke,
		ring1="Acumen Ring",
		ring2="Strendu Ring",
		back="Toro Cape",
		--waist="Eschan Stone",
		legs=gear.Chironic_legs_nuke,
		feet=gear.Chironic_feet_nuke
	})
	
	-- Specific weaponskill sets.	Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
	})
	
	-- Magical WS
	
	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Spirit Taker'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS.MAB, {
	})
	
	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		-- 5% 5RC
		head="Nahtirah Hat",
		-- 2% 7RC
		body="Inyanga Jubbah +2",
		-- 7RC
		hands="Gendewitha Gages",
		ring2="Defending Ring",
		-- 5% 2RC
		waist="Embla Sash",
		-- 5% 2RC
		legs="Lengo Pants",
		-- 3%
		feet="Brioso Slippers +3"
	})
	
	sets.midcast.MACC = {
		main=gear.MaccStaff,
		sub="Enki Strap",
		head="Chironic Hat",
		--neck="Incanter's Torque",
		neck="Moonbow Whistle",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		--body="Chironic Doublet",
		body="Brioso Justau. +2",
		--hands="Inyan. Dastanas +2",
		hands="Brioso Cuffs +2",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back=gear.AugRhapsode,
		waist="Eschan Stone",
		legs="Chironic Hose",
		--feet="Inyan. Crackows +2"
		feet="Brioso Slippers +3"
	}
	
	sets.midcast.MAB = {
		main=gear.MainStaff,
		sub="Enki Strap",
		ammo="Ombre Tathlum +1",
		head="Chironic Hat",
		neck="Sanctity Necklace",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Chironic Doublet",
		hands=gear.Chironic_hands_nuke,
		ring1="Acumen Ring",
		ring2="Strendu Ring",
		back=gear.ElementalCape,
		waist=gear.ElementalObi,
		legs="Chironic Hose",
		feet="Chironic Slippers"
	}

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = set_combine(sets.midcast.FastRecast,{
		main="Kali",
		range="Gjallarhorn",
		head="Fili Calot +1",
		ear2="Darkside Earring",
		--neck="Aoidos' Matinee",
		neck="Moonbow Whistle",
		body="Fili Hongreline +1",
		hands="Fili Manchettes +1",
		back="Harmony Cape",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3"
	})
	
	sets.midcast.ExtraSong = {
		main="Vampirism",
		sub="Genmei Shield",
		range=gear.ExtraSongInstrument,
		head="Nahtirah Hat",
		neck="Voltsurge Torque",
		ear1="Loquac. Earring",
		ear2="Malignance Earring",
		body="Vrikodara Jupon",
		hands="Gendewitha Gages",
		back="Swith Cape",
		waist="Embla Sash",
		legs="Lengo Pants",
		feet="Chelona Boots"
	}

	sets.midcast['Herb Pastoral'] = set_combine(sets.midcast.ExtraSong,{})
	sets.midcast['Goblin Gavotte'] = set_combine(sets.midcast.ExtraSong,{})
	
	-- Song-specific recast reduction
	sets.midcast.SongRecast = set_combine(sets.midcast.FastRecast,{
		back="Harmony Cape",
		legs="Fili Rhingrave +1"
	})

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = set_combine(sets.midcast.MACC,{
		range="Gjallarhorn",
		--neck="Aoidos' Matinee",
		neck="Moonbow Whistle",
		head="Inyanga Tiara +2",
		body="Fili Hongreline +1",
		hands="Inyan. Dastanas +2",
		back="Kumbira Cape",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3"
	})

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.ResistantSongDebuff = set_combine(sets.midcast.MACC,{
		range="Gjallarhorn",
		--neck="Incanter's Torque",
		neck="Moonbow Whistle",
		body="Brioso Justau. +2",
		legs="Chironic Hose",
		--feet="Chironic Slippers"
		feet="Brioso Slippers +3"
	})

	--sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.DaurdablaInstrument})

	-- Cast spell with normal gear, except using Daurdabla instead
	sets.midcast.Daurdabla = {range=info.DaurdablaInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
	sets.midcast.DaurdablaDummy = set_combine(sets.midcast['Herb Pastoral'],{
		range=info.DaurdablaInstrument,
	})
		
	-- Gear to enhance certain classes of songs.
	sets.midcast.Ballad = set_combine(sets.midcast.SongEffect,{
		range=gear.Ballad,
		legs="Fili Rhingrave +1"
	})
	sets.midcast.Madrigal = set_combine(sets.midcast.SongEffect,{
		range=gear.Madrigal,
		head="Fili Calot +1",
		back="Intarabus's Cape"
	})
	sets.midcast.Prelude = set_combine(sets.midcast.SongEffect,{
		range=gear.Prelude,
		back="Intarabus's Cape"
	})
	-- +7
	sets.midcast.March = set_combine(sets.midcast.SongEffect,{
		range=gear.March,
		hands="Fili Manchettes +1"
	})
	-- +3
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{
		range=gear.HonorMarch,
	})
	sets.midcast.Minuet = set_combine(sets.midcast.SongEffect,{
		range=gear.Minuet,
		body="Fili Hongreline +1"
	})
	sets.midcast.Minne = set_combine(sets.midcast.SongEffect,{
		range=gear.Minne,
	})
	sets.midcast.Carol = set_combine(sets.midcast.SongEffect,{
		range=gear.Carol,
		head="Fili Calot +1",
		body="Fili Hongreline +1",
		hands="Fili Manchettes +1",
		legs="Fili Rhingrave +1",
		feet="Fili Cothurnes +1"
	})
	sets.midcast["Sentinel's Scherzo"] = set_combine(sets.midcast.SongEffect,{
		range=gear.Scherzo,
		feet="Fili Cothurnes +1"
	})
	sets.midcast.Mazurka = set_combine(sets.midcast.SongEffect,{
		range=gear.Mazurka
	})
	
	-- debuff sets, do not use set_combine as SongDebuff and ResistantSongDebuff sets need to kick in
	sets.midcast.Lullaby = {
		range=gear.Lullaby,
		hands="Brioso Cuffs +2"
	}
	sets.midcast['Magic Finale'] = {
		range=gear.Finale,
	}

	-- Other general spells and classes.
	sets.midcast['Healing Magic'] = {
		head="Hyksos Khat",
		neck="Incanter's Torque",
		body=gear.Vanya_body_B,
		hands="Inyan. Dastanas +2",
		ring1="Sirona's Ring",
		ring2="Ephedra Ring",
		back="Altruistic Cape",
		feet=gear.Vanya_feet_B
	}	
	
	-- 50% Total
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'],{
		-- 30%
		main=gear.Staff.Cure,
		sub="Enki Strap",
		head="Hyksos Khat",
		neck="Incanter's Torque",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		-- 13%
		body="Vrikodara Jupon",
		hands="Inyan. Dastanas +2",
		-- 8%
		legs="Chironic Hose",
		-- 5%
		feet=gear.Vanya_feet_B
	})
		
	sets.midcast.Curaga = set_combine(sets.midcast.Cure,{
		body="Vrikodara Jupon",
	})
	sets.midcast.CureSelf = set_combine(sets.midcast.Cure,{
		waist="Gishdubar Sash",
	})
	sets.midcast.Cursna = set_combine(sets.midcast['Healing Magic'],{
		neck="Malison Medallion",
		ring1="Ephedra Ring",
		ring2="Ephedra Ring",
		feet="Gende. Galosh +1"
	})
	sets.midcast.CursnaSelf = set_combine(sets.midcast.Cursna,{
		waist="Gishdubar Sash",
	})
	
	sets.midcast['Enhancing Magic'] = {
		main="Serenity",
		head="Umuthi Hat",
		neck="Incanter's Torque",
		ear1="Regal Earring",
		ear2="Andoaa Earring",
		body="Telchine Chas.",
		hands="Inyan. Dastanas +2",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back="Fi Follet Cape +1",
		waist="Embla Sash",
		legs="Inyanga Shalwar +2",
		feet="Inyan. Crackows +2"
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],{
		head="Umuthi Hat",
		neck="Nodens Gorget",
		ear1="Earthcry Earring",
		waist="Siegel Sash",
		legs="Haven Hose"
	})
	
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{
		head="Inyanga Tiara +2"
	})

	sets.midcast.RefreshSelf = set_combine(sets.midcast['Enhancing Magic'],{
		waist="Gishdubar Sash",
	})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],{
		head="Chironic Hat"
	})
	
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'],{
		ring1="Sheltered Ring"
	})

	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'],{
		ring1="Sheltered Ring"
	})
	
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.MACC,{
		sub="Mephitis Grip",
		--neck="Incanter's Torque",
		neck="Moonbow Whistle",
		body="Vanya Robe",
		hands="Inyan. Dastanas +2",
		ring1="Stikini Ring",
		ring2="Kishar Ring",
		--ring2="Stikini Ring",
		waist="Rumination Sash",
		legs="Chironic Hose",
		feet="Skaoi Boots",
	})
	
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast.MAB,{
	})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAB,{
		body="Vanya Robe",
		feet="Chironic Slippers"
	})
	
	sets.midcast.Repose = set_combine(sets.midcast.FastRecast,{
	})
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = set_combine(sets.sharedResting,{
	})	
	
	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		--main=gear.Staff.PDT, 
		--sub="Enki Strap",
		main="Sangoma",
		sub="Genmei Shield",
		--range=gear.AllSongs,
		range="Marsyas",
		head="Inyanga Tiara +2",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
		body="Vrikodara Jupon",
		--hands="Inyan. Dastanas +2",
		hands="Aya. Manopolas +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Lengo Pants",
		feet="Fili Cothurnes +1"
	}
	
	sets.noprotect = {ring1="Sheltered Ring"}

	-- PDT: 50%
	-- MDT: 56%
	-- MDB: 41 
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.idle.DT = set_combine(sets.idle,{		
		-- 20% PDT
		main=gear.Staff.PDT,
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
		-- 4% PDT
		waist="Flume Belt +1",
		-- 9 MDB 6% MDT
		legs="Inyanga Shalwar +2",
		-- 8 MDB 3% MDT
		feet="Inyan. Crackows +2"
	})

	sets.idle.PDT = set_combine(sets.idle.DT,{
	})
	sets.idle.MDT = set_combine(sets.idle.DT,{
	})
	
	sets.idle.MDTOnca = {
		-- 8 5%
		head="Inyanga Tiara +2",
		-- 6%
		neck="Loricate Torque +1",
		-- 3%
		ear1="Etiolation Earring",
		ear2="Arete del Luna",
		-- 12
		body="Onca Suit",
		hands=empty,
		-- 5%
		back="Moonbeam Cape",
		--back="Tantalic Cape",
		legs=empty,
		feet=empty
	}
	
	sets.idle.CP = set_combine(sets.idle,{
		--back="Mecistopins Mantle"
	})
	
	sets.idle.CPPDT = set_combine(sets.idle.PDT,{
		--back="Mecistopins Mantle"
	})
	
	sets.idle.CPMDT = set_combine(sets.idle.MDT,{
		--back="Mecistopins Mantle"
	})

	sets.idle.Town = set_combine(sets.idle, {
		body="Councilor's Garb"
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

	sets.Kiting = {feet="Fili Cothurnes +1"}

	sets.latent_refresh = {waist="Fucho-no-obi"}

	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.

	sets.buff.Doom = {
		waist="Gishdubar Sash",
	}

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
		--body="Onca Suit",
		body="Ayanmo Corazza +2",
		--hands=empty,
		hands="Aya. Manopolas +2",
		ring1="Ilabrat Ring",
		ring2="Petrov Ring",
		back="Buquwik Cape",
		waist="Goading Belt",
		--legs=empty,
		legs="Aya. Cosciales +2",
		--feet=empty
		feet="Aya. Gambieras +2",
	}

	-- Sets with weapons defined.
	sets.engaged.Dagger = set_combine(sets.engaged,{
	})

	-- Set if dual-wielding
	sets.engaged.DualWield = set_combine(sets.engaged,{
		ear1="Dudgeon Earring",
		ear2="Heartseeker Earring"
	})

	sets.engaged.Acc = set_combine(sets.engaged,{
		ear2="Digni. Earring",
		ring2="Cacoethic Ring +1",
		back="Ground. Mantle +1"
	})

	sets.engaged.Dagger.Acc = set_combine(sets.engaged.Acc,{
	})

	sets.engaged.DualWield.Acc = set_combine(sets.engaged.Acc,{
	})
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.type == 'BardSong' then
		if state.ExtraSongsMode.value == 'FullLength' then
			equip(sets.midcast.Daurdabla)
		end
		state.ExtraSongsMode:reset()
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
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if pet.isvalid then
			idleSet = set_combine(idleSet, sets.idle.Pet)
	elseif not buffactive['Protect'] then
			idleSet = set_combine(idleSet, sets.noprotect)
		end
	if state.Buff.Doom then
			idleSet = set_combine(idleSet, sets.buff.Doom)
	end
	return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.Buff.Doom then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
	end
	return meleeSet
end

function customize_defense_set(defenseSet)    
	if state.Buff.Doom then
		defenseSet = set_combine(defenseSet, sets.buff.Doom)
	end
	return defenseSet
end