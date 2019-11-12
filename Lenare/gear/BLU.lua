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
		hands="Umuthi Gloves",
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
	-- 54/27
	sets.precast.FC = {
		
		-- 4%
		neck="Baetyl Pendant",
		-- 1%
		ear1="Etiolation Earring",
		-- 2%
		ear2="Loquacious Earring",
		-- 5%
		body="Vanir Cotehardie",
		-- 5% + 1%
		hands="Leyline Gloves",
		-- 4%
		ring1="Kishar Ring",
		-- 5%
		ring2="Weather. Ring",
		-- 3%
		back="Swith Cape",
		-- 3%
		waist="Witful Belt",
		-- 7%
		legs="Psycloth Lappas",
		-- 4%
		feet="Chelona Boots",
	}
				
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Mavi Mintan +2"})

			 
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Jhakri Coronal +2",
		neck="Asperity Necklace",
		ear1="Brutal Earring",
		ear2="Moonshade Earring",
		body="Ayanmo Corazza +2",
		hands="Jhakri Cuffs +2",
		ring1="Rajas Ring",
		ring2="Apate Ring",
		back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		--legs="Samnuha Tights",
		legs=gear.Herculean_legs_WSD,
		feet="Jhakri Pigaches +2"
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
	})

	sets.precast.WS.MAB = set_combine(sets.precast.WS,{
		head="Jhakri Coronal +2",
		neck="Sanctity Necklace",
		ear2="Friomisi Earring",
		ear2="Crematio Earring",
		body="Jhakri Robe +2",
		--hands="Amalric Gages",
		hands="Jhakri Cuffs +2",
		ring1="Acumen Ring",
		ring2="Jhakri Ring",
		back="Toro Cape",
		--waist="Yamabuki-no-Obi",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"
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
		ammo="Ghastly Tathlum",
		head="Jhakri Coronal +2",
		neck="Sanctity Necklace",
		ear1="Friomisi Earring",
		ear2="Crematio Earring",
		body="Jhakri Robe +2",
		--hands="Amalric Gages",
		hands="Jhakri Cuffs +2",
		ring1="Acumen Ring",
		ring2="Jhakri Ring",
		back=gear.ElementalCape,
		waist=gear.ElementalObi,
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2"
	}
				
	sets.midcast['Blue Magic'] = {}
		
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
	sets.Learning = {
		ammo="Mavi Tathlum",
		hands="Assimilator's Bazubands +1",
		back="Cornflower Cape",
		legs="Mavi Tayt +2",
	}

	sets.latent_refresh = {
		waist="Fucho-no-obi"
	}
		
	-- Idle sets
	sets.idle = {
		head="Aya. Zucchetto +2",
		neck="Twilight Torque",
		ear1="Novia Earring",
		ear2="Ethereal Earring",
		body="Jhakri Robe +2",
		hands="Aya. Manopolas +2",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Fucho-no-Obi",
		legs="Carmine Cuisses +1",
		feet="Aya. Gambieras +2",
	}

	-- PDT:
	-- MDT:
	--
	sets.idle.PDT = {
	}

	-- PDT:
	-- MDT:
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

	sets.Kiting = {legs="Carmine Cuisses +1"}

	-- Engaged sets
		
	-- Normal melee group
	sets.engaged = {
		ammo="Amar Cluster",
		head="Aya. Zucchetto +2",
		neck="Asperity Necklace",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +2",
		ring1="Rajas Ring",
		ring2="Apate Ring",
		back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		legs="Samnuha Tights",
		feet="Aya. Gambieras +2"
	}

	sets.engaged.Acc = set_combine(sets.engaged, {
	})

	sets.engaged.Refresh = set_combine(sets.engaged, {
	})

	sets.engaged.DW = set_combine(sets.engaged, {
		ear1="Dudgeon Earring",
		ear2="Heartseeker Earring",
	})

	sets.engaged.DW.Acc = set_combine(sets.engaged, {
	})

	sets.engaged.DW.Refresh = set_combine(sets.engaged, {
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
		set_macro_page(2, 12)
	else
		set_macro_page(1, 12)
	end
end


