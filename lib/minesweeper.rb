require 'yaml'
require_relative 'board'
require_relative 'tile'

class Game
  attr_reader :win, :lose, :board
  attr_accessor :saved, :options

  def initialize(board = nil, options = {})
    defaults = {
      magnitude: 9,
      bombs: 9
    }
    @options = defaults.merge(options)
    @board = Board.new(self, @options) unless board
    @lose = false
    @saved = false
  end

  def losing
    puts "You Lose!"
    @lose = true
  end

  def over?
    lose || win? || @saved
  end

  def win?
    board.count == options[:magnitude] ** 2 - options[:bombs]
  end

  def run
    until over?
      board.render
      take_turn
    end
    board.render
    if win?
      puts "You Win!"
    end
  end

  def take_turn
    print "What's your move? > "
    response = gets.chomp.split(",")
    row = response[1].to_i
    column = response[0].to_i
    tile = board.return_tile(row, column)
    if response == ["save"]
      save_game
    elsif response.length > 2
        tile.flag
    else
      tile.reveal
    end
  end

  def save_game
    @saved = true
    File.open("saved_game.yml", "w") do |f|
      f.puts self.to_yaml
    end
    puts "Game saved."
  end

end


if __FILE__ == $PROGRAM_NAME
  if ARGV.include?("load")
    until ARGV.empty?
      ARGV.shift
    end
    saved_game = YAML::load(File.readlines("saved_game.yml").join(""))
    saved_game.saved = false
    saved_game.run
  else
    new_game = Game.new
    new_game.run
  end
end
