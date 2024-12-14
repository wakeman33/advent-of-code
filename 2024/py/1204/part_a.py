import re
answer = 0
f = open("/home/kepankra/src/personal/advent-of-code/2024/py/1204/example.txt", "r")

ws = [
    list(line.strip())
    for line in f.readlines()
]
max_x = len(ws[0])
max_y = len(ws)

list = [
    (x, y)
    for y in range(max_y)
    for x in range(max_x)
]

def check_letter(list, letter):
    return [
        (x, y)
        for x, y in list
        if ws[y][x] == letter
    ]

def prepare_check_list(list):
    return [
        [(x-1, y), (x-1, y+1), (x-1, y-1) (x+1, y),(x+1, y-1), (x+1, y+1), (x, y+1), (x, y-1)]
        for x, y in list
    ]

search = list("XMAS")

possible_words = check_letter(list, search.pop(0))

for char in search:
    list_to_search = prepare_check_list(possible_words)
    possible_words = check_letter()


print(f"M-list: {m_list}")

print(f"max_x: {max_x}")
print(f"max_y: {max_y}")

print(ws)

print(f"Answer: {answer}")
# Answer 167090022