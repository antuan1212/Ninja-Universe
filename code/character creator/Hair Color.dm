obj
	ColorSlider
		var/y_loc
		var/y_offset = 0
		layer = 9999
		pixel_x = 11
		Click(location, control, params)
			var/mob/player/P = usr
			var/c = params2list(params)
			var/px = text2num(c["icon-x"])-1
			var/py = text2num(c["icon-y"])-1
			var/icon/i = new(src.icon)
			var/check = i.GetPixel(px,py, src.icon_state)
			P.creator.hairColorChange(check, px, py, src.y_loc, src.y_offset, src.name)


		Red
			y_loc=18
			icon = 'Slider-Red.dmi'
		Blue
			y_loc=17
			y_offset = 16
			icon = 'Slider-Blue.dmi'
			pixel_y = 16
		Green
			y_loc = 17
			icon = 'Slider-Green.dmi'
		select
			New(client/c, var/screen, var/color)
				layer = layer + 1
				icon = 'select.dmi'
				icon_state = "select"
				c.screen+=src
				screen_loc = screen
				name = color