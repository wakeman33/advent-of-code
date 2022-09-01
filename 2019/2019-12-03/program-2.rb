wire_one, wire_two = File.readlines(ARGV[0])
# wire_one = "R75,D30,R83,U83,L12,D49,R71,U7,L72"
# wire_two = "U62,R66,U55,R34,D71,R55,D58,R83"
# wire_one = "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51"
# wire_two = "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"



wire_one_movements = wire_one.split(',')
wire_two_movements = wire_two.split(',')
puts wire_one_movements.length
puts wire_two_movements.length

wire_one = {head: {x: 0, y: 0}, prev: {x: 0, y: 0}}
wire_two = {head: {x: 0, y: 0}, prev: {x: 0, y: 0}}
$small
$wire_steps_1 = 0
$wire_steps_2 = 0

def add_vector(line_info, direction, distance)
  head = line_info[:head]
  prev = line_info[:prev]

  # Move head to prev
  prev[:x] = head[:x]
  prev[:y] = head[:y]

  case direction
  when 'U'
    head[:y] += distance
  when 'D'
    head[:y] -= distance
  when 'R'
    head[:x] += distance
  when 'L'
    head[:x] -= distance
  else
    puts "Unknown Direction"
  end

end

def parse_vector(line_vector)
  [line_vector.slice(0, 1), line_vector.slice(1, line_vector.length).to_i]
end

def print_points(wire_one_info, wire_two_info)
  puts "Wire One Points"
  puts 'x1: ' + wire_one_info[:head][:x].to_s + ', y1: ' + wire_one_info[:head][:y].to_s
  puts 'x2: ' + wire_one_info[:prev][:x].to_s + ', y2: ' + wire_one_info[:prev][:y].to_s

  puts "Wire Two Points"
  puts 'x1: ' + wire_two_info[:head][:x].to_s + ', y1: ' + wire_two_info[:head][:y].to_s
  puts 'x2: ' + wire_two_info[:prev][:x].to_s + ', y2: ' + wire_two_info[:prev][:y].to_s
end

