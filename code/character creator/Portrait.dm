obj
	portraitCreation
		New(client/c)
			var/mob/player/P = usr
			icon = P.portrait
			c.screen+=src
			screen_loc = "4:7,17:-5"
	portraitHair
		New(client/c)
			var/mob/player/P = usr
			icon = P.hairportrait
			c.screen+=src
			screen_loc = "4:7,17:-5"