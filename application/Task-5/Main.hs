module Main
    ( main
    ) where

-- Imports from standard libraries
import Data.ByteString.Lazy as DB.L        (hGetContents, writeFile)
import Data.Text                           (pack)
import Data.Text.IO                        (putStr)
import System.Directory                    (doesFileExist)
import System.IO                           (IOMode (ReadMode), openBinaryFile)
import Prelude                      hiding (putStr)
-- Imports from user libraries
import Codec.Text.IConv                    (convert)
-- Imports from my library
import HTML                                (wait)


headingsPath :: String
headingsPath = "resources/headings.txt"

main :: IO ()
main = do
    existence <- doesFileExist headingsPath
    if existence
    then do
        putStr $ pack "Headings file fetched, starting encode process...\n"
        handle  <- openBinaryFile headingsPath ReadMode
        content <- hGetContents handle
        let
            convertTo encoding = convert "UTF-8" encoding content
            cp866  = convertTo "CP866"
            cp1251 = convertTo "CP1251"
            koi8r  = convertTo "KOI8-R"
        DB.L.writeFile "resources/headings-CP866.txt" cp866
        DB.L.writeFile "resources/headings-CP1251.txt" cp1251
        DB.L.writeFile "resources/headings-KOI8-R.txt" koi8r
        putStr $ pack "Headings file encoded to CP866, CP1251 and KOI8-R!\n"
    else do
        putStr $ pack "Headings file doesn't exist, create it using Task-4 program...\n"
    wait
