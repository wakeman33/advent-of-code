from utils import file_lines

lines = file_lines('1208-data')

nodes = [
    tuple(map(int, line.split(',')))
    for line in lines
]

def get_distance_list(nodes):
    distance_list = []
    for i, node in enumerate(nodes):
        x, y, z = node
        for j in range(i + 1, len(nodes)):
            next_node = nodes[j]
            nx, ny, nz = next_node
            n_distance = ((x - nx) ** 2 + (y - ny) ** 2 + (z - nz) ** 2) ** 0.5
            distance_list.append(((node, next_node), n_distance))
    return sorted(distance_list, key=lambda x: x[1])

d_list = get_distance_list(nodes)
print(d_list)

circuits = []
shortest = None
for (n1, n2), distance in d_list[:1000] :
    print(n1, n2, distance)
    n1_in_circuit = None
    n2_in_circuit = None

    # print(circuits)
    # print(n1, n2)
    for circuit in circuits:
        if n1 in circuit and n2 in circuit:
            n1_in_circuit = circuit
            n2_in_circuit = circuit

        if n1 in circuit:
            n1_in_circuit = circuit

        if n2 in circuit:
            n2_in_circuit = circuit

    if not n1_in_circuit and not n2_in_circuit:
        # print(f"Creating new circuit with distance {distance}")
        circuits.append([n1, n2])

    if n1_in_circuit and not n2_in_circuit:
        # print(f"Adding n2 to n1's circuit with distance {distance}")
        n1_in_circuit.append(n2)

    if n2_in_circuit and not n1_in_circuit:
        # print(f"Adding n1 to n2's circuit with distance {distance}")
        n2_in_circuit.append(n1)

    if n1_in_circuit and n2_in_circuit and n1_in_circuit != n2_in_circuit:
        # print(f"Merging circuits with distance {distance}")
        n1_in_circuit.extend(n2_in_circuit)
        circuits.remove(n2_in_circuit)


    # print()

for circuit in circuits:
    print("Circuit:", circuit, "Length:", len(circuit))

count = [
    len(circuit) for circuit in circuits
]

count.sort(reverse=True)

print("Final Circuits:")
print(count[0] * count[1] * count[2])