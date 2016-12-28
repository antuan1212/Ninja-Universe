obj
	Clan
		icon_state = "0,0"

		var
			icon/altIcon = null
			maxHealth
			maxChakra
			strength
			defense
			willpower
			intelligence
			dexterity

		Click()
			var/mob/player/P = usr
			P.creator.changeClan(src.name)

		New(var/client/theClient)
			theClient.screen += src

		Aburame
			altIcon		= 'aburameSEL.dmi'
			icon		= 'aburame.dmi'
			screen_loc	= "3:10,7:13"
			maxHealth	= 1000
			maxChakra	= 1000
			strength	= 100
			defense		= 100
			willpower	= 100
			intelligence= 100
			dexterity	= 100

		Akimichi
			altIcon		= 'akimichiSEL.dmi'
			icon		= 'akimichi.dmi'
			screen_loc	= "5:15,7:13"
			maxHealth	= 1000
			maxChakra	= 1000
			strength	= 100
			defense		= 100
			willpower	= 100
			intelligence= 100
			dexterity	= 100

		Hyuuga
			altIcon		= 'hyuugaSEL.dmi'
			icon		= 'hyuuga.dmi'
			screen_loc	= "7:20,7:13"
			maxHealth	= 1000
			maxChakra	= 1000
			strength	= 100
			defense		= 100
			willpower	= 100
			intelligence= 100
			dexterity	= 100

		Inuzuka
			altIcon		= 'inuzukaSEL.dmi'
			icon		= 'inuzuka.dmi'
			screen_loc	= "9:25,7:13"
			maxHealth	= 1000
			maxChakra	= 1000
			strength	= 100
			defense		= 100
			willpower	= 100
			intelligence= 100
			dexterity	= 100

		Nara
			altIcon		= 'naraSEL.dmi'
			icon		= 'nara.dmi'
			screen_loc	= "11:30,7:13"
			maxHealth	= 1000
			maxChakra	= 1000
			strength	= 100
			defense		= 100
			willpower	= 100
			intelligence= 100
			dexterity	= 100

		Uchiha
			altIcon		= 'uchihaSEL.dmi'
			icon		= 'uchiha.dmi'
			screen_loc	= "13:35,7:13"
			maxHealth	= 1000
			maxChakra	= 1000
			strength	= 100
			defense		= 100
			willpower	= 100
			intelligence= 100
			dexterity	= 100

		None
			altIcon		= 'noneSEL.dmi'
			icon		= 'none.dmi'
			screen_loc	= "15:40,7:13"
			maxHealth	= 1000
			maxChakra	= 1000
			strength	= 100
			defense		= 100
			willpower	= 100
			intelligence= 100
			dexterity	= 100

		Sand
			altIcon		= 'sandSEL.dmi'
			icon		= 'sand.dmi'
			screen_loc	= "4:10,7:13"
			maxHealth	= 1000
			maxChakra	= 1000
			strength	= 100
			defense		= 100
			willpower	= 100
			intelligence= 100
			dexterity	= 100

		Puppet
			altIcon		= 'puppetSEL.dmi'
			icon		= 'puppet.dmi'
			screen_loc	= "6:15,7:13"
			maxHealth	= 1000
			maxChakra	= 1000
			strength	= 100
			defense		= 100
			willpower	= 100
			intelligence= 100
			dexterity	= 100

		NoneOther
			//name = "None"
			altIcon		= 'noneSEL.dmi'
			icon		= 'none.dmi'
			screen_loc	= "8:20,7:13"
			maxHealth	= 1000
			maxChakra	= 1000
			strength	= 100
			defense		= 100
			willpower	= 100
			intelligence= 100
			dexterity	= 100

		Haku
			altIcon		= 'hakuSEL.dmi'
			icon		= 'haku.dmi'
			screen_loc	= "4:10,7:13"
			maxHealth	= 1000
			maxChakra	= 1000
			strength	= 100
			defense		= 100
			willpower	= 100
			intelligence= 100
			dexterity	= 100

		Kaguya
			altIcon		= 'kaguyaSEL.dmi'
			icon		= 'kaguya.dmi'
			screen_loc	= "6:15,7:13"
			maxHealth	= 1000
			maxChakra	= 1000
			strength	= 100
			defense		= 100
			willpower	= 100
			intelligence= 100
			dexterity	= 100