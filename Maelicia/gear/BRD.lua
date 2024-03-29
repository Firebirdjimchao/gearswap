function job_setup()
	state.ExtraSongsMode = M{['description']='Extra Songs', 'None', 'Dummy', 'FullLength'}

	state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

	state.CP = M(false, "Capacity Points Mode")
	state.Warp = M(false, "Warp Mode")
	state.Weapon = M{['description']='Weapon Lock', 'Normal', 'Main + Sub', 'Range + Ammo', 'Full'}
	state.Neck = M(false, "Neck Mode")
	state.TreasureMode = M(false, 'TH')
	state.EngagedDT = M(false, 'Engaged Damage Taken Mode')

	-- For tracking current recast timers via the Timers plugin.
	custom_timers = {}
end

function user_setup()
	gear.ExtraSongInstrument = "Daurdabla"	
	gear.AllSongs = "Gjallarhorn"
	gear.Ballad = "Gjallarhorn"
	gear.Carol = "Gjallarhorn"
	gear.Dirge = "Marsyas"
	gear.Elegy = "Gjallarhorn"
	gear.Etude = "Gjallarhorn"
	gear.Finale = "Gjallarhorn"
	gear.HonorMarch = "Marsyas"
	gear.Hymnus = "Marsyas"
	gear.FoeLullaby = "Gjallarhorn"
	gear.Lullaby = "Daurdabla"
	gear.Madrigal = "Gjallarhorn"
	gear.Mambo = "Gjallarhorn"
	gear.March = "Gjallarhorn"
	gear.Mazurka = "Marsyas"
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
	
	-- Options: Override default values
	state.CastingMode:options('Normal', 'Resistant')
	state.OffenseMode:options('None', 'Normal')
	state.WeaponskillMode:options('Normal')
	state.RestingMode:options('Normal')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.IdleMode:options('CP', 'Normal', 'PDT', 'MDT', 'CPPDT', 'CPMDT')

	gear.IntarabusMACC = { name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}

	state.HasteMode = M{['description']='Haste Mode', 'Normal', 'Hi'}

	brd_daggers = S{'Carnwenhan','Tauret','Blur Knife +1','Taming Sari'}
	pick_tp_weapon()
	
	-- Adjust this if using the Terpander (new +song instrument)
	info.DaurdablaInstrument = gear.ExtraSongInstrument
	-- How many extra songs we can keep from Daurdabla/Terpander
	info.DaurdablaSongs = 2
	-- Whether to try to automatically use Daurdabla when an appropriate gap in current vs potential
	-- songs appears, and you haven't specifically changed state.DaurdablaMode.
	state.AutoDaurdabla = false
	
	-- Set this to false if you don't want to use custom timers.
	state.UseCustomTimers = M(true, 'Use Custom Timers')	

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
	send_command('bind @d gs c cycle ExtraSongsMode') -- WindowKey'D' for dummy
	send_command('bind @m input /recast "Chocobo Mazurka"; input /ma "Chocobo Mazurka" <stpt>') -- WindowKey'M'

	send_command('bind @c gs c toggle CP') --WindowKey'C'
	send_command('bind @e gs c toggle EngagedDT') --Windowkey'E'
	send_command('bind @h gs c cycle TreasureMode') --Windowkey'H'
	send_command('bind @n gs c toggle Neck') --Windowkey'N'
	send_command('bind @r gs c toggle Warp') --Windowkey'R'
	send_command('bind @w gs c cycle Weapon') --Windowkey'W'

	-- Default macro set/book
	set_macro_page(1, 9)

	global_aliases()
end


