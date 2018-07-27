require 'byebug'

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

def dfs(target_value)

  return self if self.value == target_value

  self.children.each do |child|
    result = child.dfs(target_value)
    return result unless result.nil?
  end
  nil
end

def bfs(target_value)
  queue = [self]
  until queue.empty?
    res = queue.shift
    if res.value == target_value
      return res
    else
      res.children.each do |node|
        queue << node
      end
    end

  end
  nil
end
end
