from aocd import get_data, submit

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
    print(readings)
    while sum(readings) != 0:
        print("Count")
        print(len(readings))
        head_minus_one = None
        new_readings = []
        for index, reading in enumerate(readings):
            if head_minus_one is None:
                head_minus_one = reading
            else:
                new_reading = reading - head_minus_one
                head_minus_one = reading
                new_readings.append(new_reading)
            
            if index == len(readings) - 1:
                future_reading += reading

        print(new_readings)
        if not new_readings:
            future_reading = 0
        readings = new_readings
    print("FUTURE READING")
    print(future_reading)
    answer += future_reading
    print()

print("ANSWER")
print(answer)
print()
print()

result = submit(answer, part="a", day=day, year=year)
print(result)
