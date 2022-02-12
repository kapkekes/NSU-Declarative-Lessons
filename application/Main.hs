module Main
    ( main
    ) where

import           Control.Monad    (forM_, unless, when)
import           Humanity         (Person, PrettyShow (prettyShow),
                                   gravityFallsDipper, myCat, spaceWTF)
import           System.Directory (createDirectory, doesDirectoryExist,
                                   doesFileExist)
import           System.IO        (Handle, IOMode (ReadMode, WriteMode), hClose,
                                   hGetContents, hPrint, hPutStrLn, openFile)


-- Paths
outputFolder :: String
outputFolder = "output"

showPath :: String
showPath = "output/showDemonstration.txt"

prettyShowPath :: String
prettyShowPath = "output/prettyShowDemonstration.txt"

readPath :: String
readPath = "resources/readCheck.txt"


-- Example to test "Show" and "PrettyShow"
persons :: [Person]
persons = [gravityFallsDipper, myCat, spaceWTF]


-- Actual functions

-- Print list of strings to given handle
hPutStrS :: Handle -> [String] -> IO ()
hPutStrS handle = mapM_ (hPutStrLn handle)

-- Split list by given divider
-- (very ineffective, should be rewritten)
split :: (Eq a) => a -> [a] -> [[a]]
split _ [] = [[]]
split divider list = reverse . remove $ splitter divider [] list
    where
        splitter d ne [] = [reverse ne]
        splitter d ne (n: ns)
            | d == n = reverse ne: splitter d [] ns
            | otherwise = splitter d (n: ne) ns

        remove []       = []
        remove ([]: ns) = remove ns
        remove (n: ns)  = n: remove ns

-- Main function
main :: IO ()
main = do
    -- Create output folder
    outputDirectory <- doesDirectoryExist outputFolder
    unless outputDirectory $ createDirectory outputFolder

    -- Check "Show" instance
    showDemo <- openFile showPath WriteMode
    hPutStrS showDemo $ map show persons
    hClose showDemo

    -- Check "PrettyShow" instance
    prettyShowDemo <- openFile prettyShowPath WriteMode
    hPutStrS prettyShowDemo $ map prettyShow persons
    hClose prettyShowDemo

    -- Check "Read" instance
    resourcesDirectory <- doesFileExist readPath
    if resourcesDirectory
        then do
            readDemo <- openFile readPath ReadMode
            oneLongString <- hGetContents readDemo
            let parsed = [read person :: Person | person <- split '\n' oneLongString]
            forM_ parsed $ putStrLn . (++) "Found an function: " . show
        else
            putStrLn "Error: can't find resources folder to get file for \"Read\" check"
