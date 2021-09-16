extends Node

var lastPosition = null
var lastGun = 3

func UpdatePos(pos):
	lastPosition = pos
	
func GetPos():
	return lastPosition

func GetGun():
	return lastGun
	
func UpdateGun(playerGun):
	lastGun = playerGun
	print("Gun updated: ", playerGun)
	print(lastGun)
