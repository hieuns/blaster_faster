extends Sprite

func _ready():
  randomize()

  self.rotation = rand_range(0, 2 * PI)
  $smoke.emitting = true
  $flare.emitting = true
  $explosion_animations.play("fade_out")
  audio_player.play_sfx("explosion")

func init(pos):
  self.position = pos

func _on_explosion_animations_animation_finished(anim_name):
  queue_free()
