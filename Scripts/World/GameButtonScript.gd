extends AnimatedSprite

var perfect=false;
var great=false;
var good=false;
var ok=false;


func _on_PerfectArea_area_entered(area):
	if area.is_in_group("note"):
		perfect=true


func _on_PerfectArea_area_exited(area):
	if area.is_in_group("note"):
		perfect=false


func _on_GreatArea_area_entered(area):
	if area.is_in_group("note"):
		great=true


func _on_GreatArea_area_exited(area):
	if area.is_in_group("note"):
		great=false


func _on_GoodArea_area_entered(area):
	if area.is_in_group("note"):
		good=true


func _on_GoodArea_area_exited(area):
	if area.is_in_group("note"):
		good=false

func _on_Timer_timeout():
	pass
