mob/player
	verb
		charWindow()
			var/mob/player/p = usr
			if(p.interface != null)
				p.interface.characterWindow()
		inventory()
			var/mob/player/p = usr
			if(p.interface != null)
				p.inv.inventory()