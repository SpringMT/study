import Data.Char
import qualified Data.Map as Map
--findKey :: (Eq k) => k -> [(k, v)] -> v
--findKey key list = snd . head . filter ( \(k, v) -> k == key) $ list
findKey :: (Eq k) => k -> [(k, v)] -> Maybe v
findKey key list = foldl (\acc (x, y) -> if key == x then Just y else acc ) Nothing list

phoneBookToMap :: (Ord k) => [(k, String)] -> Map.Map k String
phoneBookToMap xs = Map.fromListWith add xs
  where add number1 number2 = number1 ++ ", " ++ number2


