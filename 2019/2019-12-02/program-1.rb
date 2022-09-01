
int_array = File.read(ARGV[0]).split(',')

op = 0
while int_array[op].to_i != 99 do
  first = int_array[op+1].to_i
  second = int_array[op+2].to_i
  res = int_array[op+3].to_i
  if (int_array[op].to_i == 1)
    int_array[res] = int_array[first].to_i + int_array[second].to_i
    op += 4
  elsif (int_array[op].to_i == 2)
    int_array[res] = int_array[first].to_i * int_array[second].to_i
    op += 4
  else
    puts int_array[op] + " program alarm"
  end
end

puts "End Value"
puts int_array[0]
# int_array.each {|item| print item.to_s + ", ";}
