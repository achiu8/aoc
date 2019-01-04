data Zipper = Zipper
  { focus :: Int
  , left :: [Int]
  , right :: [Int]
  , steps :: Int
  , exited :: Bool
  } deriving (Show)

move :: Zipper -> Zipper
move z@(Zipper 0 _ _ s _) = z { focus = 1, steps = s + 1 }
move z@(Zipper f ls rs s e)
  | f >= 3    = moveRight f $ z { focus = f - 1, steps = s + 1 }
  | f > 0     = moveRight f z'
  | otherwise = moveLeft (-f) z'
  where z' = z { focus = f + 1, steps = s + 1 }

moveRight :: Int -> Zipper -> Zipper
moveRight 0 z = z
moveRight n z@(Zipper f ls rs s e)
  | n > length rs = z { exited = True }
  | otherwise     = z { focus = f', left = shift ++ [f] ++ ls, right = rs' }
  where (f':shift) = reverse $ take n rs
        rs'        = drop n rs

moveLeft :: Int -> Zipper -> Zipper
moveLeft 0 z = z
moveLeft n z@(Zipper f ls rs s e)
  | n > length ls = z { exited = True }
  | otherwise     = z { focus = f', left = ls', right = shift ++ [f] ++ rs }
  where (f':shift) = reverse $ take n ls
        ls'        = drop n ls

step :: Zipper -> Int
step z =
  let z'@(Zipper _ _ _ s e) = move z
  in if e then s else step z'

solve :: [Int] -> Int
solve (f:rs) = step $ Zipper f [] rs 0 False

main = do
  print . solve . map read . lines =<< readFile "05_input.txt"
