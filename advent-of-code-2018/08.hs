import Data.Foldable (fold)

data Tree a = Leaf a | Node a [Tree a] deriving (Show)

instance Foldable Tree where
  foldMap f (Leaf a) = f a
  foldMap f (Node a children) = f a `mappend` foldMap (foldMap f) children

input :: IO [Int]
input = readFile "08_input.txt" >>= return . map read . words

parse :: Int -> [Int] -> ([Tree [Int]], [Int])
parse 1 (0:m:rest) = ([Leaf (take m rest)], drop m rest)
parse 1 (c:m:rest) =
  let (children, rem) = parse c rest
   in ([Node (take m rem) children], drop m rem)
parse n rest =
  let (child, rem) = parse 1 rest
      (children, rem') = parse (n-1) rem
   in (child ++ children, rem')

tree :: [Int] -> Tree [Int]
tree = head . fst . parse 1

partOne :: IO Int
partOne = input >>= return . sum . fold . tree

value :: Tree [Int] -> Int
value (Leaf a) = sum a
value (Node a children) = sum . map f $ a
  where f i = if i <= length children then value (children !! (i - 1)) else 0

partTwo :: IO Int
partTwo = input >>= return . value . tree

main :: IO ()
main = do
  partOne >>= print
  partTwo >>= print
