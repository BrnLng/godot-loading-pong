extends Node2D

@onready var label_left: Label = %LabelLeft
@onready var label_center: Label = %LabelCenter
@onready var label_right: Label = %LabelRight

@onready var ball: CharacterBody2D = $Ball

@onready var goal_left: Area2D = %GoalLeft
@onready var goal_right: Area2D = %GoalRight

var score: Vector2i = Vector2i(0, 0):
	set(new_score):
		score = new_score
		_update_hud()


func _ready() -> void:
	goal_left.body_entered.connect(_on_goal_entered.bind(goal_left.name))
	# goal_left.body_entered.connect(_on_goal_entered)
	goal_right.body_entered.connect(_on_goal_entered.bind(goal_right.name))
	label_center.text = ""


func _on_goal_entered(body, side) -> void:
	if body.name == "Ball":
		if side == "GoalRight":
			score += Vector2i(1, 0)
		elif side == "GoalLeft":
			score += Vector2i(0, 1)
		reset_ball()


func _update_hud() -> void:
	label_left.text = str(score.x)
	label_right.text = str(score.y)


func reset_ball() -> void:
	# print("at game reset ball")
	ball.reset()
	await countdown()
	ball.start()


func countdown() -> void:
	# print("at game countdown")
	for c in ["3", "2", "1"]:
		label_center.text = c
		await get_tree().create_timer(0.9).timeout
	label_center.text = ""
