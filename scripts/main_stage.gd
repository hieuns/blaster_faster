extends Node

const flash_class = preload("res://scenes/flash.tscn")

func _on_ship_shoot(laser, flare):
  add_child(laser)
  add_child(flare)

func _on_enemy_spawner_enemy_shoot(laser):
  add_child(laser)

func _on_ship_hit_by_laser(flare):
  add_child(flare)
  add_child(flash_class.instance())
  $camera.shake(3, 0.13)

func _on_ship_hit_by_enemy():
  add_child(flash_class.instance())
  $camera.shake(3, 0.13)

func _on_enemy_spawner_enemy_get_hit(flare):
  add_child(flare)
  $camera.shake(1, 0.13)

func _on_ship_explode(explosion):
  add_child(explosion)
  $camera.shake(8, 0.13)
  $hud/reload_button.show()
  $hud/quit_button.show()

func _on_enemy_spawner_enemy_explode(explosion):
  add_child(explosion)
  $camera.shake(8, 0.13)
  $hud/score_container.score += 1

func _on_enemy_spawner_enemy_drop_powerup(powerup_item):
  call_deferred("add_child", powerup_item)
