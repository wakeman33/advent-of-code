# f = File.new('./test.txt', 'r')
f = File.new('./input.txt', 'r')

elves = []

count = 0
f.readlines.each do |line|
  if line == "\n"
    elves.push(count)
    count = 0
    next
  end

  count += line.to_i
end

# elves.each do |e|
#   puts e
# end

elves.sort! {|x,y| y <=> x}

puts elves[0] + elves[1] + elves[2]
