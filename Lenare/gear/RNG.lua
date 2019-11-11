function user_setup()
	state.OffenseMode:options('Normal', 'Acc', 'Melee')
  state.RangedMode:options('Normal', 'Acc')
  state.WeaponskillMode:options('Normal', 'Acc')
  
  gear.default.weaponskill_neck = "Ocachi Gorget"
  gear.default.weaponskill_waist = "Elanid Belt"
  gear.AugLutianSnapshot = {
		name="Lutian Cape",
		augments={
			"STR+4",
			"AGI+1",
			"Store TP+1",
			"Snapshot+3"
		}
	}
	gear.AugLutianAGI = {
		name="Lutian Cape",
		augments={
			"STR+3",
			"AGI+4",
			"Store TP+1",
			"Snapshot+2"
		}
	}
  
  DefaultAmmo = {['Yoichinoyumi'] = "Achiyalabopa arrow", ['Annihilator'] = "Achiyalabopa bullet"}
  U_Shot_Ammo = {['Yoichinoyumi'] = "Achiyalabopa arrow", ['Annihilator'] = "Achiyalabopa bullet"}

  --select_default_macro_book()

  send_command('bind f9 gs c cycle RangedMode')
  send_command('bind ^f9 gs c cycle OffenseMode')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
  send_command('unbind f9')
  send_command('unbind ^f9')
end

