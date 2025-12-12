from utils import file_lines

lines = file_lines('1207-data')
lines = [line.strip() for line in lines]
beams = [
    False
    for char in lines[0]
]

start_line = lines.pop(0)
start = start_line.index('S')
beams[start] = True


def split_beams(beam_index: int, temp_beams: list[bool], line: str, count):
    if line[beam_index] == '^':
        temp_beams[beam_index] = False
        temp_beams[beam_index - 1] = True
        temp_beams[beam_index + 1] = True
        return True
    return False

count = 0
for line in lines:
    temp_beams = beams.copy()
    print(beams)
    print(line)
    for index, beam in enumerate(beams):
        if beam:
            if split_beams(index, temp_beams, line, count):
                count += 1
    beams = temp_beams
    print()

print(f"Count: {count}")