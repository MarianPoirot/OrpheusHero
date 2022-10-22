extends Control

class_name UIEnding

func hide():
	for n in $CanvasLayer.get_children():
		n.hide()

func show():
	for n in $CanvasLayer.get_children():
		n.show()
