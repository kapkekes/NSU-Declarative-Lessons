module Data.Forest.Simple
    -- Examples for testing
    ( nonNullSimple
    , nullSimple

    -- Task #1
    , divideBySimple
    ) where


import           Data.Forest             (BinaryTree (..))
import           Data.Functor.Arithmetic ((</*\>))


nonNullSimple :: BinaryTree Double
nonNullSimple =
    Branch
        { l = Branch
            { l = Leaf 21
            , s = 2.2
            , r = Branch
                { l = Branch
                    { l = Leaf 62
                    , s = 43
                    , r = Leaf 66
                    }
                , s = 22
                , r = Leaf 46
                }
            }
        , s = 1.1
        , r = Branch
            { l = Leaf 34
            , s = 3.3
            , r = Leaf 35
            }
        }

nullSimple :: BinaryTree Double
nullSimple =
    Branch
        { l = Branch
            { l = Leaf 21
            , s = 2.2
            , r = Branch
                { l = Branch
                    { l = Leaf 62
                    , s = 0
                    , r = Leaf 66
                    }
                , s = 22
                , r = Leaf 46
                }
            }
        , s = 1.1
        , r = Branch
            { l = Leaf 34
            , s = 3.3
            , r = Leaf 35
            }
        }

divideBySimple :: Double -> BinaryTree Double -> Maybe Double
divideBySimple n t = (n /) <$> treeProduct t

numToMaybe :: (Eq a, Num a) => a -> Maybe a
numToMaybe 0 = Nothing
numToMaybe n = Just n

treeProduct :: BinaryTree Double -> Maybe Double
treeProduct (Leaf sf) = numToMaybe sf
treeProduct (Branch lt sf rt) = treeProduct lt </*\> numToMaybe sf </*\> treeProduct rt
