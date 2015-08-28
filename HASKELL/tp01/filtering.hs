-- could be improved by using a max heap instead of sorting
-- I don't want to implement a heap in haskell yet
kmaxsubunique :: [Int] -> Int -> [(Int, Int, Int)]
kmaxsubunique l k = take k (ksub (uniq l))

ksub :: [Int] -> [(Int, Int, Int)]
ksub l = reverse (sort superList cmp)
	where 
		cmp :: (Int, Int, Int) -> (Int, Int, Int) -> Bool
		cmp (a, _, _) (b, _, _) = a <= b 
		superList = (map dtt index)
			where 
				dtt :: (Int, Int) -> (Int, Int, Int)
				dtt (i, j) = ((calcSum l (i, j)), i, j)
				index = [(a, b) | a <- [1..ll], b <- [a..ll]]
					where ll = length l


sort :: [a] -> (a-> a -> Bool) -> [a]
sort [] _ = []
sort (h:r) f = insert h (sort r f) f

insert :: a -> [a] -> (a-> a -> Bool) -> [a]
insert x [] _ = [x]
insert x (h:r) f
	| (f x h) = x : h : r
	| otherwise = h : (insert x r f)


-- Am I allowed to use map ?
mmap :: (a -> b) -> [a] -> [b]
mmap _ [] = []
mmap f (h:r) = (f h) : (mmap f r)

calcSum :: [Int] -> (Int, Int) -> Int
calcSum l (i, j)
	| i > j = 0
	| otherwise = (l !! (i - 1)) + (calcSum l ((i+1), j))

 	
uniq :: [Int] -> [Int]
uniq [] = []
uniq (h:r)
	| belongTo h cr = cr
	| otherwise = h : cr
	where cr = uniq r

belongTo :: Int -> [Int] -> Bool
belongTo _ [] = False
belongTo x (h:l)
	| x == h = True
	| otherwise = belongTo x l