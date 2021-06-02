-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.OffenseMode:options('Normal', 'Acc', 'Refresh', 'Learning')
	state.WeaponskillMode:options('Normal', 'Acc')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal', 'PDT', 'Learning')

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

	sets.buff['Burst Affinity'] = {feet="Mavi Basmak +2"}
	sets.buff['Chain Affinity'] = {head="Mavi Kavuk +2", feet="Assimilator's Charuqs"}
	sets.buff.Convergence = {head="Luhlaza Keffiyeh"}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs"}
	sets.buff.Enchainment = {body="Luhlaza Jubbah"}
	sets.buff.Efflux = {legs="Mavi Tayt +2"}

	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {hands="Mirage Bazubands +2"}


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
		-- 4% + 5%
		body="Taeon Tabard",
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
				
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Mavi Mintan +2"})

			 
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head=gear.Adhemar_head_hq_B,
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body=gear.Adhemar_body_B,
		hands=gear.Adhemar_hands_hq_B,
		ring1="Ilabrat Ring",
		ring2="Epona's Ring",
		back="Atheling Mantle",
		waist="Fotia Belt",
		legs="Samnuha Tights",
		feet=gear.Adhemar_feet_B
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		ear1="Telos Earring",
		ring1="Cacoethic Ring +1",
		waist="Eschan Stone"
	})

	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		ammo="Pemphredo Tathlum",
		--head="Jhakri Coronal +1",
		head="Amalric Coif",
		--neck="Sanctity Necklace",
		ear2="Friomisi Earring",
		ear2="Regal Earring",
		body="Amalric Doublet",
		--hands="Amalric Gages",
		hands="Jhakri Cuffs +2",
		ring1="Acumen Ring",
		ring2="Strendu Ring",
		back="Toro Cape",
		--waist="Yamabuki-no-Obi",
		legs=gear.Amalric_legs_D,
		feet=gear.Adhemar_feet_B
	})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS.MAB, {
	})

	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.MAB, {
	})
		
	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {
	})

	sets.midcast.MAB = {
		ammo="Pemphredo Tathlum",
		--head="Jhakri Coronal +1",
		head="Amalric Coif",
		neck="Sanctity Necklace",
		ear2="Friomisi Earring",
		ear2="Regal Earring",
		body="Amalric Doublet",
		--hands="Amalric Gages",
		hands="Jhakri Cuffs +2",
		ring1="Acumen Ring",
		ring2="Strendu Ring",
		back=gear.ElementalCape,
		waist=gear.ElementalObi,
		legs=gear.Amalric_legs_D,
		feet=gear.Adhemar_feet_B
	}
				
	sets.midcast['Blue Magic'] = {
		ammo="Mavi Tathlum",
		neck="Incanter's Torque",
		body="Assim. Jubbah +1",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back="Cornflower Cape",
		legs="Mavi Tayt +2",
	}
		
	-- Physical Spells --
	
	sets.midcast['Blue Magic'].Physical = set_combine(sets.midcast['Blue Magic'], {
	})

	sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {
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
	})
	
	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {
	})

	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {
	})

	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {
	})

	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {
	})

	sets.midcast['Blue Magic'].MagicAccuracy = set_combine(sets.midcast['Blue Magic'].Magical, {
		neck="Incanter's Torque",
		ear2="Regal Earring",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		waist="Eschan Stone",
	})

	-- Breath Spells --
	
	sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'], {
	})

	-- Other Types --
	
	sets.midcast['Blue Magic'].Stun = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
	})
			
	sets.midcast['Blue Magic']['White Wind'] = set_combine(sets.midcast['Blue Magic'], {
	})

	sets.midcast['Blue Magic'].Healing = set_combine(sets.midcast['Blue Magic'], {
	})

	sets.midcast['Blue Magic'].SkillBasedBuff = set_combine(sets.midcast['Blue Magic'], {
	})

	sets.midcast['Blue Magic'].Buff = set_combine(sets.midcast['Blue Magic'], {
	})

	-- Sets to return to when not performing an action.

	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = set_combine(sets.midcast['Blue Magic'], {
		ammo="Mavi Tathlum",
		neck="Incanter's Torque",
		hands="Assim. Bazu. +1",
		ring1="Stikini Ring",
		ring2="Stikini Ring",
		back="Cornflower Cape",
		legs="Mavi Tayt +2",
	})

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
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		--legs="Lengo Pants",
		legs="Carmine cuisses +1",
		feet="Malignance Boots",
	}

	-- DT: 52%
	--
	sets.idle.PDT = {
		-- DT 2%
		ammo="Staunch Tathlum +1",
		-- DT 6%
		head="Malignance Chapeau",
		-- DT 6%
		neck="Loricate Torque +1",
		-- MDT 2%
		ear1="Odnowa earring +1",
		ear2="Ethereal earring",
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
		-- DT 5%
		legs="Aya. Cosciales +2",
		-- DT 4%
		feet="Malignance Boots",
	}


	sets.idle.MDT = set_combine(sets.idle.PDT, {
	})

	sets.idle.Town = set_combine(sets.idle, {
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
		head=gear.Adhemar_head_hq_B,
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Suppanomimi",
		body=gear.Adhemar_body_B,
		hands=gear.Adhemar_hands_hq_B,
		ring1="Ilabrat Ring",
		ring2="Epona's Ring",
		back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet=gear.Adhemar_feet_B
	}

	sets.engaged.Acc = set_combine(sets.engaged, {
	})

	sets.engaged.Refresh = set_combine(sets.engaged, {
	})

	sets.engaged.DW = set_combine(sets.engaged, {
		ear1="Suppanomimi",
		ear2="Brutal Earring",
		ring2="Haverton Ring",
		legs=gear.Carmine_legs_hq_D,
	})

	sets.engaged.DW.Acc = set_combine(sets.engaged, {
		ear1="Brutal Earring",
		ear2="Suppanomimi",
		ring2="Haverton Ring",
		legs=gear.Carmine_legs_hq_D,
		feet=gear.Carmine_feet_hq_B,
	})

	sets.engaged.DW.Refresh = set_combine(sets.engaged, {
		ear1="Suppanomimi",
		ear2="Brutal Earring",
		ring2="Haverton Ring",
		legs=gear.Carmine_legs_hq_D,
	})

	sets.engaged.Learning = set_combine(sets.engaged, sets.Learning)
	sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.Learning)


	sets.self_healing = {}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(2, 19)
	else
		set_macro_page(1, 19)
	end
end


