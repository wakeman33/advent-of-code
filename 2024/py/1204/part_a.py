import re
answer = 0
f = open("/home/kepankra/src/personal/advent-of-code/2024/py/1204/data.txt", "r")

ws = [
    list(line.strip())
    for line in f.readlines()
]
max_x = len(ws[0])
max_y = len(ws)

xy_list = [
    (x, y)
    for y in range(max_y)
    for x in range(max_x)
]

def check_letter(word_list, letter):
    return [
        (x, y)
        for x, y in word_list
        if x < max_x and y < max_y and x > -1 and y > -1 and ws[y][x] == letter
    ]

def prepare_check_list(word_list):
    return [
        [
            (x + a*1, y + b*1),
            (x + a*2, y + b*2),
            (x + a*3, y + b*3),
        ]
        for x, y in word_list
        for a in (-1, 0, 1)
        for b in (-1, 0, 1)
        if not (a == 0 and b == 0)
    ]

def check_word(char_list, word):
    return all([
        True if x < max_x and y < max_y and x > -1 and y > -1 and ws[y][x] == l else False
        for (x, y), l in list(zip(char_list, list(word)))
    ])

possible_words = check_letter(xy_list, 'X')
answer = sum([
    1 if check_word(list_to_search, "MAS") else 0
    for list_to_search in prepare_check_list(possible_words) 
])

print(f"Answer: {answer}")
# Answer 2468