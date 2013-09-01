take' :: Int -> [a] -> [a]
take' n _
  | n <= 0 = []
take' n [] = []
take' n (x:xs) = x : take' (n-1) xs

