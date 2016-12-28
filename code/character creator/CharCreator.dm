CharCreator
	var
		mob/player/p					// The player that this CharCreator is handling.
		currentClan		= "None"		// The currently selected Clan.
		currentVillage	= ""		    // The currently selected Village. (Determines available clans.)
		//currentPortrait = '03.dmi'
		baseindex 		= 1
		portraitindex   = 1
		currentHair 	= 1
		faceindex		= 1
		redHair			= "#000000"
		blueHair		= "#000000"
		greenHair		= "#000000"
		list
			/*
				clanList is an associated list of associated lists. It first indexes the clans by village name.
				Asking clanList for the value given a village name key results in second associated list that indexes
				clan type paths by name.

				Example:
					If we wanted to iterate through all the villages in the list.
					for(var/villageName in clanList)
						This would iterate 3 times, once for each village in the list.
						First iteration would have villageName = "Konoha"
						Second iteration would have villageName = "Sunagakure"
						Third iteration would have the villageName = "Kirigakure"

					If we were to see what clans were part of Konoha village.
						var/list/clans = clanList["Konoha"]
						for(var/clanName in clans)
							This would iterate seven times, once for each clan in the clans list.
							First iteration would have clanName = "Aburame"
							Second iteration would have clanName = "Akimichi"
							...
							Seventh iteration would have clanName = "None"

					If you wanted to extract the type path of a clan.
						Given clanName = "Aburame"
						var/typePath = clans[clanName]

						world << typePath // This would output: /obj/Clan/Aburame
			*/
			clanList = list("Konoha"		= list("Aburame" 	= /obj/Clan/Aburame,
												   "Akimichi"	= /obj/Clan/Akimichi,
												   "Hyuuga"		= /obj/Clan/Hyuuga,
												   "Inuzuka"	= /obj/Clan/Inuzuka,
												   "Nara" 		= /obj/Clan/Nara,
												   "Uchiha"		= /obj/Clan/Uchiha,
												   "None" 		= /obj/Clan/None),
							"Sunagakure"	= list("Sand"		= /obj/Clan/Sand,
							 					   "Puppet" 	= /obj/Clan/Puppet,
												   "NoneOther"	= /obj/Clan/NoneOther),
							"Kirigakure"	= list("Haku"		= /obj/Clan/Haku,
												   "Kaguya" 	= /obj/Clan/Kaguya,
												   "NoneOther"	= /obj/Clan/NoneOther)
							)

			/***
			baseList is an associated list of bases which are the keys for the different portraits of that base color.
			baseListF is the same as baseList, except for female bases.
			***/
			baseList = list('palebase.dmi' = list('03.dmi','06.dmi', '09.dmi'),
							'midbase.dmi'  = list('01.dmi', '04.dmi', '07.dmi'),
							'darkbase.dmi' = list('02.dmi','05.dmi', '08.dmi')
							)
			baseListF = list('palebasef.dmi' = list('03f.dmi','06f.dmi', '09f.dmi'),
							 'midbasef.dmi'  = list('01f.dmi', '04f.dmi', '07f.dmi'),
							 'darkbasef.dmi' = list('02f.dmi','05f.dmi', '08f.dmi')
							)
			hairlist = list(null, 'naruto.dmi', 'anko.dmi', 'sakura.dmi', 'shaved.dmi') 						//represents the list of possible hairs that a user can add to his icon.
			hairportraits = list(null, 'NarutoHairPortrait.dmi', 'ankop.dmi', 'sakurazp.dmi', 'shavedp.dmi')	//represents the list of portraits of hairs that a user can add to their portrait.

		/***
			hairColorChange takes in the following variables:
			check:		this represents the color passed in. (ex.: #000000 represents black)
			px:			represents the location of the x pixel of where we clicked
			py:			represents the location of the y pixel of where we clicked
			y_loc:		this is used for placing the select slide bar on the appropriate slider (red, blue, and green)
			y_offset:	same as above
			name:		name of the color. We need this so that we can store the color in the name of the color so that if the user wants to
						increase or decrease the amount of said color, we can remove the amount of said color stored so that the user may do so.

			This proc will remove whatever is stored in the said colors variable and the select bar associated with it,
			then add whatever the new color is to the hair and add a new select.
		***/
	proc
		hairColorChange(var/check, var/px, var/py, var/y_loc, var/y_offset, var/name)
			if(currentHair == 1)
				p << "Please select a hair first."
				return
			if(check == null) return
			if(name == "Red")
				hairlist[currentHair] -= redHair
				hairportraits[currentHair] -= redHair
				redHair = check
				for(var/obj/ColorSlider/select/s in p.client.screen)
					if(s.name == "Red")
						del s
				new/obj/ColorSlider/select(p.client, "11:[px+9],[y_loc]:[y_offset]", "Red")
			else if(name == "Blue")
				hairlist[currentHair] -= blueHair
				hairportraits[currentHair] -= blueHair
				blueHair = check
				for(var/obj/ColorSlider/select/s in p.client.screen)
					if(s.name == "Blue")
						del s
				new/obj/ColorSlider/select(p.client, "11:[px+9],[y_loc]:[y_offset]", "Blue")
			else if(name == "Green")
				hairlist[currentHair] -= greenHair
				hairportraits[currentHair] -= greenHair
				greenHair = check
				for(var/obj/ColorSlider/select/s in p.client.screen)
					if(s.name == "Green")
						del s
				new/obj/ColorSlider/select(p.client, "11:[px+9],[y_loc]:[y_offset]", "Green")
			//world << "Test: [check]"
			//world << "[px], [py]"
			hairportraits[currentHair] += check
			getHairPortrait()
			p.overlays -= hairlist[currentHair]
			hairlist[currentHair] += check
			p.overlays +=  hairlist[currentHair]
			p.client.screen -= /obj/ColorSlider/select

		/***
			Takes in the villages' name as a parameter.
			It will then set the appropriate variables of the user so that he's in the correct village and update the clans.
		***/
		changeVillage(var/newVillage)
			if(newVillage == currentVillage) return //No need to execute if the village is the same as it already is
			currentVillage = newVillage
			var/Village/theVillage = villageObjs[currentVillage]
			p.spawnx = theVillage.spawnX
			p.spawny = theVillage.spawnY
			p.spawnz = theVillage.spawnZ
			p.loc = locate(theVillage.locateX, theVillage.locateY, theVillage.locateZ)
			p.client.eye = locate(theVillage.eyeX, theVillage.eyeY, theVillage.eyeZ)
			updateClans()
			changeClan(theVillage.defaultClan)

		/*
			Upon changing clan to newClan we must first reset the icon of the old clan.
			Then we update newClan's image to appropriately show the new selection.
		*/
		changeClan(var/newClan)
			// No need to execute if we haven't changed clans.
			var/list/clans = clanList[currentVillage]
			for(var/obj/Clan/clanObj in p.client.screen)
				// Reset the old selection when we find it.
				//if(istype(clanObj, clans[currentClan]) )
				clanObj.icon = initial(clanObj.icon)
				currentClan = newClan
				// Change the new selection when we find it.
				if(istype(clanObj, clans[newClan]) )
					clanObj.icon   = clanObj.altIcon
					//set player's stats to what they receive from the clan's defaults
					p.maxHealth    = clanObj.maxHealth
					p.maxChakra    = clanObj.maxChakra
					p.strength     = clanObj.strength
					p.defense      = clanObj.defense
					p.intelligence = clanObj.intelligence
					p.dexterity    = clanObj.dexterity
					p.willpower    = clanObj.willpower

		/*
			This would take the place of mob/proc/getClans()
		*/
		updateClans()
			// I probably wouldn't be deleting and recreating these but that's a different matter.
			for(var/obj/Clan/O in p.client.screen)
				del O

			// Add a new object of the form /obj/Clan
			var/list/clans = clanList[currentVillage]
			for(var/clanName in clans)
				var/typePath = clans[clanName]
				new typePath(p.client)


		//Changes to the next skin color and checks new portrait accordingly.
		nextBase()
			if(p.gender == "male")
				nextBaseMale()
			else if(p.gender == "female")
				nextBaseFemale()
			getNewPortrait(-1)

		//Changes to the previous skin color and checks new portrait accordingly.
		prevBase()
			if(p.gender == "male")
				prevBaseMale()
			else if(p.gender == "female")
				prevBaseFemale()
			getNewPortrait(-1)

		nextBaseMale()
			baseindex += 1
			if(baseindex > length(baseList))
				baseindex = 1
			p.icon = baseList[baseindex]

		nextBaseFemale()
			baseindex += 1
			if(baseindex > length(baseList))
				baseindex = 1
			p.icon = baseListF[baseindex]

		prevBaseMale()
			baseindex -= 1
			if(baseindex <= 0)
				baseindex = length(baseList)
			p.icon = baseList[baseindex]

		prevBaseFemale()
			baseindex -= 1
			if(baseindex <= 0)
				baseindex = length(baseListF)
			p.icon = baseListF[baseindex]

		changeGenderMale()
			if (p.gender == "male") return
			p.gender = "male"
			p.icon = baseList[baseindex]
			getNewPortrait(-1)

		changeGenderFemale()
			if (p.gender == "female") return
			p.gender = "female"
			p.icon = baseListF[baseindex]
			getNewPortrait(-1)

		getNewPortrait(var/forward = 1)
			for(var/obj/portraitCreation/O in p.client.screen)
				del O
			if(p.gender == "male")
				var/list/portraits = baseList[p.icon]
				if(forward == 1)
					faceindex ++
					if(faceindex > length(baseList))
						faceindex = 1
				else if(forward == 0)
					faceindex --
					if(faceindex <= 0)
						faceindex = length(baseList)
				p.portrait = portraits[faceindex]
			else if(p.gender == "female")
				var/list/portraits = baseListF[p.icon]
				if(forward == 1)
					faceindex ++
					if(faceindex > length(baseListF))
						faceindex = 1
				else if(forward == 0)
					faceindex --
					if(faceindex <= 0)
						faceindex = length(baseListF)
				p.portrait = portraits[faceindex]

			new/obj/portraitCreation(p.client)
			getHairPortrait()

		changeFaceNext()
			getNewPortrait(1)

		changeFacePrev()
			getNewPortrait(0)

		nextHair()
			p.overlays = null
			currentHair++
			if(currentHair > length(hairlist))
				currentHair = 1
			p.overlays += hairlist[currentHair]
			getHairPortrait()

		prevHair()
			p.overlays = null
			currentHair--
			if(currentHair <= 0)
				currentHair = length(hairlist)
			p.overlays += hairlist[currentHair]
			getHairPortrait()

