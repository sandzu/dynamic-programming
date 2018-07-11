require "byebug"

class DynamicProgramming

  attr_accessor :blair_cache, :frog_cache
  def initialize
    @blair_cache = {}
    @blair_cache[1] = 1
    @blair_cache[2] = 2
    frog_cache_builder(0)
  end

  def blair_nums(n)
    return @blair_cache[n] unless @blair_cache[n].nil?
    res = blair_nums(n-2) + blair_nums(n-1) + (2*n -3)
    @blair_cache[n] = res
    return res
  end

  def frog_hops_bottom_up(n)
    current = 3
    while current < n
      ways_up = []
      # debugger
      @frog_cache[current].each do |path|
        ways_up.push(path + [1])
      end
      @frog_cache[current-1].each do |path|
        ways_up.push(path + [2])
      end
      @frog_cache[current-2].each do |path|
        ways_up.push(path + [3])
      end
      # debugger
      current += 1
      @frog_cache[current] = ways_up
    end
    # debugger
    @frog_cache[n]
  end

  def frog_cache_builder(n)
    @frog_cache = {}
    @frog_cache[1] = [[1]]
    @frog_cache[2] = [[2], [1,1]]
    @frog_cache[3] = [[3],[2,1],[1,2],[1,1,1]]
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] unless @frog_cache[n].nil?
    ways_up = []
    frog_hops_top_down_helper(n-1).each do |path|
      ways_up.push(path + [1])
    end
    frog_hops_top_down_helper(n-2).each do |path|
      ways_up.push(path + [2])
    end
    frog_hops_top_down_helper(n-3).each do |path|
      ways_up.push(path + [3])
    end
    @frog_cache[n] = ways_up
    @frog_cache[n]
  end

  def super_frog_hops(n, k)

  end



  def knapsack(weights, values, capacity)
    subproblems = [Array.new(weights.length, 0)]
    items = weights.zip(values)
    subproblem_capacity = 1
    # debugger
    until subproblem_capacity > capacity
      subproblem = []
      items.each_with_index do |item, index|
        w,v = item
        sum = 0
        can_include = subproblems[subproblem_capacity-1].dup
        unless w > subproblem_capacity || subproblems[subproblem_capacity-w].nil?
          sum = v
          can_include =
            subproblems[subproblem_capacity-w].dup
        end
        can_include.delete_at(index)
        subproblem.push(sum + can_include.max)
      end
      # debugger
      subproblems.push(subproblem) unless subproblem.empty?
      subproblem_capacity += 1
    end
    subproblems.last.max
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end

w = [2,3,4]
v = [1,3,3]
c = 7
dp = DynamicProgramming.new()

p dp.knapsack(w,v,c)
