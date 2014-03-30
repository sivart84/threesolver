# lib/board.rb
# 
# Handles board status and updates

class Board

  attr_accessor :board, :stack, :nums

  def initialize(stack, starting_pos = nil)
    @stack = stack
    @nums = num_map
    if starting_pos.nil?
      @board = populate
    else
      if valid_board?(starting_pos)
        @board = starting_pos
      else
        raise "Given starting position is invalid! #{starting_pos}"
      end
    end
    return self
  end

  def translate
    translated_board = get_empty_board
    @board.each_with_index do |row, x|
      row.each_with_index do |num, y|
        translated_board[x][y] = @nums[num]
      end
    end
    return translated_board
  end

  def update(direction)
    # change places!
  end


  private

  def populate
    temp_board = get_empty_board
    9.times do
      x, y = find_empty_spot(temp_board)
      temp_board[x][y] = @stack.get_next
    end
    return temp_board
  end

  def get_empty_board
    empty_board = [ [0, 0, 0, 0],
                    [0, 0, 0, 0],
                    [0, 0, 0, 0],
                    [0, 0, 0, 0] ]
  end

  def num_map(max = 15)
    temp_map = ['0', '1', '2']
    (3..max).each do |num|
      temp_map << (3 * 2**(num - 3)).to_s
    end
    return temp_map
  end

  def find_empty_spot(board)
    # better would be to put coords for all empty spots in an array and call sample
    loop do
      x = rand(4)
      y = rand(4)
      return x, y if board[x][y] == 0
    end
  end

end
