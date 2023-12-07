from aocd import get_data, submit
from functools import reduce

day = 2
year = 2023

file = open("example.txt", "r")
lines = list(map(lambda i: i.strip(), file.readlines()))
# data = get_data(day=day, year=year)
# lines = data.splitlines()

list_of_hands = list(map(lambda line: line.strip().split(" "),lines))
sorted_hands = []


def number_of_unique_cards(hand_dict):
    card_count = len(hand_dict)
    if card_count == 1:
        # Five of a kind
    elif card_count == 2:
        # Full House or Four of a kind
    elif card_count == 3:
        # Two pair or Three of a kind
    elif card_count == 4:
        # One pair
    else:
        # High card


def sort_hand(hand_dict):



for hand, bid in list_of_hands:
    print(f"HAND: {hand}")
    print(f"BID: {bid}")
    hand_dict = {}
    for card in hand:
        if card in hand_dict:
            hand_dict[card] += 1
        else:
            hand_dict[card] = 1
    
    print(hand_dict)


# result = submit(count, part="a", day=day, year=year)
# print(result)
