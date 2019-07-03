extends Sprite

func _ready():
  $flare_animations.play("fade_out")

func start(pos):
  self.position = pos

func _on_flare_animations_animation_finished(anim_name):
  queue_free()
