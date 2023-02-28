#!/usr/bin/env python3

import sys # for indicating file

# function to process & output supplied dictionary to Prolog predicate file.
def parse_dictionary(file, fileOut="parsedWords.pl"):
    # load the words
    with open(file, 'r') as f:
        words = f.read().split("\n")
    assert len(words) > 0

    words = [word for word in words if len(word) >= 4] # axe short words
    words = map(lambda word: f"word({word}).", words)  # add predicate language

    # write to file
    with open(fileOut, 'w+') as fO:
        fO.write("\n".join(words))

if __name__ == "__main__":
    assert len(sys.argv) > 1, "Need to supply file to read from."
    parse_dictionary(sys.argv[1])
