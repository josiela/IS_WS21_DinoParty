extends CanvasLayer

var scoreEasy= 0;
var collectables=-1;
var isalive=true;
var updateScore=true
var partyHatCounter=0;


func _ready():
	$ScoreField.text= String(scoreEasy)
	Signals.connect("pickedUpCollectable", self, "pickedUpCollectable")
	$PartyhatAnzahl.text=String(partyHatCounter)
	Signals.connect("collectedPartyHat", self, "collectedPartyHat")
	Signals.connect("hitCone", self, "hitCone")


func _physics_process(delta):
	if(isalive and updateScore):
		scoreEasy+=0.06
	
	$ScoreField.text= String(scoreEasy)
	$CollectableField.text=String(collectables)
	$PartyhatAnzahl.text=String(partyHatCounter)
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


func _on_survivedArea_area_entered(area):
	scoreEasy+=20


func pickedUpCollectable():
	collectables+=1;


func _on_Ralf_dontUpdateScorePlease():
	updateScore=false


func _on_Ralf_updateScorePlease():
	updateScore=true
	
func collectedPartyHat():
	partyHatCounter+=1
 
func hitCone():
	if(partyHatCounter>=1):
		partyHatCounter-=1
