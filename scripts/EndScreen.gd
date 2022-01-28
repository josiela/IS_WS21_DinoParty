extends MarginContainer

const SAVE_FILE_PATH = "user://savedata.save"
var highscore = 0
var score = 0

func _ready():
	var save_data = File.new()
	if save_data.file_exists(SAVE_FILE_PATH):
		save_data.open(SAVE_FILE_PATH, File.READ)
		self.highscore = save_data.get_var()
		save_data.close()
		
	$CenterContainer/VBoxContainer/CenterContainer3/highscore.text= "Highscore: " + String(highscore+" minutes")
	if highscore<=48:
		LevelState.level1 = false
		$CenterContainer/VBoxContainer/CenterContainer.visible=false
		$CenterContainer/VBoxContainer/CenterContainer2.visible=false
	else:
		$CenterContainer/VBoxContainer/Level21.visible = false
		$CenterContainer/VBoxContainer/Level22.visible = false
		$CenterContainer/VBoxContainer/Level23.visible = false

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		get_tree().change_scene("res://ParallaxTestScene.tscn")
