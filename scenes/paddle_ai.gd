extends CharacterBody2D

const STARTING_SPEED: float = 3.5
var speed: float = STARTING_SPEED
var ball: CharacterBody2D


func _ready() -> void:
	ball = get_tree().get_first_node_in_group("ball")


func _physics_process(_delta: float) -> void:
	velocity.y = copy_ball_y() * speed
	move_and_slide()
	velocity = Vector2.ZERO  # stops BUG of ball pushing paddle


func copy_ball_y() -> float:
	if ball:
		return ball.position.y - position.y
	return 0.0
