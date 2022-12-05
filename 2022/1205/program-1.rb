READ_TYPE = {
  containers: 0,
  instructions: 1
}

def clean_container_item(raw)
  if raw.match?(/\w/)
    raw.sub!('[','')
    raw.sub!(']','')
  else
    # for debuging purposes
    # raw = '  '
    raw = nil
  end
end

reading = READ_TYPE[:containers]
container_list = []
instructions_list = []
f = File.new('input.txt', 'r')
f.readlines.each do |line|
  if line == "\n"
    # switch reading method
    reading = READ_TYPE[:instructions]
    next
  end

  if reading == READ_TYPE[:containers]
    # get individual containers on a row
    row_array = line.scan(/(.{3} )|(.{3})/)
      .map {|i| i.compact}
      .flatten
      .map {|i| clean_container_item(i)}
    container_list.push(row_array) 
  elsif reading == READ_TYPE[:instructions]
    # clean instructions to just the numbers
    clean_instructions = line.split(/\D/)
      .delete_if {|i| i == ''}
      .map {|i| i.to_i}
    instructions_list.push(clean_instructions)
  end

end

t_list = container_list.transpose
t_list.map {|i| i.compact!}
instructions_list.each do |instruction|
  t_list.each {|i| puts "#{i}"}
  count, from, to = instruction
  puts "move #{count} from #{from} to #{to}"
  (1..count).each do |i|
    item = t_list[from - 1].shift
    t_list[to - 1].unshift(item)
  end
end

puts "Containers"
container_list.each {|i| puts i.join}
t_list.each {|i| puts i.join}
#instructions_list.each {|x| puts x.join}
