
file_name = ARGV[0]

line_array = File.readlines(file_name)
fuel = 0

line_array.each do |module_mass|
  module_mass_int = module_mass.to_i
  fuel += (module_mass_int/3).round - 2
end

puts "Required Fuel: " + fuel.to_s
