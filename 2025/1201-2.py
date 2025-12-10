def file_lines(file_path):
    with open(file_path, 'r') as file:
        return file.readlines()

lines = file_lines('1201-data')


instructions = [
    int(i.replace("L", "-").replace("R", "+"))
    for i in lines
]

start = 50
count = 0

for i in instructions:
    print(f"Start: {start}")
    if start > 0 and start + i < 0:
        print("Added 1")
        count += 1
    start += i
    print(f"After: {start}")
    print(f"Stuff: {abs(int(start / 100))}")
    rotations = abs(int(start / 100))
    start = start % 100
    if start == 0:
        count += 1
        if rotations > 0:
            count += rotations - 1
    else:
        count += rotations

    print(f"Count: {count}")
    print()

print(start)
print(count)