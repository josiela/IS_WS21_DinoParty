extends Node2D

const SAVE_FILE_PATH = "user://savedata.save"
var highscore = 0

func _ready():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		self.highscore = save_data.get_var()
		save_data.close()
		
	$highscore.text= String(highscore)

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		get_tree().change_scene("res://TestSzene.tscn")

