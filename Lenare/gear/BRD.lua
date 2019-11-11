function user_setup()
	gear.ExtraSongInstrument = "Terpander"
	
	gear.AllSongs = "Eminent Flute"
	gear.Ballad = "Eminent Flute"
	gear.Carol = "Eminent Flute"
	gear.Dirge = "Eminent Flute"
	gear.Elegy = "Syrinx"
	gear.Etude = "Langeleik"
	gear.Finale = "Pan's Horn"
	gear.Hymnus = "Pan's Horn"
	gear.Lullaby = "Pan's Horn"
	gear.Madrigal = "Cantabank's Horn"
	gear.Mambo = "Vihuela"
	gear.March = "Langeleik"
	gear.Mazurka = "Vihuela"
	gear.Minne = "Syrinx"
	gear.Minuet = "Apollo's Flute"
	gear.Nocturne = "Eminent Flute"
	gear.Paeon = "Pan's Horn"
	gear.Prelude = "Cantabank's Horn"
	gear.Requiem = "Requiem Flute"
	gear.Scherzo = "Eminent Flute"
	gear.Sirvente = "Eminent Flute"
	gear.Threnody = "Eminent Flute"
	gear.Virelai = "Eminent Flute"
	
	gear.AugRhapsode = {
		name="Rhapsode's Cape",
		augments={
			"HP+25",
			"Mag. Acc. +1",
			"Enmity-5"
		}
	}
	
	-- Options: Override default values
	options.CastingModes = {'Normal', 'Resistant'}
	options.OffenseModes = {'None', 'Normal'}
	options.DefenseModes = {'Normal'}
	options.WeaponskillModes = {'Normal'}
	options.IdleModes = {'Normal', 'PDT'}
	options.RestingModes = {'Normal'}
	options.PhysicalDefenseModes = {'PDT'}
	options.MagicalDefenseModes = {'MDT'}

	state.PhysicalDefenseMode = 'PDT'
	state.OffenseMode = 'None'

	brd_daggers = S{'Izhiikoh', 'Vanir Knife', 'Atoyac', 'Aphotic Kukri', 'Sabebus'}
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
	
	-- Additional local binds
	send_command('bind ^` gs c cycle Daurdabla')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')

	-- Default macro set/book
	--set_macro_page(2, 18)
end


