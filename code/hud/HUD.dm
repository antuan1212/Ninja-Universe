HUD
	var
		mob/player/p
		obj/hudbar/health/player_health
		obj/hudbar/chakra/player_chakra
		obj/portrait
	proc
		getPortrait()
			new/obj/portrait/background(p.client, "3,18")
			portrait = new/obj/portrait/face(p.client, "3:4,18:3")
			if(p.hairportrait != null)
				var/obj/hair = new/obj/portrait/hair(p.client)
				portrait.overlays += hair
		getHudBar()
			new/obj/hudbar/background(p.client)
			player_health = new(p.client)
			player_chakra = new(p.client)
		getActionIcons()
			new/obj/actions/Status(p.client)
			new/obj/actions/Bag(p.client)
			new/obj/actions/Mission(p.client)
			new/obj/actions/Skills(p.client)
			new/obj/actions/Talents(p.client)
			new/obj/actions/Save(p.client)
			if(admins.Find(p.key))
				new/obj/actions/Admin(p.client)
		getHotbar()
			new/obj/HotbarBegin(p.client)
			new/obj/HotbarExtend/Hotbar1(p.client)
			new/obj/HotbarExtend/Hotbar2(p.client)
			new/obj/HotbarExtend/Hotbar3(p.client)
			new/obj/HotbarExtend/Hotbar4(p.client)
			new/obj/HotbarExtend/Hotbar5(p.client)
			new/obj/HotbarExtend/Hotbar6(p.client)
			new/obj/HotbarExtend/Hotbar7(p.client)
			new/obj/HotbarExtend/Hotbar8(p.client)
			new/obj/HotbarExtend/Hotbar9(p.client)
			new/obj/HotbarExtend/Hotbar0(p.client)
			new/obj/HotbarEnd(p.client)
	New(var/mob/player/newP)
		p = newP
		getPortrait()
		getHudBar()
		getActionIcons()
		getHotbar()
		p.interface = new(p)
		p.inv = new(p)
