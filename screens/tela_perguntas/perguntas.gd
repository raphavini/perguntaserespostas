extends Node2D

@onready var lbl_question = $VBox1/VBoxQuestion/Label
@onready var btn1 = $VBox1/VBoxQuestion/Resposta1
@onready var btn2 = $VBox1/VBoxQuestion/Resposta2
@onready var btn3 = $VBox1/VBoxQuestion/Resposta3
@onready var btn4 = $VBox1/VBoxQuestion/Resposta4
@onready var btn5 = $VBox1/VBoxQuestion/Resposta5
var btn_list = []

var total_time = 10  # Tempo total de 30 segundos
@onready var progress_bar = $VBox1/ProgressBar
@onready var timer = $Timer
@onready var lbl_result = $VBox1/LabelResult

@onready var btn_next_question = $VBox1/BtnNextQuestion
var awnser_selected=-1

func _ready() -> void:
	# Inicializa a lista de botões no _ready
	btn_list = [btn1, btn2, btn3, btn4, btn5]
	restart_screen()
	
func restart_screen():
	awnser_selected=-1
	load_current_question()
	btn_next_question.visible=false
	lbl_result.visible=false
	progress_bar.visible=true
	progress_bar.max_value = total_time  # Define o valor máximo para 30 segundos
	progress_bar.value = total_time
	timer.start()  # Inicia o timer assim que a cena é carregada

func load_current_question():
	lbl_question.text=Global.current_question.question
	for i in range(btn_list.size()):
		btn_list[i].text=Global.current_question.shuffled[i]
		btn_list[i].theme = load("res://themes/tema_not_selected.tres")
		btn_list[i].disabled=false

func _on_resposta_1_pressed() -> void:
	select_button(0)
func _on_resposta_2_pressed() -> void:
	select_button(1)
func _on_resposta_3_pressed() -> void:
	select_button(2)
func _on_resposta_4_pressed() -> void:
	select_button(3)
func _on_resposta_5_pressed() -> void:
	select_button(4)
func select_button(index_button) -> void:
	awnser_selected=index_button
	for i in range(btn_list.size()):
		if i == index_button:
			print("BOTÃO ", i + 1, " - Selecionado")
			btn_list[i].theme = load("res://themes/tema_selected.tres")
		else:
			print("Desmarcando botão ", i)
			btn_list[i].theme = load("res://themes/tema_not_selected.tres")

func _on_timer_timeout() -> void:
	progress_bar.value -= 1  # Incrementa o valor da barra a cada 

	if progress_bar.value <= 0:
		timer.stop()  # Para o timer após 30 segundos
		print("Tempo terminado!")
		check_awnser()

func check_awnser():
	if Global.current_question.shuffled[awnser_selected]==Global.current_question.correct_answer:
		lbl_result.text="ACERTOU"
		lbl_result.theme=load("res://themes/correct.tres")
	else:
		lbl_result.text="ERROU"
		lbl_result.theme=load("res://themes/wrong.tres")
	progress_bar.visible=false
	lbl_result.visible=true
	for i in range(btn_list.size()):
		if i!=awnser_selected:
			btn_list[i].disabled=true
	btn_next_question.visible=true

func _on_btn_next_question_pressed() -> void:
	Global.new_question() # Replace with function body.
	load_current_question()
	restart_screen()
