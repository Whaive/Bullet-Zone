extends KinematicBody2D

onready var healthManager = $HealthManager
onready var sprite = $Skull
onready var flashTimer = $FlashTimer
onready var chargeTime = $ChargeTime
onready var dieTimer = $Die
onready var rect = $CanvasLayer/ColorRect

var dead = false
var ChargedAttack = false
var deathFx = preload("res://Effects/EnemyKill.tscn")
var normalSkull 
var AngrySkull = preload("res://Assets/AngrySkull.png")
var gigaBulelt = preload("res://Bullets/GigaBullet.tscn")

var speed = 60
var started = false

var dir = Vector2.RIGHT
var curPosition

func _ready() -> void:
	healthManager.Init()
	normalSkull = sprite.texture
	curPosition = global_position
	
func _physics_process(delta: float) -> void:
	
	if !started:
		return
	
	if dead:
		global_position = curPosition + (Vector2.ONE * rand_range(-5, 5))
		rect.color.a += .004
		if rect.color.a >= 1:
			get_tree().change_scene("res://Levels/EndScene.tscn")
		
	
	var collision
	if ChargedAttack:
		move_and_collide(Vector2.ZERO)
	else:		
		collision = move_and_collide(dir * speed * delta)
	
		
	if collision:
		if dir == Vector2.LEFT:
			dir = Vector2.RIGHT
		elif dir == Vector2.RIGHT:
			dir = Vector2.LEFT
		
		

func Hurt(dmg : int):
	if dead:
		return
	healthManager.Hurt(dmg)
	sprite.material.set_shader_param("flash_modifier", 1)
	flashTimer.start()
	
func Die():
	dead = true
	curPosition = global_position
	sprite.texture = AngrySkull
	dieTimer.start()
	$Ballista.StopShooting()
	$Ballista2.StopShooting()
	MusicController.Stop()
	
func FlashTimer():
	sprite.material.set_shader_param("flash_modifier", 0)


func _on_ChargedAtatck_timeout() -> void:
	if dead or !started: 
		return
	var random = randi() % 10
	if random == 8:
		sprite.texture = AngrySkull
		chargeTime.start()
		ChargedAttack = true


func _on_ChargeTime_timeout() -> void:
	if dead or !started:
		return
	var gigaInstance = gigaBulelt.instance()
	gigaInstance.global_position = $GigaSpawn.global_position
	get_tree().current_scene.add_child(gigaInstance)
	ChargedAttack = false
	sprite.texture = normalSkull
	
func SpawnDeathParticles():
	var deathFxInst = deathFx.instance()
	get_tree().current_scene.add_child(deathFxInst)
	deathFxInst.global_position = global_position + (Vector2(rand_range(-20, 20), rand_range(-10, 10)))
	deathFxInst.emitting = true
	dieTimer.start()


func _on_BossIntro_bossEntered() -> void:
	global_position.y = 40
	started = true
