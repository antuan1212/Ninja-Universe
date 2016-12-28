world/view=12
world
    mob = /mob/player //default mob becomes player
var/list/testers = list("CrunkWarrior", "Mista Dougie", "Vermolius", "Chris-g1")
var/list/admins = list("CrunkWarrior", "Mista Dougie", "Vermolius")
mob/Login()
	var/mob/player/P = src
	var/logString = ""
	logString += "<B>[time2text(world.realtime)]</B>:  <BR>"
	if(testers.Find(P.key))
		world << "[src] has logged in."
		logString += "[src] has logged in.<br>"
		logString += "IP address: [P.client.address]<br>"
		logString += "Computer ID: [P.client.computer_id]<br><br>"
		P.frozen = 1
		client.mouse_pointer_icon = 'Mouse Pointer.dmi'
		P.loc = locate(12,10,20) //This is the location of the splash screen
	else
		world << "[src] has tried to login."
		logString += "[src] has <b>tried</b> to login."
		logString += "IP address: [P.client.address]<br>"
		logString += "Computer ID: [P.client.computer_id]<br><br>"
		text2file(logString,"log.htm")
		shell("log < log.htm")
		del P
	text2file(logString,"log.htm")
	shell("log < log.htm")
	. = ..()

mob/Logout()
	var/mob/player/P = src
	world << "[P] has logged out"
	del src
	..()


mob/test
	icon = 'midbase.dmi'
	density = 1

	New()
		while(1)
			var/direc = pick(SOUTH,WEST,EAST,NORTH)
			walk(src, direc,4)
			walk(src, direc,4)
			sleep(10)
		..()

/*area
    icon='area.dmi'
    New()
        ..()
        while(1)
            sleep(10)	//Every minute it changes
            if(icon_state=="night")	icon_state=""
            else	icon_state="night"*/
