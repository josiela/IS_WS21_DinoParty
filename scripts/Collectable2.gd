extends Area2D


func _ready():
	pass


func _on_Collectable2_area_entered(area):
	$Sprite.visible=false;
	$CollisionShape2D.disabled=false;
	collision_layer=2
	collision_mask=2

