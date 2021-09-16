extends KinematicBody2D

var moveVector : Vector2

onready var animation = $AnimationPlayer
onready var sprite = $Sprite
onready var groundCheck = $GroundCheck
onready var flashTimer = $FlashTimer
onready var charController = $CharacterController
onready var gunHandler = $GunHandler
onready var healthManager = $HealthManager

var deathFx = preload("res://Effects/EnemyKill.tscn")

var player = null
var dead = false
var idle = true

export(bool) var stopOnLedge = false

func _ready():
	charController.Init(self)
	gunHandler.Init([self])
	healthManager.Init()
	healthManager.connect("dead", self, "Die")
	
	player = get_tree().get_nodes_in_group("player")[0]
	
func _process(delta: float) -> void:
	
	if dead:
		return
	
	if !idle:
		#if groundCheck.is_colliding():
		moveVector.x = sign(player.global_position.x - global_position.x)
		#else:
		#	moveVector.x = 0
	else:
		moveVector.x = 0
	
	moveVector.y = charController.GetGravity()
	
	if moveVector.x != 0:
		animation.play("Walk")
		sprite.flip_h = moveVector.x < 0
	else:
		animation.play("Idle")
		
	
	if charController.IsOnWall() || !groundCheck.is_colliding():
		if !stopOnLedge:
			charController.Jump()
		else:
			moveVector.x = 0
			
	charController.SetMoveVector(moveVector)
			
	if idle:
		return	
		
	gunHandler.SetTarget(player.global_position)
	gunHandler.Shoot()
	
func Hurt(dmg : int):
	healthManager.Hurt(dmg)
	sprite.material.set_shader_param("flash_modifier", 1)
	flashTimer.start()
	idle = false
	
func Die():
	dead = true
	var deathFxInst = deathFx.instance()
	get_tree().current_scene.add_child(deathFxInst)
	deathFxInst.global_position = global_position
	deathFxInst.emitting = true
	queue_free()
	
func EndFlash():
	sprite.material.set_shader_param("flash_modifier", 0)


func Chase(body: Node) -> void:
	idle = false
	


func StopChase(body: Node) -> void:
	idle = true
