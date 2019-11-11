--------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
	state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.RangedMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.HybridMode:options('Normal', 'PDT', 'MDT', 'Reraise')
	state.WeaponskillMode:options('Normal', 'MidAcc', 'HighAcc', 'FullAcc')
	state.PhysicalDefenseMode:options('PDT', 'Reraise')
	state.MagicalDefenseMode:options('MDT', 'Reraise')
	state.IdleMode:options('CP', 'Normal', 'Regen', 'Reraise')
	
	gear.Smertrio_STP = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Store TP"+10','Damage taken-5%',}}
	gear.Smertrio_STP_DEX = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Damage taken-5%',}}
	gear.Smertrio_WS = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
	
	update_combat_form()

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
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	
	select_default_macro_book()

	global_aliases()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
	send_command('unbind ^`')
	send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
	-- Precast sets to enhance JAs
	sets.precast.JA.Meditate = {
		head="Wakido kabuto +3",
		hands="Sakonji Kote +1",
		back="Smertrios's Mantle"
	}
	sets.precast.JA['Warding Circle'] = {head="Wakido kabuto +3"}
	sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +1"}
	sets.precast.JA['Hasso'] = {feet="Wakido Sune. +3"}
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
		head="Wakido kabuto +3",
		body="Dagon Breastplate",
		hands="Wakido Kote +3",
		back="Tantalic Cape",
		waist="Flume Belt +1",
		legs="Wakido Haidate +3",
		feet="Wakido Sune. +3"
	}
	    
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
	
	-- Sets for fast cast gear for spells
	sets.precast.FC = {
		-- 4% FC
		neck="Voltsurge Torque",
		-- 2%
		ear1="Loquac. Earring",
		-- 1%
		ear2="Etiolation Earring",
		hands="Leyline Gloves",
		-- 2%
		ring1="Prolix Ring",
		legs="Limbo Trousers"
	}
	
	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		ring1="Haverton Ring"
	}
	   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Knobkierrie",
		head=gear.Rao_head_hq_B,
		neck="Fotia Gorget",
		ear1="Ishvara Earring",
		ear2="Moonshade Earring",
		body="Sakonji Domaru +3",
		--hands=gear.Valorous_hand_TP,
		hands="Wakido Kote +3",
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.Smertrio_WS,
		waist="Fotia Belt",
		legs="Wakido Haidate +3",
		feet=gear.Valorous_feet_WS,
	}
	sets.precast.WS.MidAcc = set_combine(sets.precast.WS, {
	})
	sets.precast.WS.HighAcc = set_combine(sets.precast.WS, {
		feet="Wakido Sune. +3"
	})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {
		--neck="Subtlety Spec.",
		hands="Wakido Kote +3",
		waist="Grunfeld Rope",
		legs="Wakido Haidate +3",
		--feet="Flam. Gambieras +1"
		--feet=gear.Rao_feet_hq_B,
		feet="Wakido Sune. +3",
	})
	sets.precast.WS.MAB = set_combine(sets.precast.WS, {
		head=gear.Valorous_head_Magic,
		--neck="Sanctity Necklace",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		body="Found. Breastplate",
		hands="Leyline Gloves",
		ring1="Acumen Ring",
		back=gear.Smertrio_WS,
		legs="Wakido Haidate +3",
		--feet="Founder's Greaves"
		feet=gear.Valorous_feet_WS,
	})
	sets.precast.RA = set_combine(sets.precast.WS,{
		ear1="Telos Earring",
		ear2="Moonshade Earring",
		--body="Kyujutsugi",
		body="Sakonji Domaru +3",
		hands="Kobo Kote",
		ring1="Garuda Ring +1",
		ring2="Garuda Ring +1",
		legs="Wakido Haidate +3",
		feet="Wakido Sune. +3"
	})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	-- 80% STR (1-hit)
	sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {
		body="Sakonji Domaru +3",
		hands="Wakido Kote +3",
		waist="Metalsinger Belt"
	})
	sets.precast.WS['Tachi: Fudo'].MidAcc = set_combine(sets.precast.WS['Tachi: Fudo'], {
	  body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Fudo'].HighAcc = set_combine(sets.precast.WS['Tachi: Fudo'], {
		body="Sakonji Domaru +3",
		waist="Fotia Belt",
	})
	sets.precast.WS['Tachi: Fudo'].FullAcc = set_combine(sets.precast.WS['Tachi: Fudo'], {
		body="Sakonji Domaru +3",
		hands="Wakido Kote +3",
		waist="Grunfeld Rope"
	})
	
	-- 73-85% STR (2-hit)
	sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Tachi: Shoha'].MidAcc = set_combine(sets.precast.WS['Tachi: Shoha'], {
	})
	sets.precast.WS['Tachi: Shoha'].HighAcc = set_combine(sets.precast.WS['Tachi: Shoa'], {
		body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Shoha'].FullAcc = set_combine(sets.precast.WS['Tachi: Shoa'], {
		body="Sakonji Domaru +3",
		hands="Wakido Kote +3",
		waist="Grunfeld Rope"
	})
	
	-- 50% STR (3-hit)
	sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {
	})
	sets.precast.WS['Tachi: Rana'].MidAcc = set_combine(sets.precast.WS['Tachi: Rana'], {
	})
	sets.precast.WS['Tachi: Rana'].HighAcc = set_combine(sets.precast.WS['Tachi: Rana'], {
		body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Rana'].FullAcc = set_combine(sets.precast.WS['Tachi: Rana'], {
		body="Sakonji Domaru +3",
		hands="Wakido Kote +3",
		waist="Grunfeld Rope"
	})
	
	-- 75% STR (1-hit)
	sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {
		body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Kasha'].MidAcc = set_combine(sets.precast.WS['Tachi: Kasha'], {
		body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Kasha'].HighAcc = set_combine(sets.precast.WS['Tachi: Kasha'], {
		body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Kasha'].FullAcc = set_combine(sets.precast.WS['Tachi: Kasha'], {
		body="Sakonji Domaru +3",
		hands="Wakido Kote +3",
		waist="Grunfeld Rope"
	})
	
	-- 75% STR (1-hit)
	sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {
		body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Gekko'].MidAcc = set_combine(sets.precast.WS['Tachi: Gekko'], {
		body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Gekko'].HighAcc = set_combine(sets.precast.WS['Tachi: Gekko'], {
		body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Gekko'].FullAcc = set_combine(sets.precast.WS['Tachi: Gekko'], {
		body="Sakonji Domaru +3",
		hands="Wakido Kote +3",
		waist="Grunfeld Rope"
	})
	
	-- 75% STR (1-hit)
	sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {
		body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Yukikaze'].MidAcc = set_combine(sets.precast.WS['Tachi: Yukikaze'], {
		body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Yukikaze'].HighAcc = set_combine(sets.precast.WS['Tachi: Yukikaze'], {
		body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Yukikaze'].FullAcc = set_combine(sets.precast.WS['Tachi: Yukikaze'], {
		body="Sakonji Domaru +3",
		hands="Wakido Kote +3",
		waist="Grunfeld Rope"
	})
	
	-- 40% STR 60% CHR (1-hit)
	sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {
		body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Ageha'].MidAcc = set_combine(sets.precast.WS['Tachi: Ageha'], {
		body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Ageha'].HighAcc = set_combine(sets.precast.WS['Tachi: Ageha'], {
		body="Sakonji Domaru +3",
	})
	sets.precast.WS['Tachi: Ageha'].FullAcc = set_combine(sets.precast.WS['Tachi: Ageha'], {
		body="Sakonji Domaru +3",
		hands="Wakido Kote +3",
		waist="Grunfeld Rope"
	})
	
	-- Magical WS
	sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Tachi: Goten'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Tachi: Kagero'] = set_combine(sets.precast.WS.MAB, {
	})
	sets.precast.WS['Tachi: Koki'] = set_combine(sets.precast.WS.MAB, {
	})
	
	-- Ranged WS
	-- 50% AGI 20% STR
	sets.precast.WS['Flaming Arrow'] = set_combine(sets.precast.WS.MAB, {
	})
	-- 50% AGI 20% STR
	sets.precast.WS['Sidewinder'] = set_combine(sets.precast.WS.RA, {
	})
	sets.precast.WS['Sidewinder'].MidAcc = set_combine(sets.precast.WS['Sidewinder'], {
	})
	sets.precast.WS['Sidewinder'].HighAcc = set_combine(sets.precast.WS['Sidewinder'], {
	})
	sets.precast.WS['Sidewinder'].FullAcc = set_combine(sets.precast.WS['Sidewinder'], {
	})
	-- 60% STR
	sets.precast.WS['Refulgent Arrow'] = set_combine(sets.precast.WS.RA, {
	})
	sets.precast.WS['Refulgent Arrow'].MidAcc = set_combine(sets.precast.WS['Refulgent Arrow'], {
	})
	sets.precast.WS['Refulgent Arrow'].HighAcc = set_combine(sets.precast.WS['Refulgent Arrow'], {
	})
	sets.precast.WS['Refulgent Arrow'].FullAcc = set_combine(sets.precast.WS['Refulgent Arrow'], {
	})
	-- 73%-85% AGI
	sets.precast.WS['Apex Arrow'] = set_combine(sets.precast.WS.RA, {
	})
	sets.precast.WS['Apex Arrow'].MidAcc = set_combine(sets.precast.WS['Apex Arrow'], {
	})
	sets.precast.WS['Apex Arrow'].HighAcc = set_combine(sets.precast.WS['Apex Arrow'], {
	})
	sets.precast.WS['Apex Arrow'].FullAcc = set_combine(sets.precast.WS['Apex Arrow'], {
	})
	-- 40% STR 40% AGI
	sets.precast.WS['Namas Arrow'] = set_combine(sets.precast.WS.RA, {
		ear1="Vulcan's Pearl",
		ear2="Vulcan's Pearl",
		ring1="Ilabrat Ring",
		ring2="Regal Ring"
	})
	sets.precast.WS['Namas Arrow'].MidAcc = set_combine(sets.precast.WS['Namas Arrow'], {
	})
	sets.precast.WS['Namas Arrow'].HighAcc = set_combine(sets.precast.WS['Namas Arrow'], {
		ear1="Telos Earring",
		ear2="Enervating Earring",
	})
	sets.precast.WS['Namas Arrow'].FullAcc = set_combine(sets.precast.WS['Namas Arrow'], {
		ear1="Telos Earring",
		ear2="Enervating Earring",
	})
	
	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
	sets.midcast.FastRecast = set_combine(sets.precast.FC,{
		head="Rao Kabuto +1",
		body="Tartarus Platemail",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		feet="Amm Greaves"
	})
	
	sets.midcast.RA = {
		head=gear.Rao_head_hq_B,
		neck="Marked Gorget",
		ear1="Telos Earring",
		ear2="Enervating Earring",
		body="Ken. Samue",
		hands="Kobo Kote",
		ring1="Ilabrat Ring",
		ring2="Garuda Ring +1",
		back=gear.Smertrio_STP,
		waist="Yemaya Belt",
		legs="Ken. Hakama",
		feet="Wakido Sune. +3"
	}
	
	sets.midcast.RA.MidAcc = set_combine(sets.midcast.RA,{
		ring1="Haverton Ring",
		ring2="Cacoethic Ring +1"
	})
  
	sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA,{
		ring1="Haverton Ring",
		ring2="Cacoethic Ring +1"
	})
	
	sets.midcast.RA.FullAcc = set_combine(sets.midcast.RA,{
		neck="Marked Gorget",
		ring1="Haverton Ring",
		ring2="Cacoethic Ring +1"
	})
	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {
		head="Rao Kabuto +1",
		neck="Bathy Choker +1",
		body="Hiza. Haramaki +2",
		ring1="Sheltered Ring"
	}
	
	-- Idle sets
	
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Loess Barbuta +1",
		neck="Loricate Torque +1",
		ear1="Odnowa Earring +1",
		ear2="Etiolation Earring",
		body="Tartarus Platemail",
		hands="Sakonji Kote +1",
		ring1="Dark Ring",
		ring2="Defending Ring",
		back="Moonbeam Cape",
		waist="Flume Belt +1",
		legs="Valorous Hose",
		feet="Danzo Sune-ate"
	}
	
	sets.noprotect = {ring1="Sheltered Ring"}
	
	sets.idle.Town = set_combine(sets.idle,{
		ammo="Knobkierrie",
		head="Rao Kabuto +1",
		neck="Moonbeam Nodowa",
		--body="Councilor's Garb"
		body="Dagon Breastplate",
		hands="Wakido Kote +3",
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		back=gear.Smertrio_WS,
		legs="Wakido Haidate +3",
		--feet="Rao Sune-Ate +1",
	})
	
	sets.idle.Weak = set_combine(sets.idle,{
		head="Twilight Helm",
		body="Twilight Mail",
	})
	
	sets.idle.Regen = set_combine(sets.idle,{
		head="Rao Kabuto +1",
		neck="Bathy Choker +1",
		body="Hiza. Haramaki +2",
		ring1="Sheltered Ring",
		feet="Rao Sune-Ate +1",
	})
	
	-- Defense sets

	-- 42% DT 52% PDT 52% MDT 12 MDB (48% DT if using Khonsu)
	sets.defense.DT = set_combine(sets.idle,{
		-- 6& DT
		sub="Khonsu",
		-- 2% DT
		ammo="Staunch Tathlum +1",
		-- 10% DT
		head="Loess Barbuta +1",
		-- 2% MDT
		ear1="Odnowa Earring +1",
		-- 3% MDT
		ear2="Etiolation Earring",
		-- 6% DT
		neck="Loricate Torque +1",
		-- 10% DT 6 MDB
		body="Tartarus Platemail",
		-- 4% PDT 1 MDB
		hands="Sakonji Kote +1",
		--ring1="Niqmaddu Ring",
		-- 5% PDT 5% MDT
		ring1="Dark Ring",
		-- 10% DT
		ring2="Defending Ring",
		-- 5% DT
		back=gear.Smertrio_STP,
		-- 2% PDT 3 MDB
		legs="Valorous Hose",
		-- 4% DT 2 MDB
		feet="Amm Greaves"
	})

	sets.defense.PDT = set_combine(sets.defense.DT,{
	})
	
	sets.defense.Reraise = {
		head="Twilight Helm",
		body="Twilight Mail"
	}
	
	sets.defense.MDT = set_combine(sets.defense.DT,{
		--neck="Inq. Bead Necklace",
		hands="Leyline Gloves",
		ring1="Shadow Ring",
	})
	
	sets.Kiting = {feet="Danzo Sune-ate"}
	
	sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	
	-- Engaged sets
	
	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- TP/hit = floor( Base TP/hit × (100 + Store TP Total)÷100 , 1)
	-- Delay: 450
	-- Base TP/hit for Delay 176~530: floor(17+(Delay×489÷2000)) = floor((450x489/2000) +17) = 127
	--
	-- Delay 450 5 hit: 58 Total Store TP
	-- 200 = floor( 127 × (100 + 58)÷100 , 1)
	-- 200 x 5 = 1000
	-- 
	-- Delay 450 4 hit: 97 Total Store TP
	-- 250 = floor( 127 × (100 + 97)÷100 , 1)
	-- 250 x 4 = 1000
	--
	-- With 164 (25 Save TP)
	-- 209 = floor( 127 × (100 + 65)÷100 , 1)
	-- 209 x 4 + 164 (25 Save Tp) = 1000
	-- 279 = floor( 127 × (100 + 120)÷100 , 1)
	-- 279 x 3 + 164 (25 Save Tp) = 1000
	--
	-- Delay 450 3 hit: 163 Total Store TP
	-- 334 = floor( 127 × (100 + 163)÷100 , 1)
	-- 334 x 3 = 1002
	--
	-- Delay 450 2 hit: 294 Total Store TP
	-- 500 = floor( 127 × (100 + 294)÷100 , 1)
	-- 500 x 2 = 1000
	--
	-- Store TP Breakdown
	-- Trait: 30 (SAM Lv.90)
	-- Merit: 10 (5 x 2 STP)
	-- SAM Roll: Lucky (2) 32 STP, Eleven 40 STP, Unlucky (6) 4 STP
	-- Gifts: 8 (4 x 2 STP)
	--
	-- Gear STP needed for 5 hit:
	-- No SAM Roll: 58 - 48 = 10 STP
	-- Lucky: 58 - 48 - 32 = 0 (-30)
	-- Eleven: 58 - 48 - 40 = 0 (-38)
	-- Unlucky: 58 - 48 - 4 = 6 STP
	--
	-- Gear STP needed for 4 hit:
	-- No SAM Roll: 97 - 48 = 49 STP
	-- Lucky: 97 - 48 - 32 = 17 STP
	-- Eleven: 97 - 48 - 40 = 9 STP
	-- Unlucky: 97 - 48 - 4 = 45 STP
	--
	-- Gear STP needed for 3 hit:
	-- No SAM Roll: 163 - 48 = 115 STP
	-- Lucky: 163 - 48 - 32 = 83 STP
	-- Eleven: 163 - 48 - 40 = 75 STP
	-- Unlucky: 163 - 48 - 4 = 111 STP
	--
	-- Gear STP needed for 2 hit:
	-- No SAM Roll: 294 - 48 = 246 STP
	-- Lucky: 294 - 48 - 32 = 214 STP
	-- Eleven: 294 - 48 - 40 = 206 STP
	-- Unlucky: 294 - 48 - 4 = 242 STP

	-- Normal melee group
	
	-- Delay 450 GK, 25 Save TP (Tsurumaru) => 65 Store TP for a 5-hit (25 Store TP in gear), 120 Store TP for a 4-hit (55 Store TP in gear)
	--
	-- Delay 450 GK => 5-hit (34 Store TP in gear/SAM Roll), 4-hit (78 Store TP in gear/SAM Roll), 3-hit (151 STP in gear/SAM Roll)
	-- Delay 494~496 => 10 STP gear/Sam Roll (5-hit), 47 STP gear/SAM Roll (4-hit), 110 STP gear/SAM Roll (3-hit)
	--
	-- SAM Roll: Lucky (2) 32 STP, Eleven 40 STP, Unlucky (6) 4 STP
	--
	-- 35 gear STP + 10 (Dojikiri Yasutsuna) = total: 45
	-- Must use Duplus Grip
	--
	-- Gear Haste: 24%
	-- JA Haste (Hasso): 10 base + 9 gear = 19%
	-- (Hasso Gear does stack! - http://www.ffxiah.com/forum/topic/50068/does-hasso-gear-stack-now/#3211713) - Only Wakido Kote +1 and Unkai Haidate +2 didn't stack
	-- http://www.ffxiah.com/forum/topic/41903/bushido-the-way-of-the-samurai-a-guide-v-20/49#2866879
	--
	sets.engaged = {
		-- 3 STP
		ammo="Ginsen",
		-- 5 STP 4%
		head="Flam. Zucchetto +2",
		neck="Ganesha's Mala",
		ear1="Trux Earring",
		-- 1 STP
		ear2="Brutal Earring",
		-- 12 STP 3%
		--body="Kasuga Domaru +1",
		-- 1%
		body="Dagon Breastplate",
		-- 7 STP 4% Hasso +4
		hands="Wakido Kote +3",
		ring1="Niqmaddu Ring",
		-- 5 STP
		--ring2="Rajas Ring",
		ring2="Hetairoi Ring",
		-- 10 STP
		back=gear.Smertrio_STP,
		-- 7%
		waist="Ioskeha Belt",
		-- 9 STP 5% Hasso +3
		legs="Kasuga Haidate +1",
		-- 5 STP 2%
		--feet="Flam. Gambieras +1",
		-- 3% Hasso +2
		feet="Wakido Sune. +3",
	}
	-- 40 gear STP + 10 (Dojikiri Yasutsuna) = total: 50
	-- Must use Utu Grip
	--
	-- Gear Haste: 24%
	-- JA Haste (Hasso): 10 base + 6 gear = 16%
	sets.engaged.MidAcc = set_combine(sets.engaged,{
		-- 3 STP
		ammo="Ginsen",
		-- 5 STP 4%
		head="Flam. Zucchetto +2",
		neck="Ganesha's Mala",
		ear1="Trux Earring",
		-- 1 STP
		ear2="Brutal Earring",
		-- 1%
		body="Dagon Breastplate",
		-- 7 STP 4% Hasso +4
		hands="Wakido Kote +3",
		ring1="Niqmaddu Ring",
		ring2="Hetairoi Ring",
		-- 10 STP
		back=gear.Smertrio_STP,
		-- 7%
		waist="Ioskeha Belt",
		-- 9 STP 5%
		legs="Wakido Haidate +3",
		-- 3% Hasso +2
		feet="Wakido Sune. +3",
	})
	-- 48 gear STP + 10 (Dojikiri Yasutsuna) = total: 58
	-- Must use Utu Grip
	--
	-- Gear Haste: 27%
	-- JA Haste (Hasso): 10 base + 6 gear = 16%
	sets.engaged.HighAcc = set_combine(sets.engaged,{
		-- 3 STP
		ammo="Ginsen",
		-- 5 STP 4%
		head="Flam. Zucchetto +2",
		-- 8 STP
		neck="Moonbeam Nodowa",
		-- 5 STP
		ear1="Telos Earring",
		-- 1 STP
		ear2="Brutal Earring",
		-- 1%
		--body="Dagon Breastplate",
		-- 4%
		body="Ken. Samue",
		--hands=gear.Ryuo_hands_D,
		-- 7 STP 4% Hasso +4
		hands="Wakido Kote +3",
		ring1="Niqmaddu Ring",
		-- 5 STP
		--ring2="Ilabrat Ring",
		ring2="Regal Ring",
		-- 10 STP
		back=gear.Smertrio_STP_DEX,
		-- 7%
		--waist="Ioskeha Belt",
		waist="Windbuffet Belt +1",
		-- 9 STP 5%
		--legs="Wakido Haidate +3",
		-- 9%
		legs="Ken. Hakama",
		-- 5 STP 2%
		--feet="Flam. Gambieras +1",
		-- 3% Hasso +2
		feet="Wakido Sune. +3",
	})
	-- 42 gear STP + 10 (Dojikiri Yasutsuna) = total: 52
	-- Must use Utu Grip
	--
	-- Gear Haste: 27%
	-- JA Haste (Hasso): 10 base + 6 gear = 16%
	sets.engaged.FullAcc = set_combine(sets.engaged,{
		-- 3 STP
		ammo="Ginsen",
		-- 7%
		head="Wakido kabuto +3",
		-- 8 STP
		neck="Moonbeam Nodowa",
		-- 5 STP
		ear1="Telos Earring",
		ear2="Digni. Earring",
		-- 1%
		body="Dagon Breastplate",
		--hands=gear.Ryuo_hands_D,
		-- 7 STP 4% Hasso +4
		hands="Wakido Kote +3",
		-- 10 STP
		back=gear.Smertrio_STP_DEX,
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		-- 7%
		waist="Ioskeha Belt",
		-- 9 STP 5%
		legs="Wakido Haidate +3",
		-- 5 STP
		--feet=gear.Valorous_feet_TP,
		--feet=gear.Rao_feet_hq_B,
		-- 3% Hasso +2
		feet="Wakido Sune. +3",
	})
	sets.engaged.PDT = set_combine(sets.engaged,sets.defense.PDT,{
	})
	sets.engaged.MidAcc.PDT = set_combine(sets.engaged,MidAcc,sets.defense.PDT,{
	})
	sets.engaged.HighAcc.PDT = set_combine(sets.engaged,HighAcc,sets.defense.PDT,{
	})
	sets.engaged.FullAcc.PDT = set_combine(sets.engaged,FullAcc,sets.defense.PDT,{
	})
	sets.engaged.MDT = set_combine(sets.engaged,sets.defense.MDT,{
	})
	sets.engaged.MidAcc.MDT = set_combine(sets.engaged,MidAcc,sets.defense.MDT,{
		ring1="Patricius Ring",
		legs=gear.Valorous_legs_TP,
	})
	sets.engaged.HighAcc.MDT = set_combine(sets.engaged,HighAcc,{
		head="Founder's Corona",
		ring1="Patricius Ring",
		legs=gear.Valorous_legs_TP,
	})
	sets.engaged.FullAcc.MDT = set_combine(sets.engaged,FullAcc,{
		head="Founder's Corona",
		ring1="Patricius Ring",
		legs=gear.Valorous_legs_TP,
	})
	sets.engaged.Reraise = set_combine(sets.engaged,{
		head="Twilight Helm",
		body="Twilight Mail"
	})
	sets.engaged.MidAcc.Reraise = set_combine(sets.engaged.MidAcc,{
		head="Twilight Helm",
		body="Twilight Mail"
	})
	sets.engaged.HighAcc.Reraise = set_combine(sets.engaged.HighAcc,{
		head="Twilight Helm",
		body="Twilight Mail"
	})
	sets.engaged.FullAcc.Reraise = set_combine(sets.engaged.FullAcc,{
		head="Twilight Helm",
		body="Twilight Mail"
	})
	    
	-- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
	-- Delay 450 GK, 25 Save TP (Tsurumaru) + 10 Save TP (Ionis) => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
	-- Delay 450 GK => 5-hit (34 Store TP in gear/SAM Roll), 4-hit (78 Store TP in gear/SAM Roll)
	-- SAM Roll: Lucky (2) 32 STP, Eleven 40 STP, Unlucky (6) 4 STP
	sets.engaged.Adoulin = set_combine(sets.engaged,{
	})
	sets.engaged.Adoulin.MidAcc = set_combine(sets.engaged.MidAcc,{
	})
	sets.engaged.Adoulin.HighAcc = set_combine(sets.engaged.HighAcc,{
	})
	sets.engaged.Adoulin.FullAcc = set_combine(sets.engaged.FullAcc,{
	})
	sets.engaged.Adoulin.PDT = set_combine(sets.engaged.PDT,{
	})
	sets.engaged.Adoulin.MidAcc.PDT = set_combine(sets.engaged.MidAcc.PDT,{
	})
	sets.engaged.Adoulin.HighAcc.PDT = set_combine(sets.engaged.HighAcc.PDT,{
	})
	sets.engaged.Adoulin.FullAcc.PDT = set_combine(sets.engaged.FullAcc.PDT,{
	})
	sets.engaged.Adoulin.MDT = set_combine(sets.engaged.MDT,{
	})
	sets.engaged.Adoulin.MidAcc.MDT = set_combine(sets.engaged.MidAcc.MDT,{
	})
	sets.engaged.Adoulin.HighAcc.MDT = set_combine(sets.engaged.HighAcc.MDT,{
	})
	sets.engaged.Adoulin.FullAcc.MDT = set_combine(sets.engaged.FullAcc.MDT,{
	})
	sets.engaged.Adoulin.Reraise = set_combine(sets.engaged.Reraise,{
	})
	sets.engaged.Adoulin.MidAcc.Reraise = set_combine(sets.engaged.MidAcc.Reraise,{
	})
	sets.engaged.Adoulin.HighAcc.Reraise = set_combine(sets.engaged.HighAcc.Reraise,{
	})
	sets.engaged.Adoulin.FullAcc.Reraise = set_combine(sets.engaged.FullAcc.Reraise,{
	})
	
	sets.buff.Sekkanoki = {hands="Kasuga Kote +1"}
	sets.buff.Sengikori = {hands="Kas. Sune-Ate +1"}
	sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate"}
	sets.buff.Doom = {
		waist="Gishdubar Sash",
	}
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
	if areas.Adoulin:contains(world.area) and buffactive.ionis then
		state.CombatForm:set('Adoulin')
	else
		state.CombatForm:reset()
	end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(1, 17)
	elseif player.sub_job == 'DNC' then
		set_macro_page(2, 17)
	elseif player.sub_job == 'THF' then
		set_macro_page(3, 17)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 17)
	elseif player.sub_job == 'RUN' then
		set_macro_page(5, 17)
	else
		set_macro_page(1, 17)
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