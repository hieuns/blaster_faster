extends Area2D

export var velocity = Vector2()

func _ready():
  add_to_group("laser")

func _process(delta):
  translate(velocity * delta)

func start(pos):
  self.position = pos

func _on_visibility_notifier_screen_exited():
  queue_free()

func _on_area_entered(area):
  queue_free()
