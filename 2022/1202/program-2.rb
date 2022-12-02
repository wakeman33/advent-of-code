f = File.new('input.txt', 'r')

total = 0
throw_point_lookup = {
  "A": 1,
  "B": 2,
  "C": 3
}

draw_conversion = {
  "A": "A",
  "B": "B",
  "C": "C"
}

win_conversion = {
  "A": "B",
  "B": "C",
  "C": "A"
}

lose_conversion = {
  "A": "C",
  "B": "A",
  "C": "B"
}


outcome_list = {}

f.readlines.each do |line|
  line.strip!
  if outcome_list[line]
    outcome_list[line] += 1
  else
    outcome_list[line] = 1
  end
end

puts outcome_list
outcome_list.each do |key, count|
  oponent, me = key.split(" ")
  #puts "Oponent: #{oponent} <> Me: #{me}"

  # puts "'#{me}'"
  throw_points = throw_point_lookup[me.to_sym]
  win_points = 0

  case me
  when "X"
    win_points = 0
    throw_points = throw_point_lookup[lose_conversion[oponent.to_sym].to_sym]
  when "Y"
    win_points = 3
    throw_points = throw_point_lookup[draw_conversion[oponent.to_sym].to_sym]
  when "Z"
    win_points = 6
    throw_points = throw_point_lookup[win_conversion[oponent.to_sym].to_sym]
  end

  # puts throw_points
  # puts win_points 
  puts ((throw_points + win_points) * count)
  total += ((throw_points + win_points) * count)
end

puts "Total: #{total}"
