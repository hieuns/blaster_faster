extends Area2D

var velocity = Vector2(0, 300)
var screen_size
var sprite_height

func _ready():
  screen_size = get_viewport_rect().size
  sprite_height = $sprite.texture.get_size().y

func _process(delta):
  translate(velocity * delta)

  if self.position.y > screen_size.y + sprite_height:
    queue_free()

func start(pos):
  self.position = pos