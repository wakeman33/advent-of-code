
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
    row_index = 0
    space_index = 0
    board_input.each do |line|
      row = @h_board[row_index]
      line.strip.split(' ').each do |value|
        row[space_index].value = value.strip
        space_index += 1
      end
      space_index = 0
      row_index += 1
    end
  end

  def unmarked_sum()
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
        print "'#{space.value} [#{space.marked}]'"
      end
      print "\n"
    end
    puts '---------------------'
    @v_board.each do |row|
      row.each do |space|
        print "'#{space.value} [#{space.marked}]'"
      end
      print "\n"
    end
    puts '---------------------'
    puts '---------------------'
  end

  def check_for_win
    # Check horrizontal
    @h_board.each do |row|
      row_full = true
      row.each do |space|
        row_full = space.marked && row_full
      end
      if row_full
        return true
      end

      # reset the value
      row_full = true
    end
    
    # Check verticle
    @v_board.each do |row|
      row_full = true
      row.each do |space|
        row_full = space.marked && row_full
      end
      if row_full
        return true
      end

      # reset the value
      row_full = true
    end
    false
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
 
# calling_sheet.strip!.split(',').each do |number|
#   puts "Calling: " + number.to_s
#   board_list.each do |board|
#     board.mark_board(number)
#     win = board.check_for_win()
#     if win
#       puts 'Found a winner'
#       puts 'Number: ' + number.to_s
#       board.show
#       board_sum = board.unmarked_sum
#       puts 'Board Sum:'
#       puts board_sum
#       puts number
#       puts "Answer"
#       puts number.to_i * board_sum
#       exit
#     end
#   end
# end

last_to_win = {board: nil, number: nil}
calling_sheet.strip!.split(',').each do |number|
  puts "Calling: " + number.to_s
  puts "Board Count: " + board_list.count.to_s
  board_list.each do |board|
    board.mark_board(number)
    win = board.check_for_win()
    if win
      puts 'Found a winner'
      last_to_win[:board] = board
      last_to_win[:number] = number
      board_list.delete_at(board_list.index(last_to_win[:board]))
    end
  end
end

calling_number = last_to_win[:number]
board = last_to_win[:board]

puts "Calling Number"
puts calling_number
puts "Board Sum"
puts board.unmarked_sum
puts "Answer"
puts calling_number.to_i * board.unmarked_sum


