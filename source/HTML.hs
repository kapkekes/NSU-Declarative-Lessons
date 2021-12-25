module HTML
    ( checkPath
    , getHandler
    , wait
    ) where

import qualified System.Directory      as SD
import qualified Data.Text             as DT
import qualified Data.Text.IO          as DT.IO

import           Control.Monad
    ( unless
    )

import           System.IO
    ( Handle
    , IOMode (ReadMode)
    , IOMode (WriteMode)
    , hFlush
    , hIsEOF
    , getChar
    , openFile
    , stdout
    )


cHTML :: DT.Text
cHTML = DT.pack ".html"

cXHTML :: DT.Text
cXHTML = DT.pack ".xhtml"

checkPath :: DT.Text -> IO Bool
checkPath probableFile =
    let
        html = DT.takeEnd 5 probableFile == cHTML
        xhtml = DT.takeEnd 6 probableFile == cXHTML
    in do
        existence <- SD.doesFileExist (DT.unpack probableFile)
        return $ existence && (html || xhtml)

getHandler :: IO Handle
getHandler = do
    putStr "Write path to existing .html or .xhtml file -> "
    hFlush stdout
    candidate   <- DT.IO.getLine
    correctness <- checkPath candidate
    if correctness
    then
        openFile (DT.unpack candidate) ReadMode
    else
        getHandler

wait :: IO ()
wait = do
    putStr "Program execution finished. Press Enter to exit..."
    hFlush stdout
    char <- getChar
    putStr ""
