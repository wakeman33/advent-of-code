require 'json'
f = File.new('input.txt', 'r')

def compare(pair)
  left = pair.shift 
  right = pair.shift 
  while !left.empty?() || !right.empty?()
    #gets
    puts "Left: #{left}"
    puts "Right: #{right}"
    left_i =  left.shift
    right_i =  right.shift
    return true if left_i.nil?
    return false if right_i.nil?
    puts "Left_i: #{left_i}"
    puts "Right_i: #{right_i}"

    if left_i.class == Array && right_i.class == Array
      puts "Both Arrays"
      if left_i.empty? && !right_i.empty?
        return true
      elsif right_i.empty? && !left_i.empty?
        return false
      end

      break_while = false
      while !break_while
        l = left_i.shift
        r = right_i.shift
        puts "L: #{l}"
        puts "R: #{r}"
        #gets

        if l.class == Integer && r.class == Integer
          if l < r
            return true
          elsif l > r
            return false
          end
        else
          puts "Mismatch"
          l = [l] if l.class == Integer
          r = [r] if r.class == Integer
          left.unshift(l)
          right.unshift(r)
          break
        end

        if left_i.empty? && !right_i.empty?
          return true
        end

        if right_i.empty? && !left_i.empty?
          return false
        end
        puts "EMPTY"
        puts right_i.empty?
        puts left_i.empty?
        break_while = right_i.empty? && left_i.empty?
      end
      next
    end

    if left_i.class == Integer && right_i.class == Integer
      puts "Both Integers"
      if left_i < right_i 
        return true
      elsif left_i > right_i
        return false
      else
        next
      end
    end

    puts "Mismatch"
    left_i = [left_i] if left_i.class == Integer
    right_i = [right_i] if right_i.class == Integer

    left.unshift(left_i)
    right.unshift(right_i)
  end
end

in_order = []
count = 0
while !f.eof?
  count += 1
  left = JSON.parse(f.readline)
  right = JSON.parse(f.readline)
 
  puts "---- Pair #{count}-----"
  res = compare([left, right])
  puts res
  in_order.push(count) if res

  # get rid of new line
  f.readline if !f.eof?
end

puts in_order.join(', ')
puts in_order.sum
