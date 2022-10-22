extends Control

func _on_TextureButton_button_down():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(1)) #replace 1 by $HSlider.value when you have one
	if get_tree().change_scene("res://Scenes/UI/PlayingUI.tscn") != OK:
		print ("Error passing from Opening to playing scenes")
