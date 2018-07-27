class KnightPathFinder
  Relative_pos = [[2, -1], [2, 1], [1, -2], [-1, -2], [1, 2], [-1, 2], [-2, -1], [-2, 1]]

  def initialize(start_pos =[0,0])
    @start_pos = start_pos
    @visited_positions = [start_pos]
    @root_node = PolyTreeNode.new(start_pos)
    #build move tree
  end

  def build_move_tree

    queue = [root_node]
    until queue.empty?
      el = queue.shift
      el.new_move_positions.each do |new_position|
        new_position.parent = el
        el.add_child(new_position)
        queue << new_position
      end

      end

  end

  def find_path
  end

  def self.valid_moves(pos)
    arr = []
    Relative_pos.each do |coodi|
      fir = pos[0] + coodi[0]
      sec = pos[1] + coodi[1]
      if fir <= 7 && sec <= 7
        arr << [fir, sec]
      end
    end
    arr
  end

  def new_move_positions(pos)
    moves = self.valid_moves(pos)
    new_moves = moves.reject {|m| @visited_positions.include?(m)}
    new_moves.each do |arr|
      @visited_positions << arr
    end
    new_moves
  end


end

class PolyTreeNode

    def initialize(value, parent = nil)
      @parent = parent
      @children =[]
      @value = value
    end

    attr_accessor :children, :value
    attr_reader :parent


  def parent=(new_parent)
    # debugger
    self.parent.children.reject! {|node| node == self} unless self.parent.nil?
    @parent = new_parent
    return nil if new_parent.nil?
    self.parent.children << self unless new_parent == self
  end



  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Node is not a child !" unless child_node.parent == self
    child_node.parent = nil
  end
end
