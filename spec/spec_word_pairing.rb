require 'word_pairing'

RSpec.describe WordPairing do
  let(:words) { %w(al bums albums we aver weaver tail or tailor ta ilor letter) }
  let(:target_words) { words.select { |w| w.length == 6 } }
  let(:solution) do
    [
      %w(albums al bums),
      %w(weaver we aver),
      %w(tailor tail or),
      %w(tailor ta ilor)
    ]
  end

  it 'returns the correct result with the slow implementation' do
    results = WordPairing.slow words, target_words

    expect(results).to match_array solution # don't care about order
  end

  it 'returns the correct result with the fast implementation' do
    results = WordPairing.fast words, target_words

    expect(results).to match_array solution # don't care about order
  end
end
