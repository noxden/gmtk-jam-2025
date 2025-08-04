class_name Deck extends Node2D

var cards_in_deck


func _ready() -> void:
	cards_in_deck = GameState.cards_in_deck
	cards_in_deck.shuffle()

func get_card():
	var ret = cards_in_deck.pop_front()
	match cards_in_deck.size():
		3:
			$"Top".visible = false
		1:
			$"Middle".visible = false
		0:
			$"Bottom".visible = false
	return ret
