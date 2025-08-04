class_name Card extends Node2D

var cost: int

func initialize(card_info: Dictionary) -> void:
	var texture = load('res://assets/sprites/' + card_info["sprite"] + '.png')
	
	cost = card_info["cost"]
	$"Title".text = card_info["title"]
	$"Description".text = card_info["description"]
	$"Image".texture = texture

func _on_area_2d_mouse_entered() -> void:
	EventBus.emit_signal("card_hovered", self)

func _on_area_2d_mouse_exited() -> void:
	EventBus.emit_signal("card_unhovered", self)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			EventBus.emit_signal("card_clicked", self)
		else:
			EventBus.emit_signal("card_let_go", self)
