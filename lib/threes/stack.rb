# lib/stack.rb
#
# Maintains the upcoming stack of cards

class Stack
  attr_accessor :stack, :rng, :force_seed

  def initialize(rng)
    @rng = rng
    rebuild
    return self
  end

  def next?
    @stack[0]
  end

  def get_next
    next_num = @stack.shift
    rebuild if @stack.empty?
    return next_num
  end


  private

  def rebuild
    default_stack = [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3]
    # need to add bonus number when applicable...
    @stack = default_stack.shuffle(random: rng)
  end

end
