int_array = File.read(ARGV.pop).split(',')


$address = 0

def get_opt_code_and_modes(instruction)
  insruction_array = instruction.chars
  op_code = insruction_array.pop(2).join()
  param_one_mode = insruction_array.pop || '0'
  param_two_mode = insruction_array.pop || '0'
  param_three_mode = insruction_array.pop || '0'

  [op_code.to_i, [param_one_mode.to_i, param_two_mode.to_i, param_three_mode.to_i]]
end

def execute_op(context)
  op_code, param_modes = get_opt_code_and_modes(context[$address])
  case(op_code.to_i)
  when 1
    add(context, param_modes)
  when 2
    multiply(context, param_modes)
  when 3
    read(context)
  when 4
    output(context, param_modes)
  when 99
    puts "Program Halted"
    exit
  else
    puts "Invalid Op Code"
    puts op_code.to_i
    puts $address
    exit
  end
end

def add(context, param_modes)
  address_or_value1 = context[$address + 1].to_i
  address_or_value2 = context[$address + 2].to_i
  param1 = param_modes[0] == 0 ? context[address_or_value1].to_i : address_or_value1
  param2 = param_modes[1] == 0 ? context[address_or_value2].to_i : address_or_value2
  output_address = context[$address + 3].to_i

  # puts "Adding: #{param1} + #{param2} = #{param1 + param2} => #{output_address}"
  context[output_address] = (param1 + param2).to_s
  $address += 4
end

def multiply(context, param_modes)
  address_or_value1 = context[$address + 1].to_i
  address_or_value2 = context[$address + 2].to_i
  param1 = param_modes[0] == 0 ? context[address_or_value1].to_i : address_or_value1
  param2 = param_modes[1] == 0 ? context[address_or_value2].to_i : address_or_value2
  output_address = context[$address + 3].to_i

  context[output_address] = (param1 * param2).to_s
  $address += 4
end

def read(context)
  output_address = context[$address + 1].to_i
  puts "Requesting ID"
  id = gets.strip
  puts "-----------------------------"
  
  context[output_address] = id
  $address += 2
end

def output(context, param_modes)
  address_or_value1 = context[$address + 1].to_i
  param1 = param_modes[0] == 0 ? context[address_or_value1].to_i : address_or_value1

  # puts output_address
  puts "Output: #{param1}"
  $address += 2
end

while int_array[$address].to_i != 99 do
  execute_op(int_array)
end
