extends Node

class_name SpawnManager

# Preload musuh yang akan di-spawn
@export var enemy_scene: PackedScene

# Array untuk menyimpan node spawn point
var spawn_points: Array[Node] = []

# Variabel untuk mengatur waktu spawn
@export var spawn_interval: float = 3.0
var spawn_timer: float = 0.0

# Indeks untuk melacak spawn point terakhir yang digunakan
var last_spawn_index: int = -1

func _ready():
	# Dapatkan semua spawn point
	for i in range(1, 5):  # Asumsikan kita memiliki 4 spawn point
		var spawn_point = get_node("Spawn" + str(i))
		if spawn_point:
			spawn_points.append(spawn_point)
	
	if spawn_points.is_empty():
		push_error("Tidak ada spawn point yang ditemukan!")

func _process(delta):
	# Hitung waktu untuk spawn berikutnya
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_enemy()
		spawn_timer = 0.0

func spawn_enemy():
	if spawn_points.is_empty():
		return
	
	# Pilih spawn point secara acak, tapi pastikan berbeda dari yang terakhir
	var spawn_index = randi() % spawn_points.size()
	while spawn_index == last_spawn_index and spawn_points.size() > 1:
		spawn_index = randi() % spawn_points.size()
	
	last_spawn_index = spawn_index
	var spawn_point = spawn_points[spawn_index]
	
	# Instantiate musuh
	var enemy = enemy_scene.instantiate()
	get_tree().current_scene.add_child(enemy)
	enemy.global_position = spawn_point.global_position
