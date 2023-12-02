from aocd import get_data, submit

day = 2
year = 2023
data = get_data(day=day, year=year)

lines = data.splitlines()

result = submit(count, part="a", day=day, year=year)
print(result)
