niceGreeting :: String
niceGreeting = "Hello! So very nice."

badGreeting :: String
badGreeting  = "Pfft It's you"

greet :: String -> String
greet "Juan" = niceGreeting ++ " Juan"
greet "Fernando" = niceGreeting ++ " Fernando"
greet name = badGreeting ++  " " ++ name

