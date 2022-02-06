extends MarginContainer

const SAVE_FILE_PATH = "user://Level2Highscore.save"
var highscore = 0
var score = 0

func _ready():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		self.highscore = save_data.get_var()
		save_data.close()
		
	$CenterContainer/VBoxContainer/CenterContainer4/score.text= "Score: " + String(LevelState.scoreLvl2) + " minutes"
	$CenterContainer/VBoxContainer/CenterContainer3/highscore.text= "Highscore: " + String(highscore) + " minutes"
	if LevelState.level2solved:
		$CenterContainer/VBoxContainer/CenterContainer.visible=false
		$CenterContainer/VBoxContainer/CenterContainer2.visible=false
	else:
		$CenterContainer/VBoxContainer/Level21.visible = false
		$CenterContainer/VBoxContainer/Level22.visible = false
		$CenterContainer/VBoxContainer/Level23.visible = false

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		if LevelState.level2solved:
			get_tree().change_scene("res://ParallaxTestScene.tscn")
		else:
			get_tree().change_scene("res://Level2Scene.tscn")
