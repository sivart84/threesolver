# lib/stack.rb
#
# Maintains the upcoming stack of cards

class Stack
  attr_accessor :stack, :seed, :force_seed

  def initialize(force_seed = nil)
    @force_seed = force_seed
    rebuild
    return self
  end

  def next?
    @stack[0]
  end

  def get_next
    next_num = @stack.shift
    @stack.rebuild if @stack.empty?
    return next_num
  end


  private

  def rebuild
    default_stack = [1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3]
    # need to add bonus number when applicable...
    @stack = default_stack.shuffle(random: Random.new(update_seed))
  end

  def update_seed
    return @force_seed unless @force_seed.nil?
    @seed = rand(1024)
  end

end
