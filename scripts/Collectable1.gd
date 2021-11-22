extends Area2D

	
func _on_Collectable1_area_entered(area):
	$Sprite.visible=false;
	$CollisionShape2D.disabled=true;
	collision_layer=2
	collision_mask=2

