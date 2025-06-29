extends Line2D

var path_points: Array[Vector2] = [] #array dinamico
@export var maxPoints : int;
	
func _process(_delta: float) -> void:
	queue_redraw();

func update_trajectory() -> void:
	path_points.clear();
	
	var direction : Vector2 = owner.get_direction();
	var velocity : Vector2 = direction * owner.max_speed;
	
	var start_position = owner.global_position;
	
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity");
	var damp = ProjectSettings.get_setting("physics/2d/default_linear_damp");
	#renderiza por tick del motor
	var ticks = ProjectSettings.get_setting("physics/common/physics_ticks_per_second")
	var timestamp := 1.0 / float(ticks) - 0.001;
	
	#para predicciones
	var pos : Vector2 = start_position;
	var v : Vector2 = velocity;
	
		
	for i: int in maxPoints:
		#actualizar velocidad
		v.y += gravity * timestamp;
		v *= clampf(1.0 - damp * timestamp, 0, 1);
		
		#siguiente posicion
		var next_pos : Vector2 = pos + (v * timestamp);
		
		#ve si del punto actual al siguiente, se choca con algo.
		var ray := raycast_prediction(pos, next_pos);
		#si se choca con algo, parar
		if !ray.is_empty():
			path_points.append(to_local(ray.position))
			break; 
			
		#actualizar posicion
		path_points.append(to_local(pos));
		pos = next_pos;

	#updatear los puntos de lin2d
	points = path_points;

func raycast_prediction(point1: Vector2, point2: Vector2) -> Dictionary:
	var space_state := get_world_2d().direct_space_state;
	var raycast := PhysicsRayQueryParameters2D.create(point1, point2, 2);
	var result = space_state.intersect_ray(raycast);

	return result;
