data Btree = Not Btree |
			And Btree Btree |
			Or Btree Btree |
			T |
			F
t :: Btree
t = Not (Or T (Not F))

beval :: Btree -> Bool
beval T = True
beval F = False
beval (Not b) = not (beval b)
beval (And b1 b2) = beval b1 && beval b2
beval (Or b1 b2) = beval b1 || beval b2