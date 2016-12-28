var
	list/villageObjs = list()	// Stores our Village Objects.

proc
	/*
		This will create an associated list of villages with name-object as the
		key-value pair.

		Example:
			villageObjs["Konoha"] is a reference to our /Village/Konoha instance.
	*/
	initVillageObjs()
		for(var/villagePath in typesof(/Village)-/Village)
			var/Village/thisVillage = new villagePath()
			villageObjs[thisVillage.name] = thisVillage

/*
	You should probably merge this with an existing world/New() call just to be consistent.
*/
world
	New()
		..()
		initVillageObjs()

/*
	The Village datum is used to make our lives as programmers a little easier. It holds
	information regarding where players will spawn, be relocated to and where their eye
	should be placed.
*/
Village
	var
		name
		spawnX;	spawnY; spawnZ
		locateX; locateY; locateZ
		eyeX; eyeY;	eyeZ
		defaultClan;

	proc
		/*
			Returns the location of the Player position this Village.
		*/
		getLocation()
			return locate(locateX, locateY, locateZ)
		/*
			Returns the location of the Eye position for this Village.
		*/
		getEyeLocation()
			return locate(eyeX, eyeY, eyeZ)

	Konoha
		name = "Konoha"
		spawnX = 209;	spawnY = 203;	spawnZ = 1
		locateX = 6;	locateY = 35;	locateZ = 20
		eyeX = 12;		eyeY = 31;		eyeZ = 20
		defaultClan = "None"

	Sunagakure
		name = "Sunagakure"
		spawnX = 165;	spawnY = 159;	spawnZ = 5
		locateX = 6;	locateY = 56; 	locateZ = 20
		eyeX = 12;		eyeY = 52;		eyeZ = 20
		defaultClan = "NoneOther"

	Kirigakure
		name = "Kirigakure"
		spawnX = 79;	spawnY = 227;	spawnZ = 11
		locateX = 6;	locateY = 77; 	locateZ = 20
		eyeX = 12;		eyeY = 73;		eyeZ = 20
		defaultClan = "NoneOther"