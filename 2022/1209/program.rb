f = File.new('input.txt', 'r')

class Snake
  attr_accessor :grid, :count
  def initialize(x, y, grid)
    @tail_count = 8
    @head = [x, y] 
    @tail = []
    (0..@tail_count).each {|i| @tail.push([x,y])}
    @grid = grid

    #initialize starting point
    @grid[@head[0]] = [] if @grid[@head[0]].nil?
    @grid[@head[0]][@head[1]] = true if @grid[@head[0]][@head[1]].nil?
    @count = []
    @count.push([x,y].join.hash)
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

      x, y = get_new_coord(prev_x, prev_y, space[0], space[1])
      puts "NEW: #{x}, #{y}"
        
      # Update Space
      space[0] = x
      space[1] = y

      puts "Updated_Tail: #{space[0]}, #{space[1]}"
      # Update  prev

      prev_x = space[0]
      prev_y = space[1]
      puts
      if space_index == @tail_count
        tail_hash = [x,y].join.hash
        @count.push(tail_hash) if !@count.include?(tail_hash)
      end
    end
    puts
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

    if second_x - 2 == first_x && second_y - 2 == first_y
      new_x -=1
      new_y -=1
    elsif second_x + 2 == first_x && second_y + 2 == first_y
      new_x +=1
      new_y +=1
    elsif second_x + 2 == first_x && second_y - 2 == first_y
      new_x +=1
      new_y -=1
    elsif second_x - 2 == first_x && second_y + 2 == first_y
      new_x -=1
      new_y +=1
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

puts s.count.length

