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
    flow = {
        (-1, -1): (1, -1),
        (1, -1): (1, 1),
        (1, 1): (-1, 1),
        (-1, 1): (-1, -1),
    }
    return [
        [
            ((x + a, y + b), "M"),
            ((x + -1*a, y + -1*b), "S"),
            ((x + c, y + d), "M"),
            ((x + -1*c, y + -1*d), "S"),
        ]
        for x, y in word_list
        for (a, b), (c, d) in flow.items()
    ]

def check_word(char_list):
    return all([
        True if x < max_x and y < max_y and x > -1 and y > -1 and ws[y][x] == l else False
        for (x, y), l in char_list
    ])

possible_words = check_letter(xy_list, 'A')
answer = sum([
    1 if check_word(list_to_search) else 0
    for list_to_search in prepare_check_list(possible_words) 
])

print(f"Answer: {answer}")
# Answer 2468