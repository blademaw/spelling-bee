import System.Environment ( getArgs )
import Data.List (nub, sort)

main :: IO ()
main = do
    [center:_, outer, inFile] <- getArgs
    wordList <- lines <$> readFile inFile
    -- wordList <- lines <$> readFile "out.txt"
    let valids = getValidWords center outer wordList
    putStrLn $ outputWords center outer valids
    displayMatrix (outputMatrixValids valids) (sort (nub (map head valids)))

-- TODO: change this to a func that returns a string, print in main
-- outputWords :: Char -> [Char] -> [String] -> String
outputWords center outer valids =
    "Valid words are:\n"
        ++ unlines (map ("\t" ++) valids)
    ++
    "\nPangrams are:\n"
        ++ unlines (map (\ p -> "\t" ++ (if isPerfectPangram' p then "* " else "  ") ++ p) (filter (isPangram center outer) valids))
    where
        -- valids = getValidWords center outer wordList
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

outputMatrixValids valids =
    [ [ length (filter (\ x -> length x == len) (startValids letter valids)) | len <- [4..maxLen] ] | letter <- letters ]
    where
        letters = sort (nub (map head valids))
        startValids letter = filter (\ x -> head x == letter)
        maxLen = maximum $ map length valids

testdisplay = displayMatrix [[2,0,1,2,0,0],[10,6,7,10,6,1],[1,1,0,1,0,0],[0,0,2,0,0,1],[1,1,0,1,0,0],[2,1,0,1,0,0]] "afgikn"

displayMatrix :: [[Int]] -> [Char] -> IO ()
displayMatrix matrix letters = do
  let maxLen = 3 + length (head matrix)
      pads dig = if length dig == 2 then " " else "  "
      sepMatr = foldr (\a b -> a ++ pads a ++ b) ""
      colLabels = map show [4..maxLen] ++ ["Σ"]
      rowLabels = map (:[]) letters
      header = "   " ++ sepMatr colLabels
      footer = "Σ" ++ "  " ++ sepMatr ([show (sum [(matrix !! i) !! j | i <- [0 .. length matrix - 1]]) |
                                          j <- [0 .. length (head matrix) - 1]])
                           ++ show (sum (map sum matrix))
      rowStrings = zipWith (\label row -> label ++ "  " ++ sepMatr (map show row) ++ show (sum row)) rowLabels matrix
  putStrLn header
  mapM_ putStrLn rowStrings
  putStrLn footer


-- purely for testing; 6 mar 2023
testValids = getValidWords 'f' "laking"


-- finding valids
isValid :: Char -> [Char] -> String -> Bool
isValid center outer word =
    center `elem` word && all (\ l -> l `elem` (center:outer)) word

getValidWords :: Char -> [Char] -> [String] -> [String]
getValidWords center outer = filter (isValid center outer)

-- pangrams
isPangram :: Char -> [Char] -> String -> Bool
isPangram center outer word = center `elem` word && sort (nub word) == sort (nub (center:outer))

isPerfectPangram :: Char -> [Char] -> String -> Bool
isPerfectPangram center outer word = sort word == sort (center:outer)