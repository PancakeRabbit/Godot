extends Node2D


func create_timer(time : float, connection: String = "", connect_to = self, isOneShot = true):
	var timer = Timer.new()
	timer.one_shot = isOneShot
	timer.autostart = true
	timer.wait_time = time
	if connection != "":
		timer.connect("timeout",self,connection)
	add_child(timer)
	
func shoot(bullet_scene, muzzle):
	var bulletInstance = load(bullet_scene).instance()
	if $weaponSprite.flip_v:
		bulletInstance.position = muzzle.position + Vector2(0,5)
	else:
		bulletInstance.position = muzzle.position
	bulletInstance.rotation_degrees = (get_angle_to(get_global_mouse_position()) / PI) * 180
	bulletInstance.apply_impulse(Vector2.ZERO, Vector2(1000,0).rotated(rotation))
	get_node("bullets").add_child(bulletInstance)
	
#func _reload(current_ammo : int, max_ammo: int) -> int:
#	return max_ammo - current_ammo
#	
#func clickReload(reloadTime):
#	create_timer(reloadTime, "_reload")


func _physics_process(_delta):
	
	if get_global_mouse_position().x - global_position.x > 0:
		$weaponSprite.flip_v = false
		
	else:
		$weaponSprite.flip_v = true
		
	
	look_at(get_global_mouse_position())
