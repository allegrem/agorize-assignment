require 'word_pairing'

RSpec.describe WordPairing, '#load_words' do
  let(:words) { WordPairing.new.load_words }

  it 'returns a non-empty array' do
    expect(words.class).to eq Array
    expect(words).not_to be_empty
  end

  it 'returns words with 6 letters or less' do
    words.first(20).each do |word| # TODO: randomize?
      expect(word.length).to be <= 6
    end
  end
end
