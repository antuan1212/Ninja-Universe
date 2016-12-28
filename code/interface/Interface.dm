Interface
	var
		mob/player/p
		position_x
		position_y

	proc
		showWindow(var/cont as text, var/posx as num, var/posy as num)
			var/position = winget(p, "default", "pos");
			var/delimiter = findtext(position, ",")
			var/formX = text2num(copytext(position, 1, delimiter));
			var/formY = text2num(copytext(position, delimiter + 1, 0));
			if(winget(p, cont, "is-visible") == "false")
				winset(p, cont, "pos=[formX+posx],[formY+posy]")
				winshow(p, cont, 1)
			else
				winshow(p, cont, 0)
				var/posOfCont = winget(p, cont, "pos");
				var/delimeterOfCont = findtext(posOfCont, ",")
				position_x = text2num(copytext(posOfCont, 1, delimeterOfCont))- formX;
				position_y = text2num(copytext(posOfCont, delimeterOfCont + 1, 0)) - formY;
			winset(p, "default", "focus=true")

		characterWindow()
			winset(p,"nameLabel","text='[p.name]'")
			winset(p,"clanLabel","text='[p.clan]'")
			winset(p,"villageLabel","text='[p.village]'")
			winset(p,"rankLabel","text='[p.rank]'")
			new/obj/portraitForWind/portraitBG(p.client)
			var/obj/portrait = new/obj/portraitForWind/faceportrait(p.client)
			portrait.overlays = p.hud.portrait.overlays
			//winset(p,"status.portrait","image='[p.portrait]'")
			showWindow("status", p.x_character, p.y_character)
			p.x_character = position_x
			p.y_character = position_y

	New(var/mob/player/newP)
		p = newP

obj
	portraitForWind
		New(client/c)
			screen_loc = "portrait:SOUTH,WEST to 1,1"
			c.screen+=src
		portraitBG
			New(client/c)
				icon = 'pBG.dmi'
				..()
		faceportrait
			New(client/c)
				var/mob/player/p = usr
				icon = p.portrait
				..()