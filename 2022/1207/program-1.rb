require 'json'
$f = File.new('input.txt', 'r')

command = {
  ls: 0,
  cd: 1,
}

$tree = {}
$pwd = []
$current_command = ""

def get_branch()
  branch = $tree
  $pwd.each do |dir|
    branch = branch[dir]
  end
  return branch
end

def run_command()
  current_command = $current_command.sub('$ ', '')
  cmd, arg = current_command.split(/\s/) 
  case (cmd)
  when 'cd'
    if arg == ".."
      # move up a directory
      $pwd.pop
    else
      branch = get_branch()
      $pwd.push(arg)
      if branch[arg].nil?
        branch[arg] = {}
      end
    end
    $current_command = $f.readline if !$f.eof?
  when 'ls'
    branch = get_branch()

    # process ls
    $current_command = $f.readline
    size = 0
    while !$current_command.include?('$ ')
      if $current_command.include?("dir")
        # Don't Care?
      elsif $current_command.include?("$ ")
        # Dont't Care
      else
        size += $current_command.to_i
      end
      break if $f.eof?
      $current_command = $f.readline
    end
    branch["size"] = size
  end
end

$current_command = $f.readline
while !$f.eof?
  run_command()
end


puts $tree

def sum(branch)
  if branch.keys.length <= 1
    return branch['size']
  end
   
  running_total = 0
  branch.keys.each do |key|
    if key != 'size'
      running_total += sum(branch[key])
    else
      # size of current branch file 
      running_total += branch[key]
    end
  end
  return running_total
end


$grand_total = 0
def get_sums(branch)
  if branch.keys.hash  == ['size'].hash
    return
  end


  branch.keys.each do |key|
    if key == 'size'
      next
    end


    if key
    end
    total = sum(branch[key])
    $grand_total += total if total <= 100000
    get_sums(branch[key])
  end 
end

get_sums($tree)

puts 
puts 
puts JSON.generate($tree)
puts
puts $grand_total
