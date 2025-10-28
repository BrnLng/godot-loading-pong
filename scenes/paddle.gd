extends CharacterBody2D


const STARTING_SPEED: float = 300.0
var speed: float = 300.0


# func _ready() -> void:
# 	speed = STARTING_SPEED


func _physics_process(_delta: float) -> void:
	var direction := Input.get_axis("paddle_up", "paddle_down")
	velocity.y = direction * speed
	move_and_slide()
	velocity = Vector2.ZERO  # stops BUG of ball pushing paddle
