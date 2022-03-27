module Data.Forest.WithID
    -- Examples for testing
    ( nonNullID
    , oneNullID
    , twoNullID

    -- Task #2
    , divideByID

    -- Task #3
    , treeSum
    , printTreeSum

    -- Task #4.1
    , manualSimpleToID
    -- Task $4.2
    , stateSimpleToID

    -- Added these for more
    , runWriter
    , evalState
    ) where


import qualified Control.Monad.State     as S (MonadState (get, put), State,
                                               evalState)
import qualified Control.Monad.Writer    as W (MonadWriter (writer), Writer,
                                               runWriter, tell)
import           Data.Either             (isLeft)
import           Data.Forest             (BinaryTree (..))
import           Data.Functor.Arithmetic ((</*\>))
import           Data.List               (intersperse)


type Item = (Int, Double)
type IDTree = BinaryTree Item

nonNullID :: IDTree
nonNullID =
    Branch
        { l = Branch
            { l = Leaf (4, 21)
            , s = (2, 2.2)
            , r = Branch
                { l = Branch
                    { l = Leaf (100, 62)
                    , s = (7, 2)
                    , r = Leaf (200, 66)
                    }
                , s = (5,22)
                , r = Leaf (203,46)
                }
            }
        , s = (1, 1.1)
        , r = Branch
            { l = Leaf (301, 34)
            , s = (3, 3.3)
            , r = Leaf (307, 4)
            }
        }

oneNullID :: IDTree
oneNullID =
    Branch
        { l = Branch
            { l = Leaf (4, 21)
            , s = (2, 2.2)
            , r = Branch
                { l = Branch
                    { l = Leaf (100, 62)
                    , s = (7, 0)
                    , r = Leaf (200, 66)
                    }
                , s = (5,22)
                , r = Leaf (203,46)
                }
            }
        , s = (1, 1.1)
        , r = Branch
            { l = Leaf (301, 34)
            , s = (3, 3.3)
            , r = Leaf (307, 4)
            }
        }

twoNullID :: IDTree
twoNullID =
    Branch
        { l = Branch
            { l = Leaf (4, 21)
            , s = (2, 2.2)
            , r = Branch
                { l = Branch
                    { l = Leaf (100, 62)
                    , s = (7, 2)
                    , r = Leaf (200, 66)
                    }
                , s = (5,22)
                , r = Leaf (203,46)
                }
            }
        , s = (1, 1.1)
        , r = Branch
            { l = Leaf (301, 34)
            , s = (3, 0)
            , r = Leaf (307, 4)
            }
        }

divideByID :: Double -> IDTree -> Either String Double
divideByID n t = (n /) <$> treeProduct t

valueToEither :: Item -> Either String Double
valueToEither (id, 0) = Left $ "Null value in the node with ID " ++ show id
valueToEither (_, n)  = Right n

treeProduct :: IDTree -> Either String Double
treeProduct (Leaf sf) = valueToEither sf
treeProduct (Branch lt sf rt) = se </*\> le </*\> re
    where
        se = valueToEither sf
        le = treeProduct lt
        re = treeProduct rt

-- Yeah, I know that these functions have wrong type.
-- However, it's quite strange to store several messages in one string.
treeSum :: IDTree -> W.Writer [String] Double
treeSum (Leaf (si, sv)) = do
    W.tell ["Added node (ID = " ++ show si ++ ", value = " ++ show sv ++ ")"]
    return sv

treeSum (Branch lt (si, sv) rt) = do
    W.tell ["Added branch (ID = " ++ show si ++ ", value = " ++ show sv ++ ")"]
    lw <- treeSum lt
    rw <- treeSum rt
    return (sv + lw + rw)

runWriter :: W.Writer w a -> (a, w)
runWriter = W.runWriter

evalState :: S.State s a -> s -> a
evalState = S.evalState

-- Well, technically, this function uses runWriter, snd and putStr
printTreeSum :: IDTree -> IO ()
printTreeSum t = mapM_ putStr . intersperse ";\n" . (\res -> snd res `mappend` ["Sum of tree equals to " ++ show (fst res) ++ ".\n"]) . runWriter $ treeSum t


manualTransform :: Int -> BinaryTree Double -> (IDTree, Int)
manualTransform prevID (Leaf sf) = (Leaf (prevID, sf), prevID)
manualTransform prevID (Branch lt sf rt) = (Branch left (prevID, sf) right, stage_three)
    where
        stage_one = prevID
        (left, stage_two) = manualTransform (stage_one + 1) lt
        (right, stage_three) = manualTransform (stage_two + 1) rt

manualSimpleToID :: BinaryTree Double -> IDTree
manualSimpleToID = fst . manualTransform 1

stateSimpleToID :: BinaryTree Double -> S.State Int IDTree
stateSimpleToID (Leaf sf) = do
    nowID <- S.get
    S.put $ nowID + 1
    return $ Leaf (nowID, sf)

stateSimpleToID (Branch lt sf rt) = do
    nowID <- S.get
    S.put $ nowID + 1
    leftPart <- stateSimpleToID lt
    rightPart <- stateSimpleToID rt
    return $ Branch leftPart (nowID, sf) rightPart
