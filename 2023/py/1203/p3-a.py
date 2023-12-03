from aocd import get_data, submit

day = 3
year = 2023
data = get_data(day=day, year=year)

lines = data.splitlines()
schematic = []

numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0","1",]

def is_symbol(item):
    return not (item == "." or item in numbers)


def check_position(x, y, schematic):
    up_y = y - 1
    down_y = y + 1
    right_x = x + 1
    left_x = x - 1

    has_symbol = False

    if up_y > -1:
        has_symbol = has_symbol or is_symbol(schematic[up_y][x])

        if left_x > -1:
            has_symbol = has_symbol or is_symbol(schematic[up_y][left_x])

        if right_x < len(schematic[up_y]):
            has_symbol = has_symbol or is_symbol(schematic[up_y][right_x])


    if down_y < len(schematic):
        has_symbol = has_symbol or is_symbol(schematic[down_y][x])

        if left_x > -1:
            has_symbol = has_symbol or is_symbol(schematic[down_y][left_x])

        if right_x < len(schematic[down_y]):
            has_symbol = has_symbol or is_symbol(schematic[down_y][right_x])

    if left_x > -1:
        has_symbol = has_symbol or is_symbol(schematic[y][left_x])

    if right_x < len(schematic[y]):
        has_symbol = has_symbol or is_symbol(schematic[y][right_x])

    return has_symbol


def check_number(x, y, schematic):
    return_number = False
    number_list = []
    while True:
        if x >= len(schematic[y]) or schematic[y][x] not in numbers:
            break

        number_list.append(schematic[y][x])
        return_number = return_number or check_position(x, y, schematic)
        
        x += 1

    if return_number:
        print(number_list)
        value = int("".join(number_list))
        return (x, value)
    else:
        return (x, 0)


for line in lines:
    schematic.append(list(line))

sum = 0
y = 0
while (y < len(schematic)):
    engin_part = ""
    x = 0
    line = schematic[y]
    while (x < len(line)):
        item = line[x]
        if item in numbers:
            (jump, value) = check_number(x, y, schematic)
            
            sum += value

            x = jump
        else:
            x += 1
    y += 1

result = submit(sum, part="a", day=day, year=year)
print(result)


