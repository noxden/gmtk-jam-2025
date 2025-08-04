class_name Card extends Node2D

var cost: int
var effect: BaseIngredientStrategy

func initialize(card_info: Dictionary) -> void:
	var texture = load(card_info["sprite_path"])
	effect = load(card_info["effect_resource_path"])
	
	cost = card_info["cost"]
	$"Front/Title".text = card_info["title"]
	$"Front/Description".text = card_info["description"]
	$"Front/Image".texture = texture

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
