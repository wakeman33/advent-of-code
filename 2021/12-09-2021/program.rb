class MapPoint
  attr_accessor :elevation, :lowest
  def initialize(point_elevation)
    @elevation = point_elevation
    @lowest = false
  end
end

class Map

  def initialize(map_input)
    @map = []
    parse_map(map_input)
  end

  def parse_map(map_input)
    map_rows = map_input.split("\n")
    row_index = 0
    map_rows.each do |row|
      # Initialize row
      @map[row_index] = [] if @map[row_index].nil?
      map_row = @map[row_index]

      points = row.split('')
      points.each do |point|
        mp = MapPoint.new(point.to_i)
        map_row.push(mp) 
      end
      row_index += 1
    end
  end

  def show
    @map.each do |row|
      row.each do |point|
        print point.elevation.to_s + '-' + point.lowest.to_s
        print ' '
      end
      puts
    end
  end

  def determing_adjecent_points(row_index, point_index, row_length, point_length) 
    nm_row_index = row_index - 1
    if nm_row_index >= 0
      up = [nm_row_index, point_index]
    else
      up = nil
    end

    np_row_index = row_index + 1
    if np_row_index < row_length
      down = [np_row_index, point_index]
    else
      down = nil
    end

    nm_point_index = point_index - 1
    if nm_point_index >= 0
      right = [row_index, nm_point_index]
    else
      right = nil
    end

    np_point_index = point_index + 1
    if np_point_index < point_length
      left = [row_index, np_point_index]
    else
      left = nil
    end
    return up, down, right, left
  end

  def lower_elevation(orig_elevation, elevation_2)
    orig_elevation.elevation < elevation_2.elevation
  end

  def check_for_lower(up, down, right, left, orig_elevation)
    unless up.nil?
      up_elev = @map[up[0]][up[1]]
      up_r = lower_elevation(orig_elevation, up_elev)
    else
      up_r = true 
    end 

    unless down.nil?
      down_elev = @map[down[0]][down[1]] 
      down_r = lower_elevation(orig_elevation, down_elev)
    else
      down_r = true 
    end

    unless right.nil?
      right_elev = @map[right[0]][right[1]]
      right_r = lower_elevation(orig_elevation, right_elev)
    else
      right_r = true
    end
    
    unless left.nil?
      left_elev = @map[left[0]][left[1]]
      left_r = lower_elevation(orig_elevation, left_elev)
    else
      left_r = true
    end
    up_r && down_r && right_r && left_r
  end

  def find_all_lowest
    row_index = 0
    @map.each do |row|
      point_index = 0
      row.each do |point|
        up, down, right, left = determing_adjecent_points(row_index, point_index, @map.length, row.length)
        res = check_for_lower(up, down, right ,left, @map[row_index][point_index])
        point.lowest = res
        point_index += 1
      end
      row_index += 1
    end
  end

  def risk_assesment
    risk = 0
    @map.each do |row|
      row.each do |point|
        risk += point.elevation + 1 if point.lowest
      end
    end
    risk
  end

end

input = File.open('input.txt', 'r').read

map = Map.new(input)
map.find_all_lowest
# map.show
answer = map.risk_assesment
puts answer
