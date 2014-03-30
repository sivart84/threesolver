require_relative 'lib/board'
require_relative 'lib/stack'

def display(board)
  board.translate.each do |row|
    print "#{row}\n"
  end
end

begin
  stack = Stack.new
  game_board = Board.new(stack)
  display(game_board)
end