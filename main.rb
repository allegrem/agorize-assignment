require_relative './lib/word_pairing'
require_relative './lib/words'
require 'benchmark'

words, six_letters = Words.load_words

results = {}
benchmark = Benchmark.measure do
  # results = WordPairing.slow words, six_letters
  results = WordPairing.fast words, six_letters
end

results.each do |k, v|
  puts "#{k} = #{v.first} + #{v.last}"
end

puts
puts 'Combinations found: ' + results.length.to_s
puts 'Execution time: ' + benchmark.to_s
