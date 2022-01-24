extends KinematicBody2D


var distance = 10
var timeToDistance = 0.5
var acceleration = distance * timeToDistance
var velocity = Vector2.ZERO

var current_gun = null
var previousGun = current_gun

var inZone = false
var standingOver = null
var leavingArea = null

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
	pickable.position = self.global_position
	
func PickGun(areaGunStanding):
	
	previousGun = current_gun
	current_gun = areaGunStanding.representing_gun
	areaGunStanding.queue_free()
	changeGunInHand()
	
func _physics_process(delta):
	move(delta)
	
	if inZone && Input.is_action_just_pressed("PickUp_weapon") && standingOver != null:
		PickGun(standingOver)
		if previousGun != null:
			dropGun(previousGun)
	if standingOver != leavingArea:
		inZone = true
	
func changeGunInHand():
	var gun = get_node("Gun").get_child(0)
	if previousGun != null:
		gun.queue_free()
	var newGun = load("res://scenes/Guns/"+ current_gun +".tscn").instance()
	$Gun.add_child(newGun)	
	
func _on_Area2D_area_entered(area):
	inZone = true
	standingOver = area
	

func _on_Area2D_area_exited(area):
	inZone = false
	leavingArea = area
