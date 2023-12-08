from aocd import get_data, submit
from itertools import cycle
import numpy

day = 8
year = 2023

file = open("example-2.txt", "r")
lines = list(map(lambda i: i.strip(), file.readlines()))
data = get_data(day=day, year=year)
lines = data.splitlines()


def check_all_end_in_z(possible_ends):
    ret = False
    for end in possible_ends:
        if end[-1] == "Z":
            possible_ends.remove(end)
            ret = True

    return ret


directions = cycle(lines.pop(0))
lines.pop(0)

possible_paths = []
map_of_nodes = {}
for line in lines:
    node, next_nodes = line.split(" = ")
    node = node.strip()

    if node[-1] == "A":
        possible_paths.append(node)

    left, right = list(map(lambda item: item.strip(), next_nodes[1:-1].split(", ")))

    map_of_nodes[node] = {"L": left, "R": right}

multiples = []
steps = 1
count = 0
for direction in directions:
    # print(possible_paths)
    for index, path in enumerate(possible_paths):
        print(map_of_nodes[path][direction])
        possible_paths[index] = map_of_nodes[path][direction]

    is_done = check_all_end_in_z(possible_paths)
    if is_done:
        count += 1
        multiples.append(count)
    else:
        count += 1

    if not possible_paths:
        print("DONE!!!")
        break
answer = numpy.lcm.reduce(multiples)
print(answer)

result = submit(answer, part="b", day=day, year=year)
print(result)
