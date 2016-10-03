class WordPairing
  def load_words
    words = []
    File.open('wordlist.txt', 'r') do |f|
      f.each_line do |line|
        words << line.strip if line =~ /\b[a-zA-Z]{1,6}\b/ # only keep words with 6 letters or less
      end
    end
    words
  end
end
