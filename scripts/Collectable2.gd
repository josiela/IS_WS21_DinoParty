extends Area2D


func _ready():
	pass


func _on_Collectable2_area_entered(area):
	$Sprite.visible=false;
	$CollisionShape2D.disabled=false;