-- Called when this job file is unloaded (eg: job change)
function job_file_unload()
	send_command('unbind @d')
	send_command('unbind @m')
	
	send_command('unbind @c')
	send_command('unbind @e')
	send_command('unbind @h')
	send_command('unbind @n')
	send_command('unbind @r')
	send_command('unbind @w')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Fast cast sets for spells
	-- 75%/37% Total (80/40 cap) + 15% (if RDM sub)
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
		-- 14%
		body="Inyanga Jubbah +2",
		-- 2%
		ring1="Prolix Ring",
		-- 4%
		ring2="Kishar Ring",
		-- 7%
		hands="Gendewitha Gages",
		-- 10%
		back=gear.IntarabusMACC,
		-- 3%
		--waist="Witful Belt",
		-- 5%
		waist="Embla Sash",
		-- 5%
		--legs="Lengo Pants",
		-- 6%
		legs="Aya. Cosciales +2",
		-- 4%
		--feet="Chelona Boots"
	}

-- Cannot exceed 80/40 FC cap in combination with FC
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		-- 5%
		ear1="Mendi. Earring",
		-- 15%
		legs="Doyen Pants",
		-- 7%
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

	-- Total:47% (caps at 50%)
	-- Song Spellcasting Time stacks with FC
	sets.precast.FC.BardSong = set_combine(sets.precast.FC,{
		-- 7% FC
		main="Kali",
		sub="Genmei Shield",
		--range="Gjallarhorn",
		-- 14%
		head="Fili Calot +1",
		-- 15%
		body="Brioso Justau. +3",
		-- 2% + 7% FC
		hands="Gendewitha Gages",
		-- 6%
		legs="Doyen Pants",
		-- 10%
		feet="Bihu Slippers +3"
	})
	
	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.DaurdablaInstrument})
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers +3"}
	sets.precast.JA.Troubadour = {body="Bihu Jstcorps. +3"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +3"}

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak"})

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		range="Gjallarhorn",
		head="Inyanga Tiara +2",
		--neck="Reti Pendant",
		body="Brioso Justau. +3",
		hands="Brioso Cuffs +3",
		ring1="Sirona's Ring",
		ring2="Petrov Ring",
		--back="Kumbira Cape",
		waist="Flume Belt +1",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3"
	}
			 
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Nyame Helm",
		neck="Fotia Necklace",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		--body="Nyame Mail",
		body="Bihu Jstcorps. +3",
		hands="Nyame Gauntlets",
		ring1="Ilabrat Ring",
		ring2="Petrov Ring",
		back="Atheling Mantle",
		waist="Fotia Belt",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}
	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		head="Nyame Helm",
		--neck="Sanctity Necklace",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		body="Nyame Mail",
		--body=gear.Chironic_body_nuke,
		hands="Nyame Gauntlets",
		ring1="Acumen Ring",
		ring2="Strendu Ring",
		back="Toro Cape",
		--waist="Eschan Stone",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	
	-- Specific weaponskill sets.	Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		head="Blistering Sallet +1",
		ear1="Odr Earring",
	})
	sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
	})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		head="Nyame Helm",
		ear1="Ishvara Earring",
		body="Bihu Jstcorps. +3",
		hands="Nyame Gauntlets",
		ring2="Metamor. Ring +1",
		waist="Sailfi Belt +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
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
	-- Haste 30%
	-- DT 49%
	-- PDT 5% PDT
	-- MDT 19%
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		-- 6% Haste 5 MDB 7% DT
		head="Nyame Helm",
		-- 6% DT
		neck="Loricate Torque +1",
		-- 3% MDT
		ear1="Etiolation Earring",
		-- 2% MDT
		ear2="Odnowa Earring +1",
		-- 3% Haste 8 MDB 9% DT
		body="Nyame Mail",
		-- 4% Haste 5 MDB 4% MDT
		hands="Inyan. Dastanas +2",
		-- 5% PDT, 5% MDT
		ring1="Dark Ring",
		-- 10% DT
		ring2="Defending Ring",
		-- 5% DT
		back="Moonbeam Cape",
		-- 5% Haste
		waist="Goading Belt",
		-- 9% Haste MDB 5 9% DT
		legs="Aya. Cosciales +2",
		-- 3% Haste 5 MDB 3% DT
		feet="Aya. Gambieras +2",
	})
	
	sets.midcast.MACC = {
		main=gear.MaccStaff,
		sub="Enki Strap",
		--main="Daybreak",
		--sub="Ammurapi Shield",
		head="Bihu Roundlet +3",
		--neck="Incanter's Torque",
		neck="Moonbow Whistle +1",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		--body="Chironic Doublet",
		body="Brioso Justau. +3",
		--hands="Inyan. Dastanas +2",
		hands="Brioso Cuffs +3",
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
		back=gear.IntarabusMACC,
		waist="Luminary Sash",
		--legs="Chironic Hose",
		legs="Bihu Cannions +3",
		--feet="Inyan. Crackows +2"
		feet="Brioso Slippers +3"
	}
	
	sets.midcast.MAB = {
		--main=gear.MainStaff,
		--sub="Enki Strap",
		main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Ombre Tathlum +1",
		--head="Chironic Hat",
		head="Nyame Helm",
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
		main="Carnwenhan",
		range="Gjallarhorn",
		head="Fili Calot +1",
		ear2="Darkside Earring",
		--neck="Aoidos' Matinee",
		neck="Moonbow Whistle +1",
		body="Fili Hongreline +1",
		hands="Fili Manchettes +1",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3"
	})
	
	sets.midcast.ExtraSong = {
		main="Bunzi's Rod",
		sub="Genmei Shield",
		range=gear.ExtraSongInstrument,
		-- 12%
		head="Fili Calot +1",
		neck="Voltsurge Torque",
		ear1="Loquac. Earring",
		ear2="Malignance Earring",
		-- 15%
		body="Brioso Justau. +3",
		hands="Gendewitha Gages",
		back="Fi Follet Cape +1",
		waist="Embla Sash",
		-- 6%
		legs="Doyen Pants",
		feet="Bihu Slippers +3"
	}

	sets.midcast.DaurdablaDummy = set_combine(sets.midcast.ExtraSong,{})

	sets.midcast['Herb Pastoral'] = set_combine(sets.midcast.ExtraSong,{})
	sets.midcast['Goblin Gavotte'] = set_combine(sets.midcast.ExtraSong,{})
	
	-- Song-specific recast reduction
	sets.midcast.SongRecast = set_combine(sets.midcast.FastRecast,{
		legs="Fili Rhingrave +1"
	})

	-- For song debuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = set_combine(sets.midcast.MACC,{
		main="Carnwenhan",
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Bihu Roundlet +3",
		--neck="Aoidos' Matinee",
		neck="Moonbow Whistle +1",
		body="Fili Hongreline +1",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3"
	})

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.ResistantSongDebuff = set_combine(sets.midcast.MACC,{
		main=gear.MaccStaff,
		sub="Enki Strap",
		range="Gjallarhorn",
		head="Bihu Roundlet +3",
		--neck="Incanter's Torque",
		neck="Moonbow Whistle +1",
		ear1="Regal Earring",
		body="Brioso Justau. +3",
		hands="Brioso Cuffs +3",
		legs="Inyanga Shalwar +2",
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
		legs="Mou. Seraweels +1",
	})
	sets.midcast.Carol = set_combine(sets.midcast.SongEffect,{
		range=gear.Carol,
		head="Fili Calot +1",
		body="Fili Hongreline +1",
		--hands="Fili Manchettes +1",
		hands="Mousai Gages +1",
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
		hands="Brioso Cuffs +3"
	}
	sets.midcast['Foe Lullaby*'] = {
		range=gear.FoeLullaby,
	}
	sets.midcast['Magic Finale'] = {
		range=gear.Finale,
	}
	sets.midcast.Etude = {
		range=gear.Etude,
		head="Mousai Turban +1",
	}
	sets.midcast.Threnody = {
		range=gear.Threnody,
		head="Mou. Manteel +1",
	}

	-- Other general spells and classes.
	sets.midcast['Healing Magic'] = {
		head="Hyksos Khat",
		neck="Incanter's Torque",
		body=gear.Vanya_body_B,
		hands="Inyan. Dastanas +2",
		ring1="Menelaus's Ring",
		ring2="Sirona's Ring",
		back="Altruistic Cape",
		waist="Luminary Sash",
		feet=gear.Vanya_feet_B
	}	
	
	-- 55% Total
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'],{
		-- 30%
		main="Daybreak",
		sub="Ammurapi Shield",
		head="Hyksos Khat",
		neck="Incanter's Torque",
		ear1="Regal Earring",
		ear2="Malignance Earring",
		-- 13%
		body="Vrikodara Jupon",
		hands="Inyan. Dastanas +2",
		-- 5%
		ring1="Menelaus's Ring",
		waist="Luminary Sash",
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
		ring1="Menelaus's Ring",
		ring2="Haoma's Ring",
		feet="Gende. Galosh. +1"
	})
	sets.midcast.CursnaSelf = set_combine(sets.midcast.Cursna,{
		waist="Gishdubar Sash",
	})
	
	-- 139 WHM sub
	-- 16 merits
	-- 62 gear
	-- 217 WHM sub
	-- 47% DUR
	sets.midcast['Enhancing Magic'] = {
		--main="Serenity",
		-- 10% DUR
		sub="Ammurapi Shield",
		-- 13
		head="Umuthi Hat",
		-- 10
		neck="Incanter's Torque",
		ear1="Regal Earring",
		-- 5
		ear2="Andoaa Earring",
		-- 12 10% DUR
		body=gear.Telchine_body_pet,
		-- 20
		--hands="Inyan. Dastanas +2",
		-- 9% DUR
		hands=gear.Telchine_hands_pet,
		-- 5
		ring1="Stikini Ring",
		-- 8
		ring2="Stikini Ring +1",
		-- 9
		back="Fi Follet Cape +1",
		-- 10% DUR
		waist="Embla Sash",
		-- 8% DUR
		legs=gear.Telchine_legs_pet,
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
		--neck="Incanter's Torque",
		neck="Moonbow Whistle +1",
		hands="Inyan. Dastanas +2",
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		ring2="Kishar Ring",
		--ring2="Stikini Ring +1",
		--waist="Rumination Sash",
		legs="Chironic Hose",
		feet="Skaoi Boots",
	})

	sets.midcast['Dispelga'] =  set_combine(sets.midcast.MACC,{
		main="Daybreak",
	})
	
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast.MAB,{
	})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAB,{
		--body="Vanya Robe",
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
		--main="Sangoma",
		main="Daybreak",
		sub="Genmei Shield",
		--range=gear.AllSongs,
		range="Marsyas",
		head="Nyame Helm",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
		body="Nyame Mail",
		--hands="Inyan. Dastanas +2",
		hands="Nyame Gauntlets",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Lengo Pants",
		feet="Fili Cothurnes +1"
	}
	
	sets.noprotect = {ring1="Sheltered Ring"}

	-- DT: 45% DT
	-- PDT: 9%
	-- MDT: 19%
	-- MDB: 33
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.idle.DT = set_combine(sets.idle,{		
		-- 20% PDT
		--main=gear.Staff.PDT,
		-- 8 MDB 5% MDT
		head="Inyanga Tiara +2",
		-- 6% DT
		neck="Loricate Torque +1",
		-- 3% MDT
		ear1="Etiolation Earring",
		-- 2% MDT
		ear2="Odnowa Earring +1",
		-- 11 MDB 7% MDT
		--body="Inyanga Jubbah +2",
		-- 8 MDB 9% DT
		body="Nyame Mail",
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
		--legs="Inyanga Shalwar +2",
		-- MDB 5 9% DT
		--legs="Aya. Cosciales +2",
		-- MDB 7 8% DT
		legs="Nyame Flanchard",
		-- 8 MDB 3% MDT
		--feet="Inyan. Crackows +2",
		-- 5 MDB 3% DT
		--feet="Aya. Gambieras +2",
		-- 5 MDB 7% DT
		feet="Nyame Sollerets",
	})

	sets.idle.PDT = set_combine(sets.idle.DT,{
	})
	sets.idle.MDT = set_combine(sets.idle.DT,{
	})
	
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
		main="Carnwenhan",
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
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		ring1="Ilabrat Ring",
		ring2="Petrov Ring",
		back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2",
	}

	-- Sets with weapons defined.
	sets.engaged.Dagger = set_combine(sets.engaged,{
	})

	-- Set if dual-wielding
	sets.engaged.DualWield = set_combine(sets.engaged,{
		ear1="Brutal Earring",
		ear2="Suppanomimi",
		waist="Reiki Yotai",
	})

	sets.engaged.Acc = set_combine(sets.engaged,{
		body="Bihu Jstcorps. +3",
		ear2="Crep. Earring",
		ring2="Cacoethic Ring +1",
		back="Aurist's Cape +1",
		legs="Bihu Cannions +3",
	})

	sets.engaged.Dagger.Acc = set_combine(sets.engaged.Acc,{
	})

	sets.engaged.DualWield.Acc = set_combine(sets.engaged.Acc,{
		ear1="Crep. Earring",
		ear2="Suppanomimi",
		waist="Reiki Yotai",
	})

	sets.engaged.DT = {
		-- DT 7%
		head="Nyame Helm",
		-- DT 9%
		body="Nyame Mail",
		-- DT 7%
		hands="Nyame Gauntlets",
		-- DT 8%
		legs="Nyame Flanchard",
		-- DT 7%
		feet="Nyame Sollerets",
	}
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
	if spell.type == 'BardSong' then
		-- Auto-Pianissimo
		if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
			not state.Buff['Pianissimo'] then

			local spell_recasts = windower.ffxi.get_spell_recasts()
			if spell_recasts[spell.recast_id] < 2 then
				send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
				eventArgs.cancel = true
				return
			end
		end
	end

	if spell.type == 'WeaponSkill' then
		if (spell.target.model_size + spell.range * 1.642276421172564) < spell.target.distance then	
			add_to_chat(7,"--- Target "..spell.target.type.." ["..player.target.name.."] out of range of ["..spell.name.."] [ Distance: "..spell.target.distance.."] ---")
			cancel_spell()
		end
	end
