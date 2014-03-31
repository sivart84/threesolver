# lib/board.rb
# 
# Handles board status and updates

class Board

  EMPTY_BOARD = [[0, 0, 0, 0],
                 [0, 0, 0, 0],
                 [0, 0, 0, 0],
                 [0, 0, 0, 0]]

  DIR_COORDS = {up: [-1, 0], down: [1, 0], left: [0, -1], right: [0, 1]}

  NUMS = ['0', '1', '2', '3', '6', '12', '24', '48', '96', '192', '384', '768', '1536', '3072', '6144', '12288']

  attr_accessor :board, :rng, :stack

  def initialize(rng, stack, starting_pos = nil)
    @rng = rng
    @stack = stack
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
    # Figure out how to use a constant, to avoid this duplication...
    # Using Array.new(EMPTY_BOARD) would end up updating @board and break all the things.
    translated_board = [[0,0,0,0], [0,0,0,0], [0,0,0,0], [0,0,0,0]]
    each_num do |num, x, y|
      translated_board[x][y] = NUMS[num]
    end
    return translated_board
  end

  def move(direction)
    case direction
    when :up
      move_up_down([1, 2, 3], DIR_COORDS[direction])
    when :down
      move_up_down([2, 1, 0], DIR_COORDS[direction])
    when :left
      move_left_right([1, 2, 3], DIR_COORDS[direction])
    when :right
      move_left_right([2, 1, 0], DIR_COORDS[direction])
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
    @board = Array.new(EMPTY_BOARD)
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
    return empty_spots.sample(random: rng)
  end

  def each_num
    @board.each_with_index do |row, x|
      row.each_with_index do |num, y|
        yield num, x, y
      end
    end
  end

  def compatible_nums?(cur_num, to_num)
    return true if to_num == 0
    return true if cur_num == 1 && to_num == 2
    return true if cur_num == 2 && to_num == 1
    return true if cur_num > 2 && to_num > 2 && cur_num == to_num
    return false
  end

  def combine_nums(cur_num, to_num)
    arr = [cur_num, to_num].uniq
    inc = arr.length == 1 ? 1 : 0
    return arr.reduce(:+) + inc
  end

  # Mostly duplicated in #move_left_right method. Possibly figure out how to abstract them into one method.
  def move_up_down(rows, direction)
    updated_rows = []
    rows.each do |cur_x|
      to_x = cur_x + direction[0]
      (0..3).each do |cur_y|
        cur_num = @board[cur_x][cur_y]
        unless cur_num == 0
          to_num = @board[to_x][cur_y]
          if compatible_nums?(cur_num, to_num)
            @board[to_x][cur_y] = combine_nums(cur_num, to_num)
            @board[cur_x][cur_y] = 0
            updated_rows.push(cur_y)
          end
        end
      end
    end
    updated_rows.uniq
    # add the next card from the stack to a random updated_row
  end

  def move_left_right(cols, direction)
    updated_cols = []
    cols.each do |cur_y|
      to_y = cur_y + direction[1]
      (0..3).each do |cur_x|
        cur_num = @board[cur_x][cur_y]
        unless cur_num == 0
          to_num = @board[cur_x][to_y]
          if compatible_nums?(cur_num, to_num)
            @board[cur_x][to_y] = combine_nums(cur_num, to_num)
            @board[cur_x][cur_y] = 0
            updated_cols.push(cur_x)
          end
        end
      end
    end
    updated_cols.uniq
    # add the next card from the stack to a random updated_col
  end

end
