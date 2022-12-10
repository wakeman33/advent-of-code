f = File.new('test-2.txt', 'r')

class Snake
  attr_accessor :grid, :count
  def initialize(x, y, grid)
    @head = [x, y] 
    @tail = []
    (0..8).each {|i| @tail.push([x,y])}
    @grid = grid

    #initialize starting point
    @grid[@head[0]] = [] if @grid[@head[0]].nil?
    @grid[@head[0]][@head[1]] = true if @grid[@head[0]][@head[1]].nil?
    @count = 0
  end

  def update_head(x, y)
    @head[0] = @head[0] + x
    @head[1] = @head[1] + y
    puts "Update_Head: #{@head[0]}, #{@head[1]}"
  end

  def update_tail()
    prev_x = @head[0]
    prev_y = @head[1]
    puts "Head: #{@head[0]}, #{@head[1]}"

    @tail.each_index do |space_index|
      puts "--- INDEX #{space_index} ---"
      space = @tail[space_index]
      puts "Prev Tail: #{prev_x}, #{prev_y}"
      puts "Space: #{space[0]}, #{space[1]}"
      mark = (@tail.length - 1) == space_index
      if mark
        puts "Last Tail: #{space[0]}, #{space[1]}"
      end

      if !touching?(prev_x, prev_y, space[0], space[1])
        puts "NOT TOUCHING"
        puts "Tail: #{space[0]}, #{space[1]}"

        x, y = get_new_coord(prev_x, prev_y, space[0], space[1])
        
        # Update Space
        space[0] = x
        space[1] = y


        puts "Updated_Tail: #{space[0]}, #{space[1]}"

        update_space(space[0], space[1]) if mark
        if mark
          @count += 1
          puts "Mark Last Tail: #{space[0]}, #{space[1]}"
        end
      else
        puts "TOUCHING"
      end
      # Update  prev
      prev_x = space[0]
      prev_y = space[1]
      puts
    end
    puts
  end

  def touching?(first_x, first_y, second_x, second_y)
    isTouching = false
    x_dist = (first_x - second_x).abs
    y_dist = (first_y - second_y).abs
  
    # Check Verticle and Horrizontal
    if first_x == second_x && y_dist == 1
      isTouching = true
    elsif first_y == second_y && x_dist == 1
      isTouching = true
    elsif first_x == second_x && first_y == second_y
      isTouching = true
    end
  
    # Check Diaginal - Diaginal Distance of a 1x1 triangle
    if (x_dist ** 2 + y_dist ** 2) == Math.sqrt(2)
      isTouching = true
    end
  
    isTouching
  end
 
  def get_new_coord(first_x, first_y, second_x, second_y)
    new_x = second_x
    new_y = second_y
    # Move Non-Diagnal
    if second_x + 2 == first_x && second_y == first_y
      puts "Moving Right"
      new_x += 1
    elsif second_x - 2 == first_x && second_y == first_y
      puts "Moving Left"
      new_x -= 1
    elsif second_y + 2 == first_y && second_x == first_x
      puts "Moving Up"
      new_y += 1
    elsif second_y - 2 == first_y && second_x == first_x
      puts "Moving Down"
      new_y -= 1
    end
  
    # Move Diagnal
    if second_x + 2 == first_x && second_y + 1 == first_y
      puts "Moving UpRight"
      new_x += 1
      new_y += 1
    elsif second_x - 2 == first_x && second_y + 1 == first_y
      puts "Moving UpLeft"
      new_x -= 1
      new_y += 1
    elsif second_x + 2 == first_x && second_y - 1 == first_y
      puts "Moving DownRight"
      new_x += 1
      new_y -= 1
    elsif second_x - 2 == first_x && second_y - 1 == first_y
      puts "Moving DownLeft"
      new_x -= 1
      new_y -= 1
  
    elsif second_x + 1 == first_x && second_y + 2 == first_y
      puts "Moving UpRight"
      new_x += 1
      new_y += 1
    elsif second_x - 1 == first_x && second_y + 2 == first_y
      puts "Moving UpLeft"
      new_x -= 1
      new_y += 1
    elsif second_x + 1 == first_x && second_y - 2 == first_y
      puts "Moving DownRight"
      new_x += 1
      new_y -= 1
    elsif second_x - 1 == first_x && second_y - 2 == first_y
      puts "Moving DownLeft"
      new_x -= 1
      new_y -= 1
    end
    [new_x, new_y]
  end

  def update_space(x, y)
    @grid[y] = [] if @grid[y].nil?
    @grid[y][x] = true if @grid[y][x].nil?
    count += 1
  end

end


# Initialize Grid
grid = [[]]
x = 500
y = 500

s = Snake.new(x, y, grid)

def get_direction(line)
  direction, count = line.split(' ')

  # Adjust for starting with zero
  coord = ''

  case(direction)
  when 'U'
    coord = 'y'
    moves = (1..count.to_i)
  when 'D'
    coord = 'y'
    moves = (-count.to_i..-1)
  when 'R'
    coord = 'x'
    moves = (1..count.to_i)
  when 'L'
    coord = 'x'
    moves = (-count.to_i..-1)
  end
  [coord, moves]
end



# Do Instructions
f.readlines.each do |line|
  direction, moves = get_direction(line)
  puts "Direction: #{direction} => #{moves}"

  if direction == 'x'
    moves.each do |i|
      if i.positive?
        s.update_head(1, 0)
      else
        s.update_head(-1, 0)
      end

      s.update_tail()
    end
  elsif direction == 'y'
    moves.each do |i|
      if i.positive?
        s.update_head(0, 1)
      else
        s.update_head(0, -1)
      end

      s.update_tail()
    end
  end
  puts "---------"
end

puts "COUNT"
puts s.count

# count = 0
# grid.each do |row|
#   next if row.nil?
#   row.each do |space|
#     if !space.nil?
#       if space
#         count += 1 
#       end
#     end
#   end
# end
# 
# puts "COUNT #{count}"
