extends Position2D

onready var player = get_node("../Player/FollowPoint")

var lock = false

func _process(delta: float) -> void:
	
	var targetPosX
	if lock:
		targetPosX = int(lerp(global_position.x, 2800, 0.1))
	else:
		var target = player.global_position
		targetPosX = int(lerp(global_position.x, target.x, 0.8))
	
	global_position = Vector2(targetPosX, global_position.y)
	

func LockCamera():
	lock = true


func _on_BossIntro_bossEntered() -> void:
	LockCamera()
