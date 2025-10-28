extends CharacterBody2D


const START_SPEED: float = 150.0
var speed: float = 150.0
# var velocity: = Vector2.ZERO


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.get_normal())


func _ready() -> void:
	velocity = Vector2(-1, 0.290).normalized() * speed
# 	body_entered.connect(_on_body_entered)
# 	#speed = START_SPEED
# 	#randomize()
# 	var random_y = randf_range(-1.0, 1.0)
# 	var direction = Vector2(-1.0, clampf(random_y, -0.75, 0.75))
# 	direction = direction.normalized()
# 	linear_velocity = direction * speed


# func _on_body_entered(body):
# 	if body.name == "PaddleLeft" or body.name == "PaddleRight":
# 		velocity.x *= -1
# 	elif body.name == "TopWall" or body.name == "BottomWall":
# 		velocity.y *= -1


#func _process(delta: float) -> void:
	#pass
