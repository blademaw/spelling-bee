# spelling-bee

A lightweight program for solving the New York Times Spelling Bee.

## Usage
Load the `spelling.pl` predicate file in (SWI-)Prolog. To query word answers to the daily Spelling Bee, use

```prolog
?- find_words(Center, OuterLetters, Words).
```
where `Center` is the central character, `OuterLetters` is a string of the six surrounding letters.

For pangrams, since the center character is used by definition, `find_pangram/2` has the signature

```prolog
?- find_pangram(Letters, Pangrams).
```
and will find all accepted pangrams `Pangrams` using characters in the string `Letters`.

### Example usage
Below is the program run on today's (28th February 2023) characters: **A**, L, Y, K, R, D, W.

```prolog
?- find_pangrams("alykrdw", Pangrams).
Pangrams = [awkwardly].

?- find_words(a, "lykrdw", Words).
Words = [alar, alary, alky, alkyd, alkyl, allay, ally, allyl, alway, arak, array, arrayal, aryl, award, away, awkward, awkwardly, awry, dada, daddy, dally, dark, darkly, darky, dawk, draw, drawl, drawly, dray, dryad, drywall, dyad, kaka, kayak, kraal, kyak, kyar, lady, laky, lall, lard, lardy, lark, larky, layaway, lyard, radar, rally, rawly, raya, waddly, waddy, wady, walk, walkaway, walkway, wall, walla, wally, waly, ward, wark, wary, wawl, waylay, wayward, waywardly, yald, yard, yawl].
```

### Specifying a custom dictionary
The word list supplied is sourced from an official word list for Scrabble (see references) and performs well, although it tends to be overly-exhaustive for the Spelling Bee.

If you'd alternatively like to use your own word list, you first need to parse the dictionary to create the predicate word list `parsedWords.pl`. This is done by running
```bash
$ ./process_dictionary.py file
```
where `file` is a text file of words delimited by line breaks.

## References
 * [wordgamedictionary.com](https://www.wordgamedictionary.com/dictionary/) for the [TWL06 Scrabble Word List](https://www.wordgamedictionary.com/twl06/)