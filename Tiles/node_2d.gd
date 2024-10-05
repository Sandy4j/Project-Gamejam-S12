extends Node2D

# Referensi ke scene musuh
var enemy_scene = preload("res://Mobs/enemy.tscn")  # Ganti dengan path yang sesuai

func _on_Timer_timeout():
	# Spawn musuh baru
	var enemy_instance = enemy_scene.instantiate()
	add_child(enemy_instance)  # Tambahkan musuh ke scene
	enemy_instance.position = Vector2(800, randf_range(100, 500))  # Posisi spawn (ubah sesuai kebutuhan)
