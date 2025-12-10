def file_lines(file_path):
    with open(file_path, 'r') as file:
        return file.readlines()

lines = file_lines('1201-data')

instructions = [
    (i[0], i[1:])
    for i in lines
]

start = 50
count = 0
for d, i in instructions:
    if d == "L":
        start -= int(i)
    elif d == "R":
        start += int(i)
    start = start % 100
    if start == 0:
        count += 1
print(count)