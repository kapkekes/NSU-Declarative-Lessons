module Second
    ( main
    ) where

import qualified HTML                       ( getHandler
                                            , wait
                                            )
import           System.IO                  ( IOMode (WriteMode)
                                            , hIsEOF
                                            , openFile
                                            , stdout
                                            )
import qualified Data.Text.IO   as DT.IO    ( hPutStrLn
                                            , hGetLine
                                            )
import           Control.Monad              ( unless
                                            )

main :: IO ()
main = do
    inputHandler  <- HTML.getHandler
    outputHandler <- openFile "thinned.html" WriteMode
    let
        lineSkip skipNext = do
            inputEnded <- hIsEOF inputHandler
            unless inputEnded $ do
                line <- DT.IO.hGetLine inputHandler
                unless skipNext $ DT.IO.hPutStrLn outputHandler line
                lineSkip (not skipNext)
    lineSkip True
    HTML.wait