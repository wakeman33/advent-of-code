from aocd import get_data, submit
import functools

day = 9
year = 2023

file = open("example.txt", "r")
lines = list(map(lambda i: i.strip(), file.readlines()))
data = get_data(day=day, year=year)
lines = data.splitlines()

def line_to_list(line):
    return list(map(int, line.split(" ")))

list_of_readings = list(map(line_to_list, lines))
answer = 0

for readings in list_of_readings:
    future_reading = 0
    first_readings = []
    print(readings)
    while sum(readings) != 0:
        head_minus_one = None
        new_readings = []
        for index, reading in enumerate(readings):
            if head_minus_one is None:
                head_minus_one = reading
            else:
                new_reading = reading - head_minus_one
                head_minus_one = reading
                new_readings.append(new_reading)
            
            if index == 0:
                first_readings.append(reading)

        print(new_readings)
        if not new_readings:
            future_reading = 0
        readings = new_readings

    print("FIRST READINGS")
    first_readings.append(0)
    print(list(reversed(first_readings)))
    def funct(x, y):
        print(f"X: {x}")
        print(f"Y: {y}")
        print(f"SUM : {y} - {x} = {y - x}")
        return y - x
    future_reading = functools.reduce(funct, reversed(first_readings))

    print("FUTURE READING")
    print(future_reading)
    answer += future_reading
    print()

print("ANSWER")
print(answer)
print()
print()

result = submit(answer, part="b", day=day, year=year)
print(result)
