sum35 :: Integer -> Integer
sum35 num = sum( takeWhile (<= num) (filter (\x -> (x `mod` 3) == 0 || (x `mod` 5) == 0) [1..]) )

primenumJudge :: Integer -> Bool
primenumJudge num = length( takeWhile (< num) ( filter (\x -> (num `mod` x) == 0) [1..] ) ) == 1

primenum :: Integer -> [Integer]
primenum num = takeWhile(<= num) ( filter (primenumJudge) [1..] )

primenumSum :: Integer -> Integer
primenumSum num = sum (takeWhile(<= num) ( filter (primenumJudge) [1..] ) )

fizzbuzz :: Integer -> [String]
fizzbuzz n = reverse $ fizzbuzz_judge n
  where
    fizzbuzz_judge :: Integer -> [String]
    fizzbuzz_judge x
      | x            == 0 = []
      | (x `mod` 15) == 0 = "fizzbuzz":fizzbuzz_judge (x-1)
      | (x `mod` 3)  == 0 = "fizz":fizzbuzz_judge (x-1)
      | (x `mod` 5)  == 0 = "buzz":fizzbuzz_judge (x-1)
      | otherwise         = show(x):fizzbuzz_judge (x-1)

max' :: [Integer] -> Integer
max' [] = 0
max' (x:xs) = max x (max' xs)

range_stream :: Integer -> [Integer] -> Integer -> [Integer]
range_stream n [] = n [n]
range_stream n [a] = (max' [n,a]) [a,n]
range_stream n [a,b] = (max' [n,a,b]) [a,b,n]
range_stream n [a,b,c] = (max' [n,a,b,c]) [a,b,c,n]
range_stream n [a,b,c,d] = (max' [n,b,c,d]) [b,c,d,n]


--rangemax [Integer] -> [Integer]
--rangemax [] = []
--rangemax stream = 
--  where 





