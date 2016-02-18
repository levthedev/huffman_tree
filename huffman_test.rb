require "minitest"
require "minitest/autorun"
require "minitest/pride"
require "byebug"

class Node
  attr_accessor :left, :right, :value
  @@all = []

  def self.root
    @@root
  end

  def self.all
    @@all
  end

  def initialize(value, left = nil, right = nil)
    @value, @left, @right = value, left, right
    @@all << self
  end

  def self.huffman(string)
    dict = Hash.new(0)
    string.split("").inject(dict)  {|_, c| dict[c] += 1 }
    sorted_chars = dict.sort_by { |_, v| v }.map { |c, _| c }.reverse
    self.populate_tree sorted_chars
  end

  def self.populate_tree(chars)
    root_value = chars.join("")
    until @@all.max_by { |n| n.value.length.to_s == (chars.length - 1) }
      left = Node.new chars.pop
      right = Node.new chars.pop
      Node.new(left.value + right.value, left, right)
    end

    root_right = @@all.max_by { |n| n.value.length.to_s }
    root_left = Node.new(chars.pop)
    @@root = Node.new(root_value, root_left, root_right)
  end

  def huffman_code
    @@code ||= ""
    parent = Node.parent(self)
    if parent
      if parent.left == self
        @@code += "0"
      elsif parent.right == self
        @@code += "1"
      end
      parent.huffman_code
    end
    @@code
  end

  def self.parent(child)
    all.select { |node| node if (node.left == child || node.right == child) }.first
  end

  def self.find(value)
    all.select { |node| node if node.value == value }.first
  end
end

class TestHuffman < Minitest::Test
  def setup
    @tree = Node.huffman "aaaabbcddd"
  end

  def test_it_returns_parent_nodes
    b_node = Node.find("b")
    cb_node = Node.find("cb")
    parent = Node.parent(b_node)
    assert_equal cb_node, parent
  end

  def test_it_returns_a_huffman_code
    a_code = { a: 0 }
    b_code = { b: 111 }
    c_code = { c: 110 }
    d_code = { d: 10 }

    # a_node = Node.find("a")
    b_node = Node.find("b")
    c_node = Node.find("c")
    d_node = Node.find("d")

    # assert_equal a_code, a_node.huffman_code
    assert_equal b_code, b_node.huffman_code
    assert_equal c_code, c_node.huffman_code
    assert_equal d_code, d_node.huffman_code
  end

  def test_it_returns_huffman_codes
    skip
    huffman_codes = { a: 0, d: 10, b: 111, c: 110 }
    assert_equal huffman_codes, Node.huffman_codes
  end
end
