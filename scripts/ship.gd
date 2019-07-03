extends Area2D

var screen_size = Vector2()
var half_sprite_size = Vector2()

func _ready():
  screen_size = get_viewport_rect().size
  half_sprite_size = $sprite.texture.get_size() / 2

func _process(delta):
  var motion = (get_global_mouse_position().x - self.position.x) * 0.2
  self.position.x = clamp(self.position.x + motion, half_sprite_size.x, screen_size.x - half_sprite_size.x)
