module Humanity -- and cats
    ( Person -- I don't export constructor because outer constuctor function exists
        ( name
        , age
        , weight
        )
    , PrettyShow
        ( prettyShow
        )
    , identifyPerson
    , gravityFallsDipper
    , myCat
    , spaceWTF
    ) where


-- Show in Haskell is much more like __repr__ in Python
-- PrettyShow will play role of __str__
-- For logic reasons, "PrettyShow" requires existence of "Show" instance
class (Show a) => PrettyShow a where
    { prettyShow :: a -> String
    }

-- As I understand, creating instances of "Show" and "Read"
-- via "deriving" keyword will create Haskell-correct instances
data Person = Person
    { name   :: String
    , age    :: Int
    , weight :: Double
    } deriving (Eq, Show, Read)

instance PrettyShow Person where
    prettyShow (Person n a w) = n ++ year a ++ "and weighs " ++ show w ++ " kg"
        where
            year b
                | b < 0     = " is kinda strange entity "
                | b == 0    = " was born less than a year ago "
                | otherwise = " is " ++ show b ++ " years old "

identifyPerson :: String -> Int -> Double -> Person
identifyPerson n a w
    | a < 0     = error "Age must be non-negative!"
    | w <= 0    = error "Weight must be positive!"
    | otherwise = Person n a w

gravityFallsDipper :: Person
gravityFallsDipper = Person
    { name   = "Dipper Pines"
    , age    = 12
    , weight = 38.9
    }

myCat :: Person -- He is a very cool kitten, who, sometimes, 
                -- does incredible things. He deserves a function.
myCat = Person
    { name   = "Levontiy"
    , age    = 0
    , weight = 1.4
    }

spaceWTF :: Person -- Just for an example
spaceWTF = Person   
    { name   = "Abracadabra"
    , age    = -99999
    , weight = 0
    }
