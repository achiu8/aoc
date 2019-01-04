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
  | f > 0     = moveRight f z'
  | otherwise = moveLeft f z'
  where z' = z { focus = f + 1, steps = s + 1 }

moveRight :: Int -> Zipper -> Zipper
moveRight 0 z = z
moveRight _ z@(Zipper _ _ [] _ _) = z { exited = True }
moveRight n (Zipper f ls (r:rs) s e) = moveRight (n-1) (Zipper r (f:ls) rs s e)

moveLeft :: Int -> Zipper -> Zipper
moveLeft 0 z = z
moveLeft _ z@(Zipper _ [] _ _ _) = z { exited = True }
moveLeft n (Zipper f (l:ls) rs s e) = moveLeft (n+1) (Zipper l ls (f:rs) s e)

step :: Zipper -> Int
step z =
  let z'@(Zipper _ _ _ s e) = move z
  in if e then s else step z'

solve :: [Int] -> Int
solve (f:rs) = step $ Zipper f [] rs 0 False

main = do
  print . solve . map read . lines =<< readFile "05_input.txt"
