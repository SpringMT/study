elem' :: (Eq a) => a -> [a] -> Bool
elem' _ [] = False
elem' target (x:xs)
  | target == x = True
  | otherwise = elem' target xs


