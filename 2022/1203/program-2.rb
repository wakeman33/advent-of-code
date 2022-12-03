f = File.new('input.txt', 'r')
list = []

def inList(item, list)
  list.include?(item)
end
# A => 65
# a => 97
sum = 0
count = 0
group = []
f.readlines.each do |line|
  line.strip!
  group.push(line.chars)
  count += 1

  if count == 3
    # procces badge
    # only one per gropu
    badge = (group[0] & group[1] & group[2])[0]

    if badge.match(/[a-z]/)
      sum += badge.ord - 96
    else
      sum += badge.ord - 38
    end

    # reset
    count = 0
    group = []
  end

end

puts sum
