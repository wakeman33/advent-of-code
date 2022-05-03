f = File.new('input.txt', 'r')

final = []

f.each do |line|
  index = 0
  line.strip!
  line.each_char do |b_char|
    # Create a position array if it doesn't exist for the index
    if final[index].nil?
      final[index] = []
      pos_array = final[index]
    else
      pos_array = final[index]
    end

    pos_array.push(b_char)

    index += 1
  end

end

gamma = ""
epsilon = ""

zero_c = 0
one_c = 0

final.each do |pos|
  count = 0
  pos.each do |char|
    count += char == '0' ? -1 : 1
    if char == '0' then zero_c += 1  end
    if char == '1' then one_c += 1 end
  end
  puts "Count: #{count}"
  puts "Zero Count: #{zero_c}"
  puts "One Count: #{one_c}"

  if count > 0
    gamma += '1'
    epsilon += '0'
  else
    gamma += '0'
    epsilon += '1'
  end
  count = 0
  zero_c = 0
  one_c = 0
end


puts "Values"
puts gamma
puts epsilon
puts gamma.to_i(2)
puts epsilon.to_i(2)
puts "Power Consumption"
puts gamma.to_i(2) * epsilon.to_i(2)

