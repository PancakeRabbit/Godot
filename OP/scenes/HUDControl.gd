extends Control
func _process(delta):
	rect_position =(OS.get_real_window_size() - rect_size * 2) /2 * get_parent().zoom 
