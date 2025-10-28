@tool
class_name Sprite2D_Proto
extends Sprite2D

@export var img_rect_size: Vector2i
@export var img_rect_color: Color


func _ready():
	var img = Image.create(img_rect_size.x, img_rect_size.y, 
		false, Image.FORMAT_RGBA8)
	img.fill(img_rect_color)
	texture = ImageTexture.create_from_image(img)
