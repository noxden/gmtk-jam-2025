extends Node2D


func _ready() -> void:
	EventBus.connect("card_used_on_dish", on_card_used_on_dish)

func on_card_used_on_dish(card: Card, dish: Dish):
	card.effect.add_ingredient(dish)
	card.queue_free()
	print(dish.ingredients)
	EventBus.emit_signal("request_update_card_positions")
