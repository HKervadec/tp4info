package tp6;

import java.util.LinkedList;

public class Semaphore {
	
	int cpt;
	private LinkedList<Object> waitingThreads;

	
	public Semaphore(){
		
	}
	
	public void init(int x){
		cpt = x;
		waitingThreads = new LinkedList<Object>();
	}
		 
	public void p() throws InterruptedException{
			
		boolean blocage = false;
		Object o = new Object();

		synchronized(this){
			if(cpt == 0){
				waitingThreads.add(o);
				blocage = true;
			}
			else {
				cpt--;
			}
		}
				
		if(blocage){
			synchronized(o){
				System.out.println("BLOOOOCAGE " + o.toString());
				o.wait();
			}
		}
		
	}
		
	
	
	public void v() {
		
		if (cpt==0 & !(waitingThreads.isEmpty()) ){
			Object o = waitingThreads.poll();
			synchronized(o){
			System.out.println("LIBERATIONNNN " + o.toString());
			o.notify();
			}
		}
		else{
			synchronized(this){
			cpt++;
			}
		}
			
		
		
	}


	public static void main(String[] args) {
		Semaphore s = new Semaphore();
			s.init(1);
			/* création des threads */
			ThreadTP6 t1 = new ThreadTP6(s,"thread numero 1");
			ThreadTP6 t2 = new ThreadTP6(s,"thread numero 2");
			ThreadTP6 t3 = new ThreadTP6(s,"thread numero 3");
			ThreadTP6 t4 = new ThreadTP6(s,"thread numero 4");
			ThreadTP6 t5 = new ThreadTP6(s,"thread numero 5");
			
			// lunch
			t1.start();
			t2.start();
			t3.start();
			t4.start();
			t5.start();
			
	}
	
}