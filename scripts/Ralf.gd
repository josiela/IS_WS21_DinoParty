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
var wall_slide_speed= 10
var wall_slide_gravity = 10
var setHighscore = true

var movement= Vector2(500,0)
const jumpforce= -1200

# Vars about score
var oldX=302.062012
# Vars about physics
var gravity= 90


func _physics_process(delta):
	
	var koords=get_position()
	
	if(koords.x==oldX):
		print("Jo ich stehe")
		emit_signal("dontUpdateScorePlease")
	else:
		emit_signal("updateScorePlease")
	oldX=koords.x
	
	

	if(lifespan>0):											#nur Wenn nicht tot
	
		movement = move_and_slide(movement, Vector2.UP)
		movement.y = movement.y + gravity
		_animated_sprite.play("Run")
		
		
				
		#about wallsliding and jumping and walljumping
		if Input.is_action_just_pressed("jump"):
			if(is_on_floor()):
				movement.y= jumpforce
				_animated_sprite.play("Stand")
				
			if(isOnWall):
				
				movement.y= jumpforce
				print("Wall Jump BAM")
				if (direction==1):
					$Sprite.flip_h=true
					movement.x=-wallJumpForce
				if (direction==-1):
					$Sprite.flip_h=false
					movement.x=wallJumpForce
				direction*=-1
					
		if (is_on_wall() and !is_on_floor()):
			isOnWall=true
			print("aaa")
			
		if (is_on_floor()):
			
			isOnWall=false
			
		if (is_on_floor() && direction==-1):
			movement.x=300
			$Sprite.flip_h=false
			
			
			#alles mit Leben und Sterben				#Codereste, falls man mal collision braucht die nicht durchgehbar sein soll
	#	if get_slide_count()>0:
	#		
	#		for i in range(get_slide_count()):
#
#				
#				if"Enemy" in get_slide_collision(i).collider.name:		#Zum sterben bzw lifespan verniedrigen
#					_set_lifespan(-1)
			
					
		
		
	if(lifespan==0):
		#read score var from /Canvaslayer and give it to highscore
		if setHighscore:
			var scoreCounter = get_node("/root/World/ScoreCounter/")
			var score = scoreCounter.get("scoreEasy")
			var highscore = get_node("/root/World")
			highscore.setHighscore(score)
			setHighscore = false
			
	
		emit_signal("ralf_died")
		_animated_sprite.play("Hit")
		if Input.is_action_just_pressed("jump"):
			get_tree().change_scene("res://TestSzene.tscn")
			
	

		
		#zum ändern der Lebensanzeige
func _set_lifespan(variable):
	if(lifespan<=3):					#wenn man das Leben verändern will muss man _set_lifespan(1) oder -1 angeben
		lifespan+=variable
		emit_signal("lifespan_updated", lifespan)
	

func _on_Timer_timeout():
	print("timeout")
	get_tree().change_scene("res://DeadMenue.tscn")


func _on_PartyHat1_area_entered(area):
	_set_lifespan(1)
	_animated_sprite.play("Hat")
	print("The Hat is entered")



func _on_Enemy1_area_entered(area):
	_set_lifespan(-1)


func _on_PartyHat1_area_exited(area):
	pass # Replace with function body.


func _on_FallingDeathZone_area_entered(area):
	_set_lifespan(-2)


func _on_Area2D_area_entered(area):
	if get_tree().change_scene(endScreen_path) != OK:
		# Error handling
		print("Error: Unavailable endszene")
