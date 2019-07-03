extends Sprite

export var velocity = Vector2()

var screen_size = Vector2()
var sprite_height

func _ready():
  screen_size = get_viewport_rect().size
  sprite_height = texture.get_size().y

func _process(delta):
  translate(velocity * delta)

  if self.position.y > screen_size.y:
    self.position.y = -sprite_height