-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Fast cast sets for spells
	-- 41%/20% Total (80/40 cap) + 15% (if RDM sub)
	sets.precast.FC = {
		-- 10%
		head="Nahtirah Hat",
		-- 2% Aug
		neck="Jeweled Collar",
		-- 2%
		ear2="Loquac. Earring",
		-- 5%
		body="Vanir Cotehardie",
		-- 7%
		hands="Gendewitha Gages",
		-- 3%
		back="Swith Cape",
		-- 3%
		waist="Witful Belt",
		-- 5%
		legs="Orvail Pants +1",
		-- 4%
		feet="Chelona Boots"
	}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		back="Pahtli Cape"
	})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
		waist="Siegel Sash"
	})
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {
		head="Umuthi Hat"
	})

	-- Total:51%/25% (cap 80/40) + 15% FC gear + 15% (if RDM sub)
	sets.precast.FC.BardSong = set_combine(sets.precast.FC,{
		-- 6%
		main="Felibre's Dague",
		sub="Genbu's Shield",
		--range="Gjallarhorn",
		-- 12%
		head="Aoidos' Calot +2",
		-- 3%
		neck="Aoidos' Matinee",
		-- 2%
		--ear1="Aoidos' Earring",
		-- 12%
		body="Sha'ir Manteel",
		-- 2% + 7% FC
		hands="Gendewitha Gages",
		-- 5% + 1%
		legs="Gendewitha Spats",
		-- 8%
		feet="Bihu Slippers +1"
	})
	
	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.DaurdablaInstrument})
	
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		neck="Stoicheion Medal"
	})
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
	sets.precast.JA.Troubadour = {body="Bihu Justaucorps"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		--range="Gjallarhorn",
		head="Bihu Roundlet +1",
		ear1="Roundel Earring",
		body="Vanir Cotehardie",
		hands="Lurid Mitts",
		--back="Kumbira Cape",
		back="Refraction Cape",
		legs="Bihu Cannions +1",
		feet="Bihu Slippers +1"
	}
			 
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Buremte Hat",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Vanir Cotehardie",
		hands="Umuthi Gloves",
		ring1="Rajas Ring",
		ring2="Ifrit Ring",
		back="Atheling Mantle",
		waist="Caudata Belt",
		legs="Bihu Cannions +1",
		feet="Brioso Slippers +1"
	}
	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		neck="Stoicheion Medal",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		body="Artsieq Jubbah",
		hands="Otomi Gloves",
		ring1="Acumen Ring",
		ring2="Strendu Ring",
		back="Toro Cape",
		waist="Yamabuki-no-Obi",
		legs="Hagondes Pants +1",
		feet="Umbani Boots"
	})
	
	-- Specific weaponskill sets.	Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		neck=gear.ElementalGorget
	})
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
		neck=gear.ElementalGorget
	})
	sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
		neck=gear.ElementalGorget
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
	sets.midcast.FastRecast = {
		head="Nahtirah Hat",
		ear2="Loquacious Earring",
		body="Vanir Cotehardie",
		hands="Gendewitha Gages",
		back="Swith Cape",
		waist="Cetl Belt",
		legs="Bihu Cannions +1",
		feet="Brioso Slippers +1"
	}
	
	sets.midcast.MACC = {
		main=gear.MainStaff,
		sub="Mephitis Grip",
		head="Bihu Roundlet +1",
		neck="Stoicheion Medal",
		ear1="Psystorm Earring",
		ear2="Lifestorm Earring",
		body="Brioso Just. +1",
		hands="Lurid Mitts",
		ring1="Sangoma Ring",
		ring2="Strendu Ring",
		back=gear.AugRhapsode,
		waist="Demonry Sash",
		legs="Bihu Cannions +1",
		feet="Artsieq Boots"
	}
	
	sets.midcast.MAB = {
		main=gear.MainStaff,
		sub="Elder's Grip +1",
		ammo="Ombre Tathlum +1",
		head="Buremte Hat",
		neck="Stoicheion Medal",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		body="Artsieq Jubbah",
		hands="Otomi Gloves",
		ring1="Acumen Ring",
		ring2="Strendu Ring",
		back="Toro Cape",
		waist="Yamabuki-no-Obi",
		legs="Gendewitha Spats",
		feet="Umbani Boots"
	}

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = set_combine(sets.midcast.FastRecast,{
		main="Legato Dagger",
		--range="Gjallarhorn",
		head="Aoidos' Calot +2",
		neck="Aoidos' Matinee",
		body="Aoidos' Hongreline +2",
		hands="Aoidos' Manchettes +2",
		back="Harmony Cape",
		legs="Mdk. Shalwar +1",
		feet="Brioso Slippers +1"
	})
	
	-- Song-specific recast reduction
	sets.midcast.SongRecast = set_combine(sets.midcast.FastRecast,{
		back="Harmony Cape",
		legs="Aoidos' Rhing. +2"
	})

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = set_combine(sets.midcast.MACC,{
		--range="Gjallarhorn",
		neck="Aoidos' Matinee",
		body="Aoidos' Hongreline +2",
		hands="Aoidos' Manchettes +2",
		back="Kumbira Cape",
		legs="Mdk. Shalwar +1",
		feet="Brioso Slippers +1"
	})

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.ResistantSongDebuff = set_combine(sets.midcast.MACC,{
		--range="Gjallarhorn",
		back="Kumbira Cape"
	})

	--sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.DaurdablaInstrument})

	-- Cast spell with normal gear, except using Daurdabla instead
	sets.midcast.Daurdabla = {range=info.DaurdablaInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
	sets.midcast.DaurdablaDummy = {
		main="Felibre's Dague",
		sub="Genbu's Shield",
		range=info.DaurdablaInstrument,
		head="Nahtirah Hat",
		neck="Jeweled Collar",
		ear2="Loquac. Earring",
		body="Sha'ir Manteel",
		hands="Gendewitha Gages",
		back="Swith Cape",
		waist="Witful Belt",
		legs="Orvail Pants +1",
		feet="Chelona Boots"
	}
		
	-- Gear to enhance certain classes of songs.
	sets.midcast.Ballad = set_combine(sets.midcast.SongEffect,{
		range=gear.Ballad,
		legs="Aoidos' Rhing. +2"
	})
	sets.midcast.Lullaby = set_combine(sets.midcast.SongDebuff,{
		range=gear.Lullaby,
		hands="Brioso Cuffs"
	})
	sets.midcast.Madrigal = set_combine(sets.midcast.SongEffect,{
		range=gear.Madrigal,
		head="Aoidos' Calot +2"
	})
	sets.midcast.March = set_combine(sets.midcast.SongEffect,{
		range=gear.March,
		hands="Aoidos' Manchettes +2"
	})
	sets.midcast.Minuet = set_combine(sets.midcast.SongEffect,{
		range=gear.Minuet,
		body="Aoidos' Hongreline +2"
	})
	sets.midcast.Minne = set_combine(sets.midcast.SongEffect,{
		range=gear.Minne,
	})
	sets.midcast.Carol = set_combine(sets.midcast.SongEffect,{
		range=gear.Carol,
		head="Aoidos' Calot +2",
		body="Aoidos' Hongreline +2",
		hands="Aoidos' Manchettes +2",
		legs="Aoidos' Rhing. +2",feet="Aoidos' Cothrn. +2"
	})
	sets.midcast["Sentinel's Scherzo"] = set_combine(sets.midcast.SongEffect,{
		range=gear.Scherzo,
		feet="Aoidos' Cothrn. +2"
	})
	sets.midcast['Magic Finale'] = {
		range=gear.Finale,
		neck="Wind Torque",waist="Corvax Sash",legs="Aoidos' Rhing. +2"
	}
	sets.midcast.Mazurka = set_combine(sets.midcast.SongEffect,{
		range=gear.Mazurka
	})

	-- Other general spells and classes.
	sets.midcast['Healing Magic'] = {
		head="Hyksos Khat",
		neck="Colossus's Torque",
		hands="Ayao's Gages",
		ring1="Sirona's Ring",
		ring2="Ephedra Ring",
		back="Altruistic Cape"
	}	
	
	-- 53% Total
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'],{
		-- 24%
		main=gear.Staff.Cure,
		sub="Elder's Grip +1",
		head="Gendewitha Caubeen",
		ear1="Lifestorm Earring",
		-- 5%
		ear2="Roundel Earring",
		-- 8%
		body="Gendewitha Bliaut",
		-- 13%
		hands="Bokwus Gloves",
		legs="Bihu Cannions +1",
		-- 3% aug
		feet="Gende. Galoshes"
	})
		
	sets.midcast.Curaga = set_combine(sets.midcast.Cure,{
	})
	
	sets.midcast.Cursna = set_combine(sets.midcast['Healing Magic'],{
		neck="Malison Medallion",
		ring1="Ephedra Ring",
		ring2="Ephedra Ring",
		feet="Gende. Galoshes"
	})
	
	sets.midcast['Enhancing Magic'] = {
		head="Umuthi Hat",
		neck="Colossus's Torque",
		ear2="Andoaa Earring",
		body="Brioso Just. +1",
		hands="Lurid Mitts",
		waist="Siegel Sash",
		back="Refraction Cape",
		legs="Bihu Cannions +1",
		feet="Brioso Slippers +1"
	}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],{
		head="Umuthi Hat",
		neck="Stone Gorget",
		ear1="Earthcry Earring",
		hands="Carapacho Cuffs",
		waist="Siegel Sash",
		legs="Haven Hose"
	})
	
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.MACC,{
	})
	
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast.MAB,{
	})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAB,{
	})
	
	sets.midcast.Repose = set_combine(sets.midcast.FastRecast,{
	})
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = set_combine(sets.sharedResting,{
	})	
	
	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		main=gear.Staff.PDT, 
		sub="Mephitis Grip",
		range=gear.ExtraSongInstrument,
		head="Bihu Roundlet +1",
		neck="Twilight Torque",
		ear1="Novia Earring",
		ear2="Loquacious Earring",
		body="Artsieq Jubbah",
		hands="Umuthi Gloves",
		ring1="Sheltered Ring",
		ring2="Dark Ring",
		--back="Umbra Cape",
		back="Mecistopins Mantle",
		waist="Flume Belt +1",
		legs="Nares Trews",
		feet="Aoidos' Cothrn. +2"
	}

	-- Total: 40% + 20% (PDT Staff)
	-- <36%: use Shadow Mantle
	sets.idle.PDT = set_combine(sets.idle,{
		main=gear.Staff.PDT,
		-- 4%
		head="Bihu Roundlet +1",
		-- 5%
		neck="Twilight Torque",
		body="Artsieq Jubbah",
		-- 4%
		hands="Umuthi Gloves",
		-- 5%
		ring1="Patricius Ring",
		-- 5%
		ring2="Dark Ring",
		-- 6% (12% night time)
		back="Umbra Cape",
		-- 4%
		waist="Flume Belt +1",
		-- 4%
		legs="Bihu Cannions +1",
		-- 3%
		feet="Bihu Slippers +1"
	})
	
	-- MDT: 10%
	-- MDB: 27
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.idle.MDT = set_combine(sets.idle,{		
		-- 5
		head="Bihu Roundlet +1",
		-- 5%
		neck="Twilight Torque",
		-- 6
		body="Artsieq Jubbah",
		-- 2
		hands="Umuthi Gloves",
		-- 5%
		ring1="Shadow Ring",
		-- 5%
		ring2="Dark Ring",
		-- 5
		back="Rhapsode's Cape",
		-- 4%
		waist="Flume Belt +1",
		-- 6
		legs="Bihu Cannions +1",
		-- 5
		feet="Bihu Slippers +1"
	})

	sets.idle.Town = set_combine(sets.idle,{
	})
	
	sets.idle.Weak = set_combine(sets.idle,{
	})
	
	-- Defense sets

	sets.defense.PDT = set_combine(sets.idle.PDT,{
	})

	sets.defense.MDT = set_combine(sets.idle.MDT,{
	})

	sets.Kiting = {feet="Aoidos' Cothrn. +2"}

	sets.latent_refresh = {waist="Fucho-no-obi"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.	Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Basic set for if no TP weapon is defined.
	sets.engaged = {
		head="Bihu Roundlet +1",
		neck="Asperity Necklace",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
		body="Artsieq Jubbah",
		hands="Umuthi Gloves",
		ring1="Rajas Ring",
		ring2="K'ayres Ring",
		back="Atheling Mantle",
		waist="Cetl Belt",
		legs="Bihu Cannions +1",
		feet="Gende. Galoshes"
	}

	-- Sets with weapons defined.
	sets.engaged.Dagger = set_combine(sets.engaged,{
	})

	-- Set if dual-wielding
	sets.engaged.DualWield = set_combine(sets.engaged,{
		ear1="Dudgeon Earring",
		ear2="Heartseeker Earring"
	})
	
end