extends "res://scripts/gun/gunClass.gd"

var RevolverData
onready var player = get_parent().get_parent()
func _ready():
	RevolverData = _find_gun_data("Revolver")
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_mouseClick")&& player.current_magasine != 0:
		shoot("res://scenes/Guns/bullet/RevolverBullet.tscn", $Muzzle, RevolverData.bulletSpeed)
		player.current_magasine -= 1
