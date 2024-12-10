import re
answer = 0
f = open("data.txt", "r")

reports = []
for line in f:
        reports.append(list(map(int, line.strip().split(" "))))

def increase(report, i):
    print("increase")
    if i == 0:
        return True

    difference = report[i] - report[i-1]
    if difference > 0 and difference < 4:
        return True
    else:
        return False

def decrease(report, i):
    print("decrease")
    
    if i == 0:
        return True

    difference = report[i-1] - report[i]

    if difference > 0 and difference < 4:
        return True
    else:
        return False

for report in reports:
    check = increase if report[0] < report[1] else decrease
    summary =  [
        check(report, i)
        for i, k in enumerate(report)
    ]

    if all(summary):
        answer += 1

print(f"Answer: {answer}")