extends ParallaxBackground

export var speed = 0

func _process(delta):
  self.scroll_offset += Vector2(0, speed)
