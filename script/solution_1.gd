extends Area2D
class_name SolutionKey

@export var player: Node2D

@export var key_id: String = ""  
@export var offset: Vector2 = Vector2(0, -20) 

var is_picked: bool = false
var is_used: bool = false
var player_ref: CharacterBody2D = null

func _ready():
	body_entered.connect(_on_body_entered)
	add_to_group("SpecialKey")

func _on_body_entered(body):
	if is_picked or is_used:
		return

	if body.is_in_group("Player"):
		is_picked = true
		player_ref = body
		body.has_special_key = true
		body.current_special_key_id = key_id
		print("✅ Picked Special Key:", key_id)

func _process(_delta):
	if is_picked and not is_used and player_ref:
		global_position = player_ref.global_position + offset

func use_key():
	if is_used:
		return
	is_used = true
	player_ref.has_special_key = false
	player_ref.current_special_key_id = ""

	print("🔑 Used key:", key_id)
	queue_free()
