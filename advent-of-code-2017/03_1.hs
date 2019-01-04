import Control.Arrow ((&&&))

find :: (a -> Bool) -> [a] -> a
find p (x:xs) = if p x then x else find p xs

dec :: Int -> [Int]
dec n = [n,n-1..0]

patt :: Int -> [Int]
patt n = dec n ++ [1..n-1]

base :: Int -> Int
base = (^ 2) . succ . (* 2)

layer :: Int -> Int
layer n = find (\i -> base i >= n) [0..]

solve :: Int -> Int
solve n =
  let l = layer n
      x = snd . find ((== n) . fst) . uncurry zip . ((dec . base) &&& (cycle . patt)) $ l
  in l + x

main = do
  print $ solve 325489
