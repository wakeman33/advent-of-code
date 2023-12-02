from aocd import get_data, submit
# format Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
# bag loaded: 12 red cubes, 13 green cubes, and 14 blue cubes
day = 2
year = 2023
data = get_data(day=day, year=year)

lines = data.splitlines()

bag = {
    "red": 12,
    "green": 13,
    "blue": 14
}

res = 0

for line in lines:
    print(line)
    (game, draws) = line.split(":")
    draw_list = draws.split(";")
    is_possible = True
    for draw in draw_list:
        colors = draw.split(",")
        for color in colors:
            color = color.strip()
            (count, color_type) = color.split(" ")

            print(f"'{color_type}'")
            if bag.get(color_type) < int(count):
                print("Impossible")
                is_possible = False

    print("Before")
    print(res)
    if is_possible:
        (game_name, number) = game.split(" ")
        print(number)
        res += int(number)
    print("After")
    print(res)
print(res)

        

result = submit(res, part="a", day=day, year=year)
print(result)
