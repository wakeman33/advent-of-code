#####
# Initialization
#####
f = File.open('input.txt', 'r')
fish_string = f.read

fish_by_age = Array.new(7)
fish_by_age.map! {|i| i = {count: 0, days: fish_by_age.index(i)}; i}

new_fish_by_age = Array.new(2)
new_fish_by_age.map! {|i| i = {count: 0, days: new_fish_by_age.index(i) + 7}; i}

fish_list = fish_string.split(',').map {|i| i.to_i}
fish_list.each do |f|
  fish_by_age[f][:count] += 1
end
# puts "New Fish"
# puts new_fish_by_age
# puts "Old Fish"
# puts fish_by_age


#####
# Main
#####
def age_fish(list)
  fish_to_add = 0
  list.map! do |fish|
    if fish[:days] == 0
      # puts "Adding Fish"
      fish_to_add += fish[:count]
      fish[:days] = 6
    else 
      fish[:days] -= 1
    end
    fish
  end
  fish_to_add
end

def update_fish_lists(old_fish, new_fish, new_count)
  fish_to_move = new_fish.shift
  new_fish.push({count: new_count, days: 8})
  old_fish.map! do |f|
    if f[:days] == 6
      f[:count] += fish_to_move[:count]
    end
    f
  end
end

(1..256).each do |day|
  fish_to_add = age_fish(fish_by_age)
  age_fish(new_fish_by_age)
  update_fish_lists(fish_by_age, new_fish_by_age, fish_to_add)

  # puts "----------"
  # puts "Fish List"
  # puts fish_by_age
  # puts "New Fish List"
  # puts new_fish_by_age
  # puts "Fish To Add"
  # puts fish_to_add
end

sum = 0
fish_by_age.each {|i| sum += i[:count]}
new_fish_by_age.each {|i| sum += i[:count]}

puts "Answer"
puts sum
