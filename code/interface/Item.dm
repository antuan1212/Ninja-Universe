obj/Item
	var
		quantity
		maxItem = 99
	MouseDrag(over_object,src_location,over_location,src_control,over_control,params)
		if(src_control == "default.map") return
		var/icon/I = new(src.icon, src.icon_state)
		usr.client.mouse_pointer_icon = I
	MouseDrop(over_object,src_location,over_location,src_control,over_control,params)
		var/mob/player/p = usr
		p.client.mouse_pointer_icon = 'Mouse Pointer.dmi'
		if(findtext(src_control,"inventory",1,15) && over_control == "default.map")
			src.loc = p.loc
			var/number = copytext(src_control, 18,20)
			p.inv.inventorySlots[text2num(number)] = null
			p.inv.updateInventory()
		else if(over_control == "inventory.throwGrid" && findtext(src_control,"inventory.inv",1,15))
			changeItems(src_control, over_control, over_object)
		else if(src_control == "inventory.throwGrid" && findtext(over_control,"inventory.inv",1,15))
			changeItems(over_control, src_control, src)
		else if(findtext(over_control,"inventory.inv",1,15))
			var/tmp/holder
			var/number = copytext(over_control, 18,20)
			holder = p.inv.inventorySlots[text2num(number)]
			p.inv.inventorySlots[text2num(number)] = src
			number = copytext(src_control, 18,20)
			p.inv.inventorySlots[text2num(number)] = holder
			p.inv.updateInventory()
		winset(p, "default", "focus=true")
	Click(location,control,params)
		if(control == "default.map")
			var/mob/player/p = usr
			if(p in view(1, src))
				var/obj/Item/I = new src.type
				I.quantity = src.quantity
				p.inv.updateInventory()
				if(p.inv.insertItem(I) == 0)
					del src
				else
					src.updateQt()
		//else
		//	world << src.quantity
	New(var/qt = 1)
		quantity = qt
		src.updateQt()
	proc
		changeItems(var/inventoryControl, var/otherControl, var/obj/overObject=null)
			var/mob/player/p = usr
			var/tmp/holder
			var/number = copytext(inventoryControl, 18,20)
			holder = p.inv.inventorySlots[text2num(number)]
			p.inv.inventorySlots[text2num(number)] = overObject
			p.inv.throwSlot = holder
			p.inv.updateInventory()
		updateQt()
			src.overlays = null
			var/obj/i = new
			i.icon = 'inventory amounts.dmi'
			var/obj/i2 = new
			i2.icon = 'inventory amounts.dmi'
			var/string = num2text(src.quantity)
			var/first_char
			var/second_char
			if(lentext(string) == 1)
				first_char = "0"
				second_char = copytext(string,1,2)
			else if(lentext(string) == 2)
				first_char = copytext(string,1,2)
				second_char = copytext(string,2,3)
			i.icon_state = "[first_char]"
			i2.icon_state = "-[second_char]"
			src.overlays += i
			src.overlays += i2
	shuriken_inv
		name = "shurikenInv"
		icon = 'Weapons.dmi'
		icon_state = "inv_shuriken"
		maxItem = 99
	kunai_inv
		name = "kunaiInv"
		icon = 'Weapons.dmi'
		icon_state = "inv_kunai"
		maxItem = 99
	bShuriken_inv
		name = "bShurikenInv"
		icon = 'Weapons.dmi'
		icon_state = "inv_bshuriken"
		maxItem = 5
	needle_inv
		name = "needleInv"
		icon = 'Weapons.dmi'
		icon_state = "needle"
		maxItem = 99