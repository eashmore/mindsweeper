class Tile
  attr_reader :neighbors, :location, :view, :is_bomb, :board

  def initialize(tile_options)
    @view = '*'
    @is_bomb = tile_options[:is_bomb]
    @board = tile_options[:board]
    @location = tile_options[:location]
    @magnitude = tile_options[:magnitude]
  end

  def is_bomb?
    @is_bomb
  end

  def reveal
    count = neighbor_bomb_count
    if is_bomb
      @view = "X"
      board.lose
    elsif @view != '*' && @view != 'F'
      return
    elsif count == 0
      @view = "_"
      board.increment_revealed_count
      neighbors_array = board.get_neighbors(@neighbors)
      neighbors_array.each do |neighbor|
        neighbor.reveal
      end
    else
      board.increment_revealed_count
      @view = "#{count}"
    end
  end

  def generate_neighbors
    neighbor_array = []
    [1, 0, -1].each do |i|
      [1, 0,-1].each do |j|
        neighbor_array << dot_sum_array(@location, [i, j])
      end
    end

    neighbor_array = neighbor_array.select do |coordinate|
      coordinate.all? { |location| location.between?(0, @magnitude-1) }
    end

    @neighbors = neighbor_array.reject { |neighbor| neighbor == @location }
  end

  def dot_sum_array(arr1, arr2)
    result = []
    arr1.each_index do |i|
      result[i] = arr1[i] + arr2[i]
    end

    result
  end

  def neighbor_bomb_count
    generate_neighbors
    immediate_neighbors = board.get_neighbors(@neighbors)
    number_of_neighbors = 0
    immediate_neighbors.each do |neighbor|
      number_of_neighbors += 1 if neighbor.is_bomb
    end
    number_of_neighbors
  end


  def flag
    if @view == "F"
      @view = "*"
    else
      @view = "F"
    end
  end


end
