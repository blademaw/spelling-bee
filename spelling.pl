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
            member(Center, WordChars),
            subset(WordChars, Letters),
            length(WordChars, WordLength), % redundant if parsed file is already pruned
            WordLength >= 4 
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

perfect_pangram(Chars, Pangram) :-
    string_chars(Chars, Letters),
    string_chars(Pangram, PanChars),
    same_length(PanChars, Letters),
    sort(PanChars, SortedPan),
    sort(Letters, SortedPan).

find_perfect_pangrams(Chars, PerfectPangrams) :-
    findall(
        PerfectPangram,
        (
            find_pangrams(Chars, SortedPangrams),
            member(PerfectPangram, SortedPangrams),
            perfect_pangram(Chars, PerfectPangram)
        ),
        PerfectPangrams
    ).