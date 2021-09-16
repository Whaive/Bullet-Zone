extends Area2D

signal bossEntered

func _on_BossIntro_body_entered(body: Node) -> void:
	MusicController.PlayBossTheme()
	emit_signal("bossEntered")
	queue_free()
