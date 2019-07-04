extends Sprite

func _ready():
  $flash_animations.play("fade_out")

func _on_flash_animations_animation_finished(anim_name):
  queue_free()
