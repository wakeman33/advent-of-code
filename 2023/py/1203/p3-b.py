from aocd import get_data, submit

day = 3
year = 2023
data = get_data(day=day, year=year)

lines = data.splitlines()
schematic = []
numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ]

def return_reduced(list):
    ret_item = [None]
    if list[0] is not None and list[1] is None and list[2] is not None:
        return list
        
    for item in list:
        if item is not None:
            ret_item = [item]
            break

    return ret_item
    

def get_number(location):
    x = location[0]
    y = location[1]
    number_list = [schematic[y][x]]

    left_x = x - 1
    while True:
        if left_x < 0:
            break

        number_char = schematic[y][left_x]
        if number_char not in numbers:
            break

        number_list.insert(0, number_char)
        left_x -= 1

    right_x = x + 1
    while True:
        if right_x == len(schematic[y]):
            break
        
        number_char = schematic[y][right_x]
        if number_char not in numbers:
            break

        number_list.append(number_char)
        right_x += 1

    return int("".join(number_list))

def get_gear_ratio(ratio_locations):
    ratio = 1
    for location in ratio_locations:
        if location is not None:
            number = get_number(location)
            print(f"Number: {number}")
            ratio *= number

    return ratio

def check_exactly_two(top, bottom, outside):
    # print("TOP-BOTTOM-OUTSIDE")
    # print(top)
    # print(bottom)
    # print(outside)
    touching_count = 0
    if top[0] is not None and top[1] is None and top[2] is not None:
        touching_count += 2
    elif top[0] is not None or top[1] is not None or top[2] is not None:
        touching_count += 1

    if bottom[0] is not None and bottom[1] is None and bottom[2] is not None:
        touching_count += 2
    elif bottom[0] is not None or bottom[1] is not None or bottom[2] is not None:
        touching_count += 1

    if outside[0] is not None:
        touching_count += 1

    if outside[1] is not None:
        touching_count += 1

    return touching_count == 2

def is_number(item):
    print(f"CHAR: {item}")
    return item in numbers

def check_position(x, y, schematic):
    up_y = y - 1
    down_y = y + 1
    right_x = x + 1
    left_x = x - 1

    top = [None] * 3
    if up_y > -1:
        if is_number(schematic[up_y][x]):
            top[1] = [x, up_y]

        if left_x > -1:
            if is_number(schematic[up_y][left_x]):
                top[0] = [left_x, up_y]


        if right_x < len(schematic[up_y]):
            if is_number(schematic[up_y][right_x]):
                top[2] = [right_x, up_y]
    

    bottom = [None] * 3
    if down_y < len(schematic):
        if is_number(schematic[down_y][x]):
            bottom[1] = [x, down_y]

        if left_x > -1:
            if is_number(schematic[down_y][left_x]):
                bottom[0] = [left_x, down_y]

        if right_x < len(schematic[down_y]):
            if is_number(schematic[down_y][right_x]):
                bottom[2] = [right_x, down_y]

    outside = [None] * 2
    if left_x > -1:
        if is_number(schematic[y][left_x]):
            outside[0] = [left_x, y]
            
    if right_x < len(schematic[y]):
        if is_number(schematic[y][right_x]):
            outside[1] = [right_x, y]

    if check_exactly_two(top, bottom, outside):
        return return_reduced(top) + return_reduced(bottom) + outside
    else:
        print("NOT EXACTLY 2")
        return None


def check_ratio(x, y, schematic):
    print(f"Checking: x => {x}, y => {y}")
    ratio_locations = check_position(x, y, schematic)
    # print(ratio_locations)

    ratio = 0
    if ratio_locations:
        ratio = get_gear_ratio(ratio_locations)

    # print(ratio) 

    return ratio

for line in lines:
    schematic.append(list(line))

# sum = 0
# y = 0
# while (y < len(schematic)):
#     x = 0
#     line = schematic[y]
#     while (x < len(line)):
#         item = line[x]
#         if item == "*":
#             ratio = check_ratio(x, y, schematic)
#             sum += ratio
#             x += 1
#         else:
#             x += 1
#     y += 1
# 

points_to_check = []
sum = 0
y = 0
while (y < len(schematic)):
    x = 0
    line = schematic[y]
    while (x < len(line)):
        item = line[x]
        if item == "*":
            points_to_check.append([x, y])
        x += 1
    y += 1

for point in points_to_check:
    ratio = check_ratio(point[0], point[1], schematic)
    print(f"Ratio: {ratio}")
    sum += ratio

print(sum)
result = submit(sum, part="b", day=day, year=year)
print(result)


