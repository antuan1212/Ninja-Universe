obj
	hudbar
		background
			New(client/c)
				icon = 'hudbar.dmi'
				layer = 999999
				c.screen+=src
				screen_loc = "4:28,18:8"
		health
			New(client/c)
				icon = 'Health Meter.dmi'
				icon_state = "100"
				layer = 9999999
				screen_loc = "5:12,19:9"
				c.screen+=src

		chakra
			New(client/c)
				icon = 'Chakra Meter.dmi'
				icon_state = "100"
				layer = 9999999
				screen_loc = "5:12,18:27"
				c.screen+=src
