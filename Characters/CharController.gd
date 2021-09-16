extends Node2D

var body : KinematicBody2D = null
var movement : Vector2
var moveVector : Vector2
var pressedJump = false
var isOnWall = false

export var moveSpeed = 200.0
export var jumpHeight = 5.0
export var timeToPeak = 5.0
export var timeToFall = 5.0

export(AudioStream) var audio
onready var jumpAudio = $AudioStreamPlayer

var cut = false
var jumping = false

onready var jumpVelocity = ((2.0 * jumpHeight) / timeToPeak) * -1.0
onready var jumpGravity = ((-2.0 * jumpHeight) / pow(timeToPeak, 2)) * -1.0
onready var fallGravity = ((-2.0 * jumpHeight) / pow(timeToFall, 2)) * -1.0


func Init(_body : KinematicBody2D):
	body = _body
	jumpAudio.stream = audio

func _physics_process(delta: float) -> void:
	
	isOnWall = body.is_on_wall()
	
	# Movement
	movement.y += moveVector.y * delta
	movement.x = moveVector.x * moveSpeed
	movement = body.move_and_slide(movement, Vector2.UP)
	
	# Jump
	var grounded = body.is_on_floor()
	#if grounded:
	#	cut = false
		
	if grounded and pressedJump:
		if jumpAudio.stream:
			jumpAudio.play()
		movement.y = jumpVelocity
		jumping = true
		
	if jumping and cut:
		movement.y = jumpVelocity/2
		jumping = false
	cut = false
	pressedJump = false


func GetGravity() -> float:
	if cut:
		return jumpGravity*2 if movement.y < 0.0 else fallGravity*1.5
	return jumpGravity if movement.y < 0.0 else fallGravity

func Jump():
	pressedJump = true
	
func JumpCut():
	cut = true

	
func SetMoveVector(_moveVector : Vector2):
	moveVector = _moveVector
	
func IsOnWall() -> bool:
	return isOnWall
