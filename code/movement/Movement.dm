mob/player/var/frozen = 0


mob/player
	Move()
		if(src.frozen)
			return 0
		else
			..()
mob/player
	Bump()
		src.moving = 1
		src.run = 0
		src.icon_state = ""
		src.move_delay = 2
		..()
//Macro_Move
mob/player
	var
		diagonals=1		//Disable this if you don't want diagonal movement.
		move_delay=2	//The time between steps.
		moving=0		//When the player has initiated movement().
		north=0			//These determine which keys the player is holding.
		south=0
		east=0
		west=0
		run=0
	proc
		/*
		movement()
			Since this is a loop, the moving variable is used to prevent multiple
			instances running at once.

			The loop will check each of the four cardinal directions and see which
			ones come up positive and then move the player in the appropriate direction.
			If north and south both come up positive the player will not move vertically,
			the same goes for east and west on the horizontal axis. The loop will also
			attempt to combine the axes in order to move the player diagonally.

			When the player isn't trying to move in any direction the moving variable
			is set back to 0 and the movement() proc terminates.
		*/
		movement()
			if(src.combat.block) return
			if(src.moving)return
			src.moving = 1
			while(1)
				if(src.combat.is_jumping == 1)
					while(src.combat.is_jumping == 1)
						sleep(1)
				if(src.combat.KO)
					src.icon_state = "dead"
					return
				if(src.combat.battlemode)
					run = 6
				run += 1
				if(run >= 6)
					if(src.frozen)
						src.moving = 0
						src.run = 0
						src.move_delay = 2
						return
					if(!src.combat.is_jumping)
						src.icon_state = "run"
					src.move_delay = 1
				if(src.north)
					if(!src.south)
						if(src.east)
							if(!src.west)if(src.diagonals)step(src,NORTHEAST)
							else step(src,NORTH)
						else
							if(src.west)if(src.diagonals)step(src,NORTHWEST)
							else step(src,NORTH)
				else
					if(src.south)
						if(src.east)
							if(!src.west)if(src.diagonals)step(src,SOUTHEAST)
							else step(src,SOUTH)
						else
							if(src.west)if(src.diagonals)step(src,SOUTHWEST)
							else step(src,SOUTH)
				if(src.east)
					if(!src.north&&!src.south&&!west)step(src,EAST)
					else if(src.north&&src.south&&!west)step(src,EAST)
				else
					if(src.west)
						if(!src.north&&!src.south)step(src,WEST)
						else if(src.north&&src.south)step(src,WEST)
				if(!src.north&&!src.south&&!src.east&&!src.west)
					src.moving = 0
					src.run = 0
					src.move_delay = 2
					if(!src.combat.is_jumping && !src.combat.KO)
						src.icon_state = ""
					return
				else sleep(move_delay)
	verb
		/*
		These are the verbs the player uses in order to move around. Each direction
		has its own variable which is toggled on and off via keypress.

		The commands are hidden so they don't clutter the statpanel.
		They're also set to instant so the player wont continue to move around after
		letting off the movement keys.
		*/
		north()
			set
				hidden=1
				instant=1
			src.north=1
			src.movement()
		north_up()
			set
				hidden=1
				instant=1
			src.north=0
		south()
			set
				hidden=1
				instant=1
			src.south=1
			src.movement()
		south_up()
			set
				hidden=1
				instant=1
			src.south=0
		east()
			set
				hidden=1
				instant=1
			src.east=1
			src.movement()
		east_up()
			set
				hidden=1
				instant=1
			src.east=0
		west()
			set
				hidden=1
				instant=1
			src.west=1
			src.movement()
		west_up()
			set
				hidden=1
				instant=1
			src.west=0