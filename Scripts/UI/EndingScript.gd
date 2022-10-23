extends Control

class_name UIEnding

func _ready():
	$CanvasLayer/ScoreLabel.text = "Score : " + str(Global.score);
