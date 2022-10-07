# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exist?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

# Add files and commands to this file, like the example:
#   watch(%r{file/path}) { `command(s)` }
#

def drop_filename(raw)
  path_parts = raw.split('/')
  path_parts_count = path_parts.count
  path_parts.delete_at(path_parts_count -1)
  path_parts.join('/')
end

guard :shell do
  watch(%r{^*\.rb}) { |x| 
    project_path = drop_filename(x[0])
    `cd #{project_path} && bundle exec rspec ./spec`
  }
end
