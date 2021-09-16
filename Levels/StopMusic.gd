extends Area2D



func _on_StopMusic_body_entered(body: Node) -> void:
	MusicController.Stop()
