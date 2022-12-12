f = File.new('input.txt', 'r')

cycle = 0
add_cycle = 0
register = 1

command = ""
value = ""
read_line = true

while !f.eof?
  cycle += 1
  if (cycle - 1) % 40 == register || (cycle - 1) % 40 == register + 1 || (cycle - 1) % 40  == register - 1
    print '#'
  else 
    print '.'
  end

  if cycle % 40 == 0
    puts
  end

  if read_line
    command, value = f.readline.split(' ')
  end

  case (command)
  when 'noop'
  when 'addx'
    read_line = false
    add_cycle += 1
    if add_cycle == 2
      register += value.to_i
      add_cycle = 0
      read_line = true
    end
  end
end

puts "Total: #{total}"
