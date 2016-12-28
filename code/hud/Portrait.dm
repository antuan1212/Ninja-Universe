obj
	portrait
		background
			New(client/c, var/scrLoc)
				icon = 'portraitBG.dmi'
				layer = 999999
				c.screen+=src
				screen_loc = scrLoc//"3,18"
		face
			New(client/c, var/scrLoc)
				var/mob/player/p = usr
				icon = p.portrait
				layer = 999999
				screen_loc = scrLoc
				c.screen+=src
		hair
			New(client/c)
				var/mob/player/p = usr
				icon = p.hairportrait
				layer = 999999
				//screen_loc = scrLoc//"3:4,18:3"
				//c.screen+=src