extends Area2D

export var representing_gun = "Error"
export var current_magasine = 0
export var max_magasine = 0
export var max_ammo = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var sprite = Sprite.new()
	add_child(sprite)
	sprite.texture = load("res://ressources/sprites/" + representing_gun + ".png")
	sprite.scale = Vector2(0.5,0.5)
	
	for i in GunData.gunArray:
		if i.weaponName == representing_gun:
			if isItZero(current_magasine):
				current_magasine = i.magasine
			if isItZero(max_magasine):
				max_magasine = i.maxMagasine
			if isItZero(max_ammo):
				max_ammo = i.maxAmmo

func isItZero(variable):
	if variable == 0:
		return true
	return false

func changeLabelVisibility(_body):
	if _body.get_name() == "Player":
		$Label.visible = !$Label.visible

func _on_Pickup_body_entered(_body):
	changeLabelVisibility(_body)

func _on_Pickup_body_exited(_body):
	changeLabelVisibility(_body)
