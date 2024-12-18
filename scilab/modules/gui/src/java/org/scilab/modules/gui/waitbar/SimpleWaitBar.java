/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2008 - INRIA - Vincent Couvert
 * 
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at    
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

package org.scilab.modules.gui.waitbar;

/**
 * Interface for WaitBars/ProgressBars used by Scilab
 * @author Vincent COUVERT
 */
public interface SimpleWaitBar {
	
	/**
	 * Set the element id for this MessageBox
	 * @param id the id of the corresponding MessageBox object
	 */
	void setElementId(int id);
	
	/**
	 * Get the element id for this MessageBox
	 * @return id the id of the corresponding MessageBox object
	 */
	int getElementId();
	
	/**
	 * Set the title of the WaitBar
	 * @param title the title to set
	 */
	void setTitle(String title);
	
	/**
	 * Set the message of the WaitBar
	 * @param message the message to set
	 */
	void setMessage(String[] message);
	
	/**
	 * Set the current value of the WaitBar
	 * @param value the value to set
	 */
	void setValue(int value);
	
	/**
	 * Close the WaitBar
	 */
	void close();
	
	/**
	 * Indicates if the total execution time is known
	 * @param status true if the total progress time in unknown
	 */
	void setIndeterminateMode(boolean status);

}
