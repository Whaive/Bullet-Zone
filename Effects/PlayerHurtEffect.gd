extends AnimatedSprite

func _ready() -> void:
	frame = 0
	play("Animate")


func _on_PlayerHurtEffect_animation_finished() -> void:
	queue_free()
