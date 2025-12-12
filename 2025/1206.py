from utils import file_lines
import re

lines = file_lines('1206-data')

grid = [
    re.findall(r'\d+|\+|\*', line)
    for line in lines
]

new_grid = []
for index, row in enumerate(grid):
    for col_index, item in enumerate(row):
        try:
            new_row = new_grid[col_index]
        except IndexError:
            new_row = []
            new_grid.append(new_row)

        new_grid[col_index].append(item)

def do_math(row: list[str]) -> int:
    operator = row[-1]
    if operator == '+':
        result = sum(int(x) for x in row[:-1])
    else:
        result = 1
        for x in row[:-1]:
            result *= int(x)

    return result

count = sum([
    do_math(row)
    for row in new_grid
])

print(f"Count: {count}")