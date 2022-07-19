####################################################################################################################################################################################
# DEFAULT
# 1: 2 segments, cf
#
# 7: 3 segments, acf
#
# 4: 4 segments, bcdf
#
# 2: 5 segments, acdeg
# 3: 5 segments, acdfg
# 5: 5 segments, abdfg
#
# 0: 6 segments, abcefg
# 6: 6 segments, abdefg
# 9: 6 segments, abcdfg
#
# 8: 7 segments, abcdefg
#
# INPUT
# be -> 1
#
# bde -> 7
# 
# bceg -> 4
#
# abcdf -> 2,3,5
# bcdef -> 2,3,5
# cdefg -> 2,3,5
#
# fgaecd -> 0,6,9
# cdbgef -> 0,6,9
# agebfd -> 0,6,9
#
# cfbegad -> 8
#
#
#####
# Step 1: Identify 9 (7 + 4 - 9) = 1 character
# (bde + bceg) = bcdeg
# acdefg - bcdeg = af
# bcdefg - bcdeg = f -> 9
# abdefg - bcdeg = af
# 
# be -> 1

# bde -> 7
# 
# bceg -> 4
#
# abcdf -> 2,3,5
# bcdef -> 2,3,5
# cdefg -> 2,3,5
#
# acdefg -> 0,6
# bcdefg -> 9
# abdefg -> 0,6
#
# abcdefg -> 8
#
#####
# Step 2: Identify 3 (9 - 4 + 1) - 3 = 1 character
# (bcdefg - bceg + be) = bdef
# abcdf - bdef = ac
# bcdef - bdef = c -> 3
# cdefg - bdef = cg
#
# be -> 1
#
# bde -> 7
# 
# bceg -> 4
#
# abcdf -> 2,5
# bcdef -> 3
# cdefg -> 2,5
#
# acdefg -> 0,6
# bcdefg -> 9
# abdefg -> 0,6
#
# abcdefg -> 8
#
#####
# Step 3: Identify 6 (8 -1) = 1 character
# (abcdefg - be) = acdfg
# acdefg - acdfg = e -> 6
# abdefg - acdfg = be -> 0
#
#
# be -> 1
#
# bde -> 7
# 
# bceg -> 4
#
# abcdf -> 2,5
# bcdef -> 3
# cdefg -> 2,5
#
# acdefg -> 6
# bcdefg -> 9
# abdefg -> 0
#
# abcdefg -> 8
#
#####
# Step 4: Identify 2 (6 - 4 + 3) = 0 characters
# (acdefg - bceg) = adf + bcdef = abcdef
# cdefg - abcdef = g -> 5
# abcdf - abcdef = nil -> 2
# 
# be -> 1
#
# bde -> 7
# 
# bceg -> 4
#
# abcdf -> 5
# bcdef -> 3
# cdefg -> 2
#
# acdefg -> 6
# bcdefg -> 9
# abdefg -> 0
#
# abcdefg -> 8
#
####################################################################################################################################################################################

####################################################################################################################################################################################
# INPUT
# abcdefg = 8
# abd = 7
# ab = 1
# abef = 4
#
# bcdef = 5 (bcdef)
# acdfg = 2 (acdfg) 
# abcdf = 3 (abcdf)
#
# abcdef = 9 (abcdef)
# bcdefg = 6 (bcdefg)
# abcdeg = 0 (abcdeg)
#
#####
# Step 1: Identify 9 (7 + 4 - 9) = 1 character
# abd + abef = abdef
#
# abcdef - abdef = c = 9
# bcdefg - abdef = cg
# abcdeg - abdef = cg
#
#####
# Step 2: Identify 3 (9 - 4 + 1) - 3 = 1 character
# abcdef - abef = cd + ab = abcd
#
# bcdef - abcd = ef
# acdfg - abcd = fg
# abcdf - abcd = f = 3
#
#####
# Step 3: Identify 6 (8 -1) = 1 character
# abcdefg - ab = cdefg
#
# bcdefg - cdefg = b = 6
# abcdeg - cdefg = ab = 0
#
#####
# Step 4: Identify 2 (6 - 4 + 3) = 0 characters
# bcdefg - abef = cdg + abcdf = abcdfg
#
# bcdef - abcdfg = e = 5
# acdfg - abcdfg = nil = 2
#
####################################################################################################################################################################################

