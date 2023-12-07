from aocd import get_data, submit
from functools import reduce, cmp_to_key

day = 7
year = 2023

file = open("example.txt", "r")
lines = list(map(lambda i: i.strip(), file.readlines()))
data = get_data(day=day, year=year)
lines = data.splitlines()

card_heiarchy = {"A": "a", "K": "b", "Q": "c", "J": "n", "T": "e", "9": "f", "8": "g", "7": "h", "6": "i", "5": "j", "4": "k", "3": "l", "2": "m"}
list_of_hands = list(map(lambda line: line.strip().split(" "),lines))
print(list_of_hands)
sorted_hands = {}

def custom_sort(hand_1):
    # print("Sorting")
    # print(hand)

    string = ""
    for i in hand_1[0]:
        string += card_heiarchy[i]
    return string

def identify_hand_type(hand_dict):
    card_type_count = len(hand_dict)

    if card_type_count == 1:
            return "five_of_a_kind"
        # Five of a kind
    elif card_type_count == 2:
        card, count = list(hand_dict.items())[0]
        if count == 3 or count == 2:
            if "J" in hand_dict:
                return "five_of_a_kind"
            else:
                return "full_house"
        else:
            print(hand_dict)
            if "J" in hand_dict:
                print(hand_dict)
                return "five_of_a_kind"
            else:
                return "four_of_a_kind"
        # Full House or Four of a kind
    elif card_type_count == 3:
        for card, count in hand_dict.items():
            if count == 2:
                if "J" in hand_dict:
                    if hand_dict["J"] == 1:
                        return "full_house"
                    else:
                        return "four_of_a_kind"
                else:
                    return "two_pair"
            elif count == 3:
                if "J" in hand_dict:
                    return "four_of_a_kind"
                else:
                    return "three_of_a_kind"
        # Two pair or Three of a kind
    elif card_type_count == 4:
        if "J" in hand_dict:
            return "three_of_a_kind"
        else:
            return "one_pair"
        # One pair
    else:
        if "J" in hand_dict:
            return "one_pair"
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

    if hand == "333J3":
        print(f"HAND TYPE IDENTIFIED: {hand_type}")
        print(sorted_hands)



print(sorted_hands["five_of_a_kind"])

count = 0
print(sorted_hands)
for hand_type, hand_list in sorted_hands.items():
    new_sort = sorted(sorted_hands[hand_type], key=custom_sort, reverse=True)
    print("NEW SORTED")
    sorted_hands[hand_type] = new_sort

    count += len(new_sort)

ranked_hand_tuple_list = []
if "high_card" in sorted_hands:
    ranked_hand_tuple_list += sorted_hands["high_card"]
if "one_pair" in sorted_hands:
    ranked_hand_tuple_list += sorted_hands["one_pair"]
if "two_pair" in sorted_hands:
    ranked_hand_tuple_list += sorted_hands["two_pair"]
if "three_of_a_kind" in sorted_hands:
    ranked_hand_tuple_list += sorted_hands["three_of_a_kind"]
if "full_house" in sorted_hands:
    ranked_hand_tuple_list += sorted_hands["full_house"]
if "four_of_a_kind" in sorted_hands:
    ranked_hand_tuple_list += sorted_hands["four_of_a_kind"]
if "five_of_a_kind" in sorted_hands:
    ranked_hand_tuple_list += sorted_hands["five_of_a_kind"]

print(ranked_hand_tuple_list)

sum = 0
for rank, hand_tuple in enumerate(ranked_hand_tuple_list):
    sum += (rank + 1) * int(hand_tuple[1])

print(sum)
result = submit(sum , part="b", day=day, year=year)
print(result)
