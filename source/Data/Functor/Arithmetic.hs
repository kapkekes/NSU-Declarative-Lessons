module Data.Functor.Arithmetic
    ( functorAddition
    , functorSubtraction
    , functorMultiplication
    , functorDivision
    , (</+\>)
    , (</-\>)
    , (</*\>)
    , (</:\>)
    ) where


pattern :: (Applicative f, Num a) => (a -> a -> a) -> f a -> f a -> f a
pattern f a b = f <$> a <*> b

functorAddition :: (Applicative f, Num a) => f a -> f a -> f a
functorAddition = pattern (+)
(</+\>) :: (Applicative f, Num a) => f a -> f a -> f a
(</+\>) = functorAddition

functorSubtraction :: (Applicative f, Num a) => f a -> f a -> f a
functorSubtraction = pattern (-)
(</-\>) :: (Applicative f, Num a) => f a -> f a -> f a
(</-\>) = functorSubtraction

functorMultiplication :: (Applicative f, Num a) => f a -> f a -> f a
functorMultiplication = pattern (*)
(</*\>) :: (Applicative f, Num a) => f a -> f a -> f a
(</*\>) = functorMultiplication

functorDivision :: (Applicative f, Fractional a) => f a -> f a -> f a
functorDivision = pattern (/)
(</:\>) :: (Applicative f, Fractional a) => f a -> f a -> f a
(</:\>) = functorDivision
