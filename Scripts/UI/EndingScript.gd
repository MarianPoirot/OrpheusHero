extends Control

class_name UIEnding

func _ready():
	$CanvasLayer/Score.text = "Score : " + str(Global.score);
