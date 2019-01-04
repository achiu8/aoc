import qualified Data.Set as S

parseInt :: String -> Int
parseInt ('+':n) = read n
parseInt n       = read n

changes :: IO [Int]
changes = readFile "01_input.txt" >>= return . map parseInt . lines

partOne :: IO Int
partOne = changes >>= return . sum

firstDuplicateSum :: S.Set Int -> Int -> [Int] -> Int
firstDuplicateSum seen acc (x:xs) =
  let next = acc + x
   in if S.member next seen
         then next
         else firstDuplicateSum (S.insert next seen) next xs

partTwo :: IO Int
partTwo = changes >>= return . firstDuplicateSum S.empty 0 . cycle

main :: IO ()
main = do
  partOne >>= print
  partTwo >>= print
