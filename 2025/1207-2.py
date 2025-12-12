from utils import file_lines

lines = file_lines('1207-data')
lines = [line.strip() for line in lines]
beams = [False for char in lines[0]]

start_line = lines.pop(0)
start = start_line.index('S')
beams[start] = True
timelines = [0 for _ in lines[0]]
timelines[start] = 1

def split_beams(beam_index: int, temp_beams: list[bool], line: str):
    if line[beam_index] == '^':
        temp_beams[beam_index] = False
        temp_beams[beam_index - 1] = True
        temp_beams[beam_index + 1] = True
        timelines[beam_index + 1] += timelines[beam_index]
        timelines[beam_index - 1] += timelines[beam_index]
        timelines[beam_index] = 0
        return True
    return False

for line in lines:
    temp_beams = beams.copy()
    for index, beam in enumerate(beams):
        if beam:
            split_beams(index, temp_beams, line)
    beams = temp_beams

count = sum(timelines)
print(f"Count: {count}")