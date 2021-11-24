extends Node

export (String, FILE) var endScreen_path = ""

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if get_tree().change_scene(endScreen_path) != OK:
		# Error handling
		print("Error: Unavailable endszene")
