module Words
  def self.load_words
    words = []
    six_letters = []

    File.open('wordlist.txt', 'r') do |f|
      f.each_line do |line|
        word = line.strip.downcase
        next unless word =~ /\b[a-z]{1,6}\b/ # only keep words with <= 6 letters
        words << word
        six_letters << word if word.length == 6
      end
    end

    [words, six_letters]
  end
end
