# from aocd import get_data, submit

day = 1
year = 2023
# data = get_data(day=day, year=year)
file = open("./bryons-input.txt", "r")

lines = file.readlines()

numbers = {
    "zero": 0,
    "one": 1,
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6,
    "seven": 7,
    "eight": 8,
    "nine": 9
}

three_c_word = ""
four_c_word = ""
five_c_word = "" 

count = 0
for line in lines:
    print(line)
    first = None
    last = None
    value = None
    for item in list(line):
        three_c_word += item
        four_c_word += item
        five_c_word += item

        if len(three_c_word) == 3:
            # print("WORD-3")
            # print(three_c_word)
            if value is None:
                value = numbers.get(three_c_word)
            three_c_word = three_c_word[1:]
            # print(three_c_word)

        if len(four_c_word) == 4:
            # print("WORD-4")
            # print(four_c_word)
            if value is None:
                value = numbers.get(four_c_word)
            four_c_word = four_c_word[1:]
            # print(four_c_word)

        if len(five_c_word) == 5:
            # print("WORD-5")
            # print(five_c_word)
            if value is None:
                value = numbers.get(five_c_word)
            five_c_word = five_c_word[1:]
            # print(five_c_word)

        try:
            int(item)
        except:
            if value is not None:
                if first is None:
                    first = int(value)
                    last = int(value)
                else:
                    last = int(value)
            value = None
        else:
            three_c_word = ""
            four_c_word = ""
            five_c_word = ""
            if first is None:
                print("First")
                first = item
                last = item

            last = item

    number = int(f"{first}{last}")
    count += number
    print(f"Number: {number}")
    first = None
    last = None

print("Count")
print(count)

# result = submit(count, part="b", day=day, year=year)
# print(result)
