f = File.new('12-01-2021-input.txt', 'r')

depths = []
f.each_line do |line|
  depths.push(line.to_i)
end

f.close

count = 0
window = depths.shift(3)
before_sum = window.sum
depths.each do |depth|
  window.shift
  window.push(depth)

  curr_sum = window.sum

  if before_sum < curr_sum
    count += 1
  end
  before_sum = curr_sum
end

puts "Number of increases"
puts count

