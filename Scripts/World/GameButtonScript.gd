extends AnimatedSprite

var score
var note=null;	#note which will be given
export var input =""

func _unhandled_input(event):
	if event.is_action(input):
		if event.is_action_pressed(input):
			if note!=null:
				get_parent().increment_score(score)
				note.destroy(score);
			else:
				get_parent().increment_score(0)
			self.modulate = Color(5, 5, 5)
		elif event.is_action_released(input):
			$Timer.start()	#enables the animation to goes on
		
func _on_PerfectArea_area_entered(area):
	if area.is_in_group("note"):
		score = 4


func _on_PerfectArea_area_exited(area):
	if area.is_in_group("note"):
		score = 3


func _on_GreatArea_area_entered(area):
	if area.is_in_group("note"):
		score = 3


func _on_GreatArea_area_exited(area):
	if area.is_in_group("note"):
		score = 2


func _on_GoodArea_area_entered(area):
	if area.is_in_group("note"):
		score = 2


func _on_GoodArea_area_exited(area):
	if area.is_in_group("note"):
		score = 1

func _on_OkArea_area_entered(area):
	if area.is_in_group("note"):
		score = 1
		note = area	#when you enter the largest area, you init note to give to non null

func _on_OkArea_area_exited(area):
	if area.is_in_group("note"):
		score = 0
		note = null	#when you exit the largest area, you put the note to give to null

func _on_Timer_timeout():
	self.modulate = Color(1, 1, 1);
