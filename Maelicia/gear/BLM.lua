-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('None', 'Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant', 'Proc', 'Naked')
	state.IdleMode:options('CP', 'Normal', 'MP', 'Encumbered', 'PDT', 'MDT', 'CPPDT', 'CPMDT')
	
	state.MagicBurst = M(false, 'Magic Burst')
	
	LowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
		'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
		'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
		'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
		'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}
		
	ancientMagic = S{'Flare II', 'Freeze II', 'Tornado II', 'Quake II', 'Burst II', 'Flood II', 
		'Flare', 'Freeze', 'Tornado', 'Quake', 'Burst', 'Flood'}	

	--gear.MainStaff = {name="Lathi"}
	gear.MainStaff = {name="Grioavolr"}
	gear.default.obi_waist = "Sacro Cord"
	gear.default.obi_back = "Taranus's Cape"
	
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
	send_command('bind @` gs c cycle MagicBurst')
	send_command('bind ^` input /ma Stun <stnpc>; input /echo ------ Stun <t> -----')
	
	select_default_macro_book()

	global_aliases()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind @`')
	send_command('unbind ^`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Mana Wall'] = {feet="Wicce Sabots +1"}
	
	sets.precast.JA.Manafont = {body="Arch. Coat +3"}
	
	-- equip to maximize HP (for Tarus) and minimize MP loss before using convert
	sets.precast.JA.Convert = {}
	
	-- Fast cast sets for spells
	
	-- Fast cast sets for spells
	-- 67%/33% + 1%~3% Total (80/40 cap) + 15% (if RDM sub)
	sets.precast.FC = {
		--ammo="Impatiens",
		-- 10%
		head="Nahtirah Hat",
		-- 4%
		neck="Voltsurge Torque",
		-- 4%
		ear1="Malignance Earring",
		-- 2%
		ear2="Loquacious Earring",
		-- 14%
		body="Zendik Robe",
		-- 3%
		hands="Otomi Gloves",
		-- 4%
		ring1="Kishar Ring",
		-- 2%
		ring2="Prolix Ring",
		-- 8%
		back="Fi Follet Cape +1",
		-- 3%
		--waist="Witful Belt",
		-- 5%
		waist="Embla Sash",
		-- 7%
		legs="Psycloth Lappas",
		-- 4% + 1%~3%
		feet="Regal Pumps +1"
	}
	
	-- Cannot exceed 80/40 FC cap in combination with FC
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {
		-- 5%
		ear2="Mendi. Earring",
		-- 7%
		hands=gear.Vanya_hands_B,
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
	
	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
		head="Wicce Petasos +1",
		--ear1="Barkaro. Earring",
		ear1="Malignance Earring",
	})
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {
		head=empty,
		body="Twilight Cloak"
	})

	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak"})
	
	sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.precast.MP = {
		-- 30 MP
		ammo="Ombre Tathlum +1",
		-- 120 MP
		head="Pixie Hairpin +1",
		-- 35 MP
		neck="Sanctity Necklace",
		-- 50 MP
		ear1="Etiolation Earring",
		-- 30 MP
		ear2="Loquac. Earring",
		-- 133 MP
		body="Amalric Doublet",
		-- 44 MP
		hands="Telchine Gloves",
		-- 110 MP
		ring1="Mephitas's Ring +1",
		-- 80 MP
		ring2="Persis Ring",
		-- 90 MP
		back="Bane Cape",
		-- 30 MP
		waist="Fucho-no-obi",
		-- 109 MP
		legs="Psycloth Lappas",
		-- 67 MP
		feet="Skaoi Boots",
	}

	sets.precast.Death = set_combine(sets.precast.MP, {
	})
	
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Nyame Helm",
		neck="Fotia Gorget",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Vrikodara Jupon",
		hands="Jhakri Cuffs +2",
		ring1="Rajas Ring",
		ring2="Petrov Ring",
		back="Aurist's Cape +1",
		waist="Fotia Belt",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}
	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		head="Nyame Helm",
		--neck="Sanctity Necklace",
		--ear1="Barkaro. Earring",
		ear1="Malignance Earring",
		ear2="Regal Earring",
		body="Amalric Doublet",
		--hands="Amalric Gages",
		hands="Jhakri Cuffs +2",
		ring1="Freke Ring",
		ring2="Strendu Ring",
		back="Taranus's Cape",
		--waist="Yamabuki-no-Obi",
		--legs=gear.Merlinic_legs_nuke,
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})  
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	sets.precast.WS['Retribution'] = set_combine(sets.precast.WS,{
	})
	sets.precast.WS['Shattersoul'] = set_combine(sets.precast.WS,{
	})
	
	-- Magical WS
	
	sets.precast.WS['Rock Crusher'] = set_combine(sets.precast.WS.MAB,{
	})
	sets.precast.WS['Earth Crusher'] = set_combine(sets.precast.WS.MAB,{
	})
	sets.precast.WS['Starburst'] = set_combine(sets.precast.WS.MAB,{
	})
	sets.precast.WS['Sunburst'] = set_combine(sets.precast.WS.MAB,{
	})
	sets.precast.WS['Cataclysm'] = set_combine(sets.precast.WS.MAB,{
		head="Pixie Hairpin +1",
	})
	-- 80% INT
	sets.precast.WS['Vidohunir'] = set_combine(sets.precast.WS.MAB,{
	})
	
	-- Max MP
	sets.precast.WS['Myrkr'] = set_combine(sets.precast.MP,{
		ear2="Moonshade Earring",
	})
	
	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
	-- 25% Haste
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		ammo="Staunch Tathlum +1",
		-- 6% Haste
		head="Nyame Helm",
		ear2="Genmei Earring",
		neck="Loricate Torque +1",
		-- 3% Haste
		body="Nyame Mail",
		-- 3% Haste 3% FC
		hands="Otomi Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		-- 5% Haste
		waist="Goading Belt",
		-- 5% Haste
		legs="Gyve Trousers",
		-- 3% Haste
		feet=gear.Vanya_feet_B
	})
	
	sets.midcast.MACC = {
		--sub="Khonsu",
		head=gear.Merlinic_head_nuke,
		neck="Incanter's Torque",
		--ear1="Barkaro. Earring",
		ear1="Malignance Earring",
		ear2="Regal Earring", -- use with use of any AF1+2
		body="Spaekona's Coat +3",
		hands="Spae. Gloves +3",
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
		back="Aurist's Cape +1",
		waist="Eschan Stone",
		legs="Merlinic Shalwar",
		feet="Arch. Sabots +3",
	}
	
	sets.midcast.MAB = {
		ammo="Pemphredo Tathlum",
		head=gear.Merlinic_head_nuke,
		neck="Sanctity Necklace",
		--ear1="Barkaro. Earring",
		ear1="Malignance Earring",
		ear2="Regal Earring",
		body="Ea Houppelande",
		--hands="Arch. Gloves +3",
		hands=gear.Amalric_hands_hq_D,
		ring1="Freke Ring",
		ring2="Strendu Ring",
		back=gear.ElementalCape,
		waist=gear.ElementalObi,
		--legs="Merlinic Shalwar",
		legs="Arch. Tonban +3",
		--feet="Arch. Sabots +3",
		feet=gear.Amalric_feet_hq_D,
	}
	
	sets.midcast.ConserveMP = set_combine(sets.midcast.FastRecast,{
		-- 3
		head=gear.Merlinic_head_nuke,
		-- 5
		--neck="Reti Pendant",
		-- 3
		ear1="Gifted Earring",
		-- 6
		body=gear.Amalric_body_A,
		-- 5
		back="Fi Follet Cape +1",
		-- 8
		waist="Austerity Belt",
		-- 5
		legs="Lengo Pants",
		-- 7
		feet=gear.Amalric_feet_hq_D,
	})

	-- === Healing Magic =========================================
	
	sets.midcast['Healing Magic'] = {
		ammo="Staunch Tathlum +1",
		head="Hyksos Khat",
		neck="Incanter's Torque",
		body=gear.Vanya_body_B,
		hands=gear.Vanya_hands_B,
		ring1="Menelaus's Ring",
		ring2="Sirona's Ring",
		back="Altruistic Cape",
		feet=gear.Vanya_feet_B
	}
	
	-- 53% Total
	sets.midcast.Cure = set_combine(sets.midcast['Healing Magic'],{
		head="Befouled Crown",
		neck="Incanter's Torque",
		-- 5%
		ear1="Roundel Earring",
		-- 5%
		ear2="Mendi. Earring",
		-- 13%
		body="Vrikodara Jupon",
		-- 10%
		hands="Telchine Gloves",
		-- 5%
		ring1="Menelaus's Ring",
		back="Aurist's Cape +1",
		waist=gear.ElementalObi,
		-- 10%
		legs="Gyve Trousers",
		-- 5%
		feet=gear.Vanya_feet_B
	});
			
	sets.midcast.Curaga = set_combine(sets.midcast.Cure,{
		body="Vrikodara Jupon"
	})
	sets.midcast.CureSelf = set_combine(sets.midcast.Cure,{
		waist="Gishdubar Sash",
	})
	sets.midcast.Cursna = set_combine(sets.midcast['Healing Magic'],{
		neck="Malison Medallion",
		ring1="Menelaus's Ring",
		ring2="Haoma's Ring",
		feet=gear.Vanya_feet_B
	})
	sets.midcast.CursnaSelf = set_combine(sets.midcast.Cursna,{
		waist="Gishdubar Sash",
	})

	-- === Enhancing Magic =========================================
	
	-- 300 Base
	-- 16 merits
	-- 76 gear
	-- 392 Total
	-- 37% DUR
	sets.midcast['Enhancing Magic'] = {
		-- 16
		head="Befouled Crown",
		-- 10
		neck="Incanter's Torque",
		-- 5
		ear1="Andoaa Earring",
		ear2="Regal Earring",
		-- 12 10% DUR
		body=gear.Telchine_body_pet,
		-- 10
		-- hands="Ayao's Gages",
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
		-- 11
		feet="Regal Pumps +1"		
	}
	
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'],{
		neck="Nodens Gorget",
		ear1="Earthcry Earring",
		waist="Siegel Sash",
		legs="Haven Hose"
	})
	
	sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'],{
		body=Telchine_body_pet
	})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'],{
		head="Amalric Coif",
		hands="Regal Cuffs",
	})

	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'],{
		head="Amalric Coif",
	})
	sets.midcast.RefreshSelf = set_combine(sets.midcast.Refresh,{
		waist="Gishdubar Sash",
		feet="Inspirited Boots"
	})
	
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'],{
		ring1="Sheltered Ring"
	})
	
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'],{
		ring1="Sheltered Ring"
	})
	
	-- === Enfeebling Magic =========================================
	
	-- 378 Base
	-- 16 merits
	-- 394 Initial
	-- 90 gear
	-- 484 total
	sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast.MACC,{
		-- 16
		head="Befouled Crown",
		-- 10
		neck="Incanter's Torque",
		-- 21
		body="Spaekona's Coat",
		-- Duration +20%
		hands="Regal Cuffs",
		-- 5
		--ring1="Stikini Ring",
		-- Duration +10%
		ring1="Kishar Ring",
		-- 8
		ring2="Stikini Ring +1",
		-- 7
		--waist="Rumination Sash",
		-- 18
		legs="Psycloth Lappas",
		-- 17
		feet="Skaoi Boots",
	})

	-- For enfeebs with no known skill caps
	-- 394 Initial
	-- 95 gear
	-- 489 total
	sets.midcast.enfeebFullSkill = set_combine(sets.midcast['Enfeebling Magic'], {
		-- 5
		ring1="Stikini Ring",
	})

	-- For MND potency based enfeebs
	sets.midcast.enfeebMND = set_combine(sets.midcast['Enfeebling Magic'], {
		--neck="Imbodla Necklace",
		--ring1="Stikini Ring",
		ring2="Metamor. Ring +1",
	})

	-- For INT potency based enfeebs
	sets.midcast.enfeebINT = set_combine(sets.midcast['Enfeebling Magic'], {
		head="Ea Hat",
		--neck="Imbodla Necklace",
		back="Taranus's Cape",
		legs=gear.Merlinic_legs_nuke,
		feet="Jhakri Pigaches +2",
	})

	-- For enfeebs with static values (use MACC and duration+ gear)
	sets.midcast.enfeebStatic = set_combine(sets.midcast.MACC, {
		neck="Erra Pendant",
		-- Duration +10%
		ring1="Kishar Ring",
	})

	-- For enfeebs with 500 skill caps
	-- 394 Initial
	-- 95 gear
	-- 489 total
	sets.midcast.enfeebSkillCap = set_combine(sets.midcast['Enfeebling Magic'], {
		-- 5
		ring1="Stikini Ring",
	})

	-- Static value (use duration+ gear)
	sets.midcast['Dia'] = set_combine(sets.midcast.enfeebStatic, {
	})
	-- Static value (use duration+ gear)
	sets.midcast['Dia II'] = set_combine(sets.midcast.enfeebStatic, {
	})

	-- MND potency mod
	-- Lowest value at -75 MND compared to enemy: About 7.3%
	-- Highest value at +75 MND compared to enemy: About 29.2%
	sets.midcast['Slow'] = set_combine(sets.midcast.enfeebMND, {
	})

	-- MND potency mod
	-- Lowest value at -40 MND compared to enemy: 5%
	-- Highest value at +40 MND compared to enemy: 25%
	sets.midcast['Paralyze'] = set_combine(sets.midcast.enfeebMND, {
	})

	-- INT potency mod
	-- Lowest value at -80 player INT compared to enemy INT: 5
	-- Highest value at +120 player INT compared to enemy INT: 50
	sets.midcast['Blind'] = set_combine(sets.midcast.enfeebINT, {
	})

	-- Skill mod
	-- 500 skill cap
	sets.midcast['Poison'] = set_combine(sets.midcast.enfeebSkillCap, {
	})

	-- Skill mod
	-- No known cap
	sets.midcast['Poison II'] = set_combine(sets.midcast.enfeebFullSkill, {
	})

	-- Skill mod
	-- Max 3 damage/tick
	sets.midcast['Poisonga'] = set_combine(sets.midcast.enfeebSkillCap, {
	})
	
	-- MND and Skill mod

	-- Distract I (caps 125 skill for -25 eva, -35 eva cap with MND)
	-- Already skill-capped without gear, use MACC to make sure it lands
	sets.midcast['Distract'] = set_combine(sets.midcast.MACC, {
	})

	-- Frazzle I (caps 135 skill for -25 meva, -35 meva cap with MND)
	-- Already skill-capped without gear, use MACC to make sure it lands
	sets.midcast['Frazzle'] = set_combine(sets.midcast.MACC, {
	})

	sets.midcast['Dispelga'] =  set_combine(sets.midcast.MACC,{
		main="Daybreak",
	})

	-- === Dark Magic =========================================
	
	sets.midcast['Dark Magic'] = set_combine(sets.midcast.MACC,{
		neck="Erra Pendant",
		hands="Arch. Gloves +3",
		ring1="Evanescence Ring",
		--ring2="Stikini Ring",
		ring2="Metamor. Ring +1",
		legs="Psycloth Lappas",
		feet="Wicce Sabots +1"
	})
	
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
	})
	
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
		head="Striga Crown",
		neck="Erra Pendant",
		ring1="Evanescence Ring",
		waist="Fucho-no-Obi",
		feet=gear.Merlinic_feet_absorb,
	})
	
	sets.midcast.Aspir = sets.midcast.Drain
	
	-- === Elemental Magic =========================================
	
	sets.midcast['Elemental Magic'] = set_combine(sets.midcast.MAB,{
	})
	
	sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'],{
		head="Arch. Petasos +3",
		body="Arch. Coat +3",
		hands="Arch. Gloves +3",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
		legs="Arch. Tonban +3",
		feet="Arch. Sabots +3",
	})
	
	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {
		body="Spaekona's Coat +3",
	})
	sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {
	})

	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})
	
	sets.midcast.Death = {
		ammo="Ombre Tathlum +1",
		head="Pixie Hairpin +1",
		--head=gear.Merlinic_head_burst,
		--head="Ea Hat",
		-- 10%
		neck="Mizu. Kubikazari",
		--neck="Sanctity Necklace",
		--ear1="Etiolation Earring",
		--ear1="Barkaro. Earring",
		ear1="Malignance Earring",
		ear2="Regal Earring",
		--ear2="Loquac. Earring",
		--body="Amalric Doublet",
		-- 8% II 8%
		body="Ea Houppelande",
		-- 6% II
		--hands=gear.Amalric_hands_hq_D,
		hands="Arch. Gloves +3",
		ring1="Mephitas's Ring +1",
		-- 5% II
		ring2="Mujin Band",
		back="Bane Cape",
		waist=gear.ElementalObi,
		legs=gear.Amalric_legs_D,
		feet="Arch. Sabots +3",
	}
	
	sets.midcast.Comet = set_combine(sets.midcast.MAB,{
		head="Pixie Hairpin +1"
	})

	sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Elemental Magic'],{
		ammo="Ombre Tathlum +1",
		--neck="Imbodla Necklace",
		--ear1="Barkaro. Earring",
		ear1="Malignance Earring",
		ear2="Regal Earring",
		body="Spaekona's Coat +3",
		hands="Spae. Gloves +3",
		--ring1="Stikini Ring",
		ring1="Metamor. Ring +1",
		ring2="Stikini Ring +1",
		back="Taranus's Cape",
		legs="Arch. Tonban +3",
		feet="Arch. Sabots +3",
	})

	-- For 5k+ non-killing MB
	sets.midcast['Elemental Magic'].Proc = {
		ammo="Ombre Tathlum +1",
		head=empty,
		neck=empty,
		ear1="Etiolation Earring",
		ear2="Loquac. Earring",
		body=empty,
		hands=gear.Amalric_hands_hq_D,
		ring1="Persis Ring",
		ring2="Stikini Ring +1",
		back="Moonbeam Cape",
		waist="Luminary Sash",
		legs=empty,
		feet=empty
	}

	-- For low damage procs Omen sub-objectives
	sets.midcast['Elemental Magic'].Naked = {
		ammo=empty,
		head=empty,
		neck=empty,
		ear1=empty,
		ear2=empty,
		body=empty,
		hands=empty,
		ring1=empty,
		ring2=empty,
		back=empty,
		waist=empty,
		legs=empty,
		feet=empty
	}

	-- === Divine Magic =========================================
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.MAB,{
	})
	
	sets.midcast.Repose = set_combine(sets.midcast.FastRecast,{
	})

	-- === Misc. =========================================

	sets.midcast.BardSong = set_combine(sets.midcast.MACC,{
	})
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
	
	-- Resting sets
	set_combine(sets.sharedResting,{
	})
	
	-- Idle sets
	sets.idle = {
		main=gear.MainStaff,
		sub="Khonsu",
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		neck="Loricate Torque +1",
		ear1="Etiolation Earring",
		ear2="Odnowa Earring +1",
		body="Jhakri Robe +2",
		hands="Nyame Gauntlets",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Fucho-no-Obi",
		legs="Lengo Pants",
		feet="Herald's Gaiters"
	}
	
	sets.noprotect = {ring1="Sheltered Ring"}
	
	sets.idle.MP = {
		-- 30 MP
		ammo="Ombre Tathlum +1",
		-- 120 MP
		head="Pixie Hairpin +1",
		-- 35 MP
		neck="Sanctity Necklace",
		-- 50 MP
		ear1="Etiolation Earring",
		-- 30 MP
		ear2="Loquac. Earring",
		-- 133 MP
		body="Amalric Doublet",
		-- 44 MP
		hands="Telchine Gloves",
		-- 110 MP
		ring1="Mephitas's Ring +1",
		-- 80 MP
		ring2="Persis Ring",
		-- 90 MP
		-- back="Bane Cape",
		back="Tantalic Cape",
		-- 30 MP
		waist="Fucho-no-obi",
		-- 160 MP
		legs=gear.Amalric_legs_D,
		-- 67 MP
		feet="Skaoi Boots",
	}

	sets.idle.Encumbered = set_combine(sets.midcast.MAB,{
	})
	
	-- DT: 53% DT
	-- PDT: 7%
	-- MDT: 8%
	-- MDB: 30
	-- Meva: 674
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.idle.DT = set_combine(sets.idle,{
		-- 20% DT
		--main=gear.Staff.DT,
		-- 6% DT
		--sub="Khonsu",
		-- 2% DT
		ammo="Staunch Tathlum +1",
		-- 7% DT 5 MDB 123 Meva
		head="Nyame Helm",
		-- 6% DT
		neck="Loricate Torque +1",
		-- 3% MDT
		ear1="Etiolation Earring",
		-- 2% PDT
		ear2="Genmei Earring",
		-- 9% DT 8 MDB 139 Meva
		body="Nyame Mail",
		-- 7% DT 4 MDB 112 Meva
		hands="Nyame Gauntlets",
		-- 5% PDT 5% MDT
		ring1="Dark Ring",
		-- 10% DT
		ring2="Defending Ring",
		-- 5% DT
		back="Moonbeam Cape",
		--back="Mecisto. Mantle",
		-- 8% DT 7 MDB 150 Meva
		legs="Nyame Flanchard",
		-- 7% DT 5 MDB 150 Meva
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
		body="Councilor's Garb",
		hands="Regal Cuffs",
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
	
	sets.Kiting = {feet="Herald's Gaiters"}
	
	sets.latent_refresh = {waist="Fucho-no-obi"}
	
	-- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	
	sets.buff['Mana Wall'] = {
		back="Taranus's Cape",
		feet="Wicce Sabots +1"
	}
	
	-- Magic Burst Damage: 43% (40 cap) + 16% II
	-- INT: 252
	-- MACC: 249
	-- MAB: 301
	-- MDmg: 20
	-- Elem: 61
	sets.magic_burst = set_combine(sets.midcast.MAB, {
		-- INT 4
		-- MACC 8
		-- MAB 4
		ammo="Pemphredo Tathlum",
		-- MB 10%
		-- INT 29
		-- MACC 22
		-- MAB 40
		--head=gear.Merlinic_head_burst,
		-- MB 6% II
		-- MB 6%
		-- INT 38
		-- MACC 40
		-- MAB 33
		--head="Ea Hat",
		-- INT 29
		-- MACC 53
		-- MAB 47
		--head=gear.Merlinic_head_nuke,
		-- INT 34
		-- MACC 43
		-- MAB 55
		-- Elem 21
		-- AncientMagic Bonus
		head="Arch. Petasos +3",
		-- MB 10%
		-- INT 4
		-- MAB 8
		neck="Mizu. Kubikazari",
		-- MACC 10
		-- MAB 10 
		--neck="Sanctity Necklace",
		-- INT 3
		-- MACC 8
		-- MAB 8
		--ear1="Barkaro. Earring",
		-- INT 8
		-- MACC 10
		-- MAB 8
		ear1="Malignance Earring",
		-- INT 10
		-- MAB 7
		ear2="Regal Earring",
		-- INT 38
		-- MACC 38
		-- MAB 38
		-- Mcrit 8%
		--body="Amalric Doublet",
		-- MB 7%
		-- INT 40
		-- MACC 17
		-- MAB 13
		--body=gear.Merlinic_body_burst,
		-- MB 8% II
		-- MB 8%
		-- INT 43
		-- MACC 42
		-- MAB 39
		body="Ea Houppelande",
		-- MB 6% II
		-- INT 36
		-- MACC 20
		-- MAB 53
		-- Elem 14
		--hands=gear.Amalric_hands_hq_D,
		-- MB 5% II
		-- MB 5%
		-- INT 35
		-- MACC 39
		-- MAB 30
		--hands="Ea Cuffs",
		-- MB 20%
		-- INT 36
		-- MACC 38
		-- MAB 50
		-- Elem 23
		hands="Arch. Gloves +3",
		-- INT 10
		-- MAB 8
		ring1="Freke Ring",
		-- MB 5% II
		ring2="Mujin Band",
		-- MB 2%
		-- MACC 6
		-- MAB 3
		--ring2="Jhakri Ring",
		-- MB 5%
		-- Mcrit 5%
		-- ring2="Locus Ring",
		-- MACC 2
		-- MAB 4
		--ring2="Strendu Ring",
		-- MB 5%
		-- INT 30
		-- MACC 20
		-- MAB 10
		-- MDmg 20
		back="Taranus's Cape",
		waist=gear.ElementalObi,
		-- INT 43
		-- MACC 49
		-- MAB 52
		-- MDmg 13
		--legs="Merlinic Shalwar",
		-- MB 3% II
		-- INT 50
		-- MACC 46
		-- MAB 58
		legs="Arch. Tonban +3",
		-- MB 6%
		-- INT 24
		-- MACC 33
		-- MAB 42
		--feet=gear.Merlinic_feet_burst,
		-- MB 7%
		-- INT 33
		-- MACC 42
		-- MAB 39
		--feet="Jhakri Pigaches +2",
		-- MB 4% II
		-- MB 4%
		-- MACC 38
		-- MAB 27
		--feet="Ea Pigaches",
		-- INT 30
		-- MACC 42
		-- MAB 54
		-- Elem 17
		feet="Arch. Sabots +3",
		-- INT 21
		-- MACC 20
		-- MAB 52
		--feet=gear.Amalric_feet_hq_D,
	})

	-- Magic Burst Damage: 36% (40 cap) + 30% II
	-- INT: 267
	-- MACC: 260 + 15 * 1 (AF bonus) = 275
	-- MAB: 214
	-- MDmg: 64
	-- Elem: 21
	sets.magic_burst.Resistant = set_combine(sets.magic_burst, {
		-- INT 4
		-- MACC 8
		-- MAB 4
		ammo="Pemphredo Tathlum",
		-- MB 6% II
		-- MB 6%
		-- INT 38
		-- MACC 40
		-- MAB 33
		head="Ea Hat",
		-- MB 10%
		-- INT 4
		-- MAB 8
		neck="Mizu. Kubikazari",
		-- INT 3
		-- MACC 8
		-- MAB 8
		--ear1="Barkaro. Earring",
		-- INT 8
		-- MACC 10
		-- MAB 8
		ear1="Malignance Earring",
		-- INT 10
		-- MAB 7
		ear2="Regal Earring",
		-- INT 39
		-- MACC 55
		-- MDmg 48
		--body="Spaekona's Coat +3",
		-- MB 8% II
		-- MB 8%
		-- INT 43
		-- MACC 42
		-- MAB 39
		body="Ea Houppelande",
		-- MB 8% II
		-- INT 37
		-- MACC 52
		-- MDmg 44
		-- Elem 21
		hands="Spae. Gloves +3",
		-- INT 40
		-- MACC 45
		-- MB Acc +30
		--hands="Regal Cuffs",
		-- MB 6% II
		-- INT 36
		-- MACC 20
		-- MAB 53
		-- Elem 14
		--hands=gear.Amalric_hands_hq_D,
		-- INT 10
		-- MAB 8
		ring1="Freke Ring",
		-- MB 5% II
		ring2="Mujin Band",
		-- MB 2%
		-- MACC 6
		-- MAB 3
		--ring2="Jhakri Ring",
		-- MB 5%
		-- Mcrit 5%
		-- ring2="Locus Ring",
		-- MACC 2
		-- MAB 4
		--ring2="Strendu Ring",
		-- MB 5%
		-- INT 30
		-- MACC 20
		-- MAB 10
		-- MDmg 20
		back="Taranus's Cape",
		waist=gear.ElementalObi,
		-- INT 43
		-- MACC 49
		-- MAB 52
		-- MDmg 13
		--legs="Merlinic Shalwar",
		-- MB 3% II
		-- INT 50
		-- MACC 46
		-- MAB 58
		legs="Arch. Tonban +3",
		-- MB 6%
		-- INT 24
		-- MACC 33
		-- MAB 42
		--feet=gear.Merlinic_feet_burst,
		-- MB 7%
		-- INT 33
		-- MACC 42
		-- MAB 39
		feet="Jhakri Pigaches +2",
		-- MB 4% II
		-- MB 4%
		-- MACC 38
		-- MAB 27
		--feet="Ea Pigaches",
		-- INT 30
		-- MACC 42
		-- MAB 54
		-- Elem 17
		--feet="Arch. Sabots +3",
		-- INT 21
		-- MACC 20
		-- MAB 52
		--feet=gear.Amalric_feet_hq_D,
	})

	sets.magic_burst.Death = set_combine(sets.midcast.Death, {
		--body="Amalric Doublet",
	})

	sets.magic_burst.Death.Resistant = set_combine(sets.magic_burst.Death, {
	})
	
	-- Engaged sets
	
	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	-- 27% Haste
	sets.engaged = {
		-- 8% Haste
		head="Blistering Sallet +1",
		neck="Asperity Necklace",
		ear1="Telos Earring",
		ear2="Brutal Earring",
		-- 3% Haste
		body="Nyame Mail",
		-- 3% Haste
		hands="Nyame Gauntlets",
		ring1="Rajas Ring",
		ring2="Petrov Ring",
		back="Aurist's Cape +1",
		-- 5% Haste
		waist="Goading Belt",
		-- 5% Haste
		legs="Arch. Tonban +3",
		-- 3% Haste
		feet="Nyame Sollerets",
	}
	
	-- 24% Haste
	sets.engaged.Acc = set_combine(sets.engaged, {
		neck="Subtlety Spec.",
		ear1="Telos Earring",
		ear2="Crep. Earring",
		ring1="Cacoethic Ring +1",
		ring2="Patricius Ring",
		back="Aurist's Cape +1",
		waist="Eschan Stone"
	})

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 3)
end

function job_aftercast(spell, action, spellMap, eventArgs)
	-- Lock feet after using Mana Wall.
	if not spell.interrupted then
		if spell.english == 'Mana Wall' then
			enable('feet')
			equip(sets.buff['Mana Wall'])
			disable('feet')
		end
	end
end

function job_precast(spell, action, spellMap, eventArgs)
	if spellMap == 'Cure' or spellMap == 'Curaga' then
		equip(sets.precast.FC.Cure)
		if (world.weather_element == 'Light' or world.day_element == 'Light') then
			equip({waist='Hachirin-no-Obi'})
		end
	elseif ancientMagic:contains(spell.english) then
		equip(sets.precast.FC.AncientMagic)
	elseif spell.skill == 'Elemental Magic' then
		equip(sets.precast.FC['Elemental Magic'])    
		if state.CastingMode.value == 'Proc' then
			classes.CustomClass = 'Proc'
		end
	end
end

function job_get_spell_map(spell, default_spell_map)
	if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
		if LowTierNukes:contains(spell.english) then
			return 'LowTierNuke'
		else
			return 'HighTierNuke'
		end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Enhancing Magic' then
		if spellMap == 'Refresh' and spell.target.type == 'SELF' then
			equip(sets.midcast.RefreshSelf)
		end
	elseif spellMap == 'Cursna' and spell.target.type == 'SELF' then
		equip(sets.midcast.CursnaSelf)
	elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
		equip(sets.midcast.CureSelf)
	elseif spell.skill == 'Elemental Magic' and state.MagicBurst.value then
		equip(sets.magic_burst)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if not buffactive['Protect'] then
		idleSet = set_combine(idleSet, sets.noprotect)
	elseif player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
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