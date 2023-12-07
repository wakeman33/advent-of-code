from aocd import get_data, submit
import re
import math
from functools import reduce

day = 6
year = 2023

# file = open("example.txt", "r")
# lines = list(map(lambda i: i.strip(), file.readlines()))
data = get_data(day=day, year=year)
lines = data.splitlines()

times_string = re.sub(r" +", "", lines[0].split(":")[1])
records_string = re.sub(r" +", "", lines[1].split(":")[1])
times = int(times_string)
records = int(records_string)
print(times)
print(records)

time = times
record = records
number_of_wins = []
mm_per_sec = 0
while True:
    mm_per_sec += 1
    time -= 1
    if (mm_per_sec * time) > record:
        print("WIN!")
        print(mm_per_sec)
        break

mm_per_sec_2 = time
while True:
    mm_per_sec_2 -= 1
    time_left = time - mm_per_sec_2

    if (mm_per_sec_2 * time) > record:
        print("WIN!")
        print(mm_per_sec_2)
        break
number_of_wins.append(mm_per_sec_2 - mm_per_sec + 2)
    

print(number_of_wins)
answer = reduce(lambda x, y: x * y, number_of_wins)
print(answer)
result = submit(answer, part="b", day=day, year=year)
# print(result)
