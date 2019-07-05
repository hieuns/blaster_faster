extends Node

const filepath = "user://best_score.data"

var best_score = 0 setget set_best_score

func _ready():
  _load_best_score()

func set_best_score(score):
  best_score = score
  _save_best_score()

func _load_best_score():
  var file = File.new()

  if file.file_exists(filepath):
    file.open(filepath, File.READ)
    best_score = file.get_var()
    file.close()

func _save_best_score():
  var file = File.new()

  file.open(filepath, File.WRITE)
  file.store_var(best_score)
  file.close()
