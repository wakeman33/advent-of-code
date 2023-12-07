from aocd import get_data, submit
from functools import reduce, cmp_to_key

day = 7
year = 2023

file = open("example.txt", "r")
lines = list(map(lambda i: i.strip(), file.readlines()))
# data = get_data(day=day, year=year)
# lines = data.splitlines()

card_heiarchy = {"A": 1, "K": 2, "Q": 3, "J": 4, "T": 5, "9": 6, "8": 7, "7": 8, "6": 9, "5": 10, "4": 11, "3": 12, "2": 13}
list_of_hands = list(map(lambda line: line.strip().split(" "),lines))
print(list_of_hands)
sorted_hands = {}

def custom_sort(hand_1):
    print("Sorting")
    print(hand)

    number = ""
    for i in hand_1[0]:
        number += str(card_heiarchy[i])
    return int(number)

def identify_hand_type(hand_dict):
    card_type_count = len(hand_dict)
    if card_type_count == 1:
        return "five_of_a_kind"
        # Five of a kind
    elif card_type_count == 2:
        card, count = list(hand_dict.items())[0]
        if count == 3 or count == 2:
            return "full_house"
        else:
            return "four_of_a_kind"
        # Full House or Four of a kind
    elif card_type_count == 3:
        for card, count in hand_dict.items():
            if count == 2:
                return "two_pair"
            elif count == 3:
                return "three_of_a_kind"
        # Two pair or Three of a kind
    elif card_type_count == 4:
        return "one_pair"
        # One pair
    else:
        return "high_card"

for hand, bid in list_of_hands:
    print(f"HAND: {hand}")
    print(f"BID: {bid}")
    hand_dict = {}
    for card in hand:
        if card in hand_dict:
            hand_dict[card] += 1
        else:
            hand_dict[card] = 1
    hand_type = identify_hand_type(hand_dict)    
    if hand_type not in sorted_hands:
        sorted_hands[hand_type] = [(hand, bid)]
    else:
        sorted_hands[hand_type].append((hand, bid))

print(sorted_hands)
for hand_type, hand_list in sorted_hands.items():
    print(hand_type)
    print(hand_list)
    new_sort = sorted(sorted_hands[hand_type], key=custom_sort)
    print(new_sort)
    sorted_hands[hand_type] = new_sort

print(sorted_hands)

ranked_hand_tuple_list = []
if "five_of_a_kind" in sorted_hands:
    ranked_hand_tuple_list += sorted_hands["five_of_a_kind"]
if "four_of_a_kind" in sorted_hands:
    ranked_hand_tuple_list += sorted_hands["four_of_a_kind"]
if "full_house" in sorted_hands:
    ranked_hand_tuple_list += sorted_hands["full_house"]
if "three_of_a_kind" in sorted_hands:
    ranked_hand_tuple_list += sorted_hands["three_of_a_kind"]
if "two_pair" in sorted_hands:
    ranked_hand_tuple_list += sorted_hands["two_pair"]
if "one_pair" in sorted_hands:
    ranked_hand_tuple_list += sorted_hands["one_pair"]
if "high_card" in sorted_hands:
    ranked_hand_tuple_list += sorted_hands["high_card"]

print(ranked_hand_tuple_list)

sum = 0
for rank, hand_tuple in enumerate(list(reversed(ranked_hand_tuple_list))):
    sum += (rank + 1) * int(hand_tuple[1])

print(sum)
result = submit(sum , part="a", day=day, year=year)
print(result)
