% Load valid English words
:- [parsedWords].

% find_words(+Center, +String, -ValidWords)
% Center is the center letter (as an atom), String is a string of all outer
% letters (in any order), ValidWords is the set of all valid words.
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
            length(WordChars, WordLength), % redundant if already pruned
            WordLength >= 4 
        ),
        Words),
    sort(Words, ValidWords).


% find_pangrams(+Chars, -SortedPangrams)
% Chars is a string of all letters (outer + inner) exactly once, and
% SortedPangrams is the set of all pangrams resulting from Chars.
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


% perfect_pangram(+Chars, +Pangram)
% Holds if Pangram is a string that is just a reordering of the string Chars.
perfect_pangram(Chars, Pangram) :-
    string_chars(Chars, Letters),
    string_chars(Pangram, PanChars),
    same_length(PanChars, Letters),
    sort(PanChars, SortedPan),
    sort(Letters, SortedPan).


% find_perfect_pangrams(+Chars, -PerfectPangrams)
% PerfectPangrams is the set of all pangrams of the string of letters Chars
% that use each letter exactly once.
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