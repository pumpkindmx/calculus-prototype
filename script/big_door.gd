extends Area2D
class_name SpecialDoor

@export var door_id: String = ""   # Must match key_id from SolutionKey
var is_unlocked: bool = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if is_unlocked:
		return

	if body.is_in_group("Player"):
		print("🚪 Player touched special door:", door_id, " | Has special key:", body.has_special_key, "Key ID:", body.current_special_key_id)

		if body.has_special_key and body.current_special_key_id == door_id:
			print("✅ Correct special key! Unlocking door:", door_id)
			unlock_door(body)
		else:
			print("❌ Player doesn't have the correct special key for this door.")

func unlock_door(_player):
	is_unlocked = true

	# ✅ Play Animation if available
	var anim = get_node_or_null("AnimatedSprite2D")
	if anim:
		anim.play("big_open")

	# ✅ Disable StaticBody2D collision
	var static_body = get_node_or_null("StaticBody2D")
	if static_body:
		var col_shape = static_body.get_node_or_null("CollisionShape2D")
		if col_shape:
			col_shape.set_deferred("disabled", true)

	# ✅ Remove only the correct special key from scene
	for key in get_tree().get_nodes_in_group("SpecialKey"):
		if key.key_id == door_id and key.is_picked and not key.is_used:
			key.use_key()
			break

	print("🚪 Special Door", door_id, "is now open!")
