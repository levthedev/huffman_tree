class Node
  attr_accessor :value, :left, :right, :root  # => nil

  def self.all
    ObjectSpace.each_object(self).to_a
  end

  def root!
    @root = true
  end

  def self.visualize
    root = Node.all.select { |n| n.root }
    # " #{value}\n /\\\n#{left.value if left}  #{right.value if right}"  # ~> NameError: undefined local variable or method `value' for Node:Class
  end

  def initialize(value, left = nil, right = nil)
    @value = value
    if (left || right)
      @left = Node.new(left)
      @right = Node.new(right)
    end
  end
end

def huffman(string)
  dict = Hash.new(0)                                                    # => {}
  string.split("").inject(dict)  {|_, c| dict[c] += 1 }                 # => 1
  sorted_chars = dict.sort_by { |k, v| v }.map { |c, freq| c }.reverse  # => ["a", "b", "c"]
  Node.root! sorted_chars.join                                          # ~> NoMethodError: undefined method `root!' for Node:Class

  until sorted_chars.empty?
    right = sorted_chars.pop
    left = sorted_chars.pop
    value = left.to_s + right.to_s
    Node.new(value, left, right)
    sorted_chars
  end
end

huffman("aaaabc")
nodes = Node.all
# bc = nodes.select { |n| n.value == "bc"}.first  # => #<Node:0x007fedaa22e580 @value="bc", @left=#<Node:0x007fedaa22e0a8 @value="b">, @right=#<Node:0x007fedaa22da68 @value="c">>
puts Node.visualize

# ~> NoMethodError
# ~> undefined method `root!' for Node:Class
# ~>
# ~> /Users/levkravinsky/Desktop/levzip/huffman.rb:32:in `huffman'
# ~> /Users/levkravinsky/Desktop/levzip/huffman.rb:43:in `<main>'
