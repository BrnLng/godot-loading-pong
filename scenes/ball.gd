extends CharacterBody2D

const START_SPEED: float = 200.0
const MAX_SPEED: float = 600.0
var speed: float = START_SPEED


func _physics_process(delta):
	var current_speed = velocity.length()
	if current_speed > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED
	else:
		velocity = velocity.normalized() * speed
	
	var collision = move_and_collide(velocity * delta)
			
	if collision:
		if speed < MAX_SPEED:
			speed += 25.0
		print(str(speed))
		var normal = collision.get_normal()
		var collider = collision.get_collider()
		
		if collider.is_in_group("paddles"):
			# Calculate where on paddle the ball hit
			var hit_position = collision.get_position()
			var paddle_center = collider.global_position
			var hit_offset = (hit_position.y - paddle_center.y) / 50.0  # Normalize
			
			# Use hit position to influence bounce angle
			var modified_normal = Vector2(normal.x, normal.y + hit_offset).normalized()
			velocity = velocity.bounce(modified_normal)
		else:
			# Calculate current angle from horizontal
			var current_angle = abs(velocity.angle())
			var vertical_bias = current_angle / (PI/2)  # 0.0 = horizontal, 1.0 = vertical
			
			# Reduce randomness and bias towards horizontal when too vertical
			var base_randomness = 0.25
			var reduced_randomness = base_randomness * (1.0 - vertical_bias * 0.7)
			
			var random_angle = randf_range(-reduced_randomness, reduced_randomness)
			
			# Bias the random angle away from vertical
			if vertical_bias > 0.6:  # If too vertical
				var horizontal_bias = 0.2 * sign(velocity.x)  # Bias towards current horizontal direction
				random_angle += horizontal_bias
			else:
				var horizontal_ratio = abs(velocity.x) / velocity.length()
				# Less randomness when moving more vertically
				var max_random_angle = lerp(0.05, 0.3, horizontal_ratio)  # 3° to 17°
				random_angle = randf_range(-max_random_angle, max_random_angle)
				# var random_angle = randf_range(-0.2, 0.2)  # ±0.2 = ±12 degrees
			
			var randomized_normal = normal.rotated(random_angle)

			velocity = velocity.bounce(randomized_normal)


func _ready() -> void:
	randomize()
	start()


func reset() -> void:
	velocity = Vector2.ZERO
	position = Vector2(320, 180)


func start() -> void:
	speed = START_SPEED
	var random_x = [-1, 1].pick_random()
	var random_y = randf_range(-0.8, 0.8)
	velocity = Vector2(random_x, random_y).normalized() * speed
