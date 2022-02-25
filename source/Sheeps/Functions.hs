module Sheeps.Functions
    ( selectedBarans
    , grandfather
    , grandgrandfather
    , parents
    , grandparents
    , isOrphan
    , selectedFather
    ) where

import           Data.Maybe (catMaybes, fromJust, isNothing)
import           Sheeps     (Sheep, father, mother)

selectedBarans :: [Sheep]
selectedBarans = ["i3", "i5", "i6", "i9", "i12"]

grandfather :: Sheep -> Maybe Sheep
grandfather s = mother s >>= father

grandgrandfather :: Sheep -> Maybe Sheep
grandgrandfather s = grandfather s >>= father

parents :: Sheep -> [Sheep]
parents s = catMaybes [father s, mother s]

grandparents :: Sheep -> [Sheep]
grandparents = concatMap parents . parents

isOrphan :: Sheep -> Bool
isOrphan = null . parents

selectedFather :: Sheep -> Maybe Sheep
selectedFather s
    | fromJust f `elem` selectedBarans = f
    | otherwise = Nothing
    where
        f = father s

selectedMale :: Sheep -> Maybe Sheep
selectedMale s
    | isNothing f = Nothing
    | fromJust f `elem` selectedBarans = f
    | otherwise = selectedMale . fromJust $ f
    where
        f = father s