end

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
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(stateField, newValue, oldValue)
	if state.Weapon.value == 'Main + Sub' then
		disable('main','sub')
	elseif state.Weapon.value == 'Range + Ammo' then
		disable('range','ammo')
	elseif state.Weapon.value == 'Full' then
		disable('main','sub','range','ammo')
	else
		enable('main','sub','range','ammo')
	end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if state.Buff[buff] ~= nil then
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end

	-- Haste mode is only relevant for Dual Wield subjobs
	if S{'NIN','DNC'}:contains(player.sub_job) then
		-- This should only apply if we are truly Dual Wielding
		if not S{'grip','strap','shield'}:contains(player.equipment.sub:lower()) then
			-- If we gain or lose any haste buffs, adjust which gear set we target.
			if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
				determine_haste_group()
				if not midaction() then
					handle_equipping_gear(player.status)
				end
			end
		end
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
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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
	if S{'NIN','DNC'}:contains(player.sub_job) then
		-- This should only apply if we are truly Dual Wielding
		if not S{'grip','strap','shield'}:contains(player.equipment.sub:lower()) then
			determine_haste_group()
		end
	end

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

	if state.Weapon.value == 'Main + Sub' then
		disable('main','sub')
	elseif state.Weapon.value == 'Range + Ammo' then
		disable('range','ammo')
	elseif state.Weapon.value == 'Full' then
		disable('main','sub','range','ammo')
	else
		enable('main','sub','range','ammo')
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
		meleeSet = set_combine(meleeSet, sets.sharedTH)
	end

	return meleeSet
end