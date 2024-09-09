extends Node

var questions = []
var current_question = {
	"question": "Pergunta",
	"correct_answer": "A",
	"answers": ["A", "B", "C", "D", "E"],
	"shuffled": ["A", "B", "C", "D", "E"]
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_questions()

func load_questions() -> void:
	var file = FileAccess.open("res://questions.json", FileAccess.READ)
	var json = file.get_as_text()
	file.close()
	questions = JSON.parse_string(json)['questions']

func new_question():
	current_question = questions[randi() % questions.size()]
	current_question.shuffled = current_question.answers.duplicate()
	current_question.shuffled.shuffle()
	print(current_question.answers)
	print(current_question.shuffled)
