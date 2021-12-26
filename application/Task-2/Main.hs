module Main
    ( main
    ) where

-- Imports from standard libraries
import           Control.Monad          (unless)
import qualified Data.Text.IO  as DT.IO (hPutStrLn, hGetLine)
import           System.IO              (IOMode (WriteMode), hIsEOF, openFile)
-- Imports from my library
import           HTML                   (getHandler, wait)

main :: IO ()
main = do
    inputHandler  <- getHandler
    outputHandler <- openFile "resources/thinned.html" WriteMode
    let
        lineSkip skipNext = do
            inputEnded <- hIsEOF inputHandler
            unless inputEnded $ do
                line <- DT.IO.hGetLine inputHandler
                unless skipNext $ DT.IO.hPutStrLn outputHandler line
                lineSkip (not skipNext)
    lineSkip False
    wait
