# Get running

Install the required gems:
```
$ bundle install --binstubs
```

Run the program and run the tests:
```
$ ruby main.rb
$ bin/rspec spec/*
```

To test the slow version (*really* slow!!), invert the comments in `main.rb`:
```ruby
results = WordPairing.slow words, six_letters
# results = WordPairing.fast words, six_letters
```

# Comments on the code

I wrote tests for the most critical part of the code, which is the Node class. They do not fully cover all the class, but it was more than enough to give me confidence on the important methods (insertion and search). It also allowed me to TDD these methods.

There are also some tests on the Words module, but there are anecdotal. They obviously depend on the *wordlist.txt* file, which does not make them reliable unit tests.

The *Execution time* displayed at the end of the program shows respectively in seconds the user CPU time, the system CPU time, the sum of the user and the system CPU times and the elapsed real time. On my computer, I achieved the following speed (with the *fast* implementation): `0.080000   0.000000   0.080000 (  0.077739)`. The benchmark does not take into account the time spent reading the file and storing the words in an array in memory, nor the time displaying the results.


# Data Structure

In the *fast* implementation, I used a tree data structure to store the words and retrieve them efficiently. Each node has children identified by a letter (its label), and a boolean (`end_of_word`) indicating if the node is at the end of a path forming a word.

To insert a new word in the tree, we start at the root, take the first letter of the word, and find among the root's children the node labeled with this letter (or create a new node with this label if it does not already exist). Then we consider this new node and the second letter, and so on. The last node (which corresponds to the last letter of the word) is ultimately flagged as `end_of_word`, indicating that the path leading to this node forms an existing word.

With this structure, we can efficiently find if a word exists (aka if there is an existing path of nodes leading to a final node flagged as `end_of_word`). For a given word, we can also easily find all the existing words formed by its *n* first characters (aka the nodes flagged as `end_of_word` on the path formed by the given word).


# Complexity Analysis

Let *n* be the number of words in the dictionary (in this exercise, with 6 letters or less). We also consider that `n ~ m`, where *m* is the number of words we want to split (in this exercise, the words with exactly 6 letters).

The *slow* implementation is extremely inefficient. We have three nested loops, which gives us a complexity of `O(n^3)` (cubic!!).

The *fast* implementation is much better. Before we start, we can observe that all operations (insertion and search) on the tree are constant `O(1)`, because the depth of the tree is bound by the maximum number of letters of a word (6 in this exercise). First we build the tree which is a linear operation `O(n)`: we need to go through all the list and perform insertions which are constant time `O(1)`. Then we iterate on the words we want to split (the 6-letter words) and for every word, we perform a first search in the tree (`get_path`) and at most 6 additional searches to find the ending sub-words. So we have a bound number of searches which are constant time `0(1)`, as a consequence, this loop is linear `O(m) ~ O(n)`. This makes the overall algorithm linear `O(n)` (much much faster!!).
