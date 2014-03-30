require_relative 'lib/board'
require_relative 'lib/stack'

def display(stack, board)
  puts "NEXT CARD: #{stack.next?}"
  board.translate.each do |row|
    print "#{row}\n"
  end
end

begin
  stack = Stack.new
  game_board = Board.new(stack)
  display(stack, game_board)
end