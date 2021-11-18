extends CanvasLayer

var scoreEasy= 0;
var collectables=0;
var isalive=true;

func _ready():
	$ScoreField.text= String(scoreEasy)



func _physics_process(delta):
		if(isalive):
			scoreEasy+=0.06
		
		$ScoreField.text= String(scoreEasy)
		$CollectableField.text=String(collectables)





func _on_Ralf_ralf_died():
	isalive=false


func _on_survivedArea_area_entered(area):
	scoreEasy+=20


func _on_Collectable1_area_entered(area):

	collectables+=1;
