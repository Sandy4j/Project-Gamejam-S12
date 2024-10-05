extends Sprite2D

var is_dragging = false
var drag_offset = Vector2.ZERO

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				_start_dragging(event.position)
			else:
				_stop_dragging()

func _start_dragging(mouse_position):
	# Hitung posisi relatif mouse ke sprite
	var local_mouse_pos = to_local(mouse_position)
	if get_rect().has_point(local_mouse_pos):
		is_dragging = true
		drag_offset = position - mouse_position

func _stop_dragging():
	is_dragging = false

func _process(delta):
	if is_dragging:
		# Ikuti posisi mouse dengan drag_offset
		position = get_global_mouse_position() + drag_offset
