extends CenterContainer
# This is an extremely basic inventory system and needs to be exteded in the future

var disable_color := Color.from_hsv(0, 0, 0.5, 0.33)

export var _item_counts := PoolIntArray([0, 0, 0])

onready var _item_slots := $ItemSlots as Control


func _ready():
	for i in _item_counts.size():
		set_item_count(i, _item_counts[i])


func set_item_count(item_idx: int, value: int) -> void:
	_item_counts[item_idx] = value
	var item_slot := _item_slots.get_child(item_idx) as Control
	var item_count := item_slot.get_node("Count") as Control
	var item_count_sprite := item_slot.get_node("Sprite") as Sprite
	var item_count_label := item_count.get_node("Label") as RichTextLabel
	item_count_label.text = String(value)
	item_count.visible = (value > 1)
	#item_slot.visible = (value > 0)
	if value == 0:
		item_count_sprite.modulate = disable_color
	else:
		item_count_sprite.modulate = Color.white


func get_item_count(item_idx: int) -> int:
	return _item_counts[item_idx]


func increment_item_count(item_idx: int, amount: int) -> void:
	set_item_count(item_idx, get_item_count(item_idx) + amount)
