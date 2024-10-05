extends Node2D

# Kecepatan dan kesehatan musuh
var speed = 100
var health = 100

func _process(delta):
	# Gerakkan musuh ke arah kanan
	position.x -= speed * delta  # Bergerak ke kiri

func take_damage(damage_amount):
	# Kurangi kesehatan musuh
	health -= damage_amount
	if health <= 0:
		die()

func die():
	# Hapus musuh dari scene
	queue_free()


func _on_timer_timeout() -> void:
	pass # Replace with function body.