def check_wire_secments(wire_one_info, wire_two_info, direction_1, direction_2, distance_1, distance_2)
  calc_wire_steps_1 = $wire_steps_1
  calc_wire_steps_2 = $wire_steps_2
  # qy1 < py1 && qy1 > py2       py1 > qy1 > py2 
  # px1 < qx1 && px1 > qx2       qx1 > px1 > qx2j
  print_points(wire_one_info, wire_two_info)
  if (wire_one_info[:head][:y] <= wire_two_info[:head][:y] && wire_one_info[:prev][:y] >= wire_two_info[:head][:y]) ||
     (wire_one_info[:prev][:y] <= wire_two_info[:head][:y] && wire_one_info[:head][:y] >= wire_two_info[:head][:y])
    if (wire_two_info[:head][:x] <= wire_one_info[:head][:x] && wire_two_info[:prev][:x] >= wire_one_info[:head][:x]) ||
       (wire_two_info[:prev][:x] <= wire_one_info[:head][:x] && wire_two_info[:head][:x] >= wire_one_info[:head][:x])
      puts "wires have crossed!!!"


      if wire_one_info[:head][:x] ==  wire_one_info[:prev][:x]
        x = wire_one_info[:head][:x]
        wire_one_y_diff = true
      else
        x = wire_two_info[:head][:x]
      end

      if wire_one_info[:head][:y] ==  wire_one_info[:prev][:y]
        y = wire_one_info[:head][:y]
        wire_one_x_diff = true
      else
        y = wire_two_info[:head][:y]
      end

      puts "X - Y"
      puts x
      puts y
      return if x == 0 && y == 0

      puts "Distance 1: #{distance_1}, Distance 2: #{distance_2}"
      puts "Steps"
      puts calc_wire_steps_1
      puts calc_wire_steps_2
      puts "Adjustments"
      puts distance_1 - (wire_one_info[:prev][:x] - x).abs 
      puts distance_2 - (wire_two_info[:prev][:y] - y).abs
      puts distance_1 - (wire_one_info[:prev][:y] - y).abs
      puts distance_2 - (wire_two_info[:prev][:x] - x).abs
      if wire_one_y_diff
        puts "One y diff"
        calc_wire_steps_1 -= distance_1 - (wire_one_info[:prev][:y] - y).abs
      else
        puts "Two y diff"
        calc_wire_steps_2 -= distance_2 - (wire_two_info[:prev][:y] - y).abs
      end

      if wire_one_x_diff
        puts "One x diff"
        calc_wire_steps_1 -= distance_1 - (wire_one_info[:prev][:x] - x).abs
      else
        puts "Two x diff"
        calc_wire_steps_2 -= distance_2 - (wire_two_info[:prev][:x] - x).abs
      end
      puts "adjusted Steps - 1"
      puts calc_wire_steps_1
      puts calc_wire_steps_2

      
      if $small.nil?
        puts "NIL!"
        $small = calc_wire_steps_1 + calc_wire_steps_2
      elsif $small > (calc_wire_steps_1 + calc_wire_steps_2)
        puts "smaller"
        $small = calc_wire_steps_1 + calc_wire_steps_2
      end
        puts $small
    end
  end

  if (wire_two_info[:head][:y] <= wire_one_info[:head][:y] && wire_two_info[:prev][:y] >= wire_one_info[:head][:y]) ||
     (wire_two_info[:prev][:y] <= wire_one_info[:head][:y] && wire_two_info[:head][:y] >= wire_one_info[:head][:y])
    if (wire_one_info[:head][:x] <= wire_two_info[:head][:x] && wire_one_info[:prev][:x] >= wire_two_info[:head][:x]) ||
       (wire_one_info[:prev][:x] <= wire_two_info[:head][:x] && wire_one_info[:head][:x] >= wire_two_info[:head][:x])
      puts "wires have crossed!!!"


      if wire_one_info[:head][:x] ==  wire_one_info[:prev][:x]
        x = wire_one_info[:head][:x]
        wire_one_y_diff = true
      else
        x = wire_two_info[:head][:x]
        wire_one_y_diff = false
      end

      if wire_one_info[:head][:y] ==  wire_one_info[:prev][:y]
        y = wire_one_info[:head][:y]
        wire_one_x_diff = true
      else
        y = wire_two_info[:head][:y]
        wire_one_x_diff = false
      end

      puts "X - Y"
      puts x
      puts y
      return if x == 0 && y == 0

      puts "Distance 1: #{distance_1}, Distance 2: #{distance_2}"
      puts "Steps"
      puts calc_wire_steps_1
      puts calc_wire_steps_2
      puts "Adjustments"
      puts distance_1 - (wire_one_info[:prev][:x] - x).abs 
      puts distance_2 - (wire_two_info[:prev][:y] - y).abs
      if wire_one_y_diff
        puts "1 - y diff"
        calc_wire_steps_1 -= distance_1 - (wire_one_info[:prev][:y] - y).abs
      else
        puts "2 - y diff"
        calc_wire_steps_2 -= distance_2 - (wire_two_info[:prev][:y] - y).abs
      end

      if wire_one_x_diff
        puts "1 - x diff"
        calc_wire_steps_1 -= distance_1 - (wire_one_info[:prev][:x] - x).abs
      else
        puts "2 - x diff"
        calc_wire_steps_2 -= distance_2 - (wire_two_info[:prev][:x] - x).abs
      end
      puts "adjusted Steps - 2"
      puts calc_wire_steps_1
      puts calc_wire_steps_2

      
      if $small.nil?
        puts "NIL!"
        $small = calc_wire_steps_1 + calc_wire_steps_2
      elsif $small > (calc_wire_steps_1 + calc_wire_steps_2)
        puts "smaller"
        $small = calc_wire_steps_1 + calc_wire_steps_2
      end
        puts $small
    end
  end
end

wire_one_movements.each do |line_one_vector|
  puts "------ Start ------"
  wire_two = {head: {x: 0, y: 0}, prev: {x: 0, y: 0}}
  $wire_steps_2 = 0
  direction_1, distance_1 = parse_vector(line_one_vector)
  $wire_steps_1 += distance_1
  add_vector(wire_one, direction_1, distance_1)

  wire_two_movements.each do |line_two_vector|
    direction_2, distance_2 = parse_vector(line_two_vector)
    $wire_steps_2 += distance_2
    puts "Distance 1: #{distance_1}, Distance 2: #{distance_2}"
    puts "Direction 1: #{direction_1}, Direction 2: #{direction_2}"
    puts "Steps 1: #{$wire_steps_1}, Steps 2: #{$wire_steps_2}"

    add_vector(wire_two, direction_2, distance_2)
    check_wire_secments(wire_one, wire_two, direction_1, direction_2, distance_1, distance_2)
  end
end

puts "Shortest"
puts $small
puts "Wire One Ending Info"
puts wire_one[:head][:x]
puts wire_one[:head][:y]
puts wire_one[:prev][:x]
puts wire_one[:prev][:y]


puts "\n" * 4


puts "Wire Two Ending Info"
puts wire_two[:head][:x]
puts wire_two[:head][:y]
puts wire_two[:prev][:x]
puts wire_two[:prev][:y]

