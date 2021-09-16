extends Sprite

var time = 0
var originalPos

export(int) var gun = 0

var audio = false

func _ready() -> void:
	originalPos = global_position.y

func _process(delta: float) -> void:
		
	time += delta
	global_position.y = originalPos + (sin(time * 2) * 3)
	
	material.set_shader_param("flash_modifier", sin(time * 3) * 0.5 + 0.5)
	
	if audio and !$AudioStreamPlayer.playing:
		queue_free()


func PickGun(body: Node) -> void:
	if audio:
		return
	body.ChangeGun(gun)
	CheckPoint.UpdateGun(gun)
	$AudioStreamPlayer.play()
	$CPUParticles2D.emitting = true
	audio = true
