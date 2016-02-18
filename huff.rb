class Node
  attr_accessor :left, :right, :value

  include Enumerable
  @@all = []
  @@str = ""

  def each(&block)
    left.each(&block) if left
    block.call(self)
    right.each(&block) if right
  end

  def self.root
    @@root
  end

  def self.str
    @@str
  end

  def self.all
    @@all
  end

  def self.visualize(node, newline, buffer="")
    newline ? @@str += " #{node.value}\n" : @@str += "#{node.value}  "
    @@str += buffer
    self.visualize(node.left, false) if node.left
    self.visualize(node.right, true, " ") if node.right
    # @@buffer = " "
    # newline ? @@str += " #{node.value}\n" : @@str += "#{node.value}  "
    # if pos == :center
    #   self.visualize(node.left, false, :left) if node.left
    #   self.visualize(node.right, true, :right) if node.right
    # elsif pos == :right
    #   @@buffer += "  "
    #   @@str.ljust(1, @@buffer)
    #   self.visualize(node.left, false, :left) if node.left
    #   self.visualize(node.right, true, :right) if node.right
    # elsif pos == :left
    #   @@buffer += "  "
    #   @@str.rjust(1, @@buffer)
    #   self.visualize(node.left, false, :left) if node.left
    #   self.visualize(node.right, true, :right) if node.right
    # end
  end

  def initialize(value, left = nil, right = nil)
    @value, @left, @right = value, left, right
    @@all << self
  end

  def self.huffman(string)
    self.sort_string(string)
  end

  def self.sort_string(string)
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
end

Node.huffman "aaaabbcddd"
Node.visualize(Node.root, true)
puts Node.str
puts Node.all.map {|n| n.value}
