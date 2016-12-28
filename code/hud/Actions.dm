obj
	actions
		Status
			New(client/c)
				icon = 'interface.dmi'
				icon_state = "status"
				layer = 999999
				c.screen+=src
				screen_loc = "2,6"
			Click()
				var/mob/player/p = usr
				p.interface.characterWindow()
		Bag
			New(client/c)
				icon = 'interface.dmi'
				icon_state = "bag"
				layer = 999999
				c.screen+=src
				screen_loc = "3,6"
			Click()
				var/mob/player/p = usr
				p.inv.inventory()
		Mission
			New(client/c)
				icon = 'interface.dmi'
				icon_state = "mission"
				layer = 999999
				c.screen+=src
				screen_loc = "4,6"
		Skills
			New(client/c)
				icon = 'interface.dmi'
				icon_state = "jutsu"
				layer = 999999
				c.screen+=src
				screen_loc = "5,6"
		Talents
			New(client/c)
				icon = 'interface.dmi'
				icon_state = "talent"
				layer = 999999
				c.screen+=src
				screen_loc = "6,6"
		Save
			New(client/c)
				icon = 'interface.dmi'
				icon_state = "save"
				layer = 999999
				c.screen+=src
				screen_loc = "7,6"
		Admin
			New(client/c)
				icon = 'interface.dmi'
				icon_state = "admin"
				layer = 999999
				c.screen+=src
				screen_loc = "24,6"