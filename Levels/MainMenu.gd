extends Control

onready var pressStart = $PressStart
onready var AllSelections = [ $UI/CenterContainer/HBoxContainer/Selector, $UI/CenterContainer3/HBoxContainer/Selector]
var selectTexture = preload("res://Assets/pistol.png")
var currentSelection = 0
var time = 0
var pressedStart = false

func _ready() -> void:
	SetCurrentSelection(0)

func _process(delta: float) -> void:
	time += delta
	pressStart.modulate.a = sin(time * 7) * 0.5 + 0.5
	
	
	if pressedStart:
		if Input.is_action_just_pressed("ui_down"):
			currentSelection += 1
			currentSelection %= AllSelections.size()
			SetCurrentSelection(currentSelection)
			$Select.play()
		elif Input.is_action_just_pressed("ui_up"):
			currentSelection -= 1
			currentSelection %= AllSelections.size()
			SetCurrentSelection(currentSelection)
			$Select.play()
			
		if Input.is_action_just_pressed("Start"):
			$Start.play()
			SelectOption()
			MusicController.PlayMainTheme()
	else:
		if Input.is_action_just_pressed("Start"):
			$Start.play()
			pressStart.hide()
			$UI.show()
			pressedStart = true
			
		
func SetCurrentSelection(selection : int):
	
	for el in AllSelections:
		el.texture = null
	
	AllSelections[selection].texture = selectTexture

func SelectOption():
	if currentSelection == 0:
		get_tree().change_scene("res://Levels/World.tscn")
	else:
		get_tree().quit()
