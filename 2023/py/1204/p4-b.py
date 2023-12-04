from aocd import get_data, submit
import re

day = 4
year = 2023
data = get_data(day=day, year=year)

card_multiplyer = {1: 0}
win_cards = []
my_cards = []
lines = data.splitlines()
sum = 0
for card_number, line in lines:
    card_info = line.split(":")[1].strip()
    win_string, my_string = card_info.split("|")

    win_string = re.sub(r" +", " ", win_string.strip())
    my_string = re.sub(r" +", " ", my_string.strip())

    win_numbers = list(map(lambda a: int(a), win_string.strip().split(" ")))
    my_numbers = list(map(lambda a: int(a), my_string.strip().split(" ")))
    
    sum += 1
    sum += card_multiplyer[card_number]
    card_wins = 0
    for number in my_numbers:
        if number in win_numbers:
            card_wins += 1
    
    for i in range(card_number + 1, card_wins):
        if i in card_multiplyer:
            card_multiplyer[i] += 1
        else:
            card_number = 1


print(sum)
result = submit(sum, part="a", day=day, year=year)
print(result)
