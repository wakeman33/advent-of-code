f = File.new('input.txt', 'r')

grid = []
start_x = 0
start_y = 0

end_x = 0
end_y = 0

row_count = 0
f.readlines.each do |line|
  row = line.scan(/\w/)
  grid.push(row)
  if row.index('S')
    start_x = row.index('S')
    start_y = row_count
  end

  if row.index('E')
    end_x = row.index('E')
    end_y = row_count
  end
    
  row_count += 1
end

puts "Start: #{start_x}, #{start_y}"
puts "End: #{end_x}, #{end_y}"

def dist_from_start_to_point(start, point)
  start_x = start[0]
  start_y = start[1]

  x = point[0]
  y = point[1]
  
  return (start_x - x).abs + (start_y - y).abs
end

def dist_from_point_to_end(finish, point)
  end_x = finish[0]
  end_y = finish[1]

  x = point[0]
  y = point[1]
  
  return (end_x - x).abs + (end_y - y).abs
end

def can_move(loc, current_level, grid)
  x = loc[0]
  y = loc[1]

  # Negative numbers mean edges of grid
  return false if x < 0 || y < 0

  return false if grid[y].nil?
  return false if grid[y][x].nil?

  new_level = grid[y][x]
  new_level = 'z' if new_level == 'E'
  level_diff = new_level.ord - current_level.ord

  if level_diff == 0 || level_diff == 1 || level_diff < 0
    true
  else
    false
  end
end

def is_end?(loc, grid)
  x = loc[0]
  y = loc[1]
  return false if grid[y].nil?
  return false if grid[y][x].nil?
  return grid[y][x] == 'E'
end

def get_current_level(point, grid)
  x = point[0]
  y = point[1]
  grid[y][x]
end

def get_neighbors(point, grid)
  current_level = get_current_level(point, grid)
  current_level = 'a' if current_level == 'S'
  x = point[0]
  y = point[1]

  # Possible Neighbo
  down = [x, y + 1]
  up = [x, y - 1]
  right = [x + 1, y]
  left = [x - 1, y]

  navigable_neighbors = []
  navigable_neighbors.push(down) if can_move(down, current_level, grid)
  navigable_neighbors.push(up) if can_move(up, current_level, grid)
  navigable_neighbors.push(right) if can_move(right, current_level, grid)
  navigable_neighbors.push(left) if can_move(left, current_level, grid)
  navigable_neighbors
end

def in_open_set(open_set, item)
  open_set.each do |node|
    return true if node.keys[0].hash == item.hash
  end
  false
end

def in_came_from(came_from, item)
  came_from.keys.each do |node|
    return true if node.hash == item.hash
  end
  false
end

def reconstruct_path(came_from, current)
  total_path = []
  while in_came_from(came_from, current.keys[0])
    x, y = current.keys[0]
    
    current = came_from[current.keys[0]]  
    total_path.push(current)
  end
  total_path.length
end

def a_star(start, finish, grid)
  f_score = {}
  came_from = {}

  start_h_score = dist_from_point_to_end(finish, start)
  start_h = {start => start_h_score}
  open_set = [start_h]
  g_score = {start.hash => 0}

  while !open_set.empty?
    open_set.sort_by! {|i| i.values[0]}
    current = open_set.shift
    current_coord = current.keys[0]
  
    if is_end?(current.keys[0], grid)
      return reconstruct_path(came_from, current)
    end
  
    neighbors = get_neighbors(current.keys[0], grid)
    neighbors.each do |n|
      tenative_g_score = g_score[current_coord.hash] + 1
  
      if g_score[n.hash].nil? || tenative_g_score < g_score[n.hash]
        came_from[n] = current
        g_score[n.hash] = tenative_g_score
        f_score[n] = tenative_g_score + dist_from_point_to_end(finish, n)
        if !in_open_set(open_set, n)
          open_set.push({n => f_score[n]})
        end
      end
    end
  end
  return nil
end

shortest = nil
grid.each do |row|
  y = grid.index(row)
  row.each do |point|
    next unless point == "a" || point == "S"
    x = row.index(point)
    start = [x, y]
    finish = [end_x, end_y]

    res = a_star(start, finish, grid)
    shortest = res if (shortest.nil? && !res.nil?) || (!shortest.nil? && !res.nil? && res < shortest)
  end
end

puts shortest
