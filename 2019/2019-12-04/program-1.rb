$count = 0

def check_number(number)
  prev_digit = nil
  ascending_flag = false
  double_flag = false
  number.chars.each do |digit_char|
    digit = digit_char.to_i
    if prev_digit.nil?
      prev_digit = digit
      next
    end
    ascending_flag = check_ascending(digit, prev_digit)
    double_flag = check_double(double_flag, digit, prev_digit)
    prev_digit = digit
    break unless ascending_flag
  end

  if ascending_flag && double_flag
    puts number
    $count += 1
  end

end

def check_ascending(digit, prev_digit)
  return false if prev_digit.nil?
  digit >= prev_digit
end

def check_double(double_flag, digit, prev_digit)
  return true if double_flag
  return false if prev_digit.nil?
  digit == prev_digit
end

(272091...815432).each do |number_value|
  check_number(number_value.to_s)
end
puts ""
puts $count
