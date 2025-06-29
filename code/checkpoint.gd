extends Area2D

signal checkpoint

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("checkpoint", global_position);

func _ready() -> void:
	var player = get_tree().get_root().find_child("Player", true, false);
	if player:
		connect("checkpoint", Callable(player, "_on_checkpoint"));
