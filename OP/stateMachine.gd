extends Node

var player = get_parent()
var current_gunSM = player.current_gun
var previous_gunSM = player.previousGun
var gun
func activateCurrentGun():
	gun = (load("res://scenes/"+current_gunSM+".tscn")).instance()
	add_child(gun)

func deactivateGun():
	gun.queue_free()
	
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		pass
