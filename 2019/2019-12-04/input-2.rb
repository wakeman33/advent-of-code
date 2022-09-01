$count = 0

def check_number(number)
  prev_digit = nil
  ascending_flag = false
  adjecent_equal_flag = false
  consecuative_count = 0
  number.chars.each_with_index do |digit_char, index|
    # puts "Flags"
    # puts ascending_flag
    # puts adjecent_equal_flag
    # puts consecuative_count
    # puts ""

    digit = digit_char.to_i

    if prev_digit.nil?
      prev_digit = digit
      next
    end

    ascending_flag = check_ascending(digit, prev_digit)
    equal_flag = check_equal(digit, prev_digit)

    if equal_flag
      # puts "Equal"
      consecuative_count += 1
    else 
      # puts "Not Equal"
      adjecent_equal_flag = adjecent_equal_flag || consecuative_count == 1
      consecuative_count = 0
    end

    prev_digit = digit

    if index == number.length - 1 && equal_flag
      # puts "Cheking Last Char"
      adjecent_equal_flag = adjecent_equal_flag || consecuative_count == 1
      # puts adjecent_equal_flag
    end

    break unless ascending_flag
    # puts ""
  end

  if ascending_flag && adjecent_equal_flag
    puts number
    $count += 1
  end

end

def check_ascending(digit, prev_digit)
  return false if prev_digit.nil?
  digit >= prev_digit
end

def check_equal(digit, prev_digit)
  digit == prev_digit
end

(272091...815432).each do |number_value|
  check_number(number_value.to_s)
end
# check_number("789999")
puts ""
puts $count
