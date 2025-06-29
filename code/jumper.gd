extends Area2D

signal collected

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("collected")
		owner.queue_free();

func _ready() -> void:
	var player = get_tree().get_root().find_child("Player", true, false);
	if player:
		connect("collected", Callable(player, "_on_second_jump_collected"));
