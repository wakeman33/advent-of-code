from utils import file_lines

lines = file_lines('1204-data')

grid = [
    [
        char
        for char in line.strip()
    ]
    for line in lines
]

def all_lengths_equal():
    equal = [
        len(row)
        for row in grid
    ]
    return all(length == equal[0] for length in equal)

if not all_lengths_equal():
    raise ValueError("Not all rows in the grid have the same length.")

def valid_cell(x, y):
    return y >= 0 and y < len(grid) and x >= 0 and x < len(grid[0])

def adjacent_cells(x, y):
    directions = [
        (-1, -1), (-1, 0), (-1, 1),
        (0, -1),           (0, 1),
        (1, -1),  (1, 0),  (1, 1)
    ]
    return [
        (x + dx, y + dy)
        for dx, dy in directions
        if valid_cell(x + dx, y + dy)
    ]

def cell_is_roll(x, y):
    if grid[y][x] == '@':
        return True
    return False

cells_to_check = [
    adjacent_cells(x, y)
    for y in range(len(grid))
    for x in range(len(grid[0]))
    if grid[y][x] == '@'
]
print(cells_to_check)

rolls = [
    sum([
        1
        for (x, y) in cell_group
        if cell_is_roll(x, y)
    ])
    for cell_group in cells_to_check
]
print(rolls)

count = sum([1 for roll in rolls if roll < 4])

print(count)