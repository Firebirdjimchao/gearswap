-------------------------------------------------------------------------------------------------------------------
-- An example of setting up user-specific global handling of certain events.
-- This is for personal globals, as opposed to library globals.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()
	-- Special gear info that may be useful across jobs.

	-- Staffs
	gear.Staff = {}
	gear.MainStaff = {name="Grioavolr"}
	gear.MaccStaff = {name="Contemplator +1"}
	gear.FastcastStaff = {name="Grioavolr"}
	gear.RecastStaff = {name=""}
	gear.Staff.Cure = {name="Arka IV"}
	gear.Staff.HMP = {name="Contemplator +1"}
	gear.Staff.PDT = {name="Terra's Staff"}
	gear.Staff.DT = {name="Malignance Pole"}
	
	-- Dark Rings
	gear.DarkRing = {}
	gear.DarkRing.physical = { name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -4%',}}
	gear.DarkRing.magical = { name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -4%',}}
	
	-- Augmented Gear
	gear.Adhemar_head_B = { name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}}
	gear.Adhemar_body_B = { name="Adhemar Jacket", augments={'STR+10','DEX+10','Attack+15',}}
	gear.Adhemar_hands_B = { name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}}
	
	gear.Amalric_body_A = { name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}}
	gear.Amalric_hands_D = { name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}}  
	
	gear.Vanya_feet_B = { name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}

	gear.Merlinic_head_burst = { name="Merlinic Hood", augments={'"Mag.Atk.Bns."+25','Magic burst dmg.+9%','CHR+8','Mag. Acc.+7',}}
	gear.Merlinic_body_nuke = { name="Merlinic Jubbah", augments={'Mag. Acc.+14 "Mag.Atk.Bns."+14','Enmity-4','INT+5','Mag. Acc.+8','"Mag.Atk.Bns."+15',}}
	gear.Merlinic_legs_nuke = { name="Merlinic Shalwar", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','Magic Damage +4','INT+10','Mag. Acc.+8','"Mag.Atk.Bns."+10',}}
	gear.Merlinic_legs_idle = { name="Merlinic Shalwar", augments={'"Fast Cast"+3','"Store TP"+6','"Refresh"+2','Accuracy+12 Attack+12','Mag. Acc.+4 "Mag.Atk.Bns."+4',}}
	gear.Merlinic_feet_nuke = { name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+14','Mag. Acc.+14',}}

	gear.Chironic_legs_nuke = { name="Chironic Hose", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Conserve MP"+3','AGI+3','Mag. Acc.+12','"Mag.Atk.Bns."+2',}}
	gear.Chironic_feet_nuke = { name="Chironic Slippers", augments={'Mag. Acc.+8','CHR+3','Accuracy+17 Attack+17','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}

	gear.Herculean_head_mab = { name="Herculean Helm", augments={'"Subtle Blow"+2','"Mag.Atk.Bns."+27','Phalanx +1','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
	gear.Herculean_body_mab = { name="Herculean Vest", augments={'"Mag.Atk.Bns."+23','"Subtle Blow"+3','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	gear.Herculean_legs_TA = { name="Herculean Trousers", augments={'AGI+3','CHR+6','"Treasure Hunter"+2','Mag. Acc.+8 "Mag.Atk.Bns."+8',}}
	gear.Herculean_legs_WSD = { name="Herculean Trousers", augments={'Phys. dmg. taken -4%','STR+13','Weapon skill damage +6%','Accuracy+6 Attack+6',}}

	gear.Telchine_body_pet = { name="Telchine Chas.", augments={'Mag. Evasion+21','Pet: "Regen"+3','Enh. Mag. eff. dur. +9',}}
	gear.Telchine_hands_cure = { name="Telchine Gloves", augments={'"Cure" potency +6%',}}
	gear.Telchine_hands_pet = { name="Telchine Gloves", augments={'Mag. Evasion+22','Pet: "Regen"+3','Enh. Mag. eff. dur. +9',}}
	gear.Telchine_legs_pet = { name="Telchine Braconi", augments={'Mag. Evasion+22','Pet: "Regen"+3','Enh. Mag. eff. dur. +7',}}
	
	-- Default items for utility gear values.
	gear.default.weaponskill_neck = "Asperity Gorget"
	gear.default.weaponskill_waist = "Windbuffet Belt +1"
	--gear.default.obi_waist = "Eschan Stone"
	gear.default.obi_waist = "Refoccilation Stone"
	gear.default.obi_back = "Toro Cape"
	gear.default.obi_ring = "Strendu Ring"
	gear.default.fastcast_staff = gear.FastcastStaff
	gear.default.recast_staff = gear.RecastStaff

	sets.sharedResting = {
		main=gear.Staff.HMP,
		sub="Ariesian Grip",
		ammo="Clarus Stone",
		head="Orvail Corona +1",
		neck="Eidolon Pendant",
		ear2="Antivenom Earring",
		body="Chelona Blazer",
		hands="Nares Cuffs",
		ring1="Star Ring",
		ring2="Star Ring",
		back="Felicitas Cape",
		waist="Austerity Belt",
		legs="Nisse Slacks",
		feet="Chelona Boots"
	}

	sets.precast.JA.Sublimation = {
		waist="Embla Sash"
	}
	
	sets.midcast.Sneak = {
		feet="Dream Boots +1"
	}
	
	sets.midcast.Invisible = {
		hands="Dream Mittens +1"
	}
	
	sets.engaged.combatSkillup = {
		head="Tema. Headband",
		ear2="Terminus Earring",
		ring2="Prouesse Ring",
		legs="Temachtiani Pants",
		feet="Temachtiani Boots"
	}
	
	sets.midcast.magicSkillup = {
		ear1="Liminus Earring",
		body="Temachtiani Shirt",
		hands="Temachtiani Gloves"
	}

	sets.reive = {
		neck="Arciela's Grace +1"
	}
	sets.buff.Doom = {
		neck="Nicander's Necklace",
		ring1="Purity Ring",
		waist="Gishdubar Sash",
	}
	
end

function user_customize_idle_set(idleSet)
	if buffactive['Reive Mark'] then
		idleSet = set_combine(idleSet, sets.reive)
	end
	return idleSet
end

function precast(spell)
	if has_any_buff_of({'Petrification','Sleep','Stun','Terror'}) then cancel_spell() return end
	
	if state.Buff[spell.english] ~= nil then
		state.Buff[spell.english] = true
	end
	handle_actions(spell, 'precast')
end

function global_aliases()
	
	-- trusts
	UnityConcord = 'Apururu (UC)'
	PhysicalTank = 'August'
	MagicalTank = 'Amchuchu'
	BlinkTank = 'Gessho'
	RedMage = 'Arciela II'
	Alchemist = 'Monberaux'
	RedMageWkr = 'Koru-Moru'
	Bard = 'Joachim'
	Bard2 = 'Ulmia'
	RegenBuff = 'Sakura'
	RefreshBuff = 'Moogle'
	AccBuff = 'Kuyin Hathdenna'
	DefBuff =  'Brygid'
	MabBuff = 'Star Sibyl'
	ExpBuff = 'Kupofried'
	MeleeDD = 'Selh\'teus'
	MeleeDD2 = 'Iroha II'
	MagicDD = 'Ullegore'
	MagicDD2 = 'Adelheid'
	Healer = 'Apururu (UC)'
	Healer2 = 'Cherukiki'
	RangeDD = 'Semih Lafihna'
	RangeDD2 = 'Elivira'
	HasteBuff = 'Cornelia'
	Cor = 'Qultada'
	
	-- with UC and Tank
	send_command('alias pdttanktrust input /ma "' .. UnityConcord .. '" <me>;wait 5;input /ma "' .. PhysicalTank .. '" <me>;wait 5;input /ma "' .. RedMage .. '" <me>;wait 5;input /ma "' .. MeleeDD .. '" <me>;wait 5;input /ma "' .. Bard .. '" <me>;')
	send_command('alias mdttanktrust input /ma "' .. UnityConcord .. '" <me>;wait 5;input /ma "' .. MagicalTank .. '" <me>;wait 5;input /ma "' .. RedMage .. '" <me>;wait 5;input /ma "' .. MeleeDD .. '" <me>;wait 5;input /ma "' .. Bard .. '" <me>;')
	send_command('alias blinktanktrust input /ma "' .. UnityConcord .. '" <me>;wait 5;input /ma "' .. BlinkTank .. '" <me>;wait 5;input /ma "' .. RedMage .. '" <me>;wait 5;input /ma "' .. MeleeDD .. '" <me>;wait 5;input /ma "' .. Bard .. '" <me>;')
	
	-- special content
	send_command('alias dragontrust input /ma "' .. UnityConcord .. '" <me>;wait 5;input /ma "' .. RedMage .. '" <me>;wait 5;input /ma "' ..  Alchemist .. '" <me>;wait 5;input /ma "' .. Cor .. '" <me>;wait 5;input /ma "' .. Bard .. '" <me>;')
	send_command('alias dragontrust2 input /ma "' .. MagicalTank .. '" <me>;wait 5;input /ma "' .. UnityConcord .. '" <me>;wait 5;input /ma "' ..  Alchemist .. '" <me>;wait 5;input /ma "' .. RedMage .. '" <me>;wait 5;input /ma "' .. Bard .. '" <me>;')
	send_command('alias wkrtrust input /ma "' .. Healer .. '" <me>;wait 5;input /ma "' .. Healer2 .. '" <me>;wait 5;input /ma "' .. RedMageWkr .. '" <me>;wait 5;input /ma "' .. MeleeDD .. '" <me>;wait 5;input /ma "' .. Bard .. '" <me>;')
	send_command('alias maidentrust input /ma "' .. MagicalTank .. '" <me>;wait 5;input /ma "' .. UnityConcord .. '" <me>;wait 5;input /ma "' ..  Alchemist .. '" <me>;wait 5;input /ma "' .. RedMageWkr .. '" <me>;wait 5;input /ma "' .. Bard .. '" <me>;')
	send_command('alias divinerust input /ma "' .. UnityConcord .. '" <me>;wait 5;input /ma "' .. Cor .. '" <me>;wait 5;input /ma "' ..  Alchemist .. '" <me>;wait 5;input /ma "' .. Bard2 .. '" <me>;wait 5;input /ma "' .. MeleeDD .. '" <me>;')

	-- DD specific
	send_command('alias nuketrust input /ma "' .. UnityConcord .. '" <me>;wait 5;input /ma "' .. RedMage .. '" <me>;wait 5;input /ma "' ..  MeleeDD .. '" <me>;wait 5;input /ma "' .. MeleeDD2 .. '" <me>;wait 5;input /ma "' .. Bard .. '" <me>;')
	send_command('alias nuketrust input /ma "' .. UnityConcord .. '" <me>;wait 5;input /ma "' .. RedMage .. '" <me>;wait 5;input /ma "' ..  MagicDD .. '" <me>;wait 5;input /ma "' .. MagicDD2 .. '" <me>;wait 5;input /ma "' .. Bard .. '" <me>;')
	send_command('alias nuketrust input /ma "' .. UnityConcord .. '" <me>;wait 5;input /ma "' .. RedMage .. '" <me>;wait 5;input /ma "' ..  RangeDD .. '" <me>;wait 5;input /ma "' .. RangeDD2 .. '" <me>;wait 5;input /ma "' .. Bard .. '" <me>;')

end

-------------------------------------------------------------------------------------------------------------------
-- Test function to use to avoid modifying library files.
-------------------------------------------------------------------------------------------------------------------

function user_test(params)

end