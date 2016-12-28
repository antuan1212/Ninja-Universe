mob/player
	verb
		punch()
			for(var/mob/player/M in get_step(src, src.dir))
				src.combat.punch(M)

		kick()
			for(var/mob/player/M in get_step(src, src.dir))
				src.combat.kick(M)
		rest()
			src.combat.rest()
		throw()
			src.inv.executeThrow()
		space()
			if(src.combat.KO)
				src.combat.revive()
			else
				src.combat.jump()
		initiateBlock()
			if(src.run) return
			src.combat.initiateBlock()
		endBlock()
			src.combat.endBlock()
		nullifyTarget()
			src.combat.target = null
			usr.client.images = null
		getClosestTarget()
			src.combat.getClosestTarget()
		switchFocus()
			if(winget(src, "default.inputDefault", "focus") == "true")
				winset(src, "default.map", "focus='true'")
			else
				winset(src, "default.inputDefault", "focus='true'")
