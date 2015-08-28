data Btree v = Node v (Btree v) (Btree v) |
						Leaf v

data Color = Red | Green | Blue

instance Eq Color where
	Red == Red = True
	Green == Green = True
	Blue == Blue = True

colorify :: Ord a => a -> Btree a -> Btree Color
colorify v (Leaf l) = Leaf (pickColor v l)
colorify v (Node l b1 b2) = 
	Node (pickColor v l) (colorify v b1) (colorify v b2)

pickColor :: Ord a => a -> a -> Color
pickColor v l
	| v < l = Red
	| v == l = Green
	| otherwise = Blue


count :: Color -> Btree Color -> Int
count c (Leaf l) = comparify c l
count c (Node l b1 b2) = comparify c l + count c b1 + count c b2


comparify :: Color -> Color -> Int
comparify c1 c2
	| c1 == c2 = 1
	| otherwise = 0