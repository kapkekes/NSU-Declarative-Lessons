module           Main
    ( main
    ) where

import           HTML
    ( checkFile
    , taskOneWorker
    , taskTwoWorker
    )

import qualified Data.Text.IO     as DT.IO

main :: IO ()
main = do
    -- result <- taskOneWorker
    -- print result
    
    taskTwoWorker