import re
answer = 0
f = open("data.txt", "r")


memory = ""
for line in f.readlines():
    memory += line

# print(f"Memory: {memory}")
# print(memory)
instruction_match = re.compile(r"do\(\)|don't\(\)|mul\(\d{1,3},\d{1,3}\)")

instructions = re.findall(instruction_match, memory)
# print(instructions)

def get_numbers(instruction):
    match_numbers = re.compile(r"\d{1,3}")

    numbers = re.findall(match_numbers, instruction)
    print(numbers)
    return (int(numbers[0]), int(numbers[1]))

def get_instruction_list(instructions):
    new_list = []
    collect = True
    for i in instructions:
        if i == "do()":
            collect = True
        elif i == "don't()":
            collect = False
        else:
            if collect:
                new_list.append(i)

    return new_list

instructions = get_instruction_list(instructions)

answer = sum([
    x * y
    for x, y in list(map(get_numbers, instructions))
])

print(f"Answer: {answer}")
# Answer: 89823704