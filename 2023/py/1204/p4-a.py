from aocd import get_data, submit
import re

day = 4
year = 2023
data = get_data(day=day, year=year)

win_cards = []
my_cards = []
lines = data.splitlines()
sum = 0
for line in lines:
    card_info = line.split(":")[1].strip()
    win_string, my_string = card_info.split("|")

    win_string = re.sub(r" +", " ", win_string.strip())
    my_string = re.sub(r" +", " ", my_string.strip())

    print(win_string)
    print(my_string)
    win_numbers = list(map(lambda a: int(a), win_string.strip().split(" ")))
    my_numbers = list(map(lambda a: int(a), my_string.strip().split(" ")))
    

    print(my_numbers)
    print(win_numbers)
    score = 0
    for number in my_numbers:
        if number in win_numbers:
            score = 2 * score if score != 0 else 1
    
    print(score)
    sum += score



print(sum)
result = submit(sum, part="a", day=day, year=year)
print(result)
