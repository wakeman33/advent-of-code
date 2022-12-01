require './2021/12-09-2021/grid.rb'

RSpec.describe Grid do
  it "should create a one row grid" do
    g = Grid.new
    g.populate_grid("1,2,3,4")
    expect( g.grid.count ).to eq(1)
    expect( g.grid[0].count ).to eq(4)
  end

  it "should create a two row grid" do
    g = Grid.new
    g.populate_grid("1,2,3,4\n5,6,7,8,9")
    expect( g.grid.count ).to eq(2)
    expect( g.grid[0].count ).to eq(4)
    expect( g.grid[1].count ).to eq(5)
  end

  it "should throw exception if not csv" do
    g = Grid.new
    expect{ g.populate_grid(1) }.to raise_error(NoMethodError)
  end

end

