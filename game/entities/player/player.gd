extends Node2D

onready var animation: AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play(anime):
	if animation.has_animation(anime):
		animation.play(anime)
