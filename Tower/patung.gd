extends Panel

@onready var tower = preload("res://Tower/Patung.tscn")
var	currfile

func _on_gui_input(event):
		var tempTower = tower.instantiate()
		if event is InputEventMouseButton and event.button_mask == 1:
			
			add_child(tempTower)
			tempTower.global_position = event.global_position
			#tempTower.process_mode = Node.PROCESS_MODE_DISABLED
			
		
		elif event is InputEventMouseMotion and event.button_mask == 1:
			#button left down and dragging
			if get_child_count() > 1:
				
				get_child(1).global_position = event.global_position
				
		else:
			if get_child_count() > 1:
				get_child(1).queue_free()
