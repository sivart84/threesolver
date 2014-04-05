require_relative 'lib/board'
require_relative 'lib/stack'

class Game

  attr_accessor :game_board, :rng, :stack, :seed

  def initialize(seed = rand(2048))
    @seed = seed
    @rng = Random.new(@seed)
    puts "USING SEED: #{@seed}\n\n"
    @stack = Stack.new(@rng)
    @game_board = Board.new(@rng, @stack)
    run
  end

  def display
    puts "NEXT CARD: #{@stack.next?}"
    @game_board.translate.each do |row|
      print "#{row}\n"
    end
  end

  def run
    loop do
      display
      puts "\n"
      puts "Move: "
      dir = gets.chomp.to_sym
      @game_board.move(dir)
    end
  end

end

begin
  Game.new
end
