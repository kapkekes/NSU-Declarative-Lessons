{-# LANGUAGE QuasiQuotes, FlexibleContexts #-}

module Main
    ( main
    ) where

-- Imports from standard libraries
import qualified Data.Text.IO          as DT.IO (hPutStrLn, hGetContents)
import           System.IO                      (IOMode (WriteMode), openFile)
-- Imports from user libraries
import           Text.Regex.PCRE.Heavy          (Regex, re, scan)
-- Imports from my library
import           HTML                           (getHandler, wait)

linkRE :: Regex
linkRE = [re|href="(.*?)"|]

main :: IO ()
main = do
    inputHandler  <- getHandler
    outputHandler <- openFile "resources/links.txt" WriteMode
    content       <- DT.IO.hGetContents inputHandler
    let matches   =  scan linkRE content
    mapM_ (DT.IO.hPutStrLn outputHandler . head . snd) matches
    wait
