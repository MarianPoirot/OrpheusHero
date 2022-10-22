extends CanvasLayer

func _on_UIOpening_run_game():
	$UIOpening.hide()

func display_Opening():
	$UIOpening.show()

func display_Ending():
	$UIEnding.show()
	
func hide_Ending():
	$UIEnding.hide()
