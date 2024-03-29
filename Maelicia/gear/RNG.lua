-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff.Barrage = buffactive.Barrage or false
	state.Buff.Camouflage = buffactive.Camouflage or false
	state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
	state.Buff.Overkill = buffactive.Overkill or false

	state.CP = M(false, "Capacity Points Mode")
	state.Warp = M(false, "Warp Mode")
	state.Weapon = M(false, "Weapon Lock")
	state.Neck = M(false, "Neck Mode")
	state.TreasureMode = M(false, 'TH')
	state.EngagedDT = M(false, 'Engaged Damage Taken Mode')

	-- buffactive table cannot distinguish between different tiers of buffs, use toggle to manually set
	state.HasteMode = M('Normal', 'Hi')
	state.FlurryTier = M('Flurry', 'Flurry II')
end

function user_setup()
	state.IdleMode:options('Normal', 'CP', 'Regen', 'CPPDT', 'CPMDT')
	state.OffenseMode:options('Normal', 'FullAcc', 'DT', 'Melee', 'MeleeMidAcc', 'MeleeHighAcc', 'MeleeFullAcc', 'Encumbered')
	state.RangedMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc', 'Crit')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')	

	gear.default.weaponskill_neck = "Fotia Gorget"
	gear.default.weaponskill_waist = "Fotia Belt"
	gear.aug_belenus_stp = { name="Belenus's Cape", augments={'STR+20','Rng.Acc.+20 Rng.Atk.+20','STR+10','"Store TP"+10',}}
	gear.aug_belenus_stp_agi = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}}
	gear.aug_belenus_snapshot = { name="Belenus's Cape", augments={'"Snapshot"+10',}}
	gear.aug_belenus_ws = { name="Belenus's Cape", augments={'STR+20','Rng.Acc.+20 Rng.Atk.+20','STR+10','Weapon skill damage +10%',}}
	gear.aug_belenus_ws_agi = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}}
	gear.aug_belenus_agi_crit = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10',}}

	DefaultAmmo = {['Yoichinoyumi'] = "Chrono arrow", ['Annihilator'] = "Chrono bullet", ['Fail-Not'] = "Chrono arrow", ['Fomalhaut'] = "Chrono bullet"}
	U_Shot_Ammo = {['Yoichinoyumi'] = "Chrono arrow", ['Annihilator'] = "Chrono bullet", ['Fail-Not'] = "Chrono arrow", ['Fomalhaut'] = "Chrono bullet"}
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

	send_command('bind @` gs c cycle HasteMode') --WindowKey'`'
	send_command('bind @f gs c cycle FlurryTier') --WindowKey'F'
	send_command("bind @p gs equip sets.TaeonPhalanx; input /echo --- Phalanx set on ---") -- WindowKey'P'

	send_command('bind @c gs c toggle CP') --WindowKey'C'
	send_command('bind @e gs c toggle EngagedDT') --Windowkey'E'
	send_command('bind @h gs c toggle TreasureMode') --Windowkey'H'
	send_command('bind @n gs c toggle Neck') --Windowkey'N'
	send_command('bind @r gs c toggle Warp') --Windowkey'R'
	send_command('bind @w gs c toggle Weapon') --Windowkey'W'

	global_aliases()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind @`')
	send_command('unbind @f')
	send_command('unbind @p')

	send_command('unbind @c')
	send_command('unbind @e')
	send_command('unbind @h')
	send_command('unbind @n')
	send_command('unbind @r')
	send_command('unbind @w')
end

-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Bounty Shot'] = set_combine(sets.sharedTH,{hands="Amini Glove. +1"})
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +3"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +3"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +3"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +3"}
	sets.precast.JA['Unlimited Shot'] = {feet="Amini Bottillons +1"}
	sets.precast.JA['Eagle Eye Shot'] = {
		--head=gear.Adhemar_head_hq_B,
		--head=gear.Herculean_head_RA,
		head="Meghanada Visor +2",
		neck="Scout's Gorget +2",
		ear1="Telos Earring",
		ear2="Odr Earring",
		body="Nisroch Jerkin",
		hands="Mummu Wrists +2",
		ring1="Ilabrat Ring",
		ring2="Mummu Ring",
		back=gear.aug_belenus_ws_agi,
		waist="K. Kachina Belt +1",
		legs="Arc. Braccae +3",
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

	-- DA/TA/Store TP
	sets.precast.JA['Jump'] = {
		-- 4% TA
		head=gear.Adhemar_head_hq_B,
		-- 1% DA
		neck="Lissome Necklace",
		-- 5% TA
		body="Tatena. Harama. +1",
		-- 4% TA
		hands=gear.Adhemar_hands_hq_B,
		-- 2% TA
		ring1="Hetairoi Ring",
		-- 3% DA 3% TA
		ring2="Epona's Ring",
		-- 10% DA
		back=gear.Cichol_AccDA,
		-- 5% DA 2% TA
		waist="Sailfi Belt +1",
		-- 3% TA
		legs="Tatena. Haidate +1",
		-- 3% TA
		feet="Tatena. Sune. +1",
	}
	sets.precast.JA['High Jump'] = set_combine(sets.precast.JA['Jump'], {
	})
	sets.precast.JA['Super Jump'] = set_combine(sets.precast.JA['Jump'], {
	})

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
	-- Gear: 60% + (5% Perun +1 augments)
	-- Total: 70% + (5% Perun +1 augments)
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
		-- 3% SS
		ring2="Crepuscular Ring",
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
	-- Gear: 57% + (5% Perun +1 augments)
	-- Total: 67% + (5% Perun +1 augments)
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
		-- 3% SS
		ring2="Crepuscular Ring",
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
	-- Gear: 50% + (5% Perun +1 augments)
	-- Total: 75% + (5% Perun +1 augments)
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
		-- 3% SS
		ring2="Crepuscular Ring",
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
	-- Gear: 40% + (2% Perun +1 augments)
	-- Total: 80% + (2% Perun +1 augments)
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
		-- 3% SS
		ring2="Crepuscular Ring",
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
		head=gear.Adhemar_head_hq_B,
		neck="Fotia Gorget",
		--ear1="Brutal Earring",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		body=gear.Adhemar_body_hq_B,
		hands="Meg. Gloves +2",
		ring1="Ilabrat Ring",
		ring2="Rajas Ring",
		back=gear.aug_belenus_ws,
		waist="Fotia Belt",
		legs="Samnuha Tights",
		feet="Nyame Sollerets",
	}

	sets.precast.WS.MaxTP = {
		ear2="Crep. Earring",
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
		body=gear.Adhemar_body_hq_B,
		ring1="Ilabrat Ring",
		ring2="Regal Ring",
		--legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
	})
	
	sets.precast.WS.MAB = set_combine(sets.precast.WS, {
		head="Nyame Helm",
		neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		body="Nyame Mail",
		--hands="Meg. Gloves +2",
		hands="Nyame Gauntlets",
		ring1="Acumen Ring",
		ring2="Dingir Ring",
		--back="Toro Cape",
		back=gear.aug_belenus_ws,
		--waist="Eschan Stone",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	
	sets.precast.WS.RA = set_combine(sets.precast.WS, {
		head="Orion Beret +3",
		neck="Fotia Gorget",
		-- 5 STP
		--ear1="Telos Earring",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body="Nyame Mail",
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
		feet="Nyame Sollerets",
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
		head="Nyame Helm",
		--neck="Sanctity Necklace",
		neck="Scout's Gorget +2",
		ear1="Moonshade Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		--ring1="Ilabrat Ring",
		ring1="Beithir Ring",
		ring2="Dingir Ring",
		back=gear.aug_belenus_ws_agi,
		waist="Eschan Stone",
		--waist=gear.ElementalObi,
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
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
		body="Nyame Mail",
		hands="Meg. Gloves +2",
		--ring1="Dingir Ring",
		ring1="Beithir Ring",
		ring2="Regal Ring",
		--back=gear.aug_belenus_ws,
		back=gear.aug_belenus_ws_agi,
		waist="Fotia Belt",
		legs="Arc. Braccae +3",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Coronach'].MidAcc = set_combine(sets.precast.WS['Coronach'], {
	})
	sets.precast.WS['Coronach'].HighAcc = set_combine(sets.precast.WS['Coronach'], {
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
		head="Nyame Helm",
		--neck="Sanctity Necklace",
		neck="Scout's Gorget +2",
		ear1="Moonshade Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		--ring1="Ilabrat Ring",
		ring1="Beithir Ring",
		ring2="Dingir Ring",
		back=gear.aug_belenus_ws_agi,
		waist="Eschan Stone",
		--waist=gear.ElementalObi,
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Wildfire'].MidAcc = set_combine(sets.precast.WS['Wildfire'], {
	})
	sets.precast.WS['Wildfire'].HighAcc = set_combine(sets.precast.WS['Wildfire'], {
		head=empty,
		body="Cohort Cloak +1",
	})
	sets.precast.WS['Wildfire'].FullAcc = set_combine(sets.precast.WS['Wildfire'], {
		head=empty,
		body="Cohort Cloak +1",
	})
	sets.precast.WS['Wildfire'].Encumbered = set_combine(sets.midcast.RA.FullAcc,{
	})
	
	-- 100% AGI
	sets.precast.WS['Trueflight'] = set_combine(sets.precast.WS.MABRA, {
		head="Nyame Helm",
		--neck="Sanctity Necklace",
		neck="Scout's Gorget +2",
		ear1="Moonshade Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		--ring1="Ilabrat Ring",
		ring1="Beithir Ring",
		ring2="Dingir Ring",
		back=gear.aug_belenus_ws_agi,
		waist="Eschan Stone",
		--waist=gear.ElementalObi,
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Trueflight'].MidAcc = set_combine(sets.precast.WS['Trueflight'], {
	})
	sets.precast.WS['Trueflight'].HighAcc = set_combine(sets.precast.WS['Trueflight'], {
		head=empty,
		body="Cohort Cloak +1",
	})
	sets.precast.WS['Trueflight'].FullAcc = set_combine(sets.precast.WS['Trueflight'], {
		head=empty,
		body="Cohort Cloak +1",
	})
	
	-------------------------
	-- Archery

	-- 80% DEX, crit chance varies with TP
	sets.precast.WS["Jishnu's Radiance"] = set_combine(sets.precast.WS.RA, {
		head=gear.Adhemar_head_hq_B,
		ear1="Odr Earring",
		body="Meg. Cuirie +2",
		hands="Mummu Wrists +2",
		ring1="Mummu Ring",
		back=gear.aug_belenus_ws_agi,
		--legs="Arc. Braccae +3",
		legs="Jokushu Haidate",
		feet="Arcadian Socks +3",
	})
	sets.precast.WS["Jishnu's Radiance"].MidAcc = set_combine(sets.precast.WS["Jishnu's Radiance"], {
	})
	sets.precast.WS["Jishnu's Radiance"].HighAcc = set_combine(sets.precast.WS["Jishnu's Radiance"], {
	})
	sets.precast.WS["Jishnu's Radiance"].FullAcc = set_combine(sets.precast.WS["Jishnu's Radiance"], {
		head="Orion Beret +3",
	})
	
	-- AGI 50% STR 20%
	sets.precast.WS['Flaming Arrow'] = set_combine(sets.precast.WS.MABRA, {
	})
	sets.precast.WS['Flaming Arrow'].MidAcc = set_combine(sets.precast.WS['Flaming Arrow'], {
	})
	sets.precast.WS['Flaming Arrow'].HighAcc = set_combine(sets.precast.WS['Flaming Arrow'], {
		head=empty,
		body="Cohort Cloak +1",
	})
	sets.precast.WS['Flaming Arrow'].FullAcc = set_combine(sets.precast.WS['Flaming Arrow'], {
		head=empty,
		body="Cohort Cloak +1",
	})

	-- 73~85% AGI
	sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS.RA, {
		neck="Scout's Gorget +2",
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

	-- 40% STR / 40% AGI
	sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS.RA, {
		head="Orion Beret +3",
		neck="Scout's Gorget +2",
		body="Nyame Mail",
		hands="Meg. Gloves +2",
		--ring1="Dingir Ring",
		ring1="Beithir Ring",
		ring2="Regal Ring",
		--back=gear.aug_belenus_ws,
		back=gear.aug_belenus_ws_agi,
		waist="Fotia Belt",
		legs="Arc. Braccae +3",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Namas Arrow'].MidAcc = set_combine(sets.precast.WS['Namas Arrow'], {
	})
	sets.precast.WS['Namas Arrow'].HighAcc = set_combine(sets.precast.WS['Namas Arrow'], {
	})
	sets.precast.WS['Namas Arrow'].FullAcc = set_combine(sets.precast.WS['Namas Arrow'], {
	})
	
	----------------------------
	-- Others
	
	-- 50% MND / 30% STR, No SC elements so Elemental Gorget/Belt wont have an effect
	sets.precast.WS['Sanguine Blade'] = set_combine(sets.precast.WS.MAB, {
		head="Pixie Hairpin +1",
		neck="Sanctity Necklace",
		ear1="Moonshade Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		--ring1="Ilabrat Ring",
		ring1="Beithir Ring",
		ring2="Regal Ring",
		back=gear.aug_belenus_ws,
		waist="Eschan Stone",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Sanguine Blade'].MidAcc = set_combine(sets.precast.WS['Sanguine Blade'], {
	})
	sets.precast.WS['Sanguine Blade'].HighAcc = set_combine(sets.precast.WS['Sanguine Blade'], {
	})
	sets.precast.WS['Sanguine Blade'].FullAcc = set_combine(sets.precast.WS['Sanguine Blade'], {
	})

	-- 50% STR / 50% MND, damage varies with TP
	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
		head="Orion Beret +3",
		neck="Scout's Gorget +2",
		body="Nyame Mail",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		hands="Meg. Gloves +2",
		--ring1="Ilabrat Ring",
		ring1="Beithir Ring",
		ring2="Regal Ring",
		back=gear.aug_belenus_ws,
		waist="Sailfi Belt +1",
		legs="Arc. Braccae +3",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Savage Blade'].MidAcc = set_combine(sets.precast.WS['Savage Blade'], {
	})
	sets.precast.WS['Savage Blade'].HighAcc = set_combine(sets.precast.WS['Savage Blade'], {
	})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS['Savage Blade'], {
	})

	-- 50% DEX, crit rate varies with TP
	sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
		head=gear.Adhemar_head_hq_B,
		body=gear.Adhemar_body_hq_B,
		ear1="Odr Earring",
		ear2="Moonshade Earring",
		hands=gear.Adhemar_hands_hq_B,
		ring1="Mummu Ring",
		ring2="Regal Ring",
		back=gear.aug_belenus_ws,
		legs="Jokushu Haidate",
		feet="Nyame Sollerets",
	})
	sets.precast.WS['Evisceration'].MidAcc = set_combine(sets.precast.WS['Evisceration'], {
	})
	sets.precast.WS['Evisceration'].HighAcc = set_combine(sets.precast.WS['Evisceration'], {
	})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS['Evisceration'], {
	})

	sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Aeolian Edge'].MidAcc = set_combine(sets.precast.WS['Aeolian Edge'], {
	})
	sets.precast.WS['Aeolian Edge'].HighAcc = set_combine(sets.precast.WS['Aeolian Edge'], {
	})
	sets.precast.WS['Aeolian Edge'].FullAcc = set_combine(sets.precast.WS['Aeolian Edge'], {
	})

	-- 50% STR, acc varies with TP
	sets.precast.WS['Decimation'] = set_combine(sets.precast.WS, {
		head=gear.Adhemar_head_hq_B,
		body="Tatena. Harama. +1",
		ear1="Sherida Earring",
		ear2="Brutal Earring",
		hands="Tatena. Gote +1",
		ring1="Regal Ring",
		ring2="Epona's Ring",
		back=gear.aug_belenus_ws,
		legs="Tatena. Haidate +1",
		feet="Mummu Gamash. +2",
	})
	sets.precast.WS['Decimation'].MidAcc = set_combine(sets.precast.WS['Decimation'], {
	})
	sets.precast.WS['Decimation'].HighAcc = set_combine(sets.precast.WS['Decimation'], {
	})
	sets.precast.WS['Decimation'].FullAcc = set_combine(sets.precast.WS['Decimation'], {
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

	-- Gear: 73 STP
	-- Perun +1: 4 STP
	-- Nusku Shield: 3 STP
	-- Gear Total: 80 STP
	-- /war stat:
	-- Base RACC 1428
	-- Base RATK 1436
	sets.midcast.RA = {
		--head="Meghanada Visor +2",
		head="Arcadian Beret +3",
		-- 8 STP
		--neck="Iskur Gorget",
		-- 7 STP
		neck="Scout's Gorget +2",
		-- 5 STP
		ear1="Telos Earring",
		-- 5 STP
		--ear2="Crep. Earring",
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
	
	-- Gear: 71 STP
	-- Perun +1: 4 STP
	-- Nusku Shield: 3 STP
	-- Gear Total: 78 STP
	-- /war stat:
	-- Base RACC 1487
	-- Base RATK 1359
	sets.midcast.RA.MidAcc = set_combine(sets.midcast.RA,{
		ring1="Haverton Ring",
		-- 4 STP
		legs=gear.Herculean_legs_RA,
		-- 9 STP
		feet="Malignance Boots",
	})

	-- Gear: 77 STP
	-- Perun +1: 4 STP
	-- Nusku Shield: 3 STP
	-- Gear Total: 84 STP
	-- /war stat:
	-- Base RACC 1531
	-- Base RATK 1236
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
	-- Base RACC 1642
	-- Base RATK 1367
	sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA,{
		head="Orion Beret +3",
		-- 5 STP
		ear2="Crep. Earring",
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
		head="Meghanada Visor +2",
		ear2="Odr Earring",
		body="Nisroch Jerkin",
		hands="Mummu Wrists +2",
		ring1="Ilabrat Ring",
		ring2="Mummu Ring",
		back=gear.aug_belenus_agi_crit,
		waist="K. Kachina Belt +1",
		legs="Mummu Kecks +2",
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
		head="Nyame Helm",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Nyame Flanchard",
		feet="Orion Socks +3",
	}
	
	sets.noprotect = {ring1="Sheltered Ring"}
	
	sets.idle.Town = set_combine(sets.idle, {
		head="Nyame Helm",
		neck="Scout's Gorget +2",
		ear1="Telos Earring",
		ear2="Crep. Earring",
		--body="Councilor's Garb",
		body="Nisroch Jerkin",
		hands="Nyame Gauntlets",
		ring1="Ilabrat Ring",
		ring2="Regal Ring",
		back=gear.aug_belenus_ws_agi,
		waist="K. Kachina Belt +1",
		legs="Carmine Cuisses +1",
		feet="Nyame Sollerets",
	})
	
	sets.idle.Weak = set_combine(sets.idle,{
	})
	
	sets.idle.Regen = set_combine(sets.idle,{
		head="Meghanada Visor +2",
		body="Meg. Cuirie +2",
		neck="Bathy Choker +1",
		hands="Meg. Gloves +2",
		ring1="Sheltered Ring",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
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

	-- DT: 54%
	sets.DT = set_combine({
		-- DT 7%
		head="Nyame Helm",
		-- DT 6%
		neck="Loricate Torque +1",
		-- DT 9%
		body="Nyame Mail",
		-- DT 7%
		hands="Nyame Gauntlets",
		-- DT 10%
		ring2="Defending Ring",
		-- DT 8%
		legs="Nyame Flanchard",
		-- DT 7%
		feet="Nyame Sollerets",
	})

	sets.defense.PDT = set_combine(sets.idle, sets.DT,{
	})

	sets.defense.MDT = set_combine(sets.idle, sets.DT,{
	})

	sets.Kiting = {feet="Orion Socks +3",}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = set_combine(sets.idle,{
		feet="Orion Socks +3",
	})
	
	sets.engaged.Melee = set_combine(sets.engaged,{
		head=gear.Adhemar_head_hq_B,
		neck="Asperity Necklace",
		ear1="Sherida Earring",
		ear2="Brutal Earring",
		body=gear.Adhemar_body_hq_B,
		hands=gear.Adhemar_hands_hq_B,
		ring1="Petrov Ring",
		ring2="Epona's Ring",
		back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		legs="Tatena. Haidate +1",
		feet="Tatena. Sune. +1",
	})
	
	sets.engaged.MeleeMidAcc = set_combine(sets.engaged.Melee,{
		ring2="Cacoethic Ring +1",
	})

	sets.engaged.MeleeHighAcc = set_combine(sets.engaged.Melee,{
		head="Malignance Chapeau",
		neck="Subtlety Spec.",
		ear1="Telos Earring",
		ear2="Crep. Earring",
		ring1="Cacoethic Ring +1",
		legs="Tatena. Haidate +1",
	})

	sets.engaged.MeleeFullAcc = set_combine(sets.engaged.Melee,{
		head="Malignance Chapeau",
		neck="Subtlety Spec.",
		ear1="Telos Earring",
		ear2="Crep. Earring",
		body="Tatena. Harama. +1",
		hands="Tatena. Gote +1",
		ring1="Cacoethic Ring +1",
		ring2="Patricius Ring",
		waist="Eschan Stone",
		legs="Tatena. Haidate +1",
		feet="Tatena. Sune. +1",
	})

	sets.engaged.DT = set_combine(sets.engaged.Melee,{
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

	-- Haste Mode used when Dual Wielding. See job_buff_change() below for specific conditions
	-- /NIN, Dual Wield 3, 49DW needed to cap
	-- /DNC, Dual Wield 2, 59DW needed to cap (57DW with Haste Samba)
	sets.engaged.Melee.Haste_0 = set_combine(sets.engaged.Melee,{
		-- 5
		ear1="Suppanomimi",
		-- 6
		body=gear.Adhemar_body_hq_B,
		-- 6
		ring1="Haverton Ring",
		-- 6
		legs=gear.Carmine_legs_hq_D,
	})
	-- /NIN, Dual Wield 3, 42DW needed to cap
	-- /DNC, Dual Wield 2, 52DW needed to cap (45DW with Haste Samba)
	sets.engaged.Melee.Haste_15 = set_combine(sets.engaged.Melee,{
		-- 5
		ear1="Suppanomimi",
		-- 6
		body=gear.Adhemar_body_hq_B,
		-- 6
		ring1="Haverton Ring",
		-- 6
		legs=gear.Carmine_legs_hq_D,
	})
	-- /NIN, Dual Wield 3, 31DW needed to cap
	-- /DNC, Dual Wield 2, 41DW needed to cap (35DW with Haste Samba)
	sets.engaged.Melee.Haste_30 = set_combine(sets.engaged.Melee,{
		-- 5
		ear1="Suppanomimi",
		-- 6
		body=gear.Adhemar_body_hq_B,
		-- 6
		ring1="Haverton Ring",
		-- 6
		legs=gear.Carmine_legs_hq_D,
	})
	-- /NIN, Dual Wield 3, 26DW needed to cap
	-- /DNC, Dual Wield 2, 36DW(?) needed to cap (29DW? with Haste Samba)
	sets.engaged.Melee.Haste_35 = set_combine(sets.engaged.Melee,{
		-- 5
		ear1="Suppanomimi",
		-- 6
		body=gear.Adhemar_body_hq_B,
		-- 6
		ring1="Haverton Ring",
		-- 6
		legs=gear.Carmine_legs_hq_D,
	})
	-- /NIN, Dual Wield 3, 11DW needed to cap
	-- /DNC, Dual Wield 2, 21DW needed to cap (9DW with Haste Samba)
	sets.engaged.Melee.MaxHaste = set_combine(sets.engaged.Melee,{
		ear1="Suppanomimi",
		ring1="Haverton Ring",
	})

	sets.engaged.MeleeMidAcc.Haste_0 = set_combine(sets.engaged.MeleeMidAcc,{
		-- 5
		ear1="Suppanomimi",
		-- 6
		body=gear.Adhemar_body_hq_B,
		-- 6
		ring1="Haverton Ring",
		-- 6
		legs=gear.Carmine_legs_hq_D,
	})
	sets.engaged.MeleeMidAcc.Haste_15 = set_combine(sets.engaged.MeleeMidAcc,{
		-- 5
		ear1="Suppanomimi",
		-- 6
		body=gear.Adhemar_body_hq_B,
		-- 6
		ring1="Haverton Ring",
		-- 6
		legs=gear.Carmine_legs_hq_D,
	})
	sets.engaged.MeleeMidAcc.Haste_30 = set_combine(sets.engaged.MeleeMidAcc,{
		-- 5
		ear1="Suppanomimi",
		-- 6
		body=gear.Adhemar_body_hq_B,
		-- 6
		ring1="Haverton Ring",
		-- 6
		legs=gear.Carmine_legs_hq_D,
	})
	sets.engaged.MeleeMidAcc.Haste_35 = set_combine(sets.engaged.MeleeMidAcc,{
		-- 5
		ear1="Suppanomimi",
		-- 6
		body=gear.Adhemar_body_hq_B,
		-- 6
		ring1="Haverton Ring",
		-- 6
		legs=gear.Carmine_legs_hq_D,
	})
	sets.engaged.MeleeMidAcc.MaxHaste = set_combine(sets.engaged.MeleeMidAcc,{
		ear1="Suppanomimi",
		ring1="Haverton Ring",
	})

	sets.engaged.MeleeHighAcc.Haste_0 = set_combine(sets.engaged.MeleeHighAcc,{
		-- 5
		ear1="Suppanomimi",
		-- 6
		body=gear.Adhemar_body_hq_B,
		-- 6
		ring1="Haverton Ring",
		-- 6
		legs=gear.Carmine_legs_hq_D,
	})
	sets.engaged.MeleeHighAcc.Haste_15 = set_combine(sets.engaged.MeleeHighAcc,{
		-- 5
		ear1="Suppanomimi",
		-- 6
		body=gear.Adhemar_body_hq_B,
		-- 6
		ring1="Haverton Ring",
		-- 6
		legs=gear.Carmine_legs_hq_D,
	})
	sets.engaged.MeleeHighAcc.Haste_30 = set_combine(sets.engaged.MeleeHighAcc,{
		-- 5
		ear1="Suppanomimi",
		-- 6
		body=gear.Adhemar_body_hq_B,
		-- 6
		ring1="Haverton Ring",
		-- 6
		legs=gear.Carmine_legs_hq_D,
	})
	sets.engaged.MeleeHighAcc.Haste_35 = set_combine(sets.engaged.MeleeHighAcc,{
		-- 5
		ear1="Suppanomimi",
		-- 6
		body=gear.Adhemar_body_hq_B,
		-- 6
		ring1="Haverton Ring",
		-- 6
		legs=gear.Carmine_legs_hq_D,
	})
	sets.engaged.MeleeHighAcc.MaxHaste = set_combine(sets.engaged.MeleeHighAcc,{
		ear1="Suppanomimi",
		ring1="Haverton Ring",
	})

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = set_combine(sets.midcast.RA.FullAcc, {
		head="Meghanada Visor +2",
		ear1="Telos Earring",
		ear2="Crep. Earring",
		neck="Scout's Gorget +2",
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
	sets.buff.ArmaAftermath = set_combine(sets.midcast.RA.Crit, {
		legs="Darraigner's Brais",
	})
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

	if state.TreasureMode.value ~= false then
		equip(sets.sharedTH)
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
		if state.TreasureMode.current == 'on' then
			equip(sets.sharedTH)
		end
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	if buff == "Camouflage" then
		if gain then
			equip(sets.buff.Camouflage)
			disable('body')
		else
			enable('body')
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
		else
			add_to_chat(8, '-------------Haste 0%-------------')
			classes.CustomMeleeGroups:append('Haste_0')
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
		else
			add_to_chat(8, '-------------Haste 0%-------------')
			classes.CustomMeleeGroups:append('Haste_0')
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
		meleeSet = set_combine(meleeSet, sets.sharedTH)
	end

	return meleeSet
end
