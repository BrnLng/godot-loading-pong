extends Node2D

@onready var goal_left: Area2D = %GoalLeft
@onready var goal_right: Area2D = %GoalRight


func _ready() -> void:
	goal_left.body_entered.connect(_on_goal_entered.bind(goal_left.name))
	# goal_left.body_entered.connect(_on_goal_entered)
	goal_right.body_entered.connect(_on_goal_entered.bind(goal_right.name))


func _on_goal_entered(body, side) -> void:
	# var sender = get_signal_sender()
	print("goal: ")
	if body.name == "Ball":
		if side == "GoalLeft":
			print("player2 goals")
		elif side == "GoalRight":
			print("player1 goals")
