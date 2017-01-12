
`clanList` is an associated list of associated lists. It first indexes the clans by village name.

Asking `clanList` for the value given a village name key results in second associated list that indexes clan type paths by name.


Example:
If we wanted to iterate through all the villages in the list

  ```for(var/villageName in clanList)```

This would iterate 3 times, once for each village in the list.

First iteration would have `villageName = "Konoha"`

Second iteration would have `villageName = "Sunagakure"`

Third iteration would have the `villageName = "Kirigakure"`



If we were to see what clans were part of Konoha village.
```
	var/list/clans = clanList["Konoha"]
	for(var/clanName in clans)
```

This would iterate seven times, once for each clan in the clans list.

First iteration would have `clanName = "Aburame"`

Second iteration would have `clanName = "Akimichi"`

...

Seventh iteration would have `clanName = "None"`


If you wanted to extract the type path of a clan.

Given `clanName = "Aburame"`

```
	var/typePath = clans[clanName]
	world << typePath // This would output: /obj/Clan/Aburame
```


`baseList` is an associated list of bases which are the keys for the different portraits of that base color.

`baseListF` is the same as `baseList`, except for female bases.



`hairColorChange` takes in the following variables:

`check`:		this represents the color passed in. (ex.: #000000 represents black)

`px`:			represents the location of the x pixel of where we clicked

`py`:			represents the location of the y pixel of where we clicked

`y_loc`:		this is used for placing the select slide bar on the appropriate slider (red, blue, and green)

`y_offset`:	same as above

`name`:		name of the color. We need this so that we can store the color in the name of the color so that if the user wants to increase or decrease the amount of said color, we can remove the amount of said color stored so that the user may do so.


This proc will remove whatever is stored in the said colors variable and the select bar associated with it,
then add whatever the new color is to the hair and add a new select.
