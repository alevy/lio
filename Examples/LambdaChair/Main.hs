import LIO.LIO
import LambdaChair

import AliceCode as Alice
import BobCode as Bob

main = evalReviewDC $ do
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