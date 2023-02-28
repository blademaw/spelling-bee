% Load valid English words
:- [parsedWords].

/* Predicate that holds when all possible words are defined with a center
   character & outer letters */
find_words(Center, String, ValidWords) :-
    string_chars(String, OuterLetters),
    append([Center], OuterLetters, Letters),
    findall(
        Word, 
        (
            word(Word),
            string_chars(Word, WordChars),
            subset(WordChars, Letters),
            member(Center, WordChars),
            length(WordChars, WordLength), 
            WordLength >= 4 % redundant if parsed file is already pruned
        ),
        Words),
    sort(Words, ValidWords).

/* Pangram — holds when SortedPangrams contains all pangrams of characters
  within dictionary (not necessarily 'perfect' pangrams) */
find_pangrams(Chars, SortedPangrams) :-
    string_chars(Chars, Letters),
    findall(
        Pangram,
        (
            word(Pangram),
            string_chars(Pangram, PanChars),
            sort(PanChars, SortedLetters),
            sort(Letters, SortedLetters)
        ),
        Pangrams),
    sort(Pangrams, SortedPangrams).
