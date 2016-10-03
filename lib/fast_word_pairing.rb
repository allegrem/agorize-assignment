require 'word_pairing'
require 'node'

class FastWordPairing < WordPairing
  DEPTH = 2

  def search
    words = load_words
    results = []
    six_letters = words.select { |w| w.length == 6 }

    # We build the search tree
    root = Node.new
    words.each do |word|
      current_node = root
      word[0..DEPTH].split('').each do |letter|
        current_node = if current_node.children[letter]
                         current_node.children[letter]
                       else
                         current_node.children[letter] = Node.new
                       end
      end
      current_node.values << word
    end
    # puts root.inspect

    six_letters.first(500).each do |six_letter|
      (0..4).each do |n|
        start_word, end_word = [six_letter[0..n], six_letter[n+1..-1]]
        start_candidates = find_in_tree start_word, n, root
        if start_candidates.length > 0
          puts
          puts 'start_word: ' + start_word
          puts 'candidates: ' + start_candidates.inspect
        end
      end
    end

    results
  end

  def find_in_tree(str, length, root)
    current_node = root
    current_length = 0
    str.split('').each do |letter|
      if current_node.children[letter]
        current_node = current_node.children[letter]
        current_length += 1
        break if current_length >= length
      else
        return []
      end
    end
    current_node.values.select { |w| w.length == length }
  end
end
