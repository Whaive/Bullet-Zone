extends Area2D

onready var intereactSprite = $InteractSprite
onready var tutorialSprite = $TutorialSprite

var inside = false
var originalPos : Vector2
var time = 0

export(Texture) var spriteTexture

func _ready() -> void:
	originalPos = intereactSprite.global_position
	tutorialSprite.texture = spriteTexture

func _process(delta: float) -> void:
	time += delta
	
	intereactSprite.global_position.y = originalPos.y + (sin(time * 8) * 2)
	
	if Input.is_action_just_pressed("Interact") && inside:
		intereactSprite.hide()
		tutorialSprite.show()

func PlayerEntered(body: Node) -> void:
	inside = true
	intereactSprite.show()


func PlayerLeft(body: Node) -> void:
	inside = false
	intereactSprite.hide()
	tutorialSprite.hide()
