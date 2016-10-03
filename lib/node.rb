class Node
  # Raised when trying to access a node which does not exist
  class NotFound < StandardError; end

  # Store the children of the current node (see #[] for a shorthand version)
  attr_reader :children

  # Initialize with an empty list of children and the end_of_word flag as false
  def initialize
    @children = {}
    @end_of_word = false
  end

  # Setter and accessor for the end_of_word flag
  def end_of_word?
    @end_of_word
  end

  def end_of_word!
    @end_of_word = true
  end

  # Insert the given string in the tree. The method creates nodes along the way
  # if they do not already exist. The last node (aka the last letter) is flagged
  # as end_of_word.
  def insert(str)
    child_node = get_or_create str[0]
    if str.length == 1 # terminal condition
      child_node.end_of_word!
    else
      child_node.insert str[1..-1] # recursively call itself on the child node
    end
  end

  # If there is already a child node with the given label (aka letter), return
  # it. Otherwise, create a new node with the given label and return it.
  def get_or_create(char)
    @children[char] ||= Node.new
  end

  # Shorthand version of node.children[key]
  def [](key)
    @children[key]
  end

  # Returns an array with the value of end_of_word for each node encountered
  # while navigating the tree based on the given string.
  # Raise Node::NotFound if the given string does not form an existing path
  # of nodes (but no errors are raised if there is an existing path but the
  # final node is not flagged as end_of_word).
  def get_path(str)
    child_node = @children[str[0]] || raise(NotFound)
    return [child_node.end_of_word?] if str.length == 1
    [child_node.end_of_word?].concat child_node.get_path(str[1..-1])
  end

  # Returns true if the given string forms an existing path of nodes leading
  # to a node flagged as end_of_word.
  def exist?(str)
    return end_of_word? if str.empty? # terminal condition
    child_node = @children[str[0]]
    return false unless child_node # there is no path with the given string
    child_node.exist? str[1..-1] # recursively call itself on the child node
  end
end
