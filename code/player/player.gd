class_name Player extends CharacterBody2D

@onready var max_speed : int = 600;
@onready var line2d = %Line2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_state_machine: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity");
var damp : float = ProjectSettings.get_setting("physics/2d/default_linear_damp");
var start_pos : Vector2 = global_position;
@onready var area2D : Area2D = $endDetector;
@export_category("Nodes")
@export var state_machine : Node;

var has_midair_jump: bool = false

func _ready() -> void:
	global_position = GameManager.check_pos if GameManager.check_pos != Vector2.ZERO else start_pos;
	$MarginContainer/RichTextLabel.visible = false;
	
func get_direction() -> Vector2:
	return global_position.direction_to(get_global_mouse_position())

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("Reset"):
		GameManager.check_pos = start_pos;
		get_tree().reload_current_scene();
		
	if global_position.y > 300:
		die();
	
	if !is_on_floor():
		velocity.y += gravity * delta;
		velocity *= clampf(1.0 - damp * delta, 0 , 1);
	else:
		#reduce horizontal speed
		velocity.x = move_toward(velocity.x, 0.0, 1500 * delta)
		has_midair_jump = false;
	move_and_slide();

func _on_second_jump_collected() -> void:
	has_midair_jump = true
func _on_checkpoint(pos : Vector2) -> void:
	GameManager.check_pos = pos;

func die() -> void:
	get_tree().reload_current_scene()


func _on_end_detector_area_entered(area: Area2D) -> void:
	if area.owner.is_in_group("End"):
		$MarginContainer/RichTextLabel.visible = true;
