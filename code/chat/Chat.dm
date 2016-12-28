mob/player
	verb
		Say(t as text)
			if(t)
				view() << output("<font color=#603311>[src] says:</font> [t]", "chatOutput")
		WorldChat(t as text)
			if(t)
				world << output("<b>[src]</b>: <font color=#329555>[t]</font>","chatOutput")

mob/player
	verb
		openChat()
			var/mob/player/p = usr
			if(p.interface)
				p.interface.showWindow("chatSwitch", 33, 465)
		closeChat()
			winshow(src, "chatSwitch", 0)
		changeGlobal()
			winset(src,"inputDefault","command='WorldChat'")
			winset(src,"chatButton","text='GLOBAL'")
			winshow(src, "chatSwitch", 0)
		changeSay()
			winset(src,"inputDefault","command='Say'")
			winset(src,"chatButton","text='SAY'")
			winshow(src, "chatSwitch", 0)