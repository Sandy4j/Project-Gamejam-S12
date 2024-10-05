extends CharacterBody2D


@export var speed = 200

func _process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	if get_parent().get_progress_ratio() == 1:
		queue_free()
	if not is_stopped:
		offset += speed * delta



var is_stopped : bool = false

func _ready():
	$Area2D.connect("body_entered", self, "_on_body_entered")
	$Area2D.connect("body_exited", self, "_on_body_exited")
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("tes"): # atau grup lain yang ingin dideteksi
		is_stopped = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("tes"):
		is_stopped = false
