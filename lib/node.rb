class Node
  attr_accessor :children
  attr_accessor :values

  def initialize
    @children = {}
    @values = []
  end
end
