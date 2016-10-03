require 'word_pairing'

class SlowWordPairing < WordPairing
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

    result
  end
end
