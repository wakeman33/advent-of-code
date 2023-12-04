# from aocd import get_data, submit
import re

day = 4
year = 2023
# data = get_data(day=day, year=year)
file = open("./example.txt", "r")

card_multiplier = {0: 0}
win_cards = []
my_cards = []
lines = file.readlines()
count = 0
for card_number, line in enumerate(lines):
    card_info = line.split(":")[1].strip()
    win_string, my_string = card_info.split("|")

    win_string = re.sub(r" +", " ", win_string.strip())
    my_string = re.sub(r" +", " ", my_string.strip())

    win_numbers = list(map(lambda a: int(a), win_string.strip().split(" ")))
    my_numbers = list(map(lambda a: int(a), my_string.strip().split(" ")))
    
    card_wins = 0
    for number in my_numbers:
        if number in win_numbers:
            card_wins += 1
    
    
    print(f"WINS: {card_wins}")
    if card_number not in card_multiplier:
        card_multiplier[card_number] = 0

    multiplier = card_multiplier[card_number]

    print(f"Multiplier: {multiplier}")
    print(f"Card Number: {card_number}")
    for next_card_number in range(card_number + 1, (card_number + card_wins + 1)):
        if next_card_number in card_multiplier:
            card_multiplier[next_card_number] += (multiplier + 1)
        else:
            card_multiplier[next_card_number] = (multiplier + 1)
    
    if count == 4:
        print(card_multiplier)
        #exit()
    
    count += 1
    print()

print(card_multiplier)
sum = 0
for card_number, number_of_copies in card_multiplier.items():
    sum += (number_of_copies + 1)


print(sum)
# result = submit(sum, part="b", day=day, year=year)
# print(result)
