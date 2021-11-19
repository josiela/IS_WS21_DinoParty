extends Area2D




func _on_PartyHat1_area_entered(area):
	$Sprite.visible=false;
	$CollisionShape2D.disabled=true;