def to_number(word)
  case word
  when :one
    '1'
  when :two
    '2'
  when :three
    '3'
  when :four
    '4'
  when :five
    '5'
  when :six
    '6'
  when :seven
    '7'
  when :eight
    '8'
  when :nine
    '9'
  when :zero
    '0'
  else
    puts "Unknown WORD!!!"
    puts word
  end
end

def order_word(word)
  word.split('')

  # Old
  # word_array = word.split('')
  # ordered_word_array = word_array.sort
  # ordered_word_array.join('')
end 

def identify_nine(ident, signals)
  # Step 1: Identify 9 - (7 + 4) = 1 character
  ident_code = ident[:seven].union(ident[:four])  
  signals.select do |signal|
    if signal.length == 6
      chars = signal - ident_code 
      if chars.length == 1
        ident[:nine] = signal 
        false
      else
        true
      end
    else
      true
    end
  end
end

def identify_three(ident, signals)
  # Step 2: Identify 3 - (9 - 4 + 1) = 1 character
  ident_code = (ident[:nine] - ident[:four]).union(ident[:one])  
  signals.select do |signal|
    if signal.length == 5
      chars =  signal - ident_code
      if chars.length == 1
        ident[:three] = signal 
        false
      else
        true
      end
    else
      true
    end
  end
end

def identify_six(ident, signals)
  # Step 3: Identify 6 (8 -1) = 1 character
  ident_code = ident[:eight] - ident[:one]
  signals.select do |signal|
    if signal.length == 6
      chars = signal - ident_code 
      if chars.length == 1
        ident[:six] = signal 
        false
      else
        true
      end
    else
      true
    end
  end
end

def identify_two(ident, signals)
# Step 4: Identify 2 - (6 - 4 + 3) = 0 characters
  ident_code = (ident[:six] - ident[:four]).union(ident[:three])
  signals.select do |signal|
    if signal.length == 5
      chars = signal - ident_code 
      if chars.length == 0
        ident[:two] = signal 
        false
      else
        true
      end
    else
      true
    end
  end
end

def identify_five(ident, signals)
  signals.select do |signal|
    if signal.count == 5
      ident[:five] = signal
      false
    else
      true
    end
  end
end

def identify_zero(ident, signals)
  signals.select do |signal|
    if signal.length == 6
      ident[:zero] = signal
      false
    else
      true
    end
  end
end

def identify_simples(identification, signals)
  signals.select do |signal|
    case (signal.length)
    when 2
      identification[:one] = signal
      false
    when 3
      identification[:seven] = signal
      false
    when 4
      identification[:four] = signal
      false
    when 7
      identification[:eight] = signal
      false
    else
      signal
    end
  end
end

readouts = []
input = File.open('./input.txt', 'r').read

input_lines = input.split("\n")

input_lines.each do |line|
  signals, outputs = line.split(' | ')
  signal_list = signals.split(' ').map {|signal| order_word(signal)}
  output_list = outputs.split(' ').map {|output| order_word(output)}
  readouts.push({signals: signal_list, outputs: output_list})
end

answer = 0
readouts.each do |readout|
  ident= {
    one: nil,
    two: nil,
    three: nil,
    four: nil,
    five: nil,
    six: nil,
    seven: nil,
    eight: nil,
    nine: nil
  }

  signals = identify_simples(ident, readout[:signals])  
  signals = identify_nine(ident, signals)
  signals = identify_three(ident, signals)
  signals = identify_six(ident, signals)
  signals = identify_two(ident, signals)
  signals = identify_five(ident, signals)
  signals = identify_zero(ident, signals)

  output_string = ''
  readout[:outputs].each do |output|
    clean_output = output.sort.join('')
    ident.each do |key, value|
      if clean_output == value.sort.join('')
        output_string += to_number(key)
      end
    end
  end

  answer += output_string.to_i
   
end

puts 'Answer'
puts answer
