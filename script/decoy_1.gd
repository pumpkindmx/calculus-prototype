extends Area2D
class_name DecoyKey

@export var player: CharacterBody2D
@export var damage: int = 10            # How much HP to remove when picked

var is_picked: bool = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if is_picked or body != player:
		return
	is_picked = true

	# Subtract HP
	if player.has_method("take_damage"):
		player.take_damage(damage)
	elif "hp" in player:
		player.hp -= damage

	print("Decoy key picked - HP reduced:", damage)
	queue_free()
