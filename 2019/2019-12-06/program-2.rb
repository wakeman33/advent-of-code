# frozen_string_literal: true

orbits = File.readlines(ARGV.pop)
tree = { 'COM' => {} }
$retry_list = []
# orbits = ["COM)B", "B)C", "C)D", "D)E", "E)F", "B)G", "G)H", "D)I", "E)J", "J)K", "K)L"]

$total_count = 0

def search_and_place(tree, orbitee, orbiter)
  # puts "Info"
  # puts orbitee
  # puts orbiter
  # puts ""
  # puts tree.keys
  if tree.keys.include?(orbitee)
    # puts "Placed"
    tree[orbitee] ||= {}
    tree[orbitee][orbiter] = {}
    return true
  end

  tree.keys.each do |key|
    return true if search_and_place(tree[key], orbitee, orbiter)
  end
  false
end

def count_orbits(tree, count = 0)
  count += 1

  tree.keys.each do |key|
    $total_count += count
    # puts key
    count_orbits(tree[key], count) unless tree[key].empty?
    # puts " end" if tree[key].empty?
    # puts count if tree[key].empty?
    # puts $total_count if tree[key].empty?
  end
end

not_done = true
while not_done

  orbits.each do |orbit|
    orbitee, orbiter = orbit.split(')').each(&:strip!)
    $retry_list.push(orbit) unless search_and_place(tree, orbitee, orbiter)
    # puts count
    # break if count == 3
    # puts "---------------------------------------"
  end
  not_done = !$retry_list.empty?
  orbits = $retry_list.dup
  $retry_list = []
end

def get_orbit_path(tree, key, orbiter, orbiter_path)
  orbiter_path += key

  if tree.keys.include?(orbiter)
    orbiter_path += orbiter
    return orbiter_path
  end

  tree.keys.each do |key|
    res = get_orbit_path(tree[key], key, orbiter, orbiter_path)
    return res unless res.nil?
  end
  nil
end

# count_orbits(tree["COM"])
# puts "COUNT"
# puts $total_count
#
# puts tree
