extends Node2D

#interactions with cards
signal hovered_card(card: Card)
signal unhovered_card(card: Card)
signal clicked_card(card: Card)
signal let_go_card(card: Card)

#interactions with dishes
signal hovered_dish(dish: Dish)
signal unhovered_dish(dish: Dish)

#interactions for playing cards on dishes
signal card_used_on_dish(card: Card, dish: Dish)

#interactions for picking cards from hand
signal return_card_to_player_hand()
