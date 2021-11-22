extends ParallaxBackground

export (float) var scrollingSpeed = 500.00

func _process(delta):
	scroll_offset.y += scrollingSpeed * delta
