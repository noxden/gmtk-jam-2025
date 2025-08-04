class_name Dish extends Node2D

var ingredients = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_area_2d_mouse_entered() -> void:
	EventBus.emit_signal("hovered_dish", self)

func _on_area_2d_mouse_exited() -> void:
	EventBus.emit_signal("unhovered_dish", self)
