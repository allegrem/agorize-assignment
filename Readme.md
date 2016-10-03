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

There are also some tests on the Words module, but there are anecdotal. They obviously depends on the wordlist.txt file, which does not make them reliable unit tests.

The *Execution time* displayed at the end of the program shows respectively in seconds the user CPU time, system CPU time, sum of user and system CPU times and elapsed real time. On my computer, I achieved the following speed (with the *fast* implementation): `0.080000   0.000000   0.080000 (  0.077739)`. The benchmark does not take into account the time spent reading the file and storing the words in an array in memory, nor the time displaying the results.


# Data Structure

In the *fast* implementation, I used a tree data structure to store the words and retrieve them efficiently. Each node has children identified (its label) by a letter, and a boolean (`end_of_word`) indicating if the node is at the end of a path forming a word.

To insert a new word in the tree, we start from the root, take the first letter of the word, and navigate to the node labeled with this letter (or create a new node with this label if it does not exist). Then we consider the second letter, and so on. The last node (which corresponds to the last letter of the word) is ultimately flagged as `end_of_word`, to indicate that the path leading to this node forms an existing word.

With this structure, we can efficiently find if a word exists (aka if there is an existing path of nodes leading to a final node flagged as `end_of_word`). For a given word, we can also easily find all the existing words formed by its *n* first characters (aka the nodes flagged as `end_of_word` on the path formed by the given word).


# Complexity Analysis

Let *n* be the number of words in the dictionary (in this exercise, with 6 letters or less). We also consider that *n ~ m*, where *m* is the number of words we want to split (in this exercise, with exactly 6 letters).

The *slow* implementation is extremely inefficient. We have three nested loops, which gives us a complexity of O(n^3) (cubic!!).

The *fast* implementation is much better. First we build the tree which is a linear operation O(n): we need to go through all the list, and one insert is constant time O(1) because we are bound by the maximum length of a word (6 letters here). Then we iterate on the words we want to split, and for every word, we perform a first search in the tree (`get_path` which is constant O(1), again because we are bound by the maximum length of a word) and at most 6 additional constant searches O(1) to find the ending sub-words. All in all, this operation is linear O(m) ~ O(n) (we perform *m* times constant operations). This makes the overall algorithm linear O(n).
