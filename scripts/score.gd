extends TextureRect

var score = 0 setget set_score

func set_score(new_score):
  score = new_score
  $score_label.text = str(new_score)

  if score > game.best_score:
    game.best_score = score