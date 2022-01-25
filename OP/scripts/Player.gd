extends KinematicBody2D


var distance = 10
var timeToDistance = 0.5
var acceleration = distance * timeToDistance
var velocity = Vector2.ZERO

var current_gun = null
var previousGun = current_gun

var current_magasine
var max_magasine
var max_ammo

var previous_magasine
var previous_max_magasine
var previous_max_ammo

var inZone = false
var standingOver = null
var leavingArea = null

func _ready():
	if get_node("Gun").get_child_count() == 1:
		current_gun = get_node("Gun").get_child(0).name
		previousGun = current_gun
		for i in GunData.gunArray:
			if i.weaponName == current_gun:
				current_magasine = i.magasine
				max_magasine = i.maxMagasine
				max_ammo = i.maxAmmo
				
func move(delta):
	velocity = Vector2(0,0)
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1 * delta
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 1 * delta
	if Input.is_action_pressed("ui_up"):
		velocity.y = -1 * delta
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 1 * delta

	velocity = move_and_collide(velocity.normalized() * acceleration )
	

func dropGun(Gun):
	var pickable = (load("res://scenes/Pickup.tscn")).instance()
	pickable.representing_gun = Gun
	get_parent().get_child(0).add_child(pickable)
	pickable.current_magasine = previous_magasine
	pickable.max_magasine = previous_max_magasine
	pickable.max_ammo = previous_max_ammo
	pickable.position = self.global_position
	
func PickGun(areaGunStanding):
	
	previousGun = current_gun
	previous_magasine = current_magasine
	previous_max_magasine = max_magasine
	previous_max_ammo = max_ammo
	
	current_gun = areaGunStanding.representing_gun
	current_magasine = areaGunStanding.current_magasine
	max_magasine = areaGunStanding.max_magasine
	max_ammo = areaGunStanding.max_ammo
	
	areaGunStanding.queue_free()
	changeGunInHand()
	
func HUDHandling():
	get_node("Camera2D/Ammo/Text/CurrentMagasine").bbcode_text = "[wave]" + String(current_magasine) + "[/wave]"
	get_node("Camera2D/Ammo/Text/maxAmmo").text = String(max_ammo)
func changeGunInHand():
	if previousGun != null:
		get_node("Gun").get_child(0).queue_free()
	$Gun.add_child(load("res://scenes/Guns/"+ current_gun +".tscn").instance())

func _physics_process(delta):
	move(delta)
	HUDHandling()
	if inZone && Input.is_action_just_pressed("PickUp_weapon") && standingOver != null:
		PickGun(standingOver)
		if previousGun != null:
			dropGun(previousGun)
	if standingOver != leavingArea:
		inZone = true

	
func _on_Area2D_area_entered(area):
	inZone = true
	standingOver = area
	

func _on_Area2D_area_exited(area):
	inZone = false
	leavingArea = area
