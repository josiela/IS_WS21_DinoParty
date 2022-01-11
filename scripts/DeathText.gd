extends CanvasLayer
onready var text = get_node("/root/World/DeathText/DyingText")

func _ready():
	text.visible = false


func _on_Ralf_ralf_died():
	text.visible = true
	
