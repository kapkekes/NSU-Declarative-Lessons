module Main
    ( main
    ) where

-- Imports from standard libraries
import qualified Data.Text    as DT    (count, pack)
import qualified Data.Text.IO as DT.IO (hGetContents)
-- Imports from my library
import           HTML                  (getHandler, wait)

main :: IO ()
main = do
    inputHandler <- getHandler
    content      <- DT.IO.hGetContents inputHandler
    putStr          "Quantity of opening angle brackets is: "
    print        $  DT.count (DT.pack "<") content
    wait