f = File.new('input.txt', 'r')
list = []

def inList(item, list)
  list.include?(item)
end
# A => 65
# a => 97
sum = 0
f.readlines.each do |line|
  length = line.length
  first = line[0,length/2].chars.uniq
  second = line[length/2, length].chars.uniq
  first.each do |item|
    number = 0
    if inList(item, second)
      puts "IS IN LIST"
      puts item
      puts list
      if !!item.match(/[a-z]/)
        number = item.ord - 96
      end
      if !!item.match(/[A-Z]/)
        number = item.ord - 38
      end
    end
    
    sum += number
  end
end




puts sum
