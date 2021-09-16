extends Area2D

onready var sprite = $Sprite
onready var particle = $CPUParticles2D

var emited = false

func _on_CheckPointArea_body_entered(body: Node) -> void:
	CheckPoint.UpdatePos(body.global_position)
	sprite.frame = 1
	if !emited:
		particle.emitting = true
		$AudioStreamPlayer2D.play()
		emited = true
