extends CanvasLayer

var scoreEasy= 0;
var collectables=0;
var isalive=true;
var updateScore=true
var partyHatCounter=0;
var scoreEasyShowable=0

onready var timer = get_node("/root/World/Timer")

func _ready():
	timer.set_wait_time(0.5)
	timer.start()
	$ScoreField.text= String(scoreEasyShowable)
	Signals.connect("pickedUpCollectable", self, "pickedUpCollectable")
	$PartyhatAnzahl.text=String(partyHatCounter)
	Signals.connect("collectedPartyHat", self, "collectedPartyHat")
	Signals.connect("hitCone", self, "hitCone")
	$Time.text=("Time 23:0")
	

func _physics_process(delta):
	$ScoreField.text= String(scoreEasyShowable)
	$CollectableField.text=String(collectables)
	$PartyhatAnzahl.text=String(partyHatCounter)
	#About a cool score
	
	if(59>scoreEasy  ):
		$Time.text=("Time 23:")
	if(120>scoreEasy and scoreEasy>59 ):
		$Time.text=("Time 24:")
	if(180>scoreEasy and scoreEasy>119 ):
		$Time.text=("Time 01:")
	if(240>scoreEasy and scoreEasy>179 ):
		$Time.text=("Time 02:")
	if(scoreEasy>239 ):
		$Time.text=("Time 03:")
	if(scoreEasyShowable==60):
		scoreEasyShowable=0
	if(partyHatCounter==0):
		$PartyhatAnzahl.visible=false
		$xPartyHat.visible=false
		$PartyHat.visible=false
	else:
		$PartyhatAnzahl.visible=true
		$xPartyHat.visible=true
		$PartyHat.visible=true
		
	if(collectables==0):
		$Sprite.visible=false
		$x.visible=false
		$CollectableField.visible=false
	else:
		$Sprite.visible=true
		$x.visible=true
		$CollectableField.visible=true
		
	


func _on_Ralf_ralf_died():
	isalive=false


func pickedUpCollectable():
	collectables+=1;
	if scoreEasy <= 3:
		scoreEasy=0;
		scoreEasyShowable=0;
	else:
		scoreEasy-=3;
		scoreEasyShowable-=3;
	

func _on_Ralf_updateScorePlease():
	updateScore=true
	
func collectedPartyHat():
	partyHatCounter+=1
 
func hitCone():
	if(partyHatCounter>=1 && partyHatCounter <=3):
		partyHatCounter-=1


func _on_Timer_timeout():
	if(isalive and updateScore):
		scoreEasy+=1
		scoreEasyShowable+=1
