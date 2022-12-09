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
$visible_obj = {}

def isVisible(grid, x, y)
  if x == 0 || y == 0 || x == grid.length - 1 || y == grid.transpose.length - 1
    return
  end
  tree = grid[x][y]

  row = grid[x]
  row_length = grid[x].length - 1

  col = grid.transpose[y]
  col_length = grid.transpose[y].length - 1

  row_f_count = 0
  row[0...y].each do |blocking_tree| 
    if blocking_tree < tree
      row_f_count += 1
    elsif blocking_tree = tree
      row_f_count = 1
    else
      row_f_count = 0
    end

  end

  row_r_count = 0
  visible = true
  row.reverse[0...row_length - y].each do |blocking_tree| 
    if blocking_tree < tree
      row_r_count += 1
    elsif blocking_tree = tree
      row_r_count = 1
    else
      row_r_count = 0
    end
  end

  col_f_count = 0
  visible = true
  col[0...x].each do |blocking_tree| 
    if blocking_tree < tree
      col_f_count += 1
    elsif blocking_tree = tree
      col_f_count = 1
    else
      col_f_count = 0
    end
  end

  col_r_count = 0
  visible = true
  col.reverse[0...col_length - x].each do |blocking_tree| 
    if blocking_tree < tree
      col_r_count += 1
    elsif blocking_tree = tree
      col_r_count = 1
    else
      col_r_count = 0
    end
  end

  # puts "Counts"
  # puts "#{x},#{y}"
  # puts row_f_count
  # puts row_r_count
  # puts col_f_count
  # puts col_r_count

  $visible_obj["#{x},#{y}"] = row_f_count *
    row_r_count *
    col_f_count * 
    col_r_count
end

grid.each_index do |row_index|
  grid[row_index].each_index do |col_index|
    isVisible(grid, row_index, col_index)
  end
end

puts $visible_obj.values.max
