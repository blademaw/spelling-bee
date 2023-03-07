import System.Environment ( getArgs )
import Data.List (nub, sort)

main :: IO ()
main = do
    ((center:_):outer:_) <- getArgs
    wordList <- lines <$> readFile "out.txt"
    outputWords center outer wordList

-- TODO: change this to a func that returns a string, print in main
outputWords :: Char -> [Char] -> [String] -> IO ()
outputWords center outer wordList =
    putStrLn $
        "Valid words are:\n"
            ++ unlines (map ("\t" ++) valids)
        ++
        "\nPangrams are:\n"
            ++ unlines (map (\ p -> "\t" ++ (if isPerfectPangram' p then "* " else "  ") ++ p) (filter (isPangram center outer) valids))
    where
        valids = getValidWords center outer wordList
        isPerfectPangram' = isPerfectPangram center outer

-- outputMatrix :: Char -> [Char] -> [String] -> IO ()
-- TODO: currently works but also give option of just providing valids via pattern matching
--       figure out way to add letters as row names, lens as colnames, summation, etc.
outputMatrix center outer wordList =
    [ [ length (filter (\ x -> length x == len) (startValids letter valids)) | len <- [4..maxLen] ] | letter <- letters ]
    where
        letters = sort (center:outer)
        valids = getValidWords center outer wordList
        startValids letter = filter (\ x -> head x == letter)
        maxLen = maximum $ map length valids


isValid :: Char -> [Char] -> String -> Bool
isValid center outer word =
    center `elem` word && all (\ l -> l `elem` (center:outer)) word

getValidWords :: Char -> [Char] -> [String] -> [String]
getValidWords center outer = filter (isValid center outer)

isPangram :: Char -> [Char] -> String -> Bool
isPangram center outer word = center `elem` word && sort (nub word) == sort (nub (center:outer))

isPerfectPangram :: Char -> [Char] -> String -> Bool
isPerfectPangram center outer word = sort word == sort (center:outer)