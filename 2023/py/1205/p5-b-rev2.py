from aocd import get_data, submit

day = 5
year = 2023


def check_seed(seed_ranges, map_values):
    print()
    print()
    new_seed_ranges = []
    exit_flag = False

    while seed_ranges:
        (seed_start, seed_range) = seed_ranges.pop()
    # for seed_start, seed_range in seed_ranges:
        print("Taking One Speed Range")
        print(seed_ranges)
        print(map_values)
        found = False
        for dest_start, src_start, range_number in map_values:
            seed_end = seed_start + seed_range
            src_end = src_start + range_number
            print(f"SOURCE: {src_start} -> {src_end}")
            print(f"SEED: {seed_start} -> {seed_end}")
            if  seed_start >= src_start and seed_start < src_end:
                offset = seed_start - src_start
                print(f"OFFSET: {offset}")
                if seed_end <= src_end:
                    print("line 1 fits in line 2")
                    matched_line = (seed_start, seed_end - seed_start)
                    transform_line = (dest_start + offset, seed_end - seed_start)
                    new_seed_ranges.append(transform_line)
                    print(f"Matched String: {matched_line}")
                    print(f"Transform Line : {transform_line}")
                    found = True
                    break
                else:
                    matched_line = (seed_start, src_end - seed_start)
                    transform_line = (dest_start + offset, src_end - seed_start)
                    new_seed_ranges.append(transform_line)

                    new_line_1 = (src_end, seed_end - src_end)
                    seed_ranges.append(new_line_1)

                    print(f"Matched String: {matched_line}")
                    print(f"Transform Line: {transform_line}")
                    print(f"New String: {new_line_1}")
                    found = True
                    break
            elif src_start >= seed_start and src_start < seed_end:
                if src_start == seed_start:
                    print("Starts match")
                    matched_line = (seed_start, src_end - seed_start)
                    transform_line = (dest_start, src_end - seed_start)
                    new_seed_ranges.append(transform_line)

                    new_line_1 = (src_end, seed_end - src_end)
                    seed_ranges.append(new_line_1)

                    print(f"Matched Line: {matched_line}")
                    print(f"Transform Line: {transform_line}")
                    print(f"New Line: {new_line_1}")
                    found = True
                    break
                else:
                    if src_end <= seed_end:
                        print("Line 2 fits in Line 1")
                        matched_line = (src_start, src_end - src_start)
                        transform_line = (dest_start, src_end - src_start)
                        new_seed_ranges.append(transform_line)

                        new_line_1 = (seed_start, src_start - seed_start)
                        seed_ranges.append(new_line_1)
                        new_line_2 = (src_end, seed_end - src_end)
                        seed_ranges.append(new_line_2)
                        print(f"Matched Line: {matched_line}")
                        print(f"Transform Line: {transform_line}")
                        print(f"New Line 1: {new_line_1}")
                        print(f"New Line 2: {new_line_2}")
                        found = True
                        break
                    else:
                        print("Line 2 does NOT fit in Line 1")
                        matched_line = (src_start, seed_end - src_start)
                        transform_line = (dest_start, seed_end - src_start)
                        new_seed_ranges.append(transform_line)

                        new_line_1 = (seed_start, src_start - seed_start)
                        seed_ranges.append(new_line_1)
                        print(f"Matched Line: {matched_line}")
                        print(f"Transform Line: {transform_line}")
                        print(f"New Line 1: {new_line_1}")
                        found = True
                        break
        if not found:
            new_seed_ranges.append((seed_start, seed_range))

    print(f"Next Val: {new_seed_ranges}")
    print()

    if exit_flag:
        exit()
    return new_seed_ranges

# file = open("example.txt", "r")
# lines = list(map(lambda i: i.strip(), file.readlines()))
data = get_data(day=day, year=year)
lines = data.splitlines()

seeds = lines.pop(0).split(":")[1].strip().split(" ")
seeds = list(map(int, seeds))
seeds = list(zip(*[iter(seeds)]*2))

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
for seed_range in seeds:
    curr_seed_ranges = [seed_range]
    for map_values in chart:
        curr_seed_ranges = check_seed(curr_seed_ranges, map_values)
        # print(map_values)
    
    locations += curr_seed_ranges

sorted_answer = sorted(locations)
print(sorted_answer)
location, range_value= sorted_answer[:1][0]

print(f"LOCATION: {location}")

result = submit(location, part="b", day=day, year=year)
print(result)
