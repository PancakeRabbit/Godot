extends "res://scripts/gun/gunClass.gd"
var AWMData
onready var player = get_parent().get_parent()
func _ready():
	AWMData = _find_gun_data("AWM")

func _process(_delta):
	if Input.is_action_just_pressed("ui_mouseClick") && player.current_magasine != 0:
		shoot("res://scenes/Guns/bullet/AWMBullet.tscn", $Muzzle, AWMData.bulletSpeed)
		player.current_magasine -= 1
