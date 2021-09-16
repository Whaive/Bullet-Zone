extends Node2D

onready var tileMap = $TileMap

func _ready() -> void:
	if CheckPoint.GetPos() != null:
		$PlayerRoot/Player.global_position = CheckPoint.GetPos()
		
	if CheckPoint.GetGun() != 3:
		$PlayerRoot/Player.ChangeGun(CheckPoint.GetGun())
		
func CloseDoors():
	tileMap.set_cell(164, 4, 0, false, false, false, Vector2(0, 5))
	tileMap.set_cell(164, 5, 0, false, false, false, Vector2(0, 5))
