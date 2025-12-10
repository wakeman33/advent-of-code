from utils import file_lines

lines = file_lines('1202-data')
line = lines[0].strip()
ranges = line.split(',')

id_ranges = [
    (i.split('-')[0], i.split('-')[1])
    for i in ranges
]

ids = [
    list(range(int(f), int(s) + 1))
    for f, s in id_ranges
]

flat_ids = [str(item) for sublist in ids for item in sublist]

sum = 0
for id in flat_ids:
    mid = len(id) // 2
    if id[:mid] == id[mid:]:
        sum += int(id)

print("Sum:", sum)
