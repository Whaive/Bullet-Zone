extends TextureRect

var health = [preload("res://Assets/0HP.png"), preload("res://Assets/HP.png"),
preload("res://Assets/2HP.png"), preload("res://Assets/FullHealth.png")]

var currentHealth = 3

func UpdateHealth():
	currentHealth -= 1
	texture = health[currentHealth]
