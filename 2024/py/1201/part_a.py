import re
f = open("data.txt", "r")

left_array = []
right_array = []
for line in f:
    line = line.strip()
    (left, right) = re.split(r"\s+", line)
    left_array.append(left)
    right_array.append(right)


left_array.sort()
right_array.sort()

arranged_list = list(zip(left_array, right_array))

answer = sum([
    abs(int(left) - int(right))
    for (left, right) in arranged_list
])

print("Answer:", answer)