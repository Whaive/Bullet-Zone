extends Node2D

var bodiesToExclude = []
var target : Vector2
var shoot = false
var currentGun = 0

onready var guns = get_children()

enum ALL_GUNS {
	pistol,
	submachine,
	sniper,
	nothing
}

export(ALL_GUNS) var selectedGun = ALL_GUNS.pistol

func Init(_bodiesToExclude : Array):
	if selectedGun != ALL_GUNS.nothing:
		currentGun = guns[selectedGun]
		currentGun.show()
	
	for gun in guns:
		gun.SetBodiesToExclude(_bodiesToExclude)
	
func _process(delta: float) -> void:
	
	if selectedGun == ALL_GUNS.nothing:
		return
	
	look_at(target)
	rotation_degrees = fmod(rotation_degrees, 360)
	
	# Oh no
	if rotation_degrees < -90 && rotation_degrees > -275:
		currentGun.FlipSprite(true)
	elif rotation_degrees > 90 && rotation_degrees < 275: 
		currentGun.FlipSprite(true)
	else:
		currentGun.FlipSprite(false)

	#if shoot:
	#	currentGun.Shoot(target)
	#shoot = false

func Shoot():
	#shoot = true
	if selectedGun != ALL_GUNS.nothing:
		currentGun.Shoot(target, rotation_degrees)

func SetTarget(_target):
	target = _target
	
func ChangeGun(gun):
	if selectedGun != ALL_GUNS.nothing:
		currentGun.hide()
	selectedGun = gun
	currentGun = guns[selectedGun]
	currentGun.show()

