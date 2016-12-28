obj/sd_px_projectile/Weapons
	range = 20
	var/userMult
	var/defMult
	var/critMult
	var/chanceOfCritDiv
	var/maxCritChance
	Kunai
		icon = 'Weapons.dmi'
		icon_state = "kunai"
		speed = 30
		userMult = 0.8
		defMult = 0.15
		critMult = 1.8
		chanceOfCritDiv = 46
		maxCritChance = 20
	Shuriken
		icon = 'Weapons.dmi'
		icon_state = "shuriken"
		speed = 30
		userMult = 0.6
		defMult = 0.2
		critMult = 1.7
		chanceOfCritDiv = 46
		maxCritChance = 20
	bShuriken
		icon = 'Weapons.dmi'
		icon_state = "bshuriken"
		speed = 28
		userMult = 1.2
		defMult = 0.05
		critMult = 2.1
		chanceOfCritDiv = 40
		maxCritChance = 25
	Needle
		icon = 'Weapons.dmi'
		icon_state = "needle"
		userMult = 0.4
		defMult = 0.25
		critMult = 1.6
		chanceOfCritDiv = 50
		maxCritChance = 15
	Hit(atom/A)
		//world << "[src] hit [A] ([A.x], [A.y])."
		if(ismob(A))
			var/obj/blood = new/obj/bloodEffect(rand(1,11))
			blood.pixel_x += rand(-16, 16)
			blood.pixel_y += rand(-16, 16)
			blood.loc = A.loc
			if(istype(A,/mob/player))
				var/mob/player/p = usr
				p.combat.throwDmg(src.userMult, src.defMult, src.critMult, src.chanceOfCritDiv, src.maxCritChance,  A)
		del(src)