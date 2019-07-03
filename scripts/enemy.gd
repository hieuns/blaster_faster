extends Area2D

export var velocity = Vector2()

var screen_size = Vector2()
var half_sprite_height
var half_sprite_width

func _ready():
  screen_size = get_viewport_rect().size

  var texture_size = $sprite.texture.get_size()
  half_sprite_width = texture_size.x / 2
  half_sprite_height = texture_size.y / 2

func _process(delta):
  translate(velocity * delta)

  if self.position.y - half_sprite_height > screen_size.y:
    queue_free()

func start(pos):
  self.position = pos
