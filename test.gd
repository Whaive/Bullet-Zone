extends Sprite

var bullet = preload("res://Bullets/EnemyBullet.tscn")

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Jump"):
		var angle = 0
		for i in range(4):
			var bulletInst = bullet.instance()
			get_tree().current_scene.add_child(bulletInst)
			bulletInst.global_position = global_position
			bulletInst.SetVelocity(Vector2(cos(deg2rad(angle)), sin(deg2rad(angle))))
			angle += 90
