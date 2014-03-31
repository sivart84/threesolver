require_relative 'lib/board'
require_relative 'lib/stack'

def display(stack, board)
  puts "NEXT CARD: #{stack.next?}"
  board.translate.each do |row|
    print "#{row}\n"
  end
end

begin
  seed = rand(2048)
  rng = Random.new(seed)
  puts "USING SEED: #{rng.seed}\n\n"
  stack = Stack.new(rng)
  game_board = Board.new(rng, stack)
  loop do
    display(stack, game_board)
    puts "\n"
    puts "Move: "
    dir = gets.chomp.to_sym
    game_board.move(dir)
  end
end