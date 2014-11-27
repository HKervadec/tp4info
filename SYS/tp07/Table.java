

public class Table {
	int _n;
	Object _bag[];
	int _total;
	static Object lock = new Object();
	
	Table(int t) {
		_n = t;
		_total = _n - 1;
		_bag = new Object[_n];
		for (int i = 0; i < _n; i++) {
			_bag[i]= new Object();
		}
	}
	
	void prendreBaguettes(int i) throws InterruptedException {
		int pos[] = {i % _n, (i + 1) % _n};

		Object b1 = _bag[pos[0]];
	    synchronized(b1){
		    System.out.println("J'ai une baguette "+i);
		    Thread.sleep(100);

		    Object b2 = _bag[pos[1]];
		    synchronized(b2){
		    	System.out.println("J'ai une baguette "+i);
		    	Thread.sleep(100);

			    System.out.println("Je mange "+i);
			    Thread.sleep(5000);
		    }
	    }
	}	



	void prendreBaguettes_s1(int i) throws InterruptedException {
		boolean block = false;

		synchronized(this){
			if(_total == 0){
				this.wait();
			}
			else {
				_total--;
			}
		}

		
		Object b1 = _bag[i % _n];
	    synchronized(b1){
		    System.out.println("J'ai une baguette "+i);
		    Thread.sleep(100);

		    Object b2 = _bag[(i + 1) % _n];
		    synchronized(b2){
		    	System.out.println("J'ai une baguette "+i);
		    	Thread.sleep(100);

			    System.out.println("Je mange "+i);
			    Thread.sleep(5000);
		    }
	    }

    	if(_total == 0){
			synchronized(this){
				this.notify();
			}
		}
		else{
			synchronized(this){
				_total++;
			}
		}
	}	


	void prendreBaguettes_s1bis(int i) throws InterruptedException {
		boolean block = false;

		synchronized(this){
			while(_total == 0){
				this.wait();
			}
			_total--;
		}

		
		Object b1 = _bag[i % _n];
	    synchronized(b1){
		    System.out.println("J'ai une baguette "+i);
		    Thread.sleep(100);

		    Object b2 = _bag[(i + 1) % _n];
		    synchronized(b2){
		    	System.out.println("J'ai une baguette "+i);
		    	Thread.sleep(100);

			    System.out.println("Je mange "+i);
			    Thread.sleep(5000);
		    }
	    }


		synchronized(this){
			_total++;
			this.notify();
		}
	}

	void prendreBaguettes_s2(int i) throws InterruptedException {
		int pos[] = {i % _n, (i + 1) % _n};

		if((i % 2) != 0){
			int tmp = pos[0];
			pos[0] = pos[1];
			pos[1] = tmp;
		}

		Object b1 = _bag[pos[0]];
	    synchronized(b1){
		    System.out.println("J'ai une baguette "+i);
		    Thread.sleep(100);

		    Object b2 = _bag[pos[1]];
		    synchronized(b2){
		    	System.out.println("J'ai une baguette "+i);
		    	Thread.sleep(100);

			    System.out.println("Je mange "+i);
			    Thread.sleep(5000);
		    }
	    }
	}
}
