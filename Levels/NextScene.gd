extends Area2D

export(int) var level = 2

func _on_NextScene_body_entered(body: Node) -> void:
	if level == 2:
		get_tree().change_scene("res://Levels/World2.tscn")
	else:
		get_tree().change_scene("res://Levels/World3.tscn")
		
	CheckPoint.UpdatePos(null)
	
