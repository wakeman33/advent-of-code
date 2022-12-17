f = File.new('input.txt', 'r')

$grid = []
$start_x = 0
$start_y = 0

$end_x = 0
$end_y = 0

row_count = 0
f.readlines.each do |line|
  row = line.scan(/\w/)
  $grid.push(row)
  if row.index('S')
    $start_x = row.index('S')
    $start_y = row_count
  end

  if row.index('E')
    $end_x = row.index('E')
    $end_y = row_count
  end
    
  row_count += 1
end

# $grid.each do |row|
#   puts row.join
# end
# 
puts "Start: #{$start_x}, #{$start_y}"
puts "End: #{$end_x}, #{$end_y}"

def dist_from_point_to_line(point_x, point_y)
  top = ($end_x - $start_x) * ($start_y - point_y) - ($start_x - point_x) * ($end_y - $start_y)
  denom = Math.sqrt(($end_x - $start_x)**2 + ($end_y - $start_y)**2)
  top/denom
end

def can_move(loc, current_level)
  x = loc[0]
  y = loc[1]

  # Negative numbers mean edges of grid
  return false if x < 0 || y < 0

  return false if $grid[y].nil?
  return false if $grid[y][x].nil?

  new_level = $grid[y][x]
  level_diff = $grid[y][x].ord - current_level.ord

  # puts "Testing"
  # puts "#{x}, #{y}"
  # puts current_level
  # puts new_level
  # puts "#{level_diff}"
  # puts
 

  if level_diff == 0 || level_diff == 1
    true
  else
    false
  end
end

def is_previous_move(step_list, loc)
  step_list.include?(loc.hash)
end

def is_end?(loc)
  x = loc[0]
  y = loc[1]
  return false if $grid[y].nil?
  return false if $grid[y][x].nil?
  return $grid[y][x] == 'E'
end

def is_highest_elevation?(current_elevation)
  return $highest_elevation.ord <= current_elevation.ord
end

$shortest = 0
$highest_elevation = 'a'

def take_step(loc, current_level, step_list)
  x = loc[0]
  y = loc[1]
  $highest_elevation = current_level

  # puts "------------ New Step ------------"
  # puts "Current Level: #{current_level}"

  if $shortest != 0 && step_list.length > $shortest
    puts "TOO LONG"
    return step_list
  end

  down = [x, y + 1]
  up = [x, y - 1]
  right = [x + 1, y]
  left = [x - 1, y]

  directions = [right, down, up, left]

  weighted_directions = directions.map do |direction|
    dist = dist_from_point_to_line(direction[0], direction[1])
    {dist.abs => direction}
  end

  new_directions = weighted_directions.sort_by {|i| i.keys[0]}
  # puts new_directions.join(', ')

  if step_list.length == 10
    #exit
  end

  puts "Current Location: #{loc.join(',')}"
  new_directions.each do |item|
    direction = item.values[0]

    # puts can_move(direction, current_level)
    # puts "Is Previous Move? #{is_previous_move(step_list, direction)}"
    # puts "#{loc[0]}, #{loc[1]}"
    # puts current_level
    # puts
    if can_move(direction, current_level) && !is_previous_move(step_list, direction)
      new_step_list = step_list.dup
      new_step_list.push(direction.hash)
      take_step(direction, $grid[direction[1]][direction[0]], new_step_list)
    end
  end
  # Check for end
  directions.each do |direction|
    if is_highest_elevation?(current_level) && is_end?(direction)
      $shortest = step_list.length
      puts "SHORTEST #{$shortest}"
      return
    end
  end
  # puts "UNWINDING"
end

take_step([$start_x, $start_y], 'a', [[$start_x, $start_y].hash])
puts "Shortest #{$shortest}" 
