bmiTell :: Double -> Double -> String
bmiTell weight height
  | bmi <= 18.5 = "You are underweight,"
  | bmi <= 25.0 = "normal"
  | bmi <= 30.0 = "fatty"
  | otherwise   = "whale"
  where bmi = weight / height ^ 2

