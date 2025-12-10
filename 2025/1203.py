from utils import file_lines

lines = file_lines('1203-data')
banks = []
for line in lines:
    banks.append([
        int(jolt)
        for jolt in line.strip()
    ])


def find_joltage(bank, length, joltage):
    end = length - 1
    if length == 0:
        return int(joltage)
    if end == 0:
        biggest_first = max(bank)
    else:
        biggest_first = max(bank[:-end])
    joltage += str(biggest_first)
    return find_joltage(bank[bank.index(biggest_first) + 1:], end, joltage)


sum = 0
for bank in banks:
    joltage = find_joltage(bank, 12, '')
    sum += int(joltage)

print("Sum:", sum)