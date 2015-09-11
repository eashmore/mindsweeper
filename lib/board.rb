class Board
  attr_reader :tiles, :game, :count, :options

  def initialize(game, options)
    @game = game
    @tiles = Array.new(options[:magnitude]) { Array.new }
    @count = 0
    @options = options
    generate_tiles(options)
  end


  def generate_tiles(options)
    total = options[:magnitude] ** 2
    bombs = options[:bombs]
    bomb = (Array.new(total - bombs) { false } + Array.new(bombs) { true }).shuffle


    (0...options[:magnitude]).each do |i|
      (0...options[:magnitude]).each do |j|
        tile_options = {
          board: self,
          location: [i, j],
          is_bomb: bomb.shift,
          magnitude: options[:magnitude]
          }
        @tiles[i][j] = Tile.new(tile_options)
        # @tiles[i][j] = Tile.new(self, [i, j], bomb.shift, options[:magnitude])
      end
    end
  end

  def render
    print_column_numbers

    row_number = 0
    @tiles.each do |row|
      print row_number
      print row.map { |tile| tile.view }
      print row_number
      puts
      row_number += 1
    end

    print_column_numbers
  end


  def print_column_numbers
    print "   "
    (0...options[:magnitude]).each do |column_number|
      print column_number
      print "    "
    end
    puts
  end


  def get_neighbors(arr)
    result = []
    arr.each do |coordinates|
      i, j = coordinates[0], coordinates[1]
      result << @tiles[i][j]
    end

    result
  end

  def return_tile(i,j)
    return tiles[i][j]
  end

  def lose
    game.losing
  end

  def increment_revealed_count
    @count += 1
  end

end
