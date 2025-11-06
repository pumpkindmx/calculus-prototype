extends Area2D

var door_block: StaticBody2D
var is_open: bool = false

func _ready():
	door_block = get_parent()
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if is_open:
		return
	if body is CharacterBody2D:
		print("Player touched door. Has key:", body.has_key)
		if body.has_key and body.current_key_id == "":
			# ✅ Only allow normal keys to unlock normal doors
			unlock_door(body)
		else:
			print("Door is locked!")

func unlock_door(_player: CharacterBody2D) -> void:
	is_open = true

	# ✅ Play animation
	door_block.get_node("AnimatedSprite2D").play("open")

	# ✅ Disable collision
	door_block.get_node("CollisionShape2D").set_deferred("disabled", true)
	print("✅ Normal door unlocked!")

	# ✅ Remove only normal keys (special keys are ignored here)
	for key in get_tree().get_nodes_in_group("Key"):
		# Normal keys do NOT have key_id
		if key.is_picked and not key.is_used and not ("key_id" in key):
			key.use_key()
			break
