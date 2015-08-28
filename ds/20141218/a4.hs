class Monad m where
	(>>=) :: m a -> (a -> m b) -> m b
	(>>) :: m a -> m b -> m b
	return :: a -> m a
	fail :: String -> m a
	(<=<) :: (b -> m c) -> (a -> m b) -> (a -> m c)

	(<=<) m1 m2 = (return >>= m2) >>= m1