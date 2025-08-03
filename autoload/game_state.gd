extends Node

var hand_size = 5

var cards_in_deck = []

func _ready():
	for i in range(10):
		cards_in_deck.append(Cards.CARDS["knife"])
