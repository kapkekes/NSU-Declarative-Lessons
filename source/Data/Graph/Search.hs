{-# LANGUAGE TemplateHaskell #-}

module Data.Graph.Search
    -- Graph from the picture
    ( exampleGraph

    --Algorith itself
    , breadthFirst

    -- Converter to Tree
    , applyBFS

    -- Shortcut from Data.Tree
    , drawTree

    -- Prints Tree Vertex
    , printer
    ) where

import           Control.Lens        (makeLenses, (%~), (&), (.~), (^.))
import           Control.Monad.State (MonadState (get), State, evalState,
                                      modify, when)
import           Data.Array          (Array, assocs, listArray, (!), (//))
import           Data.Dequeue        as Q (BankersDequeue,
                                           Dequeue (fromList, popFront, pushBack),
                                           null)
import           Data.Graph          (Bounds, Edge, Graph, Vertex, buildG,
                                      edges, vertices)
import           Data.Maybe          (fromJust, isJust)
import qualified Data.Tree           as T (Tree, drawTree, unfoldTree)

type Distance = Int
data Color = White | Grey | Black deriving (Eq, Ord, Show)

data GraphStateVars = GraphStateVars
    { _colors       :: Array Vertex Color
    , _distances    :: Array Vertex (Maybe Int)
    , _predecessors :: Array Vertex (Maybe Vertex)
    , _queue        :: BankersDequeue Vertex
    }

type GraphState a = State GraphStateVars a

makeLenses ''GraphStateVars

exampleGraph :: Graph
exampleGraph = buildG (1, 6) [(1, 2), (1, 4), (2, 5), (3, 5), (3, 6), (4, 2), (5, 4), (6, 6)]

colorChanger :: [Edge] -> Vertex -> GraphState ()
colorChanger [] _ = return ()
colorChanger ((u, v): e) t = do
    now <- get
    when ((now ^. colors) ! v == White && t == u) $ modify (\s -> s
        & colors        %~ (// [(v, Grey)])
        & distances     %~ (// [(v, fmap (+1) ((now ^. distances) ! u))])
        & predecessors  %~ (// [(v, Just u)])
        & queue         %~ (`pushBack` v)
        )
    colorChanger e t

computationThing :: [Edge] -> [Vertex] -> GraphState (Array Vertex (Maybe Distance), Array Vertex (Maybe Vertex))
computationThing e v = do
    now <- get
    if Q.null $ now ^. queue
    then return (now ^. distances, now ^. predecessors)
    else do
        let (n, qn) = fromJust . popFront $ now ^. queue
        modify (& queue .~ qn)
        colorChanger e n
        computationThing e v

breadthFirst :: Graph -> Vertex -> (Array Vertex (Maybe Distance), Array Vertex (Maybe Vertex))
breadthFirst graph initial = evalState (computationThing e v) g
    where
        v = vertices graph                                       :: [Vertex]                    -- all vertices
        e = edges graph                                          :: [Edge]                      -- all edges
        b = (head v, last v)                                     :: Bounds
        l = listArray b . repeat
        g = GraphStateVars
            { _colors = l White // [(initial, Grey)]            :: Array Vertex Color          -- colors
            , _distances = l Nothing // [(initial, Just 0)]     :: Array Vertex (Maybe Int)    -- distances
            , _predecessors = l Nothing // [(initial, Nothing)] :: Array Vertex (Maybe Vertex) -- predecessors
            , _queue = fromList [initial]                       :: BankersDequeue Vertex       -- queue
            }

buildSearchTree :: Vertex -> Array Vertex (Maybe Vertex) -> T.Tree Vertex
buildSearchTree t p = T.unfoldTree getNode t
    where
        allEdges = [(fromJust s, e) | (e, s) <- assocs p, isJust s]
        getNode x = (x, [b | (a, b) <- allEdges, a == x])

applyBFS :: Graph -> Vertex -> T.Tree Vertex
applyBFS g v = buildSearchTree v . snd $ breadthFirst g v

drawTree :: T.Tree String -> String
drawTree = T.drawTree

printer :: T.Tree Vertex -> IO ()
printer = mapM_ putStrLn . lines . drawTree . fmap show
