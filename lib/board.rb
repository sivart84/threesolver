# lib/board.rb
# 
# Handles board status and updates

class Board

  EMPTY_BOARD = [ [0, 0, 0, 0],
                  [0, 0, 0, 0],
                  [0, 0, 0, 0],
                  [0, 0, 0, 0] ]

  DIR_COORDS = {up: [-1, 0], down: [1, 0], left: [0, -1], right: [0, 1]}

  attr_accessor :board, :stack, :nums

  def initialize(stack, starting_pos = nil)
    @stack = stack
    @nums = ['0', '1', '2', '3', '6', '12', '24', '48', '96', '192', '384', '768', '1536', '3072', '6144', '12288']
    if starting_pos.nil?
      populate
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
    translated_board = EMPTY_BOARD
    each_num do |num, x, y|
      translated_board[x][y] = @nums[num]
    end
    return translated_board
  end

  def move(direction)
    case direction
    when :up
      # move_rows([1, 2, 3], DIR_COORDS[direction])
    when :down
      # move_rows([2, 1, 0], DIR_COORDS[direction])
    when :left
      # move_cols([1, 2, 3], DIR_COORDS[direction])
    when :right
      # move_cols([2, 1, 0], DIR_COORDS[direction])
    end
  end


  private

  def valid_board?(board)
    return false unless board.kind_of?(Array) && board.length == 4
    board.each do |row| 
      return false unless row.kind_of?(Array) && row.length == 4
      row.each do |num|
        return false unless num.kind_of?(Fixnum)
      end
    end
    return true
  end

  def populate
    @board = EMPTY_BOARD
    9.times do
      x, y = find_empty_spot(@board)
      @board[x][y] = @stack.get_next
    end
  end

  def find_empty_spot(board)
    empty_spots = []
    each_num do |num, x, y|
      empty_spots << [x, y] if num == 0
    end
    return empty_spots.sample
  end

  def each_num
    @board.each_with_index do |row, x|
      row.each_with_index do |num, y|
        yield num, x, y
      end
    end
  end

end
