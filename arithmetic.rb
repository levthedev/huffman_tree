require 'radix'

class Compressor
  attr_accessor :text,     # => :text
                :base,     # => :base
                :uniques,  # => :uniques
                :dict      # => nil

  def initialize(text)
    @text = text        # => "ABBCAB"
  end

  def zip
    calculate_base     # => 3
    assign_values      # => {"A"=>"0", "B"=>"1", "C"=>"2"}
    substitute         # => ["0", "01", "011", "0112", "01120", "011201"]
    convert_to_binary  # => "1111111"
  end

  def calculate_base
    @uniques = @text      # => "ABBCAB"
              .split("")  # => ["A", "B", "B", "C", "A", "B"]
              .uniq       # => ["A", "B", "C"]

    @base = @uniques.length  # => 3
  end

  def assign_values
    @dict = {}                          # => {}
    @uniques.each_with_index do |c, i|  # => ["A", "B", "C"]
      @dict[c] = "#{i}"                 # => "0", "1", "2"
    end                                 # => ["A", "B", "C"]
    @dict                               # => {"A"=>"0", "B"=>"1", "C"=>"2"}
  end

  def substitute
    @subbed = ""                                     # => ""
    @text.split("").map { |c| @subbed += @dict[c] }  # => ["0", "01", "011", "0112", "01120", "011201"]
  end

  def convert_to_binary
    @subbed              # => "011201"
    .to_i(@base)         # => 127
    .to_s(2)             # => "1111111"
  end
end

"subbed in base 4 -> converted to_i base 4 -> base 2"  # => "subbed in base 4 -> converted to_i base 4 -> base 2"

class Decompressor
  attr_accessor :text  # => nil

  def initialize(text, length, base)
    @text = text                      # => "11011000001110000011110010100"
    @length = length                  # => 16
    @base = base                      # => 4
  end

  def unzip
    convert_to_base  # => 91479457626669328
    # substitute
    # assign_values
    # uncompressed
  end

  def convert_to_base
    @text              # => "11011000001110000011110010100"
    .to_i(@base)       # => 91479457626669328
  end
end

l = Compressor.new("ABBCAB")                                  # => #<Compressor:0x007fa12b01fad0 @text="ABBCAB">
l.zip                                                         # => "1111111"
z = Decompressor.new("11011000001110000011110010100", 16, 4)  # => #<Decompressor:0x007fa12c85a168 @text="11011000001110000011110010100", @length=16, @base=4>
z.unzip                                                       # => 91479457626669328

#what if I converted to binary than did run length compression? what if I converted that result back to binary and so on and so forth?
