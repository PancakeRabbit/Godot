extends Node2D


func create_timer(time : float, connect_to = self, connection: String = "", parameters : Array = [], isOneShot = true):
	var timer = Timer.new()
	timer.one_shot = isOneShot
	timer.autostart = true
	timer.wait_time = time
	timer.connect("timeout",connect_to,connection, parameters)
	add_child(timer)
	
func shoot(bullet_scene, muzzle, bulletSpeed):
	var bulletInstance = load(bullet_scene).instance()
	if $weaponSprite.flip_v:
		bulletInstance.position = muzzle.position + Vector2(0,5)
	else:
		bulletInstance.position = muzzle.position
	bulletInstance.rotation_degrees = (get_angle_to(get_global_mouse_position()) / PI) * 180
	bulletInstance.apply_impulse(Vector2.ZERO, Vector2(bulletSpeed,0).rotated(rotation))
	get_node("bullets").add_child(bulletInstance)
	
func _find_gun_data(GunName : String) ->Dictionary:
	for i in GunData.gunArray:
		if i.weaponName == GunName:
			return i
	return {}
	
func _physics_process(_delta):
	
	if get_global_mouse_position().x - global_position.x > 0:
		$weaponSprite.flip_v = false
		
	else:
		$weaponSprite.flip_v = true
		
	
	look_at(get_global_mouse_position())
