obj
	bloodEffect
		icon = 'Blood.dmi'
		New(var/state)
			..()
			src.icon_state = "[state]"
			spawn(2500)
				del src
	battleEffects
		icon = 'Battle Effects.dmi'
		layer = MOB_LAYER + 1
		blockedEffect
			New(var/state)
				..()
				src.icon_state = "blocked[state]"
				spawn(1)
					del src
		hitEffect
			New(var/state)
				..()
				src.icon_state = "[state]"
				spawn(1)
					del src

	s_damage_crit
		icon = 's_damage_crit.dmi'
		layer = FLY_LAYER
		pixel_x = -16
		New()
			..()
			spawn(10)
				del src