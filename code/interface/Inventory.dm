Inventory
	var
		mob/player/p
		list/obj/Item/inventorySlots[40]
		obj/Item/throwSlot
		//currentItem = 1
	proc
		inventory()
			if(winget(p, "inventory", "is-visible") == "false")
				updateInventory()
			p.interface.showWindow("inventory", p.x_inv, p.y_inv)
			p.x_inv = p.interface.position_x
			p.y_inv = p.interface.position_y
		executeThrow()
			if(p.combat.action) return
			if(throwSlot == null) return
			if(p.combat.throw())
				--throwSlot.quantity
				throwSlot.updateQt()
				if(throwSlot.quantity == 0)
					throwSlot = null
				p << output(throwSlot, "inventory.throwGrid")
		updateInventory()
			for(var/x = 1; x <= length(inventorySlots); x++)
				var/obj/Item/O = inventorySlots[x]
				if(O != null)
					O.updateQt()
				p << output(inventorySlots[x], "inventory.invGrid[x]")
			p << output(throwSlot, "inventory.throwGrid")

		insertItem(var/obj/Item/I) //Note: returning 0 does NOT mean it was unsuccessful.
			var/maxItem = I.maxItem
			for(var/x = 1; x <= inventorySlots.len; x++)
				if(inventorySlots[x] != null)
					var/obj/Item/O = inventorySlots[x]
					if(O.name == I.name)
						if(O.quantity >= maxItem)
							O.loc = p.loc
							p << "<font color='red'>Your inventory is full!</font>"
							return 0
						else
							if(O.quantity + I.quantity <= maxItem)
								O.quantity += I.quantity
								return 0
							else
								var/tmp/bigQt = O.quantity + I.quantity
								O.quantity = maxItem
								I.quantity = bigQt - O.quantity
								I.loc = p.loc
								I.updateQt()
								p << "<font color='red'>Your inventory is full!</font>"
								return I.quantity
			for(var/x = 1; x <= inventorySlots.len; x++)
				if(inventorySlots[x] == null)
					if(I.quantity <= maxItem)
						var/obj/Item/newIt = new I.type
						newIt.quantity = I.quantity
						newIt.updateQt()
						inventorySlots[x] = newIt
						del I
						updateInventory()
						return 0
					else
						var/remainingQt = I.quantity - maxItem
						I.quantity = maxItem
						inventorySlots[x] = I
						var/obj/Item/remains = new I.type
						remains.quantity = remainingQt
						remains.updateQt()
						remains.loc = p.loc
						p << "<font color='red'>Your inventory is full!</font>"
						return remains.quantity
			updateInventory()
			p << "<font color='red'>Your inventory is full!</font>"
			return 0


	New(var/mob/player/newP)
		p = newP
		insertItem(new/obj/Item/kunai_inv(50))
		insertItem(new/obj/Item/shuriken_inv(50))
		insertItem(new/obj/Item/bShuriken_inv(5))
		insertItem(new/obj/Item/needle_inv(50))



