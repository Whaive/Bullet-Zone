extends Area2D

var dmg = 3
onready var audio = $AudioStreamPlayer

var bullet = preload("res://Bullets/EnemyBullet.tscn")

var velocity : Vector2
var speed = 60

func _ready() -> void:
	audio.play()
	
func _process(delta: float) -> void:
	global_position += speed * delta * Vector2.DOWN

func SummonBullets() -> void:
	var angle = 0
	for i in range(8):
		var bulletInst = bullet.instance()
		get_tree().current_scene.add_child(bulletInst)
		var ShootTo = Vector2(cos(deg2rad(angle)), sin(deg2rad(angle)))
		bulletInst.global_position = global_position + (ShootTo * 16)
		bulletInst.SetVelocity(ShootTo)
		angle += 45

func OffScreen() -> void:
	queue_free()


func OnCollision(body: Node) -> void:
	if body.has_method("Hurt"):
		body.Hurt(dmg)
	SummonBullets()
	queue_free()
