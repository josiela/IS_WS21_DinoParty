extends Node

const SAVE_FILE_PATH = "user://savedata.save"

var highscore = 0
var hour=22
var showablehighscore
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	self.load_highscore()
	# Highscore in Uhrzeit umrechnen
	showablehighscore=highscore
	LevelState.level2solved = false
	while(showablehighscore>60):
		hour+=1
		showablehighscore-=60
	if(hour>24):
		hour-=24
	
		
	$ScoreCounter/highscore.text= "Best time " +String(hour)+": " +String(showablehighscore)

func setHighscore(score):
	if highscore!=0:
		if score < self.highscore:
			highscore = score
			self.save_highscore()
	else:
		highscore = score
		self.save_highscore()
		
func save_highscore():
	var save_data = File.new()
	save_data.open(SAVE_FILE_PATH, File.WRITE)
	save_data.store_var(self.highscore)
	save_data.close()

func load_highscore():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		self.highscore = save_data.get_var()
		save_data.close() 
