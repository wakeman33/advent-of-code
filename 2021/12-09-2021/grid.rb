class InvalidRowValue < StandardError
end

class Grid
  attr_reader :grid

  def initialize()
    @grid = []
  end

  def populate_grid(grid_data)
    rows = grid_data.split("\n") 
    rows.each do |row|
      row_arr = create_row(row)
      @grid.append(row_arr)
    end
  end

  private
  def create_row(row_csv)
    if row_csv.class != String
      raise InvalidRowValue
    end
    row_csv.split(',')
  end

end
