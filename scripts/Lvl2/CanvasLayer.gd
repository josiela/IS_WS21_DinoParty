extends CanvasLayer

onready var scoreEasy= LevelState.score;
var collectables=0;
var isalive=true;
var updateScore=true
var partyHatCounter=0;
onready var scoreEasyShowable = self.scoreEasy
var tenMinutes = 0
var entranceEnd = 90
onready var hour = LevelState.hour

onready var timer = get_node("/root/World/Timer")

func _ready():
	timer.set_wait_time(0.5)
	timer.start()
	$ScoreField.text= String(scoreEasyShowable)
	Signals.connect("pickedUpCollectable", self, "pickedUpCollectable")
	$PartyhatAnzahl.text=String(partyHatCounter)
	Signals.connect("collectedPartyHat", self, "collectedPartyHat")
	Signals.connect("hitCone", self, "hitCone")
	$Time.text=("Time 22:0")
	

func _physics_process(delta):
	$ScoreField.text= String(scoreEasyShowable)
	$CollectableField.text=String(collectables)
	$PartyhatAnzahl.text=String(partyHatCounter)
	#About a cool score
	
	if(59>scoreEasy  ):
		$Time.text=("Time 22:")
	if(120>scoreEasy and scoreEasy>59 ):
		$Time.text=("Time 23:")
	if(180>scoreEasy and scoreEasy>119 ):
		$Time.text=("Time 24:")
	if(240>scoreEasy and scoreEasy>179 ):
		$Time.text=("Time 01:")
	if(scoreEasy>239 ):
		$Time.text=("Time 02:")
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
	if (entranceEnd >= 0):
		$EntranceEnd.text = "23:50"
	else:
		$EntranceEnd.text = "Admission is ending now"
		
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
	$BottleSound.play()
	collectables+=1;
	if scoreEasy <= 3:
		scoreEasy=0;
		scoreEasyShowable=0;
	else:
		scoreEasy-=3;
		scoreEasyShowable-=3;
	entranceEnd + 3
	

func _on_Ralf_updateScorePlease():
	updateScore=true
	
func collectedPartyHat():
	$PartyHorn.play()
	partyHatCounter+=1
 
func hitCone():
	if(partyHatCounter>=1 && partyHatCounter <=3):
		partyHatCounter-=1


func _on_Timer_timeout():
	tenMinutes+=1
	if(isalive and updateScore):
		scoreEasy+=1
		scoreEasyShowable+=1
	if (tenMinutes % 10 == 0):
		if entranceEnd != 0:
			entranceEnd-=10
