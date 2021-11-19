extends Node

const SAVE_FILE_PATH = "user://savedata.save"

var highscore = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	load_highscore()
	print(highscore)

func setHighscore(score):
	if score > highscore:
		highscore = score
		save_highscore()
		
func save_highscore():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH, File.WRITE)
	save_data.store_var(highscore)
	save_data.close()

func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		highscore = save_data.get_var()
		save_data.close() 
