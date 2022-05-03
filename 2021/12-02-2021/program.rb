def decodeCommand(command)
  axis_word, velocity_string = command.split(' ')

  veloc = velocity_string.to_i

  case axis_word
  when 'forward'
    {x: veloc}
  when 'up'
    {y: -veloc}
  when 'down'
    {y: veloc}
  else
    puts "Bad Axis Word"
    exit
  end

end

f = File.new('input.txt', 'r')

commands = []
f.each do |line|
  commands.push(decodeCommand(line))
end

x_pos = 0
y_pos = 0
aim = 0

commands.each do |command|
  if !command[:x].nil?
    x_pos += command[:x]
    y_pos += command[:x] * aim
  elsif !command[:y].nil?
    aim += command[:y]
  end
end

puts 'X Pos'
puts x_pos
puts 'Y Pos'
puts y_pos
puts 'Answer'
puts x_pos * y_pos

