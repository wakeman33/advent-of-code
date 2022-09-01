
orig_int_array = File.read(ARGV[0]).split(',')

def run_int_code(int_array)
  op = 0

  while int_array[op].to_i != 99 do
    first = int_array[op+1].to_i
    second = int_array[op+2].to_i
    res = int_array[op+3].to_i
    if (int_array[op].to_i == 1)
      int_array[res] = int_array[first].to_i + int_array[second].to_i
      op += 4
    elsif (int_array[op].to_i == 2)
      int_array[res] = int_array[first].to_i * int_array[second].to_i
      op += 4
    else
      puts int_array[op] + " program alarm"
    end
  end

  int_array[0] == 19690720
end

noun = 0
verb = 0
while noun < 100 do
  while verb < 100 do
    new_array = orig_int_array.dup
    new_array[1] = noun
    new_array[2] = verb

    if run_int_code(new_array)
      puts "Noun: #{noun}"
      puts "Verb: #{verb}"
      puts "Answer: #{(100* noun) + verb}"
      exit
    end

    verb += 1
  end
  verb = 0
  noun += 1
end

