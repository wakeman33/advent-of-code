
class Space
  attr_accessor :value, :marked
  def initialize
    @value = nil
    @marked = false
  end
end

class Board
  attr_accessor :row_1, :row_2, :row_3, :row_4, :row_5

  def initialize
    @row_1 = [].fill(0, 5) {|i| Space.new()}
    @row_2 = [].fill(0, 5) {|i| Space.new()}
    @row_3 = [].fill(0, 5) {|i| Space.new()}
    @row_4 = [].fill(0, 5) {|i| Space.new()}
    @row_5 = [].fill(0, 5) {|i| Space.new()}
    @h_board = [@row_1, @row_2, @row_3, @row_4, @row_5]
    @v_board = @h_board.transpose

  end

  def populate_board(board_input)
    row = 0
    board_input.each do |line|
      line.strip!
      col = 0
      line.split(/\s+/).each do |value|
        s = @h_board[row][col]
        s.value = value
        col += 1
      end
      row += 1
    end
  end

  def unmarked_sum
    sum_array = []

    @h_board.each do |row|
      unmarked_array = row.select do |space|
        space.marked == false
      end
      value_array = unmarked_array.map do |space|
        space.value.to_i
      end
      sum_array.concat(value_array)
    end

    sum_array.sum
  end

  def mark_board(called_value)
    marked = false
    @h_board.each do |row|
      row.each do |space|
        if space.value == called_value
          space.marked = true
          marked = true
        end
        break if marked
      end
      break if marked
    end

    marked
  end

  def show
    @h_board.each do |row|
      row.each do |space|
        m = space.marked ? "M" : ""
        print " #{space.value}#{m} "
      end
      print "\n"
    end
    puts '---------------------'
    @v_board.each do |row|
      row.each do |space|
        print " '#{space.value}' "
      end
      print "\n"
    end
    puts '---------------------'
    puts '---------------------'
  end

  def check_for_win
    # Check horrizontal
    win = true
    @h_board.each do |row|
      row.each do |space|
        win &= space.marked
      end
      if win
        break
      end
    end
    
    # Check verticle
    if !win
      win = true
      @h_board.each do |row|
        row.each do |space|
          win &= space.marked
        end
        if win
          break
        end
      end     
    end
    win
  end
end


f = File.new('input.txt', 'r')
input = []
f.each {|line| input.push(line)}

calling_sheet = input.shift
puts calling_sheet
puts input.shift

boards = []

board = []
input.each do |board_line|
  if board_line == "\n"
    boards.push(board)
    board = []
  else
    board.push(board_line)
  end
end
# Pushing the last board
boards.push(board)

board_list =  []

boards.each do |board_input|
  b = Board.new
  b.populate_board(board_input)
  board_list.push(b)
end

# board_list.each do |b|
#   b.show
# end
 
calling_sheet.strip!.split(',').each do |number|
  board_list.each do |board|
    board.mark_board(number)
    win = board.check_for_win
    if win
      puts "FOUND A WINNER"
      puts "Number: #{number}"
      board.show
      sum = board.unmarked_sum
      puts "Sum: #{sum}"
      puts "Answer: #{number.to_i*sum.to_i}"
    end
  end
  
end


