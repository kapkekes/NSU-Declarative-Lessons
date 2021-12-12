module           HTML
    ( checkFile
    , countOpeningAngleBracketsInFile
    , taskOneWorker
    , taskTwoWorker
    ,
    ) where

import qualified System.Directory   as SD
import qualified Data.Text          as DT
import qualified Data.Text.IO       as DT.IO

import           Control.Monad
    ( when, unless
    )

import           System.IO
    ( openFile
    , IOMode (ReadMode)
    , IOMode (WriteMode)
    , stdout
    , hFlush
    , hIsEOF
    )


constantHTML :: DT.Text
constantHTML = DT.pack ".html"

constantXHTML :: DT.Text
constantXHTML = DT.pack ".xhtml"

takeBack :: Int -> DT.Text -> DT.Text
takeBack quantity text = DT.reverse $ DT.take quantity $ DT.reverse text

checkFile :: DT.Text -> IO Bool
checkFile probableFile =
    let
        html = takeBack 5 probableFile == constantHTML
        xhtml = takeBack 6 probableFile == constantXHTML
    in do
        existance <- SD.doesFileExist (DT.unpack probableFile)
        return $ existance && (html || xhtml)

countOpeningAngleBracketsInFile :: DT.Text -> IO Int
countOpeningAngleBracketsInFile path = do
    handler <- openFile (DT.unpack path) ReadMode
    content <- DT.IO.hGetContents handler
    return $ DT.count (DT.pack "<") content

taskOneWorker :: IO Int
taskOneWorker = do
    putStr "Write path to existing .html or .xhtml file -> "
    hFlush stdout
    path        <- DT.IO.getLine
    correctness <- checkFile path
    if correctness
    then
        countOpeningAngleBracketsInFile path
    else
        taskOneWorker

taskTwoWorker :: IO ()
taskTwoWorker = do
    putStr "Write path to existing .html or .xhtml file -> "
    hFlush stdout
    path        <- DT.IO.getLine
    correctness <- checkFile path
    if correctness
    then do
        inputHandler  <- openFile (DT.unpack path)      ReadMode
        outputHandler <- openFile "output//second.html" WriteMode
        let
            lineSkip skipNext = do
                inputEnded <- hIsEOF inputHandler
                unless inputEnded $ do
                    line <- DT.IO.hGetLine inputHandler
                    unless skipNext $ DT.IO.hPutStrLn outputHandler line
                    lineSkip (not skipNext)
        lineSkip True
    else
        taskTwoWorker

test :: IO ()
test = do
    getChar >>= print
    print =<< getChar 