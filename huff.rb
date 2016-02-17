class Node
  attr_accessor :left, :right, :value
  include Enumerable
  @@all = []

  def each(&block)
    left.each(&block) if left
    block.call(self)
    right.each(&block) if right
  end

  def self.visualize
    # @root.map do |n|
    #   " #{n.value}\n #{"/" if n.left}#{"\\" if n.right}\n#{n.left.value if n.left}  #{n.right.value if n.right}"
    # end
    # @root.map do |n|
    #   puts "#{@root.value}"
    #   if n.left && n.right
    #     puts "/\\\n#{n.left.value}  #{n.right.value}"
    #   elsif n.left
    #     puts "/\n#{n.left.value}"
    #   elsif n.right
    #     puts "\\\n#{n.right.value }"
    #   end
    # end
    @root.each_with_index { |n, i| puts "#{n.value}: #{i}"}
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
    @root = Node.new(root_value, root_left, root_right)
  end
end

Node.huffman "aaaabc"
p Node.visualize
