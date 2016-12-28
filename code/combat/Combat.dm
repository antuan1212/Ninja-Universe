Combat
	var
		mob/player/p
		action = 0 //keeps track of whether player is currently performing an action
		KO = 0
		block = 0
		defMultiplier = 1 //amount of defense gained during blocking
		jump_time = 50
		is_jumping = 0
		timelim = 0
		mob/target
		list/revDir = list(2,1,,8,10,9,,4,6,5)
		tmp/regenRate = 5 //percent
		tmp/regenDelay = 75
		regenerating = 0
		resting = 0
		battlemode = 0
		battlemodetimer = 10

	proc
		battleMode()
			if(battlemode)
				battlemodetimer = 60
				return
			else
				battlemode = 1
				while(battlemodetimer > 0)
					sleep(10)
					battlemodetimer--
				battlemode = 0
				target = null
				p.client.images = null

		regenHealth()
			if(regenerating) return
			regenerating = 1
			while(p.health < p.maxHealth)
				sleep(regenDelay)
				if(KO)
					p.health = 0
					return
				var/increase = round(p.maxHealth * (regenRate/100))
				p.health += increase
				var/state = round(((p.health/p.maxHealth) * 100),1)
				p.hud.player_health.icon_state = "[state]"
			p.health = p.maxHealth
			p.hud.player_health.icon_state = "100"
			regenerating = 0
		rest()
			if(resting == 0)
				if(action) return
				if(p.frozen) return
				if(KO) return
				resting = 1
				p.icon_state = "kneeling"
				p.frozen = 1
				action = 1
				regenDelay = 50
				regenRate = 7
			else
				resting = 0
				p.icon_state = ""
				p.frozen = 0
				action = 0
				regenDelay = initial(regenDelay)
				regenRate = initial(regenRate)
		advanceddirection(mob/U, mob/M)
			// (Courtesy of Lummox)
			// this is a little more intelligent than get_dir; it will return the "truest" direction
			// (instead of get_dir's policy of returning a diagonal move whenever possible)
			var/A = Arctan(usr.x - M.x, usr.y - M.y)
			var/B = round(A, 45)
			switch(B)
				if(-90) return NORTH
				if(90) return SOUTH
				if(180, -180) return EAST
				if(0) return WEST
				if(-135) return NORTHEAST
				if(135) return SOUTHEAST
				if(-45) return NORTHWEST
				if(45) return SOUTHWEST
		target(var/mob/a)
			if(target == a) return
			usr.client.images = null
			target = a
			var/image/I = image('target.dmi',a)
			usr.client.images += I
		getClosestTarget()
			var/closestM
			var/closestMDist = 99999
			for(var/mob/M in oview())
				var/dist = get_dist(p,M)
				if(dist < closestMDist)
					closestMDist = dist
					closestM = M
			target(closestM)

		get_steps(atom/A, var/dir, var/num)
			var/T = get_step(A, dir)
			while(num && T)
				A = T
				T = get_step(A, dir)
				--num
			return A
		throw()
			if(action) return
			if(KO) return
			if(target == null) return 0
			//battleMode()
			action = 1
			p.dir = advanceddirection(p, target)
			is_jumping = 1
			flick("Punch[pick(1,2)]", p)
			spawn()
				if(p.inv.throwSlot.name == "needleInv")
					throwNeedle()
				else if(p.inv.throwSlot.name == "shurikenInv")
					throwShuriken()
				else if(p.inv.throwSlot.name == "kunaiInv")
					throwKunai()
				else if(p.inv.throwSlot.name =="bShurikenInv")
					throwBShuriken()
				spawn(1)
					is_jumping = 0
			sleep(5)
			action = 0
			return 1
		throwNeedle()
			FireSpread(p, target, /obj/sd_px_projectile/Weapons/Needle, 5, 30)
		throwShuriken()
			FireSpread(p, target, /obj/sd_px_projectile/Weapons/Shuriken, 3, 45)
		throwKunai()
			FirePixelProjectile(p, target, /obj/sd_px_projectile/Weapons/Kunai)
		throwBShuriken()
			FirePixelProjectile(p, target, /obj/sd_px_projectile/Weapons/bShuriken)
		throwDmg(var/x, var/y, var/z, var/critDiv, var/critMax, var/mob/player/M)
			var/dmg = (rand(88,112)/100) *(x*(0.9*(p.dexterity) + 0.1*(p.strength)) - (y * (M.defense*M.combat.defMultiplier)))
			var/critCh = p.dexterity/critDiv
			if(critCh > critMax)
				critCh = critMax
			if(prob(round(critCh)))
				dmg = dmg * z
				M.combat.dealDamage(dmg, p, 1)
			else
				M.combat.dealDamage(dmg, p)
		jump()
			if(is_jumping) return
			if(!p.run) return
			var/atom/a = get_steps(p, p.dir, 9)
			if(a.density == 1)
				return
			spawn()
				is_jumping = 1
				var/jumpt = 0
				p.icon_state = "jump"
				p.density = 0
				p.layer += 5000
				while(src && jumpt <= jump_time/2)
					jumpt += 5
					p.pixel_y += 5
					switch(p.dir)
						if(NORTH)
							p.loc = locate(p.x, p.y+1, p.z)
						if(SOUTH)
							p.loc = locate(p.x, p.y-1, p.z)
						if(EAST)
							p.loc = locate(p.x+1, p.y, p.z)
						if(WEST)
							p.loc = locate(p.x-1, p.y, p.z)
						if(NORTHEAST)
							p.loc = locate(p.x+1, p.y+1, p.z)
						if(NORTHWEST)
							p.loc = locate(p.x-1, p.y+1, p.z)
						if(SOUTHEAST)
							p.loc = locate(p.x+1, p.y-1, p.z)
						if(SOUTHWEST)
							p.loc = locate(p.x-1, p.y-1, p.z)
					sleep(1)
				sleep(1)
				while(src && jumpt <= jump_time)
					jumpt += 8
					p.pixel_y -= 8
					switch(p.dir)
						if(NORTH)
							p.loc = locate(p.x, p.y+1, p.z)
						if(SOUTH)
							p.loc = locate(p.x, p.y-1, p.z)
						if(EAST)
							p.loc = locate(p.x+1, p.y, p.z)
						if(WEST)
							p.loc = locate(p.x-1, p.y, p.z)
						if(NORTHEAST)
							p.loc = locate(p.x+1, p.y+1, p.z)
						if(NORTHWEST)
							p.loc = locate(p.x-1, p.y+1, p.z)
						if(SOUTHEAST)
							p.loc = locate(p.x+1, p.y-1, p.z)
						if(SOUTHWEST)
							p.loc = locate(p.x-1, p.y-1, p.z)
					sleep(1)
				p.pixel_y = 0
				p.icon_state = ""
				is_jumping = 0
				p.density = 1
				p.layer -= 5000

		punch(var/mob/player/M)
			if(M)
				if(M.combat.KO == 0)
					if(action) return
					action=1
					var/dmg = 0
					if(p.dir == revDir[M.dir])
						dmg = round(p.strength - (0.75*(M.defense*M.combat.defMultiplier)))
					else
						dmg = round(p.strength - (0.75*(M.defense*1)))
					M.combat.dealDamage(dmg, p)
					flick("Punch[pick(1,2)]",p)
					target(M)
					sleep(3)
					action=0
					return 1
				else
					p << "You've already knocked [M] out."
					return 0

		kick(var/mob/player/M)
			//battleMode()
			if(M)
				if(M.combat.KO == 0)
					if(action) return
					action=1
					var/dmg = 0
					if(p.dir == revDir[M.dir])
						dmg = round(p.strength - (0.70*(M.defense*M.combat.defMultiplier)))
					else
						dmg = round(p.strength - (0.70*(M.defense*1)))
					M.combat.dealDamage(dmg, p)
					var/state = pick("kick","lowkick")
					flick("[state]",p)
					target(M)
					sleep(5)
					action=0
					return 1
				else
					p << "You've already knocked [M] out."
					return 0

		initiateBlock()
			if(action) return
			if(KO) return
			block = 1
			p.frozen = 1
			action = 1
			defMultiplier = 2
			p.icon_state = "block"
		endBlock()
			block = 0
			p.frozen = 0
			action = 0
			defMultiplier = 1
			p.icon_state = ""

		dealDamage(var/damage, var/mob/attacker, var/critical = 0)
			if(KO) return
			if(damage < 0)
				damage = 0
			damage = round(damage, 1)
			p.health -= damage
			var/obj/effect
			if(p.combat.block)
				effect = new/obj/battleEffects/blockedEffect(rand(1,6))
			else
				effect = new/obj/battleEffects/hitEffect(rand(1,6))
			effect.loc = p.loc
			if(!critical)
				s_damage(p, damage)
			else
				var/obj/s_damage_crit/s = new
				s.loc = p.loc
				flick("crit", s)
			if(((p.health/p.maxHealth) * 100) <= 25)   //if the health of the mob is less than 25% start showing blood.
				var/obj/blood = new/obj/bloodEffect(rand(1,11))
				blood.pixel_x += rand(-16, 16)
				blood.pixel_y += rand(-16, 16)
				blood.loc = p.loc
			if(p.health <= 0)
				p << "[usr] has knocked you out."
				attacker << "You have knocked out [p]."
				p.frozen = 1
				action = 1
				p.icon_state = "dead"
				KO = 1
			var/state = round(((p.health/p.maxHealth) * 100),1)
			p.hud.player_health.icon_state = "[state]"
			regenHealth()

		revive()
			p.health = p.maxHealth
			p.hud.player_health.icon_state = "100"
			p.loc = locate(p.spawnx,p.spawny,p.spawnz)
			p.icon_state = ""
			action = 0
			p.frozen = 0
			KO = 0
	New(var/mob/player/newP)
		p = newP