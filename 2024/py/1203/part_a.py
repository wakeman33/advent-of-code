import re
answer = 0
f = open("data.txt", "r")


memory = ""
for line in f.readlines():
    memory += line

print(f"Memory: {memory}")

print(memory)
instruction_match = re.compile(r"mul\(\d{1,3},\d{1,3}\)")

instructions = re.findall(instruction_match, memory)
print(instructions)

def get_numbers(instruction):
    match_numbers = re.compile(r"\d{1,3}")

    numbers = re.findall(match_numbers, instruction)
    print(numbers)
    return (int(numbers[0]), int(numbers[1]))

answer = sum([
    x * y
    for x, y in list(map(get_numbers, instructions))
])

print(f"Answer: {answer}")
# Answer 167090022