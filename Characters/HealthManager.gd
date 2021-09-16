extends Node2D

export(int) var maxHealth = 3
export(AudioStream) var hurtSound
var health

signal dead

func Init():
	health = maxHealth
	$AudioStreamPlayer.stream = hurtSound
	
func _process(delta: float) -> void:
	if global_position.y > 190:
		Hurt(1000)

func Hurt(dmg):
	health -= dmg
	if $AudioStreamPlayer.stream:
		$AudioStreamPlayer.play()
	if health <= 0:
		emit_signal("dead")
		return true
