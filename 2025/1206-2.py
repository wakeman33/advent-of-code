from utils import file_lines
import re

lines = file_lines('1206-data')

operators = lines.pop()

grid = [
    [
        char
        for char in line.replace('\n', '')
    ]
    for line in lines
]

print(grid)

new_grid = []
for index, row in enumerate(grid):
    for col_index, item in enumerate(row):
        try:
            new_row = new_grid[col_index]
        except IndexError:
            new_row = []
            new_grid.append(new_row)

        new_grid[col_index].append(item)


count = 0
for operator in re.findall(r'\+|\*', operators):
    operator_numbers = []
    while True:
        try:
            number_list = new_grid.pop(0)
        except IndexError:
            break
        if all(digit == ' ' for digit in number_list):
            break
        number = int("".join(str(digit) for digit in number_list))
        operator_numbers.append(number)

    if operator == '+':
        result = sum(operator_numbers)
    else:
        result = 1
        for number in operator_numbers:
            result *= number

    count += result

print(f"Count: {count}")