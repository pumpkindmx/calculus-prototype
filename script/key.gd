class_name Key
extends Area2D

@export var player: Node2D
@export var offset: Vector2 = Vector2(0, -20)

var is_picked: bool = false
var is_used: bool = false

func _ready():
	body_entered.connect(_on_body_entered)
	add_to_group("Key")

func _on_body_entered(body: Node) -> void:
	if is_picked or is_used:
		return
	if body == player:
		is_picked = true
		player.has_key = true
		player.current_key_id = ""  # ✅ Make sure it is normal key
		print("✅ Normal key picked up!")

func _process(_delta):
	if is_picked and not is_used:
		global_position = player.global_position + offset

func use_key():
	if is_used:
		return

	is_used = true
	player.has_key = false
	player.current_key_id = ""

	print("✅ Normal key used and removed!")

	# ✅ Disappear animation or instant removal
	var anim = get_node_or_null("AnimationPlayer")
	if anim and anim.has_animation("done"):
		anim.play("done")
		anim.animation_finished.connect(_on_animation_finished)
	else:
		queue_free()

func _on_animation_finished(_anim_name = ""):
	queue_free()
