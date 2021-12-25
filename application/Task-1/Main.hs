module Main
    ( main
    ) where

import qualified HTML                       ( getHandler
                                            , wait
                                            )
import qualified Data.Text      as DT       ( count
                                            , pack
                                            )
import qualified Data.Text.IO   as DT.IO    ( hGetContents
                                            , putStrLn
                                            )
import           Control.Monad              ( unless
                                            )

main :: IO ()
main = do
    inputHandler    <- HTML.getHandler
    content         <- DT.IO.hGetContents inputHandler
    putStr             "Quantity of opening angle brackets is: "
    print           $  DT.count (DT.pack "<") content
    HTML.wait