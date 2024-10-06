extends Panel

@onready var tower = preload("res://Sprites/statue.tscn")
@onready var tilemap = get_node_or_null("/root/Main/TileMap")  # Adjust this path
var currfile

var is_dragging = false
var tempTower = null

func _ready():
	if tilemap == null:
		push_error("TileMap not found. Please check the path in the script.")
	else:
		print_valid_position()

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not is_dragging and tempTower == null:
			tempTower = tower.instantiate()
			add_child(tempTower)
			tempTower.global_position = event.global_position
			is_dragging = true

	elif event is InputEventMouseMotion and is_dragging:
		if tempTower != null:
			tempTower.global_position = event.global_position

	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		if is_dragging:
			if tempTower != null:
				if is_valid_position(tempTower.global_position):
					print("Tower placed at:", tempTower.global_position)
					tempTower = null
				else:
					tempTower.queue_free()
					tempTower = null
					print("Invalid position, tower removed")
			
			is_dragging = false

func is_valid_position(position):
	if tilemap == null:
		push_error("TileMap is null. Cannot check valid position.")
		return false

	var area = Area2D.new()
	area.position = position
	add_child(area)
	var overlap = area.get_overlapping_bodies()
	area.queue_free()

	return overlap.size() == 0

func print_valid_position():
	print("Valid position for tower placement: Any position without collision")
