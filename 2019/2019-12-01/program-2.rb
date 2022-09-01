
file_name = ARGV[0]

line_array = File.readlines(file_name)
total_fuel = 0

def calc_fuel(mass)
  fuel = (mass/3) - 2

  if (fuel > 0)
    fuel += calc_fuel(fuel)
  else
    0
  end
  
end

line_array.each do |module_mass|
  module_mass_int = module_mass.to_i
  total_fuel += calc_fuel(module_mass_int)
end

puts "Required Fuel: " + total_fuel.to_s
