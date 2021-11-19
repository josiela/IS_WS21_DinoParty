extends CanvasLayer


func _ready():
	pass


func _on_Ralf_ralf_died():
	$DeathTextField.text= String("Oh no u died :'(")
	
