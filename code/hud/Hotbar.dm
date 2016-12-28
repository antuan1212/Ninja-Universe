obj
	HotbarBegin
		New(client/c)
			icon = 'interface.dmi'
			icon_state = "sh01"
			layer = 999999
			c.screen+=src
			screen_loc = "8,6"
	HotbarExtend
		New(client/c)
			icon = 'interface.dmi'
			icon_state = "sh02"
			layer = 999999
			c.screen+=src
		Hotbar1
			screen_loc = "9,6"
		Hotbar2
			screen_loc = "10,6"
		Hotbar3
			screen_loc = "11,6"
		Hotbar4
			screen_loc = "12,6"
		Hotbar5
			screen_loc = "13,6"
		Hotbar6
			screen_loc = "14,6"
		Hotbar7
			screen_loc = "15,6"
		Hotbar8
			screen_loc = "16,6"
		Hotbar9
			screen_loc = "17,6"
		Hotbar0
			screen_loc = "18,6"
	HotbarEnd
		New(client/c)
			icon = 'interface.dmi'
			icon_state = "sh03"
			layer = 999999
			c.screen+=src
			screen_loc = "19,6"