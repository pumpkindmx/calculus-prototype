extends CharacterBody2D

@export var speed: float = 150

# ✅ Normal key support
var has_key: bool = false
var current_key_id: String = ""

# ✅ Special key support
var has_special_key: bool = false
var current_special_key_id: String = ""

# ✅ Health system
@export var max_hp: int = 100
var hp: int = max_hp

func _ready():
	# ✅ Add player to group so keys can detect it
	add_to_group("Player")

func _physics_process(_delta: float) -> void:
	var input_vector = Vector2.ZERO

	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	input_vector = input_vector.normalized()
	velocity = input_vector * speed
	move_and_slide()

	_update_animation(input_vector)

func _update_animation(move_dir: Vector2) -> void:
	var anim = $AnimatedSprite2D

	if move_dir == Vector2.ZERO:
		anim.play("idle")
	else:
		anim.play("run")

	if move_dir.x != 0:
		anim.flip_h = move_dir.x < 0

# ✅ Damage system
func take_damage(amount: int):
	hp -= amount
	if hp < 0:
		hp = 0
	print("⚠ HP:", hp)
