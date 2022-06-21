class Line
  attr_accessor :x1, :x2, :y1, :y2
  def initialize(line_string)
    left, right = line_string.split(' -> ')
    @x1, @y1 = left.split(',').map {|i| i.to_i}
    @x2, @y2 = right.split(',').map {|i| i.to_i}
  end

  def is_diag
    if @x1 == @x2 || @y1 == @y2
      false
    else 
      # self.show
      true
    end
  end
  
  def show
    puts "----------"
    puts "Point 1: #{@x1}, #{@y1}"
    puts "Point 2: #{@x2}, #{@y2}"
    puts "----------"
  end
end

class Grid
  def initialize()
    @grid = []
  end

  def add_line(line)
    done = false
    x_point = line.x1
    y_point = line.y1

    while !done do
      x_done = false
      y_done = false

      # Set Point
      if @grid[y_point].nil?
        @grid[y_point] = []
      end
       
      if @grid[y_point][x_point].nil?
        @grid[y_point][x_point] = 0
      end
      @grid[y_point][x_point] += 1

      # Increment x
      if x_point > line.x2
        x_point -= 1
      elsif x_point < line.x2
        x_point += 1
      else
        x_done = x_point == line.x2
      end

      # Increment y
      if y_point > line.y2
        y_point -= 1
      elsif y_point < line.y2
        y_point += 1
      else
        y_done = y_point == line.y2
      end

      done = y_done && x_done
    end
  end

  def show
    @grid.each do |row|
      row = [] if row.nil?
      row.each do |point|
        print point.to_s + ' '
      end
      puts
    end
  end

  def count_line_crosses
    count = 0
    @grid.each do |row|
      next if row.nil?
      row.each do |point|
        next if point.nil?
        if point > 1
          count += 1
        end
      end
    end
    count
  end
end


f = File.new('input.txt', 'r')
g = Grid.new

f.each do |line| 
  l = Line.new(line)
 
  g.add_line(l)

  # # Remove diagnal lines
  # unless l.is_diag
  #   g.add_line(l)
  #   input.push(l)
  # end
end
puts "Board"
# puts g.show
puts "Answer"
puts g.count_line_crosses

