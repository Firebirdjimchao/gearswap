-------------------------------------------------------------------------------------------------------------------
-- An example of setting up user-specific global handling of certain events.
-- This is for personal globals, as opposed to library globals.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()
	-- Special gear info that may be useful across jobs.

	-- Staffs
	gear.Staff = {}
	gear.MainStaff = {name="Grioavolr"}
	gear.MaccStaff = {name="Serenity"}
	gear.FastcastStaff = {name="Grioavolr"}
	gear.RecastStaff = {name="Serenity"}
	gear.Staff.Cure = {name="Serenity"}
	gear.Staff.HMP = {name="Chatoyant Staff"}
	gear.Staff.PDT = {name="Terra's Staff"}
	gear.Staff.DT = {name="Malignance Pole"}
	
	-- Dark Rings
	gear.DarkRing = { name="Dark Ring", augments={'Spell interruption rate down -3%','Magic dmg. taken -5%','Phys. dmg. taken -5%',}}
	
	-- Augmented Gear
	gear.MeleeTaeonHands = { name="Taeon Gloves", augments={'Accuracy+16','"Triple Atk."+2','STR+7 VIT+7',}}
	gear.MeleeTaeonLegs = { name="Taeon Tights", augments={'Accuracy+12 Attack+12','"Triple Atk."+2','STR+4',}}
	gear.MeleeTaeonFeet = {	name="Taeon Boots",	augments={'Attack+24','"Triple Atk."+2','Crit. hit damage +1%',}}
	gear.RATaeonFeet = { name="Taeon Boots",augments={'Rng.Acc.+19 Rng.Atk.+19','Crit.hit rate+3','STR+3 AGI+3',}}
	
	gear.rawhide_body_D = { name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}}
	
	gear.pursuer_head_B = { name="Pursuer's Beret", augments={'DEX+7','AGI+10','"Recycle"+15',}}
	gear.pursuer_body_D = { name="Pursuer's Doublet", augments={'HP+50','Crit. hit rate+4%','"Snapshot"+6',}}
	gear.pursuer_legs_A = { name="Pursuer's Pants", augments={'AGI+10','"Rapid Shot"+10','"Subtle Blow"+7',}}
	gear.pursuer_legs_D = { name="Pursuer's Pants", augments={'DEX+7','AGI+10','STR+7',}}
	gear.pursuer_feet_D = { name="Pursuer's Gaiters", augments={'Rng.Acc.+10','"Rapid Shot"+10','"Recycle"+15',}}
	
	gear.Adhemar_head_B = { name="Adhemar Bonnet", augments={'STR+10','DEX+10','Attack+15',}}
	gear.Adhemar_body_B = { name="Adhemar Jacket", augments={'STR+10','DEX+10','Attack+15',}}
	gear.Adhemar_hands_B = { name="Adhemar Wristbands", augments={'STR+10','DEX+10','Attack+15',}}
	gear.Adhemar_legs_D = { name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}}
	gear.Adhemar_feet_B = { name="Adhemar Gamashes", augments={'STR+10','DEX+10','Attack+15',}}
	gear.Adhemar_feet_C = { name="Adhemar Gamashes", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}}
	gear.Adhemar_feet_D = { name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}}
	
	gear.Amalric_body_A = { name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}}
	gear.Amalric_hands_D = { name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}}
	gear.Amalric_legs_D = { name="Amalric Slops", augments={'MP+60','"Mag.Atk.Bns."+20','Enmity-5',}}
	
	gear.Vanya_body_B = { name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
	gear.Vanya_hands_B = { name="Vanya Cuffs", augments={'Healing magic skill +15','"Cure" spellcasting time -5%','Magic dmg. taken -2',}}
	gear.Vanya_feet_B = { name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}

	gear.Argosy_head_A = { name="Argosy Celata", augments={'STR+10','DEX+10','Attack+15',}}
	gear.Argosy_body_D = { name="Argosy Hauberk", augments={'STR+10','Attack+15','"Store TP"+5',}}

	gear.Argosy_head_hq_A = { name="Argosy Celata +1", augments={'STR+12','DEX+12','Attack+20',}}
	gear.Argosy_body_hq_D = { name="Argosy Hauberk +1", augments={'STR+12','Attack+20','"Store TP"+6',}}
	gear.Argosy_hands_hq_D = { name="Argosy Mufflers +1", augments={'STR+20','"Dbl.Atk."+3','Haste+3%',}}
	gear.Argosy_legs_hq_D = { name="Argosy Breeches +1", augments={'STR+12','Attack+25','"Store TP"+6',}}
	gear.Argosy_feet_hq_A = { name="Argosy Sollerets +1", augments={'STR+12','DEX+12','Attack+20',}}

	gear.Odyssean_hands_WS = { name="Odyssean Gauntlets", augments={'Attack+16','Weapon skill damage +5%','Accuracy+14',}}
	
	gear.Herculean_head_Magic = { name="Herculean Helm", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Weapon skill damage +1%','MND+1','"Mag.Atk.Bns."+15',}}
	gear.Herculean_head_RA = { name="Herculean Helm", augments={'Rng.Acc.+22','Crit.hit rate+5',}}
	gear.Herculean_hands_RA = { name="Herculean Gloves", augments={'Rng.Acc.+26','Crit.hit rate+5','Rng.Atk.+11',}}
	gear.Herculean_body_WS = { name="Herculean Vest", augments={'Accuracy+30','Weapon skill damage +4%','DEX+1','Attack+3',}}
	gear.Herculean_body_RA = { name="Herculean Vest", augments={'Rng.Acc.+22 Rng.Atk.+22','Crit.hit rate+2','Rng.Acc.+2',}}
	gear.Herculean_body_RA_WS = { name="Herculean Vest", augments={'Rng.Acc.+23 Rng.Atk.+23','Weapon skill damage +4%','INT+10','Rng.Acc.+8',}}
	gear.Herculean_body_Magic = { name="Herculean Vest", augments={'"Mag.Atk.Bns."+25','Crit.hit rate+1','Accuracy+14 Attack+14','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
	gear.Herculean_legs_RA = { name="Herculean Trousers", augments={'Rng.Acc.+23 Rng.Atk.+23','Crit.hit rate+3','DEX+9','Rng.Acc.+8','Rng.Atk.+4',}}
	gear.Herculean_legs_Magic = { name="Herculean Trousers", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','"Fast Cast"+5','MND+10','"Mag.Atk.Bns."+14',}}
	gear.Herculean_feet_RA = { name="Herculean Boots", augments={'Rng.Acc.+25','Crit.hit rate+5','Rng.Atk.+15',}}
	
	gear.Merlinic_head_nuke = { name="Merlinic Hood", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','"Conserve MP"+3','MND+2','Mag. Acc.+13','"Mag.Atk.Bns."+12',}}
	gear.Merlinic_head_burst = { name="Merlinic Hood", augments={'"Mag.Atk.Bns."+30','Magic burst dmg.+10%','Mag. Acc.+7',}}
	gear.Merlinic_body_burst = { name="Merlinic Jubbah", augments={'Mag. Acc.+9 "Mag.Atk.Bns."+9','Magic burst dmg.+7%','Mag. Acc.+8','"Mag.Atk.Bns."+4',}}
	gear.Merlinic_legs_nuke = { name="Merlinic Shalwar", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Conserve MP"+3','Mag. Acc.+5','"Mag.Atk.Bns."+13',}}
	gear.Merlinic_feet_burst = { name="Merlinic Crackows", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Magic burst dmg.+6%','CHR+7','Mag. Acc.+14','"Mag.Atk.Bns."+8',}}
	gear.Merlinic_feet_absorb = { name="Merlinic Crackows", augments={'"Drain" and "Aspir" potency +9','Mag. Acc.+11','"Mag.Atk.Bns."+14',}}

	gear.Chironic_head_nuke = { name="Chironic Hat", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Haste+1','INT+7','Mag. Acc.+14','"Mag.Atk.Bns."+8',}}
	gear.Chironic_body_nuke = { name="Chironic Doublet", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+2','Mag. Acc.+10','"Mag.Atk.Bns."+2',}}
	gear.Chironic_hands_nuke = { name="Chironic Gloves", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','INT+13','Mag. Acc.+6',}}
	gear.Chironic_legs_nuke = { name="Chironic Hose", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Haste+2','"Mag.Atk.Bns."+10',}}
	gear.Chironic_feet_nuke = { name="Chironic Slippers", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','MND+2','Mag. Acc.+1','"Mag.Atk.Bns."+14',}}
	
	gear.Valorous_head_DA = { name="Valorous Mask", augments={'Accuracy+17 Attack+17','"Dbl.Atk."+1','DEX+3','Accuracy+9','Attack+13',}}
	gear.Valorous_head_WS = { name="Valorous Mask", augments={'Rng.Atk.+1','Magic dmg. taken -5%','Weapon skill damage +9%','Accuracy+13 Attack+13','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
	gear.Valorous_head_Magic = { name="Valorous Mask", augments={'Rng.Atk.+1','Magic dmg. taken -5%','Weapon skill damage +9%','Accuracy+13 Attack+13','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
	gear.Valorous_body_TP = { name="Valorous Mail", augments={'Accuracy+14 Attack+14','"Store TP"+7',}}
	gear.Valorous_hand_TP = { name="Valorous Mitts", augments={'Accuracy+8 Attack+8','"Store TP"+6','STR+9','Accuracy+11',}}
	gear.Valorous_hand_WS = { name="Valorous Mitts", augments={'Accuracy+13','Weapon skill damage +3%','Attack+15',}}
	gear.Valorous_legs_TP = { name="Valorous Hose", augments={'Accuracy+12 Attack+12','Weapon Skill Acc.+9','DEX+1','Accuracy+15','Attack+13',}}
	gear.Valorous_feet_TP = { name="Valorous Greaves", augments={'Accuracy+25 Attack+25','DEX+4','Accuracy+5','Attack+4',}}
	gear.Valorous_feet_WS = { name="Valorous Greaves", augments={'Accuracy+25','Weapon skill damage +5%','VIT+10',}}

	gear.lustratio_legs_hq_B ={ name="Lustr. Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}}
	gear.lustratio_feet_hq_D ={ name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}}
	
	gear.Rao_head_hq_B = { name="Rao Kabuto +1", augments={'STR+12','DEX+12','Attack+20',}}
	gear.Rao_body_B = { name="Rao Togi", augments={'STR+10','DEX+10','Attack+15',}}
	gear.Rao_feet_hq_B = { name="Rao Sune-Ate +1", augments={'STR+12','DEX+12','Attack+20',}}

	gear.Ryuo_head_A = { name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15',}}
	gear.Ryuo_hands_D = { name="Ryuo Tekko", augments={'DEX+10','Accuracy+20','"Dbl.Atk."+3',}}

	gear.Carmine_hands_D = { name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}

	gear.Telchine_body_pet = { name="Telchine Chas.", augments={'Pet: "Regen"+3',}}
	gear.Telchine_hands_pet = { name="Telchine Gloves", augments={'Pet: "Regen"+3',}}
	gear.Telchine_legs_pet = { name="Telchine Braconi", augments={'Pet: "Regen"+3',}}
	
	-- Default items for utility gear values.
	gear.default.weaponskill_neck = "Fotia Gorget"
	gear.default.weaponskill_waist = "Fotia Belt"
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
		back="Vita Cape",
		waist="Austerity Belt",
		legs="Nisse Slacks",
		feet="Chelona Boots"
	}

	sets.precast.JA.Sublimination = {
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
		ear2="Liminus Earring",
		body="Temachtiani Shirt",
		hands="Temachtiani Gloves"
	}

	sets.reive = {
		--neck="Ygna's Resolve +1"
	}
	sets.buff.Doom = {
		neck="Nicander's Necklace",
		ring1="Purity Ring",
		ring2="Saida Ring",
		waist="Gishdubar Sash",
	}

end

function user_customize_melee_set(meleeSet)
	if buffactive['Reive Mark'] then
		meleeSet = set_combine(meleeSet, sets.reive)
	end
	
	return meleeSet
end

function user_customize_idle_set(idleSet)
	if buffactive['Reive Mark'] then
		idleSet = set_combine(idleSet, sets.reive)
	end
	
	return idleSet
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
-- Global event-handling functions.
-------------------------------------------------------------------------------------------------------------------

function precast(spell, action, spellMap, eventArgs)
	if has_any_buff_of({'Petrification','Sleep','Stun','Terror'}) then cancel_spell() return end

	if spell.type == 'WeaponSkill' then
		if (spell.target.model_size + spell.range * 1.642276421172564) < spell.target.distance then	
			add_to_chat(7,"--- Target "..spell.target.type.." ["..player.target.name.."] out of range of ["..spell.name.."] [ Distance: "..spell.target.distance.."] ---")
			cancel_spell()
		end
	end

	cancel_conflicting_buffs(spell, action, spellMap, eventArgs)
	refine_waltz(spell, action, spellMap, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Test function to use to avoid modifying library files.
-------------------------------------------------------------------------------------------------------------------

function user_test(params)

end