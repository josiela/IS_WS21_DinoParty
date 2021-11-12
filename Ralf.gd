extends KinematicBody2D


signal lifespan_updated(lifespan)
signal killed()
# Vars about Life 
onready var lifespan = 1 setget _set_lifespan


 #  Vars about movement
onready var leftWallRaycast = $LefttRaycast2
onready var rightWallRaycast= $RightRaycast
var isOnWall : bool=false
var direction= 1
var wallJumpForce=500
var justWallJumped= false
var wall_slide_speed= 10
var wall_slide_gravity = 10

var movement= Vector2(300,0)
const jumpforce= -1200


# Vars about physics
var gravity= 90


func _physics_process(delta):

	if(lifespan>0):											#nur Wenn nicht tot
	
		movement = move_and_slide(movement, Vector2.UP)
		movement.y = movement.y + gravity
		
		
				
		#about wallsliding and jumping and walljumping
		if Input.is_action_just_pressed("jump"):
			if(is_on_floor()):
				movement.y= jumpforce
				print("jumped")
				
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
		print("I DIED")
		get_tree().change_scene("res://DeadMenue.tscn")
		$Timer.start()
			
	

		
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
	print("The Hat is entered")



func _on_Enemy1_area_entered(area):
	_set_lifespan(-1)
