class SlowWordPairing
  def load_words
    words = []
    File.open('wordlist.txt', 'r') do |f|
      f.each_line do |line|
        words << line.strip if line =~ /\b[a-zA-Z]{1,6}\b/ # only keep words with 6 letters or less
      end
    end
    words
  end

  def search
    words = load_words
    result = {}

    six_letters = words.select { |w| w.length == 6 }
    puts words.length
    puts six_letters.length

    six_letters.each do |six_letter|
      words.each do |start_word|
        words.each do |end_word|
          if six_letter == start_word + end_word
            result[six_letter] = [start_word, end_word]
            puts [six_letter, start_word, end_word]
          end
        end
      end
    end
  end
end
