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
        found = False
        print(map_values)
        for dest, src, range_number in map_values:
            seed_end = seed_start + seed_range
            src_end = src + range_number
            print(f"SOURCE: {src} -> {src_end}")
            print(f"SEED: {seed_start} -> {seed_end}")
            if seed_start >= src and seed_start< src_end:
                found = True
                print("Seed in range")
                offset = seed_start - src
                end_offset = (seed_end) - (src_end)
                print(f"OFFSET: {offset}")
                print(f"END_OFFSET: {end_offset}")
                if end_offset < 0:
                    # whole range fits
                    print("Whole seed range in range")
                    new_seed_ranges.append((dest + offset, seed_range))
                elif end_offset > 0:
                    # partial range fits
                    print("Whole seed range doesn't fit in range")
                    add_range = (dest + offset, seed_range - end_offset)
                    print("ADDING")
                    print(add_range)
                    new_seed_ranges.append(add_range)


                    print(f"OFFSET: {offset}")
                    print(f"END OFFSET: {end_offset}")

                    missed = (src_end, end_offset)
                    print(f"MISSED: {missed}")
                    seed_ranges.append(missed)
                    print(seed_ranges)
                    found = False
                    exit()
                    break
                else:
                    print("Fits Exactly ")
                    new_seed_ranges.append((dest + offset, seed_range))
            elif src >= seed_start and src < seed_end:
                print("Range in seed range")
                found = True
                offset = src - seed_start
                end_offset = (src_end) - (seed_end)
                print(f"OFFSET: {offset}")
                print(f"END OFFSET: {end_offset}")
                if end_offset < 0:
                    add_range = (dest, range_number)
                    new_seed_ranges.append(add_range)
                    print("Whole range in seed range")

                    # Adding before range
                    seed_range = offset
                    print("Continuing From")
                    print(f"SEED_RANGE: {seed_start} -> {seed_range}")

                    # Adding after range
                    missed_1 = (seed_end, seed_end - src_end)
                    missed_2 = (seed_start, offset)
                    print(f"ADD: {missed_1}")
                    print(f"ADD: {missed_2}")
                    seed_ranges.append(missed_1)
                    seed_ranges.append(missed_2)
                    print(seed_ranges)
                    found = False
                    exit()
                    break
                    
                elif end_offset > 0:
                    print("Whole range NOT in seed range")

                    add_range = (dest, seed_range - offset)
                    print(f"NEW RANGE: {add_range}")
                    new_seed_ranges.append((dest, seed_range - offset))

                    missed = (seed_start, offset)
                    print(f"MISSED: {missed}")
                    seed_ranges.append(missed)
                    print(seed_ranges)

                    print(new_seed_ranges)
                    # exit_flag = True
                    found = False
                    exit_flag = True
                    break
                else:
                    print("Fits Exactly ")
                    new_seed_ranges.append((dest + offset, seed_range))

            
            
        if not found:
            new_seed_ranges.append((seed_start, seed_range))



    print(f"Next Val: {new_seed_ranges}")
    print()

    if exit_flag:
        exit()
    return new_seed_ranges

file = open("example.txt", "r")
lines = list(map(lambda i: i.strip(), file.readlines()))
# data = get_data(day=day, year=year)
# lines = data.splitlines()

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
