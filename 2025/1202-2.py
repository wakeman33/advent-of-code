from utils import file_lines

def factors_func(n):
    result = set()
    for i in range(1, int(n**0.5) + 1):
        if n % i == 0:
            result.add(i)
            result.add(n // i)
    return sorted(result)

def get_factors(id_str):
   factors_list = list(factors_func(len(id_str)))
   factors_list.remove(len(id_str))
   return list(factors_list)

def is_id(id_str, factor_list):
    for factor in factor_list:
        id_parts = [
            id_str[c_count:c_count + factor]

            for c_count in range(0, len(id_str), factor)
        ]

        if len(list(set(id_parts))) == 1:
            return True
    return False

lines = file_lines('1202-data')
line = lines[0].strip()
ranges = line.split(',')

id_ranges = [
    (i.split('-')[0], i.split('-')[1])
    for i in ranges
]

ids = [
    list(range(int(f), int(s) + 1))
    for f, s in id_ranges
]

flat_ids = [str(item) for sublist in ids for item in sublist]

sum = 0
for id in flat_ids:
    factors = get_factors(id)
    if is_id(id, factors):
        print("ID confirmed:", id)
        sum += int(id)

print("Sum:", sum)