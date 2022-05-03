f = File.new('input.txt', 'r')

list_a = []
list_b = []
f.each do |line|
  list_a.push(line)
  list_b.push(line)
end

ones = []
zeros = []
pos = 0
go = true

while go do 
  list_a.each do |line|
    if line[pos] == '1' then ones.push(line) end
    if line[pos] == '0' then zeros.push(line) end
  end

  puts "Counts"
  puts zeros.count
  puts ones.count

  if ones.count >= zeros.count
    list_a = ones
  else
    list_a = zeros
  end

  go = false if list_a.count == 1
  pos += 1
  ones = []
  zeros = []
end

puts 'Oxygen'
puts list_a

ones = []
zeros = []
pos = 0
go = true

while go do 
  list_b.each do |line|
    if line[pos] == '1' then ones.push(line) end
    if line[pos] == '0' then zeros.push(line) end
  end

  puts "Counts"
  puts zeros.count
  puts ones.count

  if ones.count >= zeros.count
    list_b = zeros
  else
    list_b = ones
  end

  go = false if list_b.count == 1
  pos += 1
  ones = []
  zeros = []
end


puts 'CO2'
puts list_b

puts 'Answer'
puts list_a[0].to_i(2) * list_b[0].to_i(2)
