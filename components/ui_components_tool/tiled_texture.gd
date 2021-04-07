tool
extends Control

export (Texture) var texture:Texture
export (int) var width
export (int) var height

func _ready():
	rect_size = Vector2(width, height)
	 

func _draw():
	for i in range( int(width / texture.region.size.x)):
		for j in range(int(height / texture.region.size.y)):
			draw_texture(texture, Vector2( i * texture.region.size.x, j * texture.region.size.y))
