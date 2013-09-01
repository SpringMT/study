calsBims :: [(Double, Double)] -> [Double]
calsBims xs = [bmi | (w,h) <- xs , bmi > 25.0, let bmi = w / h ^ 2]


