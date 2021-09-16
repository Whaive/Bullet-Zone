extends Node2D

export(Resource) var bullet = preload("res://Bullets/Bullet.tscn")
export(float) var fireRate = 2
export(int) var recoil = 6
export(bool) var hasRotation = false
export(int) var angleToShoot = 25

onready var sprite = $Sprite
onready var firePoint = $FirePoint
onready var firePoint2 = $FirePoint2
var currentFirePoint
var fireTimer : Timer
var canShoot = true
var bodiesToExclude = []

func _ready() -> void:
	fireTimer = Timer.new()
	fireTimer.wait_time = fireRate
	fireTimer.one_shot = true
	fireTimer.connect("timeout", self, "FireTimerEnd")
	add_child(fireTimer)
	currentFirePoint = firePoint

func Shoot(pos : Vector2, rotationAngle):
	if !canShoot:
		return
	
	if hasRotation:
		var angle = rotationAngle - angleToShoot
		for i in range(4):
			var bulletInst = bullet.instance()
			get_tree().current_scene.add_child(bulletInst)
			bulletInst.global_position = currentFirePoint.global_position
			bulletInst.SetVelocity(Vector2(cos(deg2rad(angle)), sin(deg2rad(angle))))
			angle += angleToShoot
	else:
		var bulletInst = bullet.instance()
		get_tree().current_scene.add_child(bulletInst)
		bulletInst.global_position = currentFirePoint.global_position
		var randomRecoil = Vector2.ONE * round(rand_range(-recoil, recoil))
		bulletInst.SetVelocity(pos - bulletInst.global_position + randomRecoil)
		
	canShoot = false
	fireTimer.start()
	
func FireTimerEnd():
	canShoot = true
	
func SetBodiesToExclude(_bodiesToExclude : Array):
	bodiesToExclude = _bodiesToExclude
	
func FlipSprite(flip : bool):
	sprite.flip_v = flip
	if flip == true:
		currentFirePoint = firePoint2
	else:
		currentFirePoint = firePoint
