from aocd import get_data, submit

day = 2
year = 2023

# file = open("example.txt", "r")
# lines = list(map(lambda i: i.strip(), file.readlines()))
data = get_data(day=day, year=year)
lines = data.splitlines()

# result = submit(count, part="a", day=day, year=year)
# print(result)
