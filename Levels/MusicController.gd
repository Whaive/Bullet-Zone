extends Node

var mainTheme = load("res://BGM/Medium Voltage.wav")
var bossTheme = load("res://BGM/High Shortage.wav")

func _ready() -> void:
	pass

func PlayMainTheme():
	$Themes.stream = mainTheme
	$Themes.volume_db = -20
	$Themes.play()
	
func PlayBossTheme():
	$Themes.stream = bossTheme
	$Themes.volume_db = -15
	$Themes.play()
	
func Stop():
	$Themes.stop()
