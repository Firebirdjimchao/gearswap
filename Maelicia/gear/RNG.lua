function user_setup()
	state.IdleMode:options('Normal', 'CP', 'Regen', 'CPPDT', 'CPMDT')
	state.OffenseMode:options('Normal', 'FullAcc', 'DT', 'Melee', 'Encumbered')
	state.RangedMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc', 'Crit')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')

	-- buffactive table cannot distinguish between different tiers of buffs, use toggle to manually set
	state.FlurryTier = M('Flurry', 'Flurry II')

	gear.default.weaponskill_neck = "Fotia Gorget"
	gear.default.weaponskill_waist = "Fotia Belt"
	gear.aug_belenus_stp = { name="Belenus's Cape", augments={'STR+20','Rng.Acc.+20 Rng.Atk.+20','STR+10','"Store TP"+10',}}
	gear.aug_belenus_stp_agi = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}}
	gear.aug_belenus_snapshot = { name="Belenus's Cape", augments={'"Snapshot"+10',}}
	gear.aug_belenus_ws = { name="Belenus's Cape", augments={'STR+20','Rng.Acc.+20 Rng.Atk.+20','STR+10','Weapon skill damage +10%',}}
	gear.aug_belenus_ws_agi = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}

	DefaultAmmo = {['Yoichinoyumi'] = "Achiyalabopa arrow", ['Annihilator'] = "Chrono bullet", ['Fail-Not'] = "Chrono arrow", ['Fomalhaut'] = "Chrono bullet"}
	U_Shot_Ammo = {['Yoichinoyumi'] = "Achiyalabopa arrow", ['Annihilator'] = "Chrono bullet", ['Fail-Not'] = "Chrono arrow", ['Fomalhaut'] = "Chrono bullet"}
	--gear.RAbullet = "Eradicating bullet"
	--gear.MAbullet = "Silver Bullet"
	--gear.MAbullet = "Bullet"
	gear.MAbullet = "Eradicating bullet"
	gear.MAArrow = "Chrono arrow"

	select_default_macro_book()

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
	send_command('bind @` gs c cycle FlurryTier')

	global_aliases()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind @`')
end

-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Bounty Shot'] = {hands="Amini Glove. +1"}
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +3"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +3"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +3"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +3"}
	sets.precast.JA['Unlimited Shot'] = {feet="Amini Bottillons +1"}
	sets.precast.JA['Eagle Eye Shot'] = {
		--head=gear.Adhemar_head_B,
		head=gear.Herculean_head_RA,
		neck="Iskur Gorget",
		ear1="Telos Earring",
		ear2="Enervating Earring",
		body="Nisroch Jerkin",
		hands="Mummu Wrists +2",
		ring1="Ilabrat Ring",
		ring2="Mummu Ring",
		back=gear.aug_belenus_ws_agi,
		waist="K. Kachina Belt +1",
		legs="Arc. Braccae +3",
		--feet=gear.Herculean_feet_RA
		feet="Osh. Leggings +1",
	}
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Mummu Bonnet +2",
		body="Orion Jerkin +3",
		hands="Orion Bracers +3",
		ring1="Dark Ring",
		ring2="Sirona's Ring",
		back="Tantalic Cape",
		waist="Chaac Belt",
		legs="Arc. Braccae +3",
		feet="Arcadian Socks +3",
	}

	-- Fast cast sets for spells

	-- 43%
	sets.precast.FC = {
		-- 7%
		head=gear.Herculean_head_RA,
		-- 4%
		neck="Voltsurge Torque",
		-- 2%
		ear1="Loquacious Earring",
		-- 1%
		ear2="Etiolation Earring",
		-- 4% + 5%
		body="Taeon Tabard",
		-- 5% + 3%
		hands="Leyline Gloves",
		-- 2%
		ring1="Prolix Ring",
		-- 4%
		--legs="Gyve Trousers",
		-- 5%
		legs=gear.Herculean_legs_Magic,
		-- 8%
		feet="Carmine Greaves +1",
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	-- Ranged sets
	
	-- == Snapshot: 70% cap ==
	-- Merits: 10%
	-- Gear: 57% + (5% Perun +1 augments)
	-- Total: 67% + (5% Perun +1 augments)
	--
	-- == Rapid Shot ==
	-- Merits: 5%
	-- Gear: 39%
	-- Total: 44%;
	--
	sets.precast.RA = {
		-- 7% SS
		--head="Amini Gapette +1",
		-- 18% RS
		head="Orion Beret +3",
		-- 4% SS
		neck="Scout's Gorget +2",
		-- 12% SS
		body="Oshosi Vest",
		-- 8% SS + 11% RS
		hands="Carmine Fin. Ga. +1",
		-- 6% SS
		ring1="Haverton Ring",
		-- 10% SS + 2% VS
		back=gear.aug_belenus_snapshot,
		-- 3% SS
		--waist="Impulse Belt",
		-- 5% RS
		waist="Yemaya Belt",
		-- 9% SS + 10% RS
		legs=gear.Adhemar_legs_D,
		-- 10% SS
		feet="Meg. Jam. +2",
	}

	-- == Snapshot: 70% cap ==
	-- Merits: 10%
	-- Gear: 54% + (5% Perun +1 augments)
	-- Total: 64% + (5% Perun +1 augments)
	--
	-- == Rapid Shot ==
	-- Merits: 5%
	-- Gear: 26%
	-- Total: 31%;
	--
	-- Note: Snapshot+ is not the same as Velocity Shot+
	-- == Velocity Shot ==
	-- JA: 15%
	-- Gift: 10%
	-- Gear: 9%
	-- Total: 34%
	--
	sets.precast.RA.VS = set_combine(sets.precast.RA,{
		-- 7% SS
		head="Amini Gapette +1",
		-- 4% SS
		neck="Scout's Gorget +2",
		-- 7% VS
		body="Amini Caban +1",
		-- 8% SS + 11% RS
		hands="Carmine Fin. Ga. +1",
		-- 6% SS
		ring1="Haverton Ring",
		-- 10% SS + 2% VS
		back=gear.aug_belenus_snapshot,
		-- 3% SS
		--waist="Impulse Belt",
		-- 5% RS
		waist="Yemaya Belt",
		-- 9% SS + 10% RS
		legs=gear.Adhemar_legs_D,
		-- 10% SS
		feet="Meg. Jam. +2",
	})

	-- == Snapshot: 70% cap ==
	-- Merits: 10%
	-- Flurry: 15%
	-- Gear: 47% + (5% Perun +1 augments)
	-- Total: 72% + (5% Perun +1 augments)
	--
	-- == Rapid Shot ==
	-- Merits: 5%
	-- Gear: 44%
	-- Total: 49%;
	--
	-- == Velocity Shot ==
	-- JA: 15%
	-- Gift: 10%
	-- Gear: 9%
	-- Total: 34%
	--
	sets.precast.RA.Flurry = set_combine(sets.precast.RA,{
		-- 7% SS
		--head="Amini Gapette +1",
		-- 18% RS
		head="Orion Beret +3",
		-- 4% SS
		neck="Scout's Gorget +2",
		-- 7% VS
		body="Amini Caban +1",
		-- 8% SS + 11% RS
		hands="Carmine Fin. Ga. +1",
		-- 6% SS
		ring1="Haverton Ring",
		-- 10% SS + 2% VS
		back=gear.aug_belenus_snapshot,
		-- 5% RS
		waist="Yemaya Belt",
		-- 9% SS + 10% RS
		legs=gear.Adhemar_legs_D,
		-- 10% SS
		feet="Meg. Jam. +2",
	})

	-- == Snapshot: 70% cap ==
	-- Merits: 10%
	-- Flurry II: 30%
	-- Gear: 37% + (2% Perun +1 augments)
	-- Total: 77% + (2% Perun +1 augments)
	--
	-- == Rapid Shot ==
	-- Merits: 5%
	-- Gear: 52%
	-- Total: 59%;
	--
	-- == Velocity Shot ==
	-- JA: 15%
	-- Gift: 10%
	-- Gear: 9%
	-- Total: 34%
	--
	sets.precast.RA.FlurryII = set_combine(sets.precast.RA,{
		-- 18% RS
		head="Orion Beret +3",
		-- 4% SS
		neck="Scout's Gorget +2",
		-- 7% VS
		body="Amini Caban +1",
		-- 8% SS + 11% RS
		hands="Carmine Fin. Ga. +1",
		-- 6% SS
		ring1="Haverton Ring",
		-- 10% SS + 2% VS
		back=gear.aug_belenus_snapshot,
		-- 5% RS
		waist="Yemaya Belt",
		-- 9% SS + 10% RS
		legs=gear.Adhemar_legs_D,
		-- 10% RS
		feet=gear.pursuer_feet_D,
	})
	
	-- SS: 50% (Overkill) + 10% Merits
	sets.precast.RA.Overkill = set_combine(sets.precast.RA,{
		-- 14% RS
		head="Arcadian Beret +3",
		-- 18% RS
		--head="Orion Beret +3",
		-- 4% SS
		neck="Scout's Gorget +2",
		-- 7% VS
		--body="Amini Caban +1",
		-- 16% RS 5% SS (Merit augment)
		body="Arc. Jerkin +3",
		-- 8% SS + 11% RS
		--hands="Carmine Fin. Ga. +1",
		-- 15% RS
		hands="Mrigavyadha Gloves",
		-- 10% SS + 2% VS
		back=gear.aug_belenus_snapshot,
		-- 5% RS
		waist="Yemaya Belt",
		-- 9% SS 10% RS
		legs=gear.Adhemar_legs_D,
		-- 9% RS + 10% RS
		--legs=gear.pursuer_legs_A,
		-- 10% RS
		feet=gear.pursuer_feet_D,
	})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head=gear.Adhemar_head_B,
		neck="Fotia Gorget",
		--ear1="Brutal Earring",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body=gear.Adhemar_body_B,
		hands="Meg. Gloves +2",
		ring1="Ilabrat Ring",
		ring2="Rajas Ring",
		back=gear.aug_belenus_ws,
		waist="Fotia Belt",
		legs="Samnuha Tights",
		feet=gear.Adhemar_feet_B
	}

	sets.precast.WS.MaxTP = {
		ear2="Enervating Earring",
	}
	
	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
		ring1="Ilabrat Ring",
	})

	sets.precast.WS.HighAcc = set_combine(sets.precast.WS, {
		ring1="Ilabrat Ring",
		ring2="Regal Ring",
	})

	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {
		head="Meghanada Visor +2",
		body=gear.Adhemar_body_B,
		ring1="Ilabrat Ring",
		ring2="Regal Ring",
		--legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
	})
	
	sets.precast.WS.MAB = set_combine(sets.precast.WS, {
		--head=gear.Herculean_head_Magic,
		--head="Orion Beret +3",
		neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		--body=gear.Herculean_body_Magic,
		body="Cohort Cloak +1",
		hands=gear.Carmine_hands_hq_D,
		--hands="Meg. Gloves +2",
		ring1="Acumen Ring",
		ring2="Dingir Ring",
		--back="Toro Cape",
		back=gear.aug_belenus_ws,
		--waist="Eschan Stone",
		legs="Gyve Trousers", -- from a purely MAB perspective, as Gyve has MAB +40, vs. Herculean_legs_Magic with MAB +30
		feet=gear.Adhemar_feet_B
	})
	
	sets.precast.WS.RA = set_combine(sets.precast.WS, {
		head="Orion Beret +3",
		neck="Fotia Gorget",
		-- 5 STP
		--ear1="Telos Earring",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body=gear.Herculean_body_RA_WS,
		hands="Meg. Gloves +2",
		-- 5 STP
		ring1="Ilabrat Ring",
		ring2="Regal Ring",
		back=gear.aug_belenus_ws_agi,
		waist="Fotia Belt",
		-- 10 STP
		--legs="Amini Brague +1",
		-- 4 STP
		--legs=gear.Herculean_legs_RA,
		legs="Arc. Braccae +3",
		feet=gear.Herculean_feet_RA
	})
	
	sets.precast.WS.RA.MidAcc = set_combine(sets.precast.WS.RA, {
		body="Arc. Jerkin +3",
	})

	sets.precast.WS.RA.HighAcc = set_combine(sets.precast.WS.RA, {
		body="Arc. Jerkin +3",
		feet="Arcadian Socks +3",
	})
	
	sets.precast.WS.RA.FullAcc = set_combine(sets.precast.WS.RA, {
		--body="Orion Jerkin +3",
		body="Arc. Jerkin +3",
		feet="Orion Socks +3",
	})
	
	sets.precast.WS.MABRA = set_combine(sets.precast.WS.MAB, {
		--neck="Sanctity Necklace",
		neck="Scout's Gorget +2",
		ear1="Moonshade Earring",
		body="Cohort Cloak +1",
		ring1="Ilabrat Ring",
		ring2="Dingir Ring",
		back=gear.aug_belenus_ws_agi,
		waist="Eschan Stone",
		--waist=gear.ElementalObi,
		legs=gear.Herculean_legs_Magic,
		--legs="Arc. Braccae +3",
		feet=gear.Adhemar_feet_B,
	})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	-------------------------
	-- Marksmanship

	-- 73~85% AGI
	sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS.RA, {
		back=gear.aug_belenus_ws_agi,
		legs="Arc. Braccae +3",
	})
	sets.precast.WS['Last Stand'].MidAcc = set_combine(sets.precast.WS['Last Stand'], {
		body="Nisroch Jerkin",
		legs="Arc. Braccae +3",
	})
	sets.precast.WS['Last Stand'].HighAcc = set_combine(sets.precast.WS['Last Stand'], {
		body="Arc. Jerkin +3",
		legs="Arc. Braccae +3",
		feet="Arcadian Socks +3",
	})
	sets.precast.WS['Last Stand'].FullAcc = set_combine(sets.precast.WS['Last Stand'], {
		body="Arc. Jerkin +3",
		ring1="Haverton Ring",
		legs="Arc. Braccae +3",
		--feet="Meg. Jam. +2",
		feet="Arcadian Socks +3",
	})
	
	-- 40% AGI/ 40% DEX, Static fTP 3.0
	sets.precast.WS['Coronach'] = set_combine(sets.precast.WS.RA, {
		head="Orion Beret +3",
		neck="Scout's Gorget +2",
		ear1="Ishvara Earring",
		ear2="Sherida Earring",
		body=gear.Herculean_body_RA_WS,
		hands="Meg. Gloves +2",
		ring1="Dingir Ring",
		ring2="Regal Ring",
		--back=gear.aug_belenus_ws,
		back=gear.aug_belenus_ws_ag,
		waist="Fotia Belt",
		legs="Arc. Braccae +3",
		feet=gear.Herculean_feet_RA
	})
	sets.precast.WS['Coronach'].MidAcc = set_combine(sets.precast.WS['Coronach'], {
		body="Arc. Jerkin +3",
	})
	sets.precast.WS['Coronach'].HighAcc = set_combine(sets.precast.WS['Coronach'], {
		body="Arc. Jerkin +3",
		feet="Arcadian Socks +3",
	})
	sets.precast.WS['Coronach'].FullAcc = set_combine(sets.precast.WS['Coronach'], {
		--body="Orion Jerkin +3",
		body="Arc. Jerkin +3",
		ring1="Haverton Ring",
		legs="Arc. Braccae +3",
		--feet="Orion Socks +3",
		feet="Arcadian Socks +3",
	})
	
	-- 60% AGI
	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS.MABRA, {
		--neck="Sanctity Necklace",
		neck="Scout's Gorget +2",
		ear1="Moonshade Earring",
		body="Cohort Cloak +1",
		ring1="Ilabrat Ring",
		ring2="Dingir Ring",
		back=gear.aug_belenus_ws_agi,
		waist="Eschan Stone",
		--waist=gear.ElementalObi,
		legs=gear.Herculean_legs_Magic,
		--legs="Arc. Braccae +3",
		feet=gear.Adhemar_feet_B,
	})
	sets.precast.WS['Wildfire'].MidAcc = set_combine(sets.precast.WS['Wildfire'], {
	})
	sets.precast.WS['Wildfire'].HighAcc = set_combine(sets.precast.WS['Wildfire'], {
	})
	sets.precast.WS['Wildfire'].FullAcc = set_combine(sets.precast.WS['Wildfire'], {
	})
	sets.precast.WS['Wildfire'].Encumbered = set_combine(sets.midcast.RA.FullAcc,{
	})
	
	-- 100% AGI
	sets.precast.WS['Trueflight'] = set_combine(sets.precast.WS.MABRA, {
		--neck="Sanctity Necklace",
		neck="Scout's Gorget +2",
		ear1="Moonshade Earring",
		body="Cohort Cloak +1",
		ring1="Ilabrat Ring",
		ring2="Dingir Ring",
		back=gear.aug_belenus_ws_agi,
		waist="Eschan Stone",
		--waist=gear.ElementalObi,
		legs=gear.Herculean_legs_Magic,
		--legs="Arc. Braccae +3",
		feet=gear.Adhemar_feet_B,
	})
	sets.precast.WS['Trueflight'].MidAcc = set_combine(sets.precast.WS['Trueflight'], {
	})
	sets.precast.WS['Trueflight'].HighAcc = set_combine(sets.precast.WS['Trueflight'], {
	})
	sets.precast.WS['Trueflight'].FullAcc = set_combine(sets.precast.WS['Trueflight'], {
	})
	
	-------------------------
	-- Archery

	-- 80% DEX
	sets.precast.WS["Jishnu's Radiance"] = set_combine(sets.precast.WS.RA, {
		head=gear.Adhemar_head_B,
		body="Meg. Cuirie +2",
		back=gear.aug_belenus_ws_agi,
		legs="Arc. Braccae +3",
	})
	sets.precast.WS["Jishnu's Radiance"].MidAcc = set_combine(sets.precast.WS["Jishnu's Radiance"], {
		legs=gear.Herculean_legs_RA,
	})
	sets.precast.WS["Jishnu's Radiance"].HighAcc = set_combine(sets.precast.WS["Jishnu's Radiance"], {
		head="Orion Beret +3",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS["Jishnu's Radiance"].FullAcc = set_combine(sets.precast.WS["Jishnu's Radiance"], {
		head="Orion Beret +3",
		legs=gear.Herculean_legs_RA,
	})
	
	-- AGI 50% STR 20%
	sets.precast.WS['Flaming Arrow'] = set_combine(sets.precast.WS.MABRA, {
	})
	sets.precast.WS['Flaming Arrow'].MidAcc = set_combine(sets.precast.WS['Flaming Arrow'], {
	})
	sets.precast.WS['Flaming Arrow'].HighAcc = set_combine(sets.precast.WS['Flaming Arrow'], {
	})
	sets.precast.WS['Flaming Arrow'].FullAcc = set_combine(sets.precast.WS['Flaming Arrow'], {
	})

	-- 73~85% AGI
	sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS.RA, {
		back=gear.aug_belenus_ws_agi,
		legs="Arc. Braccae +3",
	})
	sets.precast.WS['Apex Arrow'].MidAcc = set_combine(sets.precast.WS['Apex Arrow'], {
		body="Orion Jerkin +3",
	})
	sets.precast.WS['Apex Arrow'].HighAcc = set_combine(sets.precast.WS['Apex Arrow'], {
		body="Meg. Cuirie +2",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS['Apex Arrow'].FullAcc = set_combine(sets.precast.WS['Apex Arrow'], {
		body="Meg. Cuirie +2",
		ring1="Haverton Ring",
		feet="Meg. Jam. +2",
	})

	-- 60% STR
	sets.precast.WS['Refulgent Arrow'] = set_combine(sets.precast.WS.RA, {
		back=gear.aug_belenus_ws,
		legs="Arc. Braccae +3",
		feet=gear.Herculean_feet_RA
	})
	sets.precast.WS['Refulgent Arrow'].MidAcc = set_combine(sets.precast.WS['Refulgent Arrow'], {
	})
	sets.precast.WS['Refulgent Arrow'].HighAcc = set_combine(sets.precast.WS['Refulgent Arrow'], {
		body="Meg. Cuirie +2",
		feet="Meg. Jam. +2",
	})
	sets.precast.WS['Refulgent Arrow'].FullAcc = set_combine(sets.precast.WS['Refulgent Arrow'], {
		--body="Orion Jerkin +3",
		body="Meg. Cuirie +2",
		ring1="Haverton Ring",
		--feet="Orion Socks +3",
		feet="Meg. Jam. +2",
	})
	
	----------------------------
	-- Others
	
	-- 50% MND / 30% STR, No SC elements so Elemental Gorget/Belt wont have an effect
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.MABRA, {
		neck="Sanctity Necklace",
		ear1="Moonshade Earring",
		ring1="Ilabrat Ring",
		ring2="Regal Ring",
		back=gear.aug_belenus_ws,
		waist="Eschan Stone",
		legs=gear.Herculean_legs_Magic,
	})
	sets.precast.WS['Sanguine Blade'].MidAcc = set_combine(sets.precast.WS['Sanguine Blade'], {
	})
	sets.precast.WS['Sanguine Blade'].HighAcc = set_combine(sets.precast.WS['Sanguine Blade'], {
	})
	sets.precast.WS['Sanguine Blade'].FullAcc = set_combine(sets.precast.WS['Sanguine Blade'], {
	})

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	-- 26% Haste
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})

	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast,{
	})

	-- STP Calculator Spreadsheet Results -----------------
	--
	-- TP/hit = floor( Base TP/hit × (100 + Store TP Total)÷100 , 1)
	-- Delay: 582 (Annihilator) + 240 (Chrono or Eradicating Bullets) = 822
	-- Base TP/hit for Delay 721~900: 161+[(Delay-720)×24÷360] = 167.8
	--
	-- Gear STP Needed:
	-- 5 hit: 20 STP
	-- 4 hit: 49 STP, 17 (lucky SAM Roll), 9 (11 SAM Roll), 45 (unlucky SAM Roll)
	-- 3 hit: 100 STP, 68 (lucky SAM Roll), 60 (11 SAM Roll), 96 (unlucky SAM Roll)
	-- 2 hit: 198 STP
	--
	-- Delay: 600 (Fail-Not) + 90 (Chrono Arrows) = 690
	-- Base TP/hit for Delay 631~720: 154+[(Delay-630)×28÷360] = 158.66667
	--
	-- Gear STP Needed:
	-- 5 hit: 27 STP
	-- 4 hit: 58 STP, 26 (lucky SAM Roll), 18 (11 SAM Roll), 54 (unlucky SAM Roll)
	-- 3 hit: 111 STP, 79 (lucky SAM Roll), 71 (11 SAM Roll), 107 (unlucky SAM Roll)
	-- 2 hit: 216 STP
	--
	-- SAM Roll - Lucky: 32 STP, Unlucky: 4 STP, 11: 40 STP

	-- Ranged sets

	-- Gear: 74 STP
	-- Perun +1: 4 STP
	-- Nusku Shield: 3 STP
	-- Gear Total: 81 STP
	-- /war stat:
	-- Base RACC 1414
	-- Base RATK 1466
	sets.midcast.RA = {
		--head="Meghanada Visor +2",
		head="Arcadian Beret +3",
		-- 8 STP
		neck="Iskur Gorget",
		-- 7 STP
		--neck="Scout's Gorget +2",
		-- 5 STP
		ear1="Telos Earring",
		-- 4 STP
		--ear2="Enervating Earring",
		-- 8 STP
		ear2="Dedition Earring",
		-- 6 STP
		--body="Mummu Jacket +2",
		-- 7 STP
		body="Nisroch Jerkin",
		-- 9 STP
		--hands="Amini Glove. +1",
		-- 12 STP
		hands="Malignance Gloves",
		-- 5 STP
		ring1="Ilabrat Ring",
		-- 5 STP
		ring2="Rajas Ring",
		-- 10 STP
		back=gear.aug_belenus_stp_agi,
		-- 4 STP
		waist="Yemaya Belt",
		-- 10 STP
		legs="Amini Brague +1",
		-- 4 STP
		--legs=gear.Herculean_legs_RA,
		feet="Arcadian Socks +3",
	}
	
	-- Gear: 72 STP
	-- Perun +1: 4 STP
	-- Nusku Shield: 3 STP
	-- Gear Total: 79 STP
	-- /war stat:
	-- Base RACC 1473
	-- Base RATK 1389
	sets.midcast.RA.MidAcc = set_combine(sets.midcast.RA,{
		ring1="Haverton Ring",
		-- 4 STP
		legs=gear.Herculean_legs_RA,
		-- 9 STP
		feet="Malignance Boots",
	})

	-- Gear: 78 STP
	-- Perun +1: 4 STP
	-- Nusku Shield: 3 STP
	-- Gear Total: 85 STP
	-- /war stat:
	-- Base RACC 1517
	-- Base RATK 1266
	sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA,{
		--body="Amini Caban +1",
		-- 7 STP
		--body="Nisroch Jerkin",
		-- 11 STP
		body="Malignance Tabard",
		-- 12 STP
		hands="Malignance Gloves",
		ring1="Haverton Ring",
		waist="K. Kachina Belt +1",
		-- 10 STP
		legs="Malignance Tights",
		-- 9 STP
		feet="Malignance Boots",
	})
	
	-- Gear: 35 STP
	-- Perun +1: 4 STP
	-- Nusku Shield: 3 STP
	-- Gear Total: 42 STP
	-- /war stat:
	-- Base RACC 1628
	-- Base RATK 1397
	sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA,{
		head="Orion Beret +3",
		-- 4 STP
		ear2="Enervating Earring",
		-- 8 STP
		body="Orion Jerkin +3",
		hands="Orion Bracers +3",
		ring1="Haverton Ring",
		ring2="Regal Ring",
		waist="K. Kachina Belt +1",
		legs="Orion Braccae +3",
		feet="Orion Socks +3",
	})

	sets.midcast.RA.Annihilator = set_combine(sets.midcast.RA, {
	})
	sets.midcast.RA.Annihilator.MidAcc = set_combine(sets.midcast.RA.MidAcc, {
	})
	sets.midcast.RA.Annihilator.HighAcc = set_combine(sets.midcast.RA.HighAcc, {
	})
	sets.midcast.RA.Annihilator.FullAcc = set_combine(sets.midcast.RA.FullAcc, {
	})

	sets.midcast.RA.Crit = set_combine(sets.midcast.RA.FullAcc, {
		head=gear.Herculean_head_RA,
		body="Nisroch Jerkin",
		hands="Mummu Wrists +2",
		ring1="Ilabrat Ring",
		ring2="Mummu Ring",
		legs="Mummu Kecks +2",
		waist="K. Kachina Belt +1",
		feet="Osh. Leggings +1",
	})

	sets.midcast.RA.Annihilator.Crit = set_combine(sets.midcast.RA.Crit, {
	})

	-- Gear: 49 STP
	-- Perun +1: 4 STP
	-- Nusku Shield: 3 STP
	-- Fail-Not: 10 STP
	-- Gear Total: 66 STP
	sets.midcast.RA['Fail-Not'] = set_combine(sets.midcast.RA, {
		back=gear.aug_belenus_stp,
	})
	-- Gear: 46 STP
	-- Perun +1: 4 STP
	-- Nusku Shield: 3 STP
	-- Fail-Not: 10 STP
	-- Gear Total: 63 STP
	sets.midcast.RA['Fail-Not'].MidAcc = set_combine(sets.midcast.RA.MidAcc, {
		back=gear.aug_belenus_stp,
	})
	-- Gear: 44 STP
	-- Perun +1: 4 STP
	-- Nusku Shield: 3 STP
	-- Fail-Not: 10 STP
	-- Gear Total: 61 STP
	sets.midcast.RA['Fail-Not'].HighAcc = set_combine(sets.midcast.RA.HighAcc, {
		-- 9 STP
		--hands="Amini Glove. +1",
		hands="Oshosi Glove +1",
	})
	-- Gear: 43 STP
	-- Perun +1: 4 STP
	-- Nusku Shield: 3 STP
	-- Fail-Not: 10 STP
	-- Gear Total: 60 STP
	sets.midcast.RA['Fail-Not'].FullAcc = set_combine(sets.midcast.RA.FullAcc, {
		-- 9 STP
		hands="Amini Glove. +1",
	})
	sets.midcast.RA['Fail-Not'].Crit = set_combine(sets.midcast.RA.Crit, {
	})

	sets.midcast.RA.Yoichinoyumi = set_combine(sets.midcast.RA, {
	})
	sets.midcast.RA.Yoichinoyumi.MidAcc = set_combine(sets.midcast.RA.MidAcc, {
	})
	sets.midcast.RA.Yoichinoyumi.HighAcc = set_combine(sets.midcast.RA.HighAcc, {
	})
	sets.midcast.RA.Yoichinoyumi.FullAcc = set_combine(sets.midcast.RA.FullAcc, {
	})
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {
		ring1="Sheltered Ring"
	}

	-- Idle sets
	sets.idle = {
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Malignance Tights",
		feet="Orion Socks +3",
	}
	
	sets.noprotect = {ring1="Sheltered Ring"}
	
	sets.idle.Town = set_combine(sets.idle, {
		--head="Orion Beret +3",
		head="Arcadian Beret +3",
		neck="Scout's Gorget +2",
		ear1="Telos Earring",
		ear2="Enervating Earring",
		--body="Arc. Jerkin +3",
		--body="Councilor's Garb",
		body="Nisroch Jerkin",
		hands="Orion Bracers +3",
		ring1="Ilabrat Ring",
		ring2="Regal Ring",
		back=gear.aug_belenus_ws_agi,
		waist="K. Kachina Belt +1",
		legs="Arc. Braccae +3",
		--feet="Orion Socks +3",
		feet="Arcadian Socks +3",
	})
	
	sets.idle.Weak = set_combine(sets.idle,{
	})
	
	sets.idle.Regen = set_combine(sets.idle,{
		neck="Bathy Choker +1",
		ring1="Sheltered Ring",
	})
	
	sets.idle.CP = set_combine(sets.idle,{
		back="Mecisto. Mantle"
	})
	
	sets.idle.CPPDT = set_combine(sets.defense.PDT,{
		back="Mecisto. Mantle"
	})
	
	sets.idle.CPMDT = set_combine(sets.defense.MDT,{
		back="Mecisto. Mantle"
	})
	
	-- Defense sets
	-- DT: 52%
	-- PDT: 9%
	-- MDT: 10%
	sets.defense.PDT = set_combine(sets.idle,{
		-- DT 6%
		head="Malignance Chapeau",
		-- DT 6%
		neck="Loricate Torque +1",
		-- MDT 2%
		ear1="Odnowa Earring +1",
		-- MDT 3%
		ear2="Etiolation Earring",
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

	-- DT: 52%
	-- PDT: 9%
	-- MDT: 10%
	-- MDB: 37
	-- To cap: Shellra5: 23%, Shell5: 26%, Shell4: 29%
	sets.defense.MDT = set_combine(sets.idle,{
		-- DT 6% MDB 5
		head="Malignance Chapeau",
		-- MDT 2%
		ear1="Odnowa Earring +1",
		-- MDT 3%
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
		-- DT 4%
		feet="Malignance Boots",
	})

	sets.Kiting = {feet="Orion Socks +3",}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = set_combine(sets.idle,{
		feet="Orion Socks +3",
	})
	
	sets.engaged.Melee = set_combine(sets.engaged,{
		head=gear.Adhemar_head_B,
		neck="Asperity Necklace",
		ear1="Telos Earring",
		ear2="Brutal Earring",
		--body=gear.Adhemar_body_B,
		body="Tatena. Harama. +1",
		--hands=gear.Adhemar_hands_B,
		hands="Tatena. Gote +1",
		ring1="Ilabrat Ring",
		ring2="Epona's Ring",
		back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		legs="Meg. Chausses +2",
		feet=gear.Adhemar_feet_B
	})
	
	sets.engaged.Melee.MidAcc = set_combine(sets.engaged.Melee,{
		ring2="Cacoethic Ring +1",
	})

	sets.engaged.Melee.HighAcc = set_combine(sets.engaged.Melee,{
		head="Malignance Chapeau",
		neck="Subtlety Spec.",
		ear1="Telos Earring",
		ear2="Digni. Earring",
		ring1="Cacoethic Ring +1",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})

	sets.engaged.Melee.FullAcc = set_combine(sets.engaged.Melee,{
		head="Malignance Chapeau",
		neck="Subtlety Spec.",
		ear1="Telos Earring",
		ear2="Digni. Earring",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
		ring1="Cacoethic Ring +1",
		ring2="Patricius Ring",
		waist="Eschan Stone",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})

	sets.engaged.DT = set_combine(sets.engaged,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})

	sets.engaged.DT.MidAcc = set_combine(sets.engaged.Melee.MidAcc,{
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})

	sets.engaged.DT.HighAcc = set_combine(sets.engaged.Melee.HighAcc,{
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})

	sets.engaged.DT.FullAcc = set_combine(sets.engaged.Melee.FullAcc,{
		head="Malignance Chapeau",
		neck="Loricate Torque +1",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		ring1="Dark Ring",
		ring2="Defending Ring",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	
	sets.engaged.Encumbered = set_combine(sets.midcast.RA.HighAcc,{
	})

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = set_combine(sets.midcast.RA.FullAcc, {
		head="Meghanada Visor +2",
		ear1="Telos Earring",
		ear2="Enervating Earring",
		neck="Iskur Gorget",
		body="Nisroch Jerkin",
		hands="Orion Bracers +3",
		ring1="Haverton Ring",
		ring2="Regal Ring",
		back=gear.aug_belenus_stp_agi,
		waist="K. Kachina Belt +1",
		legs=gear.Herculean_legs_RA,
		feet="Arcadian Socks +3",
	})
	sets.buff.Barrage.Archery = set_combine(sets.buff.Barrage, {
	})
	sets.buff.Barrage.Yoichinoyumi = set_combine(sets.buff.Barrage.Archery, {
	})
	sets.buff.Barrage.Cibitshavore = set_combine(sets.buff.Barrage.Archery, {
	})
	sets.buff.Barrage.Phaosphaelia = set_combine(sets.buff.Barrage.Archery, {
	})
	sets.buff.Camouflage = {body="Orion Jerkin +3"}	
	sets.buff.ArmaAftermath = {
		body="Nisroch Jerkin",
	}
	sets.buff.ArmaAftermath.MidAcc = set_combine(sets.buff.ArmaAftermath, {
	})
	sets.buff.ArmaAftermath.HighAcc = set_combine(sets.buff.ArmaAftermath, {
	})
	sets.buff.ArmaAftermath.FullAcc = set_combine(sets.buff.ArmaAftermath, {
	})
	sets.buff.Doubleshot = {
		--head="Oshosi Mask",
		head="Arcadian Beret +3",
		--body="Oshosi Vest",
		body="Arc. Jerkin +3",
		hands="Oshosi Gloves +1",
		legs="Osh. Trousers +1",
		feet="Osh. Leggings +1",
	}
	sets.buff.Doubleshot.MidAcc = set_combine(sets.buff.Doubleshot, {
	})
	sets.buff.Doubleshot.HighAcc = set_combine(sets.buff.Doubleshot, {
		waist="K. Kachina Belt +1",
	})
	sets.buff.Doubleshot.FullAcc = set_combine(sets.buff.Doubleshot, {
		waist="K. Kachina Belt +1",
	})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)

	--add_to_chat(7,"--- [ Spell Type: "..spell.type.." [ Name: "..player.target.name.."] [ Model Size: "..spell.target.model_size.."] ---")
	--if spell.type == 'WeaponSkill' then
		--add_to_chat(7,"--- "..spell.name.." [ Range: "..spell.range.."] [ Distance: "..spell.target.distance.."] ---")
		--add_to_chat(7,"--- Distance Factor: "..(spell.target.model_size + spell.range * 1.642276421172564).."---")
	--end

	if spell.type == 'WeaponSkill' then
		if (spell.target.model_size + spell.range * 1.642276421172564) < spell.target.distance then	
			add_to_chat(7,"--- Target "..spell.target.type.." ["..player.target.name.."] out of range of ["..spell.name.."] [ Distance: "..spell.target.distance.."] ---")
			cancel_spell()
		end
	end

	if spell.action_type == 'Ranged Attack' then

		state.CombatWeapon:set(player.equipment.range)

		if not buffactive['Flurry'] then
			add_to_chat(122,"--- Flurry not active ---")
		end

		if not buffactive['Velocity Shot'] then
			add_to_chat(122,"--- Velocity Shot not active ---")
		end
	end

	if spell.action_type == 'Ranged Attack' or
		(spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
		check_ammo(spell, action, spellMap, eventArgs)
	end
	
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

	if spell.action_type == 'Ranged Attack' then
		if buffactive['Flurry'] then
			-- buffactive table cannot distinguish between different tiers of buffs, use toggle to manually set
			if state.FlurryTier.value == "Flurry II" then
				equip(sets.precast.RA.FlurryII)
			else
				equip(sets.precast.RA.Flurry)
			end
		else
			if buffactive['Velocity Shot'] then
				equip(sets.precast.RA.VS)
			else
				equip(sets.precast.RA)
			end
		end
	end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ranged Attack' then
		if (player.equipment.range == "Armageddon" and (buffactive['Aftermath: Lv.1'] or buffactive['Aftermath: Lv.2'] or buffactive['Aftermath: Lv.3'])) then
			--add_to_chat(7, "--- Armageddon Aftermath Active ---")
			if state.RangedMode.current == 'Normal' then
				--add_to_chat(7, "Equipping sets.buff.ArmaAftermath")
				equip(sets.buff.ArmaAftermath)
			else
				--add_to_chat(7, "Equipping sets.buff.ArmaAftermath["..state.RangedMode.current.."]")
				equip(sets.buff.ArmaAftermath[state.RangedMode.current])
			end
		end
		if buffactive['Double Shot'] then
			--add_to_chat(7, "--- Doubleshot Active ---")
			if state.RangedMode.current == 'Normal' then
				--add_to_chat(7, "Equipping sets.buff.Doubleshot")
				equip(sets.buff.Doubleshot)
			else
				--add_to_chat(7, "Equipping sets.buff.Doubleshot["..state.RangedMode.current.."]")
				equip(sets.buff.Doubleshot[state.RangedMode.current])
			end
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 10)
	elseif player.sub_job == 'NIN' then
		set_macro_page(2, 10)
	elseif player.sub_job == 'DNC' then
		set_macro_page(3, 10)
	else
		set_macro_page(1, 10)
	end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
	if not buffactive['Protect'] then
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