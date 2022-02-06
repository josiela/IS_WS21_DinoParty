extends KinematicBody2D

signal lifespan_updated(lifespan)
signal ralf_died()
signal dontUpdateScorePlease()
signal updateScorePlease()
# Vars about Life 
onready var lifespan = 1 setget _set_lifespan

onready var _animated_sprite = $AnimatedSprite

export (String, FILE) var endScreen_path = ""

 #  Vars about movement

var isOnWall : bool=false
var direction= 1
var wallJumpForce=500
var justWallJumped= false
var setHighscore = true

var movement= Vector2(475,0)
const jumpforce= -1300

# Vars about score
var oldX=302.062012
# Vars about physics
var gravity= 90

func _ready():
	Signals.connect("hitCone", self, "hitCone")
	Signals.connect("collectedPartyHat", self, "collectedPartyHat")
	Signals.connect("pickedUpCollectable", self, "pickedUpCollectable")
	LevelState.life = 1

func _physics_process(delta):
	
	var koords=get_position()
															#Score zählen und Pausieren
	emit_signal("updateScorePlease")
	oldX=koords.x
	
		
	if(lifespan>0):
		movement = move_and_slide(movement, Vector2.UP)
		movement.y = movement.y + gravity
		if(lifespan==1):
			_animated_sprite.play("Run")
		if (lifespan ==2):
			_animated_sprite.play("Hat_Run")
		if (lifespan == 3):
			_animated_sprite.play("Hat2_Run")
		if (lifespan == 4):
			_animated_sprite.play("Hat3_Run")
		
		if movement.x == 0 :
			movement.x = 475
		
		if(nextToWall() and not is_on_floor() and not Input.is_action_just_pressed("jump") and movement.y>0   ):
			print(movement.y)
			gravity=10
		else: gravity=90
														 #about wallsliding and jumping and walljumping
		if Input.is_action_just_pressed("jump"):
			if(is_on_floor()):
				#movement.x=500
				movement.y= jumpforce
				$SoundJump.play()
				if(lifespan==1):
					_animated_sprite.play("Stand")
				if (lifespan ==2):
					_animated_sprite.play("Stand_Hat")
				if (lifespan == 3):
					_animated_sprite.play("Stand_Hat2")
				if (lifespan == 4):
					_animated_sprite.play("Stand_Hat3")
				
			if(nextToWall() and not is_on_floor()):
				movement.y= jumpforce
				print("Wall Jump BAM")
				if (direction==1):
					$AnimatedSprite.flip_h=true
					movement.x=-wallJumpForce
					
				if (direction==-1):
					$AnimatedSprite.flip_h=false
					movement.x=wallJumpForce
				direction*=-1

	
		if (is_on_floor() && direction==-1):
			movement.x=475
			$AnimatedSprite.flip_h=false
			
			
			#alles mit Leben und Sterben				#Codereste, falls man mal collision braucht die nicht durchgehbar sein soll
	#	if get_slide_count()>0:
	#		
	#		for i in range(get_slide_count()):
#
#				
#				if"Enemy" in get_slide_collision(i).collider.name:		#Zum sterben bzw lifespan verniedrigen
#					_set_lifespan(-1)
			
					
		
		
	if(lifespan==0):
		emit_signal("ralf_died")
		_animated_sprite.play("Hit")
		if Input.is_action_just_pressed("jump"):
			get_tree().change_scene("res://ParallaxTestScene.tscn")
			
	

		
		#zum ändern der Lebensanzeige
func _set_lifespan(variable):
	if(lifespan<=4):					#wenn man das Leben verändern will muss man _set_lifespan(1) oder -1 angeben
		lifespan+=variable
		emit_signal("lifespan_updated", lifespan)

func collectedPartyHat():
	if lifespan <= 4:
		_set_lifespan(1)
	_animated_sprite.play("Hat")
	print("The Hat is entered")

func nextToWall():
	return nextToRightWall() or nextToLeftWall() or nextToRightWall2() or nextToLeftWall2() 
	
func nextToRightWall():
	return $RightWall.is_colliding()
	
func nextToLeftWall():
	return $LeftWall.is_colliding()
	
func nextToRightWall2():
	return $RightWall2.is_colliding()
	
func nextToLeftWall2():
	return $LeftWall2.is_colliding()
	

func hitCone():
	$SoundHit.play()
	print("workies")
	_set_lifespan(-1)

func _on_Area2D_area_entered(area):
	#read score var from /Canvaslayer and give it to highscore
	var scoreCounter = get_node("/root/World/ScoreCounter/")
	var score = scoreCounter.get("scoreEasyShowable")
	var highscore = get_node("/root/World")
	LevelState.score = score
	LevelState.life = lifespan
	highscore.setHighscore(score)
	if score <= 48:
		LevelState.level1 = false
	LevelState.hour = highscore.hour
	if get_tree().change_scene(endScreen_path) != OK:
		# Error handling
		print("Error: Unavailable endszene")
		

func _on_FallTracker_area_entered(area):
	$SoundFall.play()
	print(lifespan)
	lifespan=0
