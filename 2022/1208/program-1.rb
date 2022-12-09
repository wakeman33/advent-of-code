f = File.new('input.txt', 'r')

grid = []
from_left_count = 0
from_right_count = 0
from_up_count = 0
from_down_count = 0

left_tallest = nil
right_tallest = nil

up_tallest = []
down_tallest = []



f.readlines.each do |line|
  line_array = line.scan(/\w/).map {|i| i.to_i}
  grid.push(line_array)
end
$visible = 0

def isVisible(grid, x, y)
  if x == 0 || y == 0 || x == grid.length - 1 || y == grid.transpose.length - 1
    # Count as visible
    $visible += 1
    return
  end
  tree = grid[x][y]

  row = grid[x]
  row_length = grid[x].length - 1

  col = grid.transpose[y]
  col_length = grid.transpose[y].length - 1

  visible = true
  row[0...y].each do |blocking_tree| 
    #   puts "#{blocking_tree} > #{tree}"
    if blocking_tree >= tree
      visible = false
    end
  end
  if visible then $visible += 1; return end

  visible = true
  row.reverse[0...row_length - y].each do |blocking_tree| 
    #   puts "#{blocking_tree} > #{tree}"
    if blocking_tree >= tree
      visible = false
    end
  end
  if visible then $visible += 1; return end

  visible = true
  col[0...x].each do |blocking_tree| 
    #   puts "#{blocking_tree} > #{tree}"
    if blocking_tree >= tree
      visible = false
    end
  end
  if visible then $visible += 1; return end

  visible = true
  col.reverse[0...col_length - x].each do |blocking_tree| 
    # puts "#{blocking_tree} > #{tree}"
    if blocking_tree >= tree
      visible = false
    end
  end
  if visible then $visible += 1; return end

  # puts
  # puts
end

grid.each_index do |row_index|
  grid[row_index].each_index do |col_index|
    isVisible(grid, row_index, col_index)
  end
end

puts $visible
