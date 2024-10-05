extends CharacterBody2D

# Kecepatan dan kesehatan musuh
var speed = 100
var health = 100

# Variabel untuk mengecek apakah sedang bersentuhan dengan patung
var is_touching_statue = false

# Timer untuk damage berkelanjutan
var damage_timer: Timer

func _ready():
	# Inisialisasi timer
	damage_timer = Timer.new()
	add_child(damage_timer)
	damage_timer.connect("timeout", Callable(self, "_on_damage_timer_timeout"))
	damage_timer.set_wait_time(0.1)  # 0.1 detik untuk 10 kali per detik
	damage_timer.set_one_shot(false)

func _physics_process(delta):
	if not is_touching_statue:
		# Gerakkan musuh ke arah kiri jika tidak sedang menyentuh patung
		velocity.x = -speed
	else:
		# Berhenti jika menyentuh patung
		velocity.x = 0
	
	move_and_slide()

func take_damage(damage_amount):
	# Kurangi kesehatan musuh
	health -= damage_amount
	if health <= 0:
		die()

func die():
	# Hapus musuh dari scene
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("patung"):
		is_touching_statue = true
		damage_timer.start()

func _on_area_2d_body_exited(body):
	if body.is_in_group("patung"):
		is_touching_statue = false
		damage_timer.stop()

func _on_damage_timer_timeout():
	take_damage(10)  # Terima 10 damage setiap 0.1 detik
