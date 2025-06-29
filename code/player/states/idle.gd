extends State

@onready var player := $"../..";

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	if Input.is_action_just_pressed("right_click"):
		if player.has_midair_jump:
			emit_signal("finished", "MidAirAiming");
		else: emit_signal("finished", "Aiming");

## Called by the state machine on the engine's physics update tick.
func physics_update(_delta: float) -> void:
	pass

## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	pass

## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	pass
