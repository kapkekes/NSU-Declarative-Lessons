module Data.Forest
    ( BinaryTree (..)
    ) where

data BinaryTree a = Leaf {s :: a} | Branch {l :: BinaryTree a, s :: a, r :: BinaryTree a}
    deriving (Show, Read)

instance Functor BinaryTree where
    fmap f (Leaf sf)         = Leaf $ f sf
    fmap f (Branch lt sf rt) = Branch {l = fmap f lt, s = f sf, r = fmap f rt}

instance Applicative BinaryTree where
    pure f = Leaf f
    (Leaf as) <*> (Leaf bs) = Leaf $ as bs
    (Leaf as) <*> (Branch bl bs br) = Branch (Leaf as <*> bl) (as bs) (Leaf as <*> br)
    (Branch bl bs br) <*> (Leaf as) = Branch (bl <*> Leaf as) (bs as) (br <*> Leaf as)
    (Branch al as ar) <*> (Branch bl bs br) = Branch (al <*> bl) (as bs) (ar <*> br)
