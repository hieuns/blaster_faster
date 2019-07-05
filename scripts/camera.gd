extends Camera2D

var magnitude = 0
var shaking_time_left = 0

func _process(delta):
  if shaking_time_left > 0:
    shaking_time_left -= delta
    self.position.x = rand_range(-magnitude, magnitude)
    self.position.y = rand_range(-magnitude, magnitude)
  else:
    magnitude = 0
    self.position = Vector2(0, 0)

func shake(new_magnitude, shaking_time):
  if new_magnitude > magnitude or shaking_time_left <= 0:
    magnitude = new_magnitude
    shaking_time_left = shaking_time