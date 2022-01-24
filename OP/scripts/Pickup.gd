extends Area2D

export var representing_gun = "Error"

# Called when the node enters the scene tree for the first time.
func _ready():
	var sprite = Sprite.new()
	add_child(sprite)
	sprite.texture = load("res://ressources/sprites/" + representing_gun + ".png")
	sprite.scale = Vector2(0.5,0.5)
	

func changeLabelVisibility(_body):
	if _body.get_name() == "Player":
		$Label.visible = !$Label.visible

func _on_Pickup_body_entered(_body):
	changeLabelVisibility(_body)

func _on_Pickup_body_exited(_body):
	changeLabelVisibility(_body)
