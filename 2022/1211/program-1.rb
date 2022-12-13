f = File.new('input.txt', 'r')

class Monkey
  attr_accessor :id, :inspected_count
  def initialize(id, item_list, operation, test_value, if_true, if_false)
    @id = id
    @item_list = item_list
    @operation = operation
    @test_value = test_value
    @if_true = if_true
    @if_false = if_false
    @inspected_count = 0
  end

  def recive_item(item)
    @item_list.push(item)
  end

  def throw_items(monkey_list)
    while !@item_list.empty?
      item = @item_list.shift
      @inspected_count += 1
      worry_level = run_operation(item)
      worry_level = (worry_level/ 3).floor
      test_val = run_test(worry_level)
      if test_val
        # puts "Sending #{worry_level} to #{@if_true}"
        monkey_list[@if_true].recive_item(worry_level)
      else
        # puts "Sending #{worry_level} to #{@if_false}"
        monkey_list[@if_false].recive_item(worry_level)
      end
    end
  end

  def run_operation(worry_level)
    @operation.(worry_level)
  end

  def run_test(worry_level)
    return  worry_level % @test_value == 0
  end

  def print_items()
    puts @item_list.join(", ")
  end
end

def create_opteration(opp, value)


  case (opp.strip)
  when '+'
    if value.strip == "old"
      func = ->(worry) {worry + worry}
    else
      func = ->(worry) {worry + value.to_i}
    end
  when '-'
    if value.strip == "old"
      func = ->(worry) {worry - worry}
    else
      func = ->(worry) {worry - value.to_i}
    end
  when '*'
    if value.strip == "old"
      func = ->(worry) {worry * worry}
    else
      func = ->(worry) {worry * value.to_i}
    end
  when '/'
    if value.strip == "old"
      func = ->(worry) {worry / worry}
    else
      func = ->(worry) {worry / value.to_i}
    end
  end
  
end

monkey_list = []

while !f.eof?
  id = f.readline.split(' ')[1].to_i
  items = f.readline
    .split(':')[1]
    .split(',')
    .map {|i| i.strip!; i.to_i}
  line = f.readline
  operation = line.match(/\+|\-|\*|\//).to_s
  operation_value = line.split(/\+|\-|\*|\//)[1]
  test = f.readline.split('by')[1].to_i
  if_true = f.readline.split('monkey')[1].to_i
  if_false = f.readline.split('monkey')[1].to_i
  if !f.eof? then f.readline end

  operation_lambda = create_opteration(operation, operation_value)

  # Monkey initialize(id, item_list, operation, test_value, if_true, if_false)
  monkey = Monkey.new(id, items, operation_lambda, test, if_true, if_false)
  monkey_list.push(monkey)
end

(1..20).each do |round|
  puts "ROUND #{round}"
  monkey_list.each do |monkey|
    puts "Monkey: #{monkey.id}"
    monkey.throw_items(monkey_list)
  end
end

inspected_count_list = []
monkey_list.each do |monkey|
  inspected_count_list.push(monkey.inspected_count)
  puts "Monkey #{monkey.id} Inspected: #{monkey.inspected_count}"
end

inspected_count_list.sort!.reverse!
puts inspected_count_list[0] * inspected_count_list[1]



