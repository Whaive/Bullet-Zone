extends KinematicBody2D

var hurtFx = preload("res://Effects/PlayerHurtEffect.tscn")

onready var sprite = $Sprite
onready var animation = $AnimationPlayer
onready var flashTimer = $FlashTimer
onready var invTimer = $InvincibilityTimer
onready var charController = $CharacterController
onready var gunHandler = $GunHandler
onready var healthManager = $HealthManager
onready var audio = $AudioStreamPlayer

#var fallParticles = preload("res://Effects/LandParticles.tscn")

var time = 0
var jumpTimer = 0
var jumping = false
var moveVector : Vector2
var dead = false
var invincible = false
var fightingBoss = false

signal playerDamaged

func _ready():
	charController.Init(self)
	gunHandler.Init([self])
	healthManager.Init()
	healthManager.connect("dead", self, "Die")
	
func _process(delta: float) -> void:
	time += delta
	
	if dead:
		return
	
	if invincible:
		sprite.modulate.a = sin(time * 12) * 0.5 + 0.5
	else:
		sprite.modulate.a = 1
		
		
	# Movement
		
	
	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y = charController.GetGravity()
	moveVector = Vector2(x, y)
	charController.SetMoveVector(moveVector)
	
	if x != 0:
		animation.play("Walk")
		sprite.flip_h = x < 0
	else:
		animation.play("Idle")
		
	if Input.is_action_just_pressed("Jump"):
		charController.Jump()
	
	if Input.is_action_pressed("Jump"):
		jumpTimer += delta
	
	if Input.is_action_just_released("Jump") && !is_on_floor():
		if jumpTimer <= 0.4: # short Jump
			charController.JumpCut()
			
	if is_on_floor():
		jumpTimer = 0
			
	
		
	# Gun Handling
	
	gunHandler.SetTarget(get_global_mouse_position())
	
	if Input.is_action_pressed("Shoot"):
		gunHandler.Shoot()
		

func Hurt(dmg : int):
	if invincible:
		return
	
	dead = healthManager.Hurt(dmg)
	if dead:
		return
	var hurtInstance = hurtFx.instance()
	get_tree().current_scene.add_child(hurtInstance)
	hurtInstance.global_position = global_position
		
	invincible = true
	invTimer.start()
	FrameFreeze(0.1, 0.4)
	sprite.material.set_shader_param("flash_modifier", 1)
	flashTimer.start()
	emit_signal("playerDamaged")

func Invincible():
	pass

func Die():
	dead = true
	if fightingBoss:
		MusicController.Stop()
	get_tree().reload_current_scene()

func ChangeGun(gun):
	gunHandler.ChangeGun(gun)
	
func FrameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	yield(get_tree().create_timer(duration * timeScale), "timeout")
	Engine.time_scale = 1.0

func EndFlash() -> void:
	sprite.material.set_shader_param("flash_modifier", 0)
	

func InvincibilityEnd() -> void:
	invincible = false


func _on_BossIntro_bossEntered() -> void:
	fightingBoss = true
