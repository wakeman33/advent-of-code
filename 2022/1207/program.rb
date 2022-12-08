$f = File.new('test.txt', 'r')

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
  puts $current_command
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
    puts $tree
    puts $pwd.join(', ')
    $current_command = $f.readline if !$f.eof?
    puts $current_command
  when 'ls'
    puts "Doing ls"
    branch = get_branch()

    # process ls
    $current_command = $f.readline
    size = 0
    while !($current_command.include?('$ ') || $f.eof?)
      if $current_command.include?("dir")
        # Don't Care?
      elsif $current_command.include?("$ ")
        next
      else
        puts $current_command
        puts  $current_command.to_i
        size += $current_command.to_i
      end
      $current_command = $f.readline
    end
    branch["size"] = size
  end
  puts
end

$current_command = $f.readline
while !$f.eof?
  run_command()
end


puts $tree
