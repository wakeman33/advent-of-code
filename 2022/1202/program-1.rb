f = File.new('input.txt', 'r')

total = 0
throw_point_lookup = {
  "X": 1,
  "Y": 2,
  "Z": 3
}

opponent_conversion = {
  "X": "A",
  "Y": "B",
  "Z": "C"
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

  if oponent == opponent_conversion[me.to_sym]
    win_points = 3
  else

  end
  case (oponent)
  when "A"
    if me == "Y"
      win_points = 6
    end
  when "B"
    if me == "Z"
      win_points = 6
    end
  when "C"
    if me == "X"
      win_points = 6
    end
  end

  # puts throw_points
  # puts win_points 
  puts ((throw_points + win_points) * count)
  total += ((throw_points + win_points) * count)
end

puts "Total: #{total}"
