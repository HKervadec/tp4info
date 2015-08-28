map' :: (a -> b) -> [a] -> [b]
map' f = foldr ff []
	where ff e r = (f e) : r


f x = 2*x

l = [1,2,3,4,5,6]

split :: Integral a => [a] -> ([a], [a])
split = foldr dtt ([], [])
dtt :: Integral a => a -> ([a], [a]) -> ([a], [a])
dtt x (l1, l2)
	| even x = (x:l1, l2)
	| otherwise = (l1, x:l2)