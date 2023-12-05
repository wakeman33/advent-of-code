from aocd import get_data, submit

day = 5
year = 2023


def check_seed(seed, map_values):
    print(map_values)
    next_val = seed
    for des, src, range_number in map_values:
        print(f"src: {src}, des: {des}, range: {range_number}")
        print(seed)

        if seed >= src and seed < src + range_number:
            diff = seed - src
            print(f"DIFF: {diff}")
            next_val = des + diff
            break
    
    print(f"Next Val: {next_val}")
    return next_val

# file = open("example.txt", "r")
# lines = list(map(lambda i: i.strip(), file.readlines()))
data = get_data(day=day, year=year)
lines = data.splitlines()

seeds = lines.pop(0).split(":")[1].strip().split(" ")
seeds = map(int, seeds)
print(seeds)
print()

lines.pop(0)
lines.pop(0)

chart = []
map_values = []
for line in lines:
    if line == "":
        something = "NOTHING"
    elif ":" in line:
        chart.append(map_values)
        map_values = []
    else:
        map_values.append(list(map(int, line.split(" "))))
chart.append(map_values)

locations = []
for seed in seeds:
    value = seed
    for map_values in chart:
        value = check_seed(value, map_values)
        # print(map_values)
    
    print(f"LOCATION: {value}")
    locations.append(value)

sorted_answer = sorted(locations)
print(sorted_answer)
answer = sorted_answer[:1]
print(answer)

result = submit(answer[0], part="a", day=day, year=year)
print(result)
