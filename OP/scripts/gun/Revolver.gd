extends "res://scripts/gun/gunClass.gd"


func _ready():
	pass
	
func _process(_delta):
	if Input.is_action_just_pressed("ui_mouseClick"):
		shoot("res://scenes/Guns/bullet/RevolverBullet.tscn", $Muzzle)
