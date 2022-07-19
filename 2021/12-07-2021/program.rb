f = File.open('input.txt', 'r')
crabs = f.read.split(',').map {|i| i.to_i}

crabs.sort!

count = crabs.count
median_index = (count/2).floor

median = crabs[median_index]
average = crabs.sum / crabs.size


def get_bf_direction(start, crabs)
  mid_gas = 0
  up_gas = 0
  down_gas = 0
  up_start = start + 1
  down_start = start - 1

  crabs.each do |location|
    mid_gas += (start - location).abs
  end
  crabs.each do |location|
    up_gas += (up_start - location).abs
  end
  crabs.each do |location|
    down_gas += (down_start - location).abs
  end

  puts 'Gas: '
  puts "Start Gas: #{mid_gas}"
  puts "Up Start Gas: #{up_gas}"
  puts "Down Start Gas: #{down_gas}"
end

def get_new_bf_direction(start, crabs)
  mid_gas = 0
  up_gas = 0
  down_gas = 0
  up_start = start + 1
  down_start = start - 1

  crabs.each do |location|
    loc_diff = (start - location).abs
    mid_gas += (loc_diff * (loc_diff + 1) / 2)
  end
  crabs.each do |location|
    loc_diff = (up_start - location).abs
    up_gas += (loc_diff * (loc_diff + 1) / 2)
  end
  crabs.each do |location|
    loc_diff = (down_start - location).abs
    down_gas += (loc_diff * (loc_diff + 1) / 2)
  end


  if up_gas < mid_gas
    return true, up_start
  elsif down_gas < mid_gas
    return true, down_start
  else
    puts 'Gas: '
    puts "Start Gas: #{mid_gas}"
    puts "Up Start Gas: #{up_gas}"
    puts "Down Start Gas: #{down_gas}"
    return false, mid_gas
  end
end

# get_bf_direction(median, crabs)
puts "Averaage: #{average}"
puts "Median: #{median}"

cont, new_start = get_new_bf_direction(average, crabs)
while cont do
  cont, new_start = get_new_bf_direction(new_start, crabs)
end
