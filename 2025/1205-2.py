from utils import file_lines

lines = file_lines('1205-data')

fresh_ranges = [
    tuple(map(int, line.strip().split('-')))
    for line in lines
    if '-' in line
]

sorted_ranges = sorted(fresh_ranges, key=lambda x: x[0])

def ranges_overlap(r1: tuple[int, int], r2: tuple[int, int]) -> bool:
    return r1[1] >= r2[0] or r1[1] >= r2[1]

def get_range_size(r: tuple[int, int]) -> int:
    return r[1] - r[0] + 1

updated_ranges = []
while len(sorted_ranges) > 0:
    first = sorted_ranges.pop(0)

    if len(sorted_ranges) == 0:
        updated_ranges.append(first)
        break

    second = sorted_ranges[0]

    if ranges_overlap(first, second):
        new_range = (min(first[0], second[0]), max(first[1], second[1]))
        sorted_ranges[0] = new_range
    else:
        updated_ranges.append(first)

count = sum([
    get_range_size(r)
    for r in updated_ranges
])
print(f"Count: {count}")

