
public class Main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		int taille = 6;
		Philosophe p;
		Table t = new Table (taille);
		for (int i = 0; i <taille; i++) {
			p = new Philosophe(i,t);
			p.start();
		}
	}
}
