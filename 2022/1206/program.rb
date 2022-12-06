count = 0

f = File.new('input.txt', 'r')
f.readlines.each do |line|
  first = 0
  last = 14
  found = false
  while !found
    marker = line[first...last].chars.uniq
    if marker.length == 14
      found = true
      count += last
      first = 0
      last = 14
    else
      first += 1
      last += 1
    end
  end
end
puts count
