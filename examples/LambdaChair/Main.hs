{-# LANGUAGE CPP #-}
#if __GLASGOW_HASKELL__ >= 702 && __GLASGOW_HASKELL__ < 704
{-# LANGUAGE SafeImports #-}
#endif
#if __GLASGOW_HASKELL__ >= 704
{-# LANGUAGE Unsafe #-}
#endif
import LambdaChair
import DCLabel.PrettyShow

#if __GLASGOW_HASKELL__ >= 702
import safe AliceCode as Alice
import safe BobCode as Bob
#else
import AliceCode as Alice
import BobCode as Bob
#endif


main :: IO ()
main = printL . evalReviewDC $ do
  addUser "Alice" "password"
  
  p1 <- addPaper "Flexible Dynamic..."
  p2 <- addPaper "A Static..."
  
  addAssignment "Alice" p1
  addAssignment "Alice" p2
  
  asUser "Alice" $ Alice.mainReview
  
  addUser "Bob" "password"
  
  addAssignment "Bob" p2
  addConflict "Bob" p1

  asUser "Bob" $ Bob.mainReview
    where printL m = m >>= (putStrLn . prettyShow . snd)
