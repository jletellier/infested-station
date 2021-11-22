extends Node2D

export var _text: String = "" setget set_text

onready var _label := $"MarginContainer/MarginContainer/CenterContainer/Text" as Label


func _ready():
	_label.text = _text


func set_text(value: String):
	_text = value
	if _label:
		_label.text = _text
