require 'rspec'

class Cell
  attr_accessor :x, :y, :world

  def initialize(world, x=0, y=0)
    @world = world
    @x = x
    @y = y
    world.cells << self
  end

  def neighbors
    @neighbors = []
    world.cells.each do |cell|
      if self.x == cell.x && self.y == cell.y - 1 #one cell above
        @neighbors << cell
      end
    end
    @neighbors
  end

  def spawn_at(x, y)
    Cell.new(world, x, y)
  end
end

class World
  attr_accessor :cells

  def initialize
    @cells = []
  end
end

describe 'game' do
  let(:world) { World.new }

  context 'cell support methods' do
    subject { Cell.new(world) }

    it 'creates a relative cell' do
      cell = subject.spawn_at(3,5)
      expect(cell.x).to eq(3)
      expect(cell.y).to eq(5)
      expect(cell.world).to eq(subject.world)
    end

    it 'detects neighbor directly above' do
      cell = Cell.new(0, 1)
      expect(subject.neighbors.count).to eq(1)
    end

  end

  it 'Any live cell with fewer than two live neighbors dies' do
    cell = Cell.new(world)
    # cell2 = Cell.new()
    expect(cell.neighbors.count).to eq(0)
  end
end
