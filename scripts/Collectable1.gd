extends Area2D

	
func _on_Collectable1_area_entered(area):
	$Sprite.visible=false;
	$CollisionShape2D.disabled=true;

