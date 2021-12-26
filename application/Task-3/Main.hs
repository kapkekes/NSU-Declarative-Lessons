{-# LANGUAGE QuasiQuotes, FlexibleContexts #-}

module Main
    ( main
    ) where

import qualified HTML                               ( getHandler
                                                    , wait
                                                    )
import           System.IO                          ( IOMode (WriteMode)
                                                    , openFile
                                                    )
import qualified Data.Text.IO           as DT.IO    ( hPutStrLn
                                                    , hGetContents
                                                    )
import           Text.Regex.PCRE.Heavy              ( Regex
                                                    , re
                                                    , scan
                                                    )

linkRE :: Regex
linkRE = [re|href="(.*?)"|]

main :: IO ()
main = do
    inputHandler  <- HTML.getHandler
    outputHandler <- openFile "resources/links.txt" WriteMode
    content       <- DT.IO.hGetContents inputHandler
    let matches   =  scan linkRE content
    mapM_ (DT.IO.hPutStrLn outputHandler . head . snd) matches
    HTML.wait
