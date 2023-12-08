from aocd import get_data, submit
from itertools import cycle

day = 8
year = 2023

file = open("example.txt", "r")
lines = list(map(lambda i: i.strip(), file.readlines()))
data = get_data(day=day, year=year)
lines = data.splitlines()

directions = cycle(lines.pop(0))
lines.pop(0)

map_of_nodes = {}
for line in lines:
    node, next_nodes = line.split(" = ")
    node = node.strip()
    left, right = list(map(lambda item: item.strip(), next_nodes[1:-1].split(", ")))

    map_of_nodes[node] = {"L": left, "R": right}

next_nodes = map_of_nodes["AAA"]
steps = 0
for direction in directions:
    print(next_nodes)
    next_node = next_nodes[direction]
    if next_node == "ZZZ":
        steps += 1
        break
    else:
        next_nodes = map_of_nodes[next_node]
        steps += 1

print(steps)

result = submit(steps, part="a", day=day, year=year)
print(result)
