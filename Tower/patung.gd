extends Panel

@onready var tower = preload("res://Tower/Patung.tscn")
var	currfile

var is_dragging = false  # Variabel untuk melacak apakah sedang dragging
var tempTower = null  # Menyimpan tower yang sedang di-drag


func _on_gui_input(event):
	# Jika mouse klik kiri ditekan dan tidak ada tower yang sedang di-drag
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if not is_dragging and tempTower == null:
			tempTower = tower.instantiate()  # Buat instance baru tower
			add_child(tempTower)
			tempTower.global_position = event.global_position
			is_dragging = true  # Mulai dragging

	# Jika mouse sedang bergerak dan tombol kiri masih ditekan (dragging)
	elif event is InputEventMouseMotion and is_dragging:
		if tempTower != null:
			tempTower.global_position = event.global_position  # Update posisi tower

	# Jika mouse dilepas (selesai drag)
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		if is_dragging:
			if tempTower != null:
				# Cek apakah posisi valid untuk meletakkan tower
				if is_valid_position(tempTower.global_position):
					print("Tower placed at:", tempTower.global_position)
					tempTower = null  # Reset tempTower setelah diletakkan
				else:
					# Jika tidak valid, hapus tower
					tempTower.queue_free()
					tempTower = null  # Reset tempTower setelah dihapus
					print("Invalid position, tower removed")
			
			is_dragging = false  # Akhiri dragging

# Fungsi untuk memeriksa apakah posisi valid
func is_valid_position(position):
	# Tambahkan logika untuk memeriksa apakah posisi valid (misal di dalam grid)
	# Sementara, ini hanya mengembalikan true
	return true
