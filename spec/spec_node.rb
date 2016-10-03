require 'node'

RSpec.describe Node, '#insert' do
  before do
    @tree = Node.new
    @tree.insert 'abc'
  end

  it 'creates the different nodes if they do not exist' do
    expect(@tree.children.length).to eq 1
    expect(@tree.children).to have_key 'a'
    expect(@tree['a'].children.length).to eq 1
    expect(@tree['a'].children).to have_key 'b'
    expect(@tree['a']['b'].children.length).to eq 1
    expect(@tree['a']['b'].children).to have_key 'c'
  end

  it 'flags the last node' do
    expect(@tree['a']['b']['c'].end_of_word?).to be true
  end

  it 'does not duplicate existing node while inserting' do
    @tree.insert 'abd'

    expect(@tree.children.length).to eq 1
    expect(@tree['a'].children.length).to eq 1
    expect(@tree['a']['b'].children.length).to eq 2
  end

  it 'inserts correctly a word on an already existing path' do
    @tree.insert 'ab'

    expect(@tree['a']['b'].end_of_word?).to be true
  end
end

RSpec.describe Node, '#get_or_create' do
  before do
    @tree = Node.new
  end
  it 'creates a new node if it does not already exist' do
    @tree.get_or_create 'a'

    expect(@tree.children.length).to eq 1
  end

  it 'returns the existing node otherwise' do
    previous_node = @tree.get_or_create 'a'
    new_node = @tree.get_or_create 'a'

    expect(@tree.children.length).to eq 1
    expect(previous_node).to equal new_node # object identity
  end
end

RSpec.describe Node, '#get_path' do
  before do
    @tree = Node.new
    @tree.insert 'abc'
    @tree.insert 'ab'
  end

  it 'returns the path leading to the word' do
    expect(@tree.get_path('abc')).to eq [false, true, true]
  end

  it 'raises an exception if no path exists' do
    expect { @tree.get_path('abcd') }.to raise_error Node::NotFound
  end
end

RSpec.describe Node, '#exist?' do
  before do
    @words = %w(abc def abcd)
    @tree = Node.new
    @words.each { |w| @tree.insert w }
  end

  it 'finds existing words' do
    @words.each do |w|
      expect(@tree.exist?(w)).to be true
    end
    %w(a ab abcde ghi).each do |w|
      expect(@tree.exist?(w)).to be false
    end
  end
end
