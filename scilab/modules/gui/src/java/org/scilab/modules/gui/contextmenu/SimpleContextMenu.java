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

package org.scilab.modules.gui.contextmenu;

import org.scilab.modules.gui.menu.Menu;
import org.scilab.modules.gui.menuitem.MenuItem;
import org.scilab.modules.gui.menuitem.SimpleMenuItem;

/**
 * Interface for SimpleMenu the associated object to Scilab GUIs Menu
 * @author Vincent COUVERT
 */
public interface SimpleContextMenu extends SimpleMenuItem {
	
	/**
	 * Append a MenuItem to the ContextMenu
	 * @param newMenuItem the MenuItem to add to the ContextMenu
	 */
	void add(MenuItem newMenuItem);
	
	/**
	 * Append a Menu to the ContextMenu
	 * @param newMenu the Menu to add to the ContextMenu
	 */
	void add(Menu newMenu);

	/**
	 * Display the ContextMenu
	 * @return the label of the menu pressed
	 */
	String displayAndWait();
}
