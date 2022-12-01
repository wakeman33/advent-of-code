require "./2021/12-09-2021/grid_space.rb"

RSpec.describe GridSpace do
  it "should receive a value" do
    l = GridSpace.new
    l.value = "new value"
    expect(l.value).to eq("new value")
  end
end
