extends Node2D

export var _text: String = ""
export var text_speed: float = 20

var _text_length: int = 1

onready var _label := $"MarginContainer/MarginContainer/CenterContainer/Text" as Label


func _ready():
	set_text(_text)


func _process(delta):
	_label.percent_visible += delta * text_speed / _text_length
	if (_label.percent_visible > 1):
		_label.percent_visible = 1
		set_process(false)


func set_text(value: String):
	_text = value
	_label.text = _text.c_unescape()
	_text_length = _label.text.length()
	if _text_length > 0:
		visible = true
		_label.percent_visible = 0
		set_process(true)
	else:
		visible = false
		set_process(false)
