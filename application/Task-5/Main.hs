{-# LANGUAGE QuasiQuotes, FlexibleContexts #-}

module Main
    ( main
    ) where
{-
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
-}
import qualified Data.ByteString.Lazy as L
import qualified System.IO as S
import qualified Codec.Text.IConv as IConv
import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.Encoding as TE
import qualified Data.Text.Lazy.IO as TLIO

main :: IO ()
main = do
    openhandle <- S.openFile "test.txt" S.ReadMode
    writehandle <- S.openFile "testUp.txt" S.WriteMode
    S.hSetEncoding writehandle S.utf8
    contents <- L.hGetContents openhandle
    let convcont = IConv.convert "CP1251" "UTF-8" contents
    let readystr = TE.decodeUtf8 convcont
    TLIO.hPutStr writehandle (T.toUpper readystr)
    S.hClose openhandle
    S.hClose writehandle