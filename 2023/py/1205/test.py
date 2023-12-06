
range_1 = (80, 36)

range_2 = (85, 50)

def get_sub_strings(line_1, line_2):
    start_1, range_1 = line_1
    end_1 = start_1 + range_1
    start_2, range_2 = line_2
    end_2 = start_2 + range_2
    print(f"LINE 1: {start_1} -> {end_1}")
    print(f"LINE 2: {start_2} -> {end_2}")

    if  start_1 >= start_2 and start_1 < end_2:
        if end_1 <= end_2:
            print("line 1 fits in line 2")
            print(f"{line_1}")
        else:
            range_3 = end_2 - start_1
            matched_string = (start_1, range_3)
            new_string = (end_2, end_1 - end_2)
            print(f"Matched String: {matched_string}")
            print(f"New String: {new_string}")
    elif start_2 >= start_1 and start_2 < end_1:
        if start_2 == start_1:
            print("Starts match")
            new_line_1 = (end_2, end_1 - end_2)
            matched_line = (start_1, end_2 - start_1)
            print(f"Matched Line: {matched_line}")
            print(f"New Line: {new_line_1}")
        else:
            if end_2 <= end_1:
                print("Line 2 fits in Line 1")
                new_line_1 = (start_1, start_2 - start_1)
                matched_line = (start_2, end_2 - start_2)
                new_line_2 = (end_2, end_1 - end_2)
                print(f"Matched Line: {matched_line}")
                print(f"New Line 1: {new_line_1}")
                print(f"New Line 2: {new_line_2}")
            else:
                print("Line 2 does NOT fit in Line 1")
                new_line_1 = (start_1, start_2 - start_1)
                matched_line = (start_2, end_1 - start_2)
                print(f"Matched Line: {matched_line}")
                print(f"New Line 1: {new_line_1}")

    

get_sub_strings(range_1, range_2)

        