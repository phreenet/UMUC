/**
 * Author: Justin Smith
 * Course: CMSC335.6380
 * Date: Jun 25, 2010
 * Project: Project 1
 * File: LibraryInterface.java
 * Development Environment:  Apple Mac OS X 10.6.4
 *                           Eclipse 3.6 / Java 1.6.0_20
 */
package project2;

public interface LibraryInterface<T> {
	// Formal Generic Type: T
	
	// Methods operating on Library items
	public void		add(T o, String s) throws LibraryException;
	public void 	delete(T o, String s) throws LibraryException;
	
	// Methods checking in/out Library items
	public void checkOut(String uid) throws LibraryException;
	public void checkIn(String uid) throws LibraryException;
	
	// Methods of retreiving items.
	public Object 	getAtIndex(int i) throws LibraryException;
	public Object[] toArray();
	public int 		size();
	public void 	deleteAtIndex (int i) throws LibraryException;
	public Boolean  checkID(String s);
}