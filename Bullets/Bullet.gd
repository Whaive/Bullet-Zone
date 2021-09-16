extends Area2D

var bulletFx = preload("res://Bullets/BulletExplode.tscn")
var failBulletFx = preload("res://Bullets/BulletExplodeFail.tscn")

onready var audio = $AudioStreamPlayer

var velocity : Vector2
export(int) var speed = 300
var bodiesToExclude = []

export(int) var dmg = 1

func _ready() -> void:
	audio.pitch_scale = rand_range(0.7, 1.3)
	audio.play()

func _physics_process(delta: float) -> void:
	
	global_position += velocity.normalized() * speed * delta
	"""var collision = move_and_collide(velocity.normalized() * speed * delta)
	if collision:
		var collider = collision.collider
		if collider.has_method("Hurt"):
			collider.Hurt(dmg)
			DestroyBullet(bulletFx)
		else:
			DestroyBullet(failBulletFx)
	"""
	
func SetVelocity(direction : Vector2):
	velocity = direction

func SetBodiesToExclude(_bodiesToExclude : Array):
	bodiesToExclude = _bodiesToExclude
	
func DestroyBullet(fx):
	var bulletFxInst = fx.instance()
	get_tree().current_scene.add_child(bulletFxInst)
	bulletFxInst.global_position = global_position
	queue_free()

func OffScreen() -> void:
	queue_free()


func OnCollision(body: Node) -> void:
	if body.has_method("Hurt"):
		body.Hurt(dmg)
		DestroyBullet(bulletFx)
	else:
		DestroyBullet(failBulletFx)
