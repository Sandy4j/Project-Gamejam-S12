extends Node2D

# Preload musuh
var EnemyScene = preload("res://Mobs/Goblin.tscn")

func _ready():
	$Timer.connect("timeout", self, "_spawn_enemy")  # Hubungkan timer ke fungsi spawn

func _spawn_enemy():
	var enemy = EnemyScene.instance()  # Buat instance musuh dari scene musuh
	enemy.position = Vector2(1100, randf() * 400 + 100)  # Spawn musuh di kanan layar, dengan posisi Y acak
	add_child(enemy)  # Tambahkan musuh ke game
