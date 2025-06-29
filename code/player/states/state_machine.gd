class_name StateMachine extends Node

@export var initial_state: State;

@onready var state: State = get_initial_state()

#obtiene el primer nodo, sino, Idle
func get_initial_state() -> State:
	return initial_state if initial_state else get_child(0)

func _ready() -> void:
	#conecta la señal "finished" de un State a la funcion "_transition_to_next_state)"
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)

	await owner.ready 
	state.enter("")

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

#invocado cuando un estado envia la señal "finished" para cambiar a otro estado
func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	var previous_state_path := state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path, data)
