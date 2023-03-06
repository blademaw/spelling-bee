import System.Environment ( getArgs )
import Data.List (nub, sort)

main :: IO ()
main = do
    ((center:_):outer:_) <- getArgs
    wordList <- lines <$> readFile "out.txt"
    putStrLn $ "Valid words are:\n" ++
        unlines (map ("\t" ++) (getValidWords center outer wordList))
    putStrLn $ "Pangrams are:\n" ++
        unlines (map ("\t" ++) (filter (isPangram center outer) wordList))

isValid :: Char -> [Char] -> String -> Bool
isValid center outer word =
    center `elem` word && all (\ l -> l `elem` (center:outer)) word

getValidWords :: Char -> [Char] -> [String] -> [String]
getValidWords center outer wordList = filter (isValid center outer) wordList

isPangram :: Char -> [Char] -> String -> Bool
isPangram center outer word = center `elem` word && sort (nub word) == sort (nub (center:outer))