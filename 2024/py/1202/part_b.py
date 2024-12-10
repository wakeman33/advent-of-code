import re
answer = 0
f = open("/home/kepankra/src/personal/advent-of-code/2024/py/1202/data.txt", "r")

reports = []
for line in f:
        reports.append(list(map(int, line.strip().split(" "))))


def increase(report, bad_level = False):
    safety = True
    for k, i in enumerate(report):
        if k + 1 == len(report):
            break
        difference = report[k+1] - i
        safety = safety and difference > 0 and difference < 4
        if not safety and not bad_level:
            remove_current = list(report)
            del remove_current[k]
            remove_next = list(report)
            if k+1 < len(report):
                del remove_next[k+1]
            if increase(remove_current, True) or increase(remove_next, True):
                return True
            else:
                return False 
    return safety 

def decrease(report, bad_level = False):
    safety = True
    for k, i in enumerate(report):
        if k + 1 == len(report):
            break
        difference = i - report[k+1]
        safety = safety and difference > 0 and difference < 4
        if not safety and not bad_level:
            remove_current = list(report)
            del remove_current[k]
            remove_next = list(report)
            if k+1 < len(report):
                del remove_next[k+1]
            if decrease(remove_current, True) or decrease(remove_next, True):
                return True
            else:
                return False
    return safety 

for report in reports:
    print("\nNew report")
    if increase(report):
        answer += 1
    elif decrease(report):
        answer += 1

print(f"Answer: {answer}")
# TODO: UNFINISHED