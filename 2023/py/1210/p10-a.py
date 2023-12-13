from aocd import get_data, submit

day = 2
year = 2023

file = open("example.txt", "r")
lines = list(map(lambda i: i.strip(), file.readlines()))
# data = get_data(day=day, year=year)
# lines = data.splitlines()

possible_moves_table = {
    "left": {"-": "left", "L": "up", "F": "down"},
    "right": {"-": "right", "7": "down", "J": "up"},
    "up": {"|": "up", "7": "left", "F": "right"},
    "down": {"|": "down", "L": "right", "J": "left"},
}

start = (
    (x,y)
    for y, row in enumerate(lines) if "S" in row
    for x, char in enumerate(row)
    if char == "S"
)

start_x, start_y = next(start)
print(f"START: {start_x}, {start_y}")

direction_one = []
direction_two = []

breadth_list = []

next_x = start_x - 1
if next_x >= 0:
    breadth_list.append(([next_x, start_y], "left", 1))

next_x = start_x + 1
if next_x < len(lines[start_y]):
    breadth_list.append(([next_x, start_y], "right", 1))

next_y = start_y + 1
if next_y >= 0:
    breadth_list.append(([start_x, next_y], "down", 1))

next_y = start_y - 1
if next_y < len(lines):
    breadth_list.append(([start_x, next_y], "up", 1))

def check_next_moves(coord, direction, steps):
    x_range = [-1,0,1]
    if direction == "left":
        x_range = [0, -1]
    if direction == "right":
        x_range = [1, 0]

    y_range = [-1, 0, 1]
    if direction == "up":
        y_range = [-1, 0]
    if direction == "down":
        y_range = [0, 1]

    print(f"COORDS: {coord}")
    additional_moves = []
    possible_coords = (
        (x,y)
        for x in x_range
        for y in y_range
        if abs(x) != abs(y)
    )

    possible_moves = possible_moves_table[direction]

    x, y = coord
    char = lines[y][x]
    #print("CURR CHAR")
    #print(char)

    for x_mod, y_mod in possible_coords:
        next_x = x + x_mod
        next_y = y + y_mod
        print(f"NEXT COORD X: {next_x}, Y: {next_y}")
        if next_y >= len(lines) or next_y < 0:
            print("Out of bounds")
            print(f"X: {next_x}, Y: {next_y}")
        elif next_x >= len(lines[next_y]) or next_x < 0:
            print("Out of bounds")
            print(f"X: {next_x}, Y: {next_y}")
        else:

            char = lines[next_y][next_x]
            print(f"NEXT CHAR: {char}")
            print(direction)
            if char in possible_moves:
                print("Adding Move")
                new_steps = steps + 1
                additional_moves.append(([next_x, next_y], possible_moves[char], new_steps)) 
    

    print()
    print()
    return additional_moves
        
count = 0
while breadth_list:
    print(breadth_list)
    coord, direction, steps = breadth_list.pop(0)
    next_moves = check_next_moves(coord, direction, steps) 
    breadth_list += next_moves

    if count == 4:
        print(breadth_list)
        exit()

    count += 1
        


# result = submit(count, part="a", day=day, year=year)
# print(result)
