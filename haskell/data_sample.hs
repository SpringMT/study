import Data.List
import Data.Char

numUniques :: (Eq a) => [a] -> Int
numUniques = length . nub

wordsNums :: String -> [(String, Int)]
--wordsNums text = map (\xs -> (head xs, length xs))(group(sort(words text)))
wordsNums = map (\xs -> (head xs, length xs)) . group . sort . words

encode :: Int -> String -> String
--encode offset msg = map (\x -> chr $ ord x + offset) msg
encode offset msg = map (chr . (+offset) . ord) msg

decode :: Int -> String -> String
decode offset msg = encode (negate offset) msg

--fn :: (Eq a) => [a] -> [a]-> Bool
--fn haystack needle = any (`isPrefixOf` needle)  (tails haystack)

digitSum :: Int -> Int
digitSum = sum . map (digitToInt) . show

findNA :: Maybe Int
findNA  = find (\x -> digitSum x == 40 ) [1..]
