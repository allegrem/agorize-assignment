require 'words'

RSpec.describe Words, '#load_words' do
  before do
    @words, @target_words = Words.load_words
  end

  it 'returns non-empty arrays' do
    expect(@words.class).to eq Array
    expect(@words).not_to be_empty

    expect(@target_words.class).to eq Array
    expect(@target_words).not_to be_empty
  end

  it 'returns words with 6 letters or less' do
    @words.first(20).each do |word| # TODO: randomize?
      expect(word.length).to be <= 6
    end
  end

  it 'returns target words with exactly 6 letters' do
    @target_words.first(20).each do |word| # TODO: randomize?
      expect(word.length).to eq 6
    end
  end
end
