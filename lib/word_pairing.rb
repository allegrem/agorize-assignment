require_relative 'node'

module WordPairing
  def self.fast(words, target_words)
    results = []

    # Build the search tree
    tree = Node.new
    words.each { |word| tree.insert word }

    target_words.each do |word|
      # Get the list of the words which begin like the current word
      # get_path() returns an array of boolean. A "true" value at index i means
      # that the first i+1 letters form an existing word.
      tree.get_path(word).each_with_index do |word_exist, i|
        next unless word_exist # we only consider the "true" values
        # We check if the remaining letters also form an existing word. If so,
        # we save the result.
        results << [word, word[0..i], word[i+1..-1]] if tree.exist?(word[i+1..-1])
      end
    end

    results
  end

  def self.slow(words, target_words)
    results = []

    target_words.each do |target_word|
      words.each do |start_word|
        words.each do |end_word|
          if target_word == start_word + end_word
            results << [target_word, start_word, end_word]
          end
        end
      end
    end

    results
  end
end
