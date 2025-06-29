extends State

@onready var player : CharacterBody2D = $"../..";
var Velocity : Vector2;
var direction : Vector2;
const launch_speed : int = 600;

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	if owner.is_on_floor() and owner.velocity.y >= 0:
		emit_signal("finished", "Idle");
	
	if Input.is_action_just_pressed("right_click") and player.has_midair_jump:
		emit_signal("finished", "MidAirAiming")
		

## Called by the state machine on the engine's physics update tick.
func physics_update(_delta: float) -> void:
	pass

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	if player.has_midair_jump:
		return
	direction = data.get("direction");
	owner.velocity = direction * launch_speed;
## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	pass
