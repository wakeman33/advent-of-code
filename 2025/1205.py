from utils import file_lines

lines = file_lines('1205-data')

fresh_range = [
    tuple(map(int, line.strip().split('-')))
    for line in lines
    if '-' in line
]

def fresh_check(range_list: list[tuple[int, int]], item) -> bool:
    print(range_list[0], item, range_list[1])
    print(range_list[0] <= item <= range_list[1])
    return range_list[0] <= item <= range_list[1]

print(fresh_range)

items = [
    int(line.strip())
    for line in lines
    if '-' not in line and line != '\n'
]

count = 0
for item in items:
    for range in fresh_range:
        check = fresh_check(range, item)
        if check:
            print(f"Item {item} is in range {range}")
            count += 1
            break


print(f"Count: {count}")