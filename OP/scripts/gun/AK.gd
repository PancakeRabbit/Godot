extends "res://scripts/gun/gunClass.gd"

var AKData
onready var player = get_parent().get_parent()
func _ready():
	AKData = _find_gun_data("AK")

func _process(_delta):
	if Input.is_action_just_pressed("ui_mouseClick")&& player.current_magasine != 0:
		shoot("res://scenes/Guns/bullet/AKBullet.tscn", $Muzzle, AKData.bulletSpeed)
		player.current_magasine -= 1