/*		GetRed()
			var/hex = uppertext(redHair)
			var
				hi = text2ascii(hex, 2)
				lo = text2ascii(hex, 3)
			return ( ((hi >= 65 ? hi-55 : hi-48)<<4) | (lo >= 65 ? lo-55 : lo-48) )

		GetGreen()
			var/hex = uppertext(greenHair)
			var
				hi = text2ascii(hex, 4)
				lo = text2ascii(hex, 5)
			return ( ((hi >= 65 ? hi-55 : hi-48)<<4) | (lo >= 65 ? lo-55 : lo-48) )

		GetBlue()
			var/hex = uppertext(blueHair)
			var
				hi = text2ascii(hex, 6)
				lo = text2ascii(hex, 7)
			return ( ((hi >= 65 ? hi-55 : hi-48)<<4) | (lo >= 65 ? lo-55 : lo-48) )
*/
		getHairPortrait()
			p.hairportrait = hairportraits[currentHair]
			for(var/obj/portraitHair/O in p.client.screen)
				del O
			new/obj/portraitHair(p.client)

		finish()
			p.clan = currentClan
			p.village = currentVillage
			p.hair = hairlist[currentHair]
			p.client.eye = p.client.mob
			p.client.perspective = MOB_PERSPECTIVE
			p.invisibility = 0
			p.loc = locate(p.spawnx, p.spawny, p.spawnz)
			p.frozen = 0
			p.pixel_y = 0
			p.pixel_x = 0
			p.health = p.maxHealth
			p.chakra = p.maxChakra
			for(var/obj/portraitHair/O in p.client.screen)
				del O
			for(var/obj/portraitCreation/O in p.client.screen)
				del O
			for(var/obj/Clan/O in p.client.screen)
				del O
			for(var/obj/ColorSlider/O in p.client.screen)
				del O
			p.hud = new(p)
			p.combat = new(p)
			del src

	New(var/mob/player/newP)
		p = newP
		p.loc = locate(6,35,20)
		p.client.perspective = EYE_PERSPECTIVE
		p.client.eye = locate(12,31,20)
		p.icon = 'palebase.dmi'
		p.pixel_x = 3
		p.pixel_y = 15
		p.invisibility = 1
		p.sight = SEE_SELF
		updateClans()
		changeVillage("Konoha")
		getNewPortrait(-1)