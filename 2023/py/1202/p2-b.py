from aocd import get_data, submit
# format Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
# bag loaded: 12 red cubes, 13 green cubes, and 14 blue cubes
day = 2
year = 2023
data = get_data(day=day, year=year)

lines = data.splitlines()

bag = {
    "red": 0,
    "green": 0,
    "blue": 0 
}

res = 0

for line in lines:
    print(line)
    (game, draws) = line.split(":")
    draw_list = draws.split(";")
    draw_total = 1
    for draw in draw_list:
        colors = draw.split(",")
        for color in colors:
            color = color.strip()
            (count, color_type) = color.split(" ")

            if bag.get(color_type) < int(count):
                bag[color_type] = int(count)

    draw_total *= bag["red"]
    draw_total *= bag["green"]
    draw_total *= bag["blue"]
    bag = {
        "red": 0,
        "green": 0,
        "blue": 0 
    }
    res += draw_total
    print("DRAW")
    print(draw_total)

print(res)
result = submit(res, part="b", day=day, year=year)
print(result)
