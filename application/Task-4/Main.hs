{-# LANGUAGE QuasiQuotes, FlexibleContexts #-}

module Main
    ( main
    ) where

import qualified HTML                               ( getHandler
                                                    , wait
                                                    )
import           System.IO                          ( IOMode (WriteMode)
                                                    , hIsEOF
                                                    , openFile
                                                    , stdout
                                                    )
import qualified Data.Text.IO           as DT.IO    ( hPutStrLn
                                                    , hGetLine
                                                    , hGetContents
                                                    )
import           Control.Monad                      ( unless
                                                    )
import           Text.Regex.PCRE.Heavy              ( Regex
                                                    , re
                                                    , scan
                                                    )


-- I really don't like this RE, but I just don't know, how to make lazy quantifier for word 
headingRE :: Regex
headingRE = [re|<[hH][1-6]>(.*?)<?/?[hH]?[1-6]?>|]

main :: IO ()
main = do
    inputHandler  <- HTML.getHandler
    outputHandler <- openFile "resources/headings.txt" WriteMode
    content       <- DT.IO.hGetContents inputHandler
    let matches   =  scan headingRE content
    mapM_ (DT.IO.hPutStrLn outputHandler . head . snd) matches
    HTML.wait
