extends Panel

@onready var tower = preload("res://Tower/Patung.tscn")
@onready var tilemap = get_node_or_null("/root/Main/TileMap")  # Adjust this path
var currfile

var is_dragging = false
var tempTower = null

# Atlas coordinates where the tower can be placed
const VALID_ATLAS_COORD = Vector2i(4, 1)

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

	var tile_pos = tilemap.local_to_map(tilemap.to_local(position))
	var atlas_coord = tilemap.get_cell_atlas_coords(0, tile_pos)
	print("Current atlas coordinates:", atlas_coord)  # Debug print
	
	return atlas_coord == VALID_ATLAS_COORD

func get_world_position_from_atlas_coord(atlas_x, atlas_y):
	if tilemap == null:
		push_error("TileMap is null. Cannot get world position.")
		return Vector2.ZERO

	for x in range(tilemap.get_used_rect().size.x):
		for y in range(tilemap.get_used_rect().size.y):
			var pos = Vector2i(x, y)
			if tilemap.get_cell_atlas_coords(0, pos) == Vector2i(atlas_x, atlas_y):
				return tilemap.map_to_local(pos)
	
	push_error("Atlas coordinates not found in TileMap")
	return Vector2.ZERO

func print_valid_position():
	var valid_world_pos = get_world_position_from_atlas_coord(VALID_ATLAS_COORD.x, VALID_ATLAS_COORD.y)
	print("Valid position for tower placement (world coordinates):", valid_world_pos)
