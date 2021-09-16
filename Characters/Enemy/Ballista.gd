extends Area2D

var bullet = preload("res://Bullets/EnemyBullet.tscn")

var shoot = false
var canShoot = false
var fireTimer : Timer
var stopShoot = false

export(float) var fireRate = 0.95

func _ready() -> void:
	fireTimer = Timer.new()
	fireTimer.wait_time = fireRate
	fireTimer.one_shot = true
	fireTimer.connect("timeout", self, "FireTimerEnd")
	add_child(fireTimer)
	fireTimer.start()

func _process(delta: float) -> void:
	
	if stopShoot:
		return
	
	if shoot and canShoot:
		var angle = 0
		for i in range(8):
			var bulletInst = bullet.instance()
			get_tree().current_scene.add_child(bulletInst)
			var ShootTo = Vector2(cos(deg2rad(angle)), sin(deg2rad(angle)))
			bulletInst.global_position = global_position + (ShootTo * 16)
			bulletInst.SetVelocity(ShootTo)
			angle += 45
		canShoot = false
		fireTimer.start()


func Shoot(body: Node) -> void:
	shoot = true


func StopShoot(body: Node) -> void:
	shoot = false

func FireTimerEnd():
	canShoot = true

func StopShooting():
	stopShoot = true
