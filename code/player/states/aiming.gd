extends State

@onready var player := $"../..";
@export var speed = 600;

## Called by the state machine on the engine's main loop tick.
func update(_delta: float) -> void:
	%Line2D.update_trajectory();
	if Input.is_action_just_pressed("click"):
		var direction : Vector2 = (player.get_global_mouse_position() - player.global_position).normalized();
		emit_signal("finished", "Launching", {"direction": direction});
	
	if Input.is_action_just_pressed("right_click"):
		emit_signal("finished", "Idle")

## Called by the state machine on the engine's physics update tick.
func physics_update(_delta: float) -> void:
	pass


## Called by the state machine upon changing the active state. The `data` parameter
## is a dictionary with arbitrary data the state can use to initialize itself.
func enter(previous_state_path: String, data := {}) -> void:
	%Line2D.visible = true;

## Called by the state machine before changing the active state. Use this function
## to clean up the state.
func exit() -> void:
	%Line2D.visible = false;
 
