f = File.new('input.txt', 'r')
count = 0
f.readlines.each do |line|
  group1, group2 = line.split(',')
  group1x, group1y = group1.split('-')
  group2x, group2y = group2.split('-')
  group1Sections = (group1x.to_i..group1y.to_i).to_a
  group2Sections = (group2x.to_i..group2y.to_i).to_a
  intersect = group1Sections.intersection(group2Sections)
  if !intersect.empty?
    count += 1 if group1Sections.hash == intersect.hash || group2Sections.hash == intersect.hash
  end
end

puts count
