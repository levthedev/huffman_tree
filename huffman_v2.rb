require 'byebug'

class Node
  attr_accessor :value, :weight, :left, :right

  def initialize(value, weight, left, right)
    @value, @weight, @left, @right = value, weight, left, right
    Tree.nodes << self
  end
end

class Tree
  def self.nodes
    @@nodes ||= []
  end

  def self.dict
    @@dict
  end

  def self.search(value)
    nodes.find { |node| node if node.value == value }
  end

  def self.insert(value, weight, left = nil, right = nil)
    Node.new(value, weight, left, right)
  end

  def self.parent(child)
    nodes.find { |node| node if (node.left == child || node.right == child) }
  end

  def self.huffman_codes(string)
    @@dict = Hash.new(0)
    string.split("").inject(@@dict)  {|_, c| @@dict[c] += 1 }
    populate
  end

  def self.populate
    until @@dict.keys.length < 2
      smallest_weights = @@dict.min_by(2) { |_, weight| weight }
      new_nodes = smallest_weights.map { |value, weight| insert(value, weight) }
      combined_weight = new_nodes.map(&:weight).reduce(:+)
      @@left = new_nodes[0]
      @@right = new_nodes[-1]
      combined_value = @@left.value.to_s + @@right.value.to_s
      @@dict.delete(@@left.value)
      @@dict.delete(@@right.value)
      @@dict[combined_value] = combined_weight

    end
    Node.new(@@dict.keys.first, @@dict.values.first, @@left, @@right)
    @@dict.delete(@@dict[@@dict.keys.first])
  end
end

Tree.huffman_codes "AAAABBBCCDGF"
puts Tree.nodes.map { |node| node.value }

#(treat nodes like ordered set. take two, search for combined values. make result parent, with left first node of combined values and right second node)
