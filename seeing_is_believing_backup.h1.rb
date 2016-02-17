class Node
  attr_accessor :left, :right, :value

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  def self.visualize
    " #{value}\n /\\\n#{left.value if left}  #{right.value if right}"
  end

  def initialize(value, left = nil, right = nil)
    @value, @left, @right = value, left, right
  end

  def self.huffman(string)
    self.sort_string(string)
  end

  def self.sort_string(string)
    dict = Hash.new(0)
    string.split("").inject(dict)  {|_, c| dict[c] += 1 }
    sorted_chars = dict.sort_by { |_, v| v }.map { |c, _| c }.reverse
    final_node = false
    until final_node
      final_node = Node.all.select do |n|
        (n.value.length == string.length) if n.value
      end.any?
      self.populate_tree sorted_chars
    end
  end

  def self.populate_tree(chars)
    x = Node.new chars.pop
    y = Node.new chars.pop
    if x || y
      Node.new(x.value.to_s + y.value.to_s, x, y)
    end
  end
end

Node.huffman "aaaabc"