-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA['Bounty Shot'] = {hands="Sylvan Glovelettes +2"}
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +1"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}
	sets.precast.JA['Eagle Eye Shot'] = {
	  head="Uk'uxkaj Cap",
	  neck="Ocachi Gorget",
	  back="Buquwik Cape",
    ring1="Garuda Ring +1",
    ring2="Garuda Ring +1",
	  legs="Arc. Braccae +1"
	}

	-- Fast cast sets for spells

	sets.precast.FC = {
		neck="Jeweled Collar",
		ear1="Loquacious Earring",
		ring1="Patricius Ring",
		ring2="Dark Ring",
		back="Shadow Mantle",
		waist="Flume Belt +1",
	}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		head="Sylvan Gapette +2",
		body="Sylvan Caban +2",
		hands="Alruna's Gloves +1",
		back=gear.AugLutianSnapshot,
		waist="Impulse Belt",
		legs="Nahtirah Trousers",
		feet="Wurrukatte Boots"
	}
	
	sets.precast.RA.Overkill = set_combine(sets.precast.RA,{
		head="Arcadian Beret +1",
		--legs="Murzim Cosciales"
	})

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Arcadian Beret +1",
		neck="Ocachi Gorget",
		ear1="Tripudio Earring",
		ear2="Moonshade Earring",
		body="Kyujutsugi",
		hands="Arcadian Bracers +1",
		ring1="Rajas Ring",
		ring2="Garuda Ring +1",
		back=AugLutianAGI,
		waist="Caudata Belt",
		legs="Nahtirah Trousers",
		feet="Orion Socks +1"
	}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {
		body="Kyujutsugi",
		hands="Alruna's Gloves +1",
		ring1="Garuda Ring +1",
		ring2="Garuda Ring +1",
		back=AugLutianAGI,
		legs="Arc. Braccae +1"
	})
	
	sets.precast.WS.MAB = set_combine(sets.precast.WS, {
		head="Umbani Cap",
		neck="Stoicheion Medal",
		ear1="Crematio Earring",
		ear2="Friomisi Earring",
		body="Orion Jerkin +1",
		ring1="Acumen Ring",
		back="Toro Cape",
		waist="Yamabuki-no-Obi",
		legs="Shned. Tights +1"
	})
	
	sets.precast.WS.RA = set_combine(sets.precast.WS, {
		head="Arcadian Beret +1",
		neck="Ocachi Gorget",
		ear1="Tripudio Earring",
		ear2="Moonshade Earring",
		body="Kyujutsugi",
		hands="Arcadian Bracers +1",
		ring1="Rajas Ring",
		ring2="Garuda Ring +1",
		back=AugLutianAGI,
		waist="Caudata Belt",
		legs="Nahtirah Trousers",
		feet="Orion Socks +1"
	})
	
	sets.precast.WS.MABRA = set_combine(sets.precast.MAB, {
		hands="Alruna's Gloves +1",
		ring1="Garuda Ring +1",
		feet="Orion Socks +1"
	})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	-------------------------
	-- Marksmanship

	sets.precast.WS['Last Stand'] = set_combine(sets.precast.WS.RA, {
		neck=gear.ElementalGorget,
		ring1="Garuda Ring +1",
		ring2="Garuda Ring +1",
		back=AugLutianAGI,
		waist=gear.ElementalBelt
	})
	sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
	})
	sets.precast.WS['Last Stand'].Mod = set_combine(sets.precast.WS['Last Stand'], {
	})
	
	sets.precast.WS['Coronach'] = set_combine(sets.precast.WS.RA, {
		neck=gear.ElementalGorget,
		ear1="Vulcan's Pearl",
		ear2="Vulcan's Pearl",
		ring2="Ifrit Ring",
		back="Buquwik Cape",
		waist=gear.ElementalBelt
	})
	sets.precast.WS['Coronach'].Acc = set_combine(sets.precast.WS['Coronach'], {
		hands="Alruna's Gloves +1"
	})
	sets.precast.WS['Coronach'].Mod = set_combine(sets.precast.WS['Coronach'], {
	})
	
	sets.precast.WS['Wildfire'] = set_combine(sets.precast.WS.MABRA, {
		
	})
	sets.precast.WS['Wildfire'].Acc = set_combine(sets.precast.WS['Wildfire'], {
		
	})
	sets.precast.WS['Wildfire'].Mod = set_combine(sets.precast.WS['Wildfire'], {
		
		waist=gear.ElementalBelt
	})
	
	sets.precast.WS['Trueflight'] = set_combine(sets.precast.WS.MABRA, {
		
	})
	sets.precast.WS['Trueflight'].Acc = set_combine(sets.precast.WS['Trueflight'], {
		
	})
	sets.precast.WS['Trueflight'].Mod = set_combine(sets.precast.WS['Trueflight'], {
		
		waist=gear.ElementalBelt
	})
	
	-------------------------
  -- Archery
  
  

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	sets.midcast.FastRecast = {
		head="Orion Beret +1",
		neck="Jeweled Collar",
		ear1="Loquacious Earring",
		ring1="Patricius Ring",
		ring2="Dark Ring",
		back="Shadow Mantle",
		waist="Flume Belt +1",
		legs="Orion Braccae +1",
		feet="Orion Socks +1"
	}

	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast,{
	})

	-- Ranged sets

	sets.midcast.RA = {
		head="Arcadian Beret +1",
		neck="Ocachi Gorget",
		ear1="Tripudio Earring",
		ear2="Volley earring",
		body="Kyujutsugi",
		hands="Alruna's Gloves +1",
		ring1="Rajas Ring",
		ring2="K'ayres Ring",
		--back=AugLutianSnapshot,
		back=AugLutianAGI,
		waist="Elanid Belt",
		legs="Aeto. Trousers +1",
		feet="Orion Socks +1"
	}
	
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA,{
		ring1="Hajduk Ring",
		ring2="Hajduk Ring",
		back=AugLutianAGI
	})

	sets.midcast.RA.Annihilator = set_combine(sets.midcast.RA)

	sets.midcast.RA.Annihilator.Acc = set_combine(sets.midcast.RA.Acc)

	sets.midcast.RA.Yoichinoyumi = set_combine(sets.midcast.RA, {
		ear2="Clearview Earring",
		ring2="Rajas Ring",
		back="Sylvan Chlamys"})

	sets.midcast.RA.Yoichinoyumi.Acc = set_combine(sets.midcast.RA.Acc, {ear2="Clearview Earring"})
	
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
		head="Arcadian Beret +1",
		neck="Twilight Torque",
		ear1="Tripudio Earring",
		ear2="Novia Earring",
		body="Mekosu. Harness",
		hands="Umuthi Gloves",
		ring1="Sheltered Ring",
		ring2="Dark Ring",
		--back="Shadow Mantle",
		back="Mecistopins Mantle",
		waist="Flume Belt +1",
		legs="Osmium Cuisses",
		feet="Skd. Jambeaux +1"
	}
	
	-- Defense sets
	sets.defense.PDT = set_combine(sets.idle,{
		neck="Twilight Torque",
		body="yujutsugi",
		hands="Umuthi Gloves",
		ring1="Patricius Ring",
		ring2="Dark Ring",
		back="Shadow Mantle",
		waist="Flume Belt +1",
		legs="Osmium Cuisses",
		feet="Orion Socks +1"
	})

	sets.defense.MDT = set_combine(sets.idle,{
		head="Arcadian Beret +1",
		neck="Inq. Bead Necklace",
		body="Kyujutsugi",
		hands="Umuthi Gloves",
		ring1="Shadow Ring",
		ring2="Dark Ring",
		back="Tuilha Cape",
		legs="Nahtirah Trousers",
		feet="Orion Socks +1"
	})

	sets.Kiting = {feet="Skd. Jambeaux +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = set_combine(sets.idle,{
	})
	
	sets.engaged.Melee = set_combine(sets.engaged,{
		head="Uk'uxkaj Cap",
		neck="Asperity Necklace",
		ear1="Bladeborn Earring",
		ear2="Steelflash Earring",
		body="Thaumas Coat",
		hands="Qaaxo Mitaines",
		ring1="Epona's Ring",
		ring2="Rajas Ring",
		back="Atheling Mantle",
		waist="Windbuffet Belt +1",
		legs="Quiahuiz Trousers",
		feet="Qaaxo Leggings"
	})

	sets.engaged.Acc = set_combine(sets.engaged,{
	})

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = set_combine(sets.midcast.RA.Acc, {
		head="Umbani Cap",
		hands="Orion Bracers +1",
		ear1="Vulcan's Pearl",
		ear2="Vulcan's Pearl",
		neck="Iqabi Necklace",
		--neck="Gaudryi Necklace",
		body="Orion Jerkin +1",
		hands="Orion Bracers +1",
		--ring1="Longshot Ring",
		--ring2-"Paqichikaji Ring",
		ring1="Hajduk Ring",
		ring2="Hajduk Ring",
		back=AugLutianAGI,
		waist="Elanid Belt",
		legs="Arc. Braccae +1",
		feet="Orion Socks +1"
	})
	sets.buff.Camouflage = {body="Orion Jerkin +1"}	
end