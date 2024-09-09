extends Node
	
func _on_button_pressed() -> void:
	Global.new_question()
	get_tree().change_scene_to_file("res://perguntas.tscn")
