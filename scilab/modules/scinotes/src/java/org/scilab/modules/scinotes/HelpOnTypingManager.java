/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2010 - Calixte DENIZET
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

package org.scilab.modules.scinotes;

import java.awt.event.KeyListener;
import java.awt.event.KeyEvent;

import javax.swing.text.BadLocationException;

import org.scilab.modules.commons.xml.XConfiguration;

/**
 * This class handles the help on typing
 * @author Calixte DENIZET
 */
public final class HelpOnTypingManager implements KeyListener {

    private static HelpOnTypingManager instance = new HelpOnTypingManager();
    private static boolean openers;
    private static boolean keywords;

    /**
     * Constructor
     */
    private HelpOnTypingManager() {
        super();
        instance = this;
        openers = SciNotesOptions.getSciNotesDisplay().autoCompleteOpeners;
        keywords = SciNotesOptions.getSciNotesDisplay().autoCompleteKeywords;
    }

    /**
     * @return the singleton instance of HelpOnTypingManager
     */
    public static HelpOnTypingManager getInstance() {
        return instance;
    }

    /**
     * @param b true if autocompletion on '(', '{', ...
     */
    public static void enableOpeners(boolean b) {
        openers = b;
        SciNotesOptions.getSciNotesDisplay().autoCompleteOpeners = b;
        XConfiguration.set(XConfiguration.getXConfigurationDocument(), SciNotesOptions.DISPLAYPATH + "/@auto-complete-openers", Boolean.toString(b));
    }

    /**
     * @param b true if autocompletion on 'if', 'function', ...
     */
    public static void enableKeywords(boolean b) {
        keywords = b;
        SciNotesOptions.getSciNotesDisplay().autoCompleteKeywords = b;
        XConfiguration.set(XConfiguration.getXConfigurationDocument(), SciNotesOptions.DISPLAYPATH + "/@auto-complete-keywords", Boolean.toString(b));
    }

    /**
     * @return true if help on typing is active
     */
    public static boolean isActive() {
        return openers || keywords;
    }

    /**
     * @return true if help on typing for the openers is active
     */
    public static boolean isOpenersActive() {
        return openers;
    }

    /**
     * @return true if help on typing for the openers is active
     */
    public static boolean isKeywordsActive() {
        return keywords;
    }

    /**
     * Nothing !
     * @param e the event
     */
    public void keyPressed(KeyEvent e) { }

    /**
     * Nothing !
     * @param e the event
     */
    public void keyReleased(KeyEvent e) { }

    /**
     * Called when a key is typed
     * @param e the event
     */
    public void keyTyped(KeyEvent e) {
        char c = e.getKeyChar();
        ScilabEditorPane textPane = ScilabEditorPane.getFocusedPane();
        ScilabDocument doc = (ScilabDocument) textPane.getDocument();
        if (isActive() && c != KeyEvent.CHAR_UNDEFINED && textPane.getSelectionStart() == textPane.getSelectionEnd()) {
            int pos = textPane.getCaretPosition();
            if (c == ' ' && e.getModifiers() == 0) {
                int end = doc.getDefaultRootElement().getElement(doc.getDefaultRootElement().getElementIndex(pos)).getEndOffset() - 1;
                /* the following test is used to know if an insertion in the line is done */
                if (pos == end) {
                    try {
                        doc.insertString(pos, " ", null);
                        e.consume();
                        KeywordEvent kwe = textPane.getKeywordEvent(pos);
                        int[] ret;
                        String kw;
                        switch (kwe.getType()) {
                            case ScilabLexerConstants.OSKEYWORD :
                                kw = doc.getText(kwe.getStart(), kwe.getLength());
                                if ("if".equals(kw)) {
                                    doc.insertString(pos + 1, " then\nend", null);
                                    ret = textPane.getIndentManager().indentDoc(pos + 1, pos + 9);
                                    textPane.setCaretPosition(ret[0]);
                                } else if (!"end".equals(kw)) {
                                    doc.insertString(pos + 1, "\nend", null);
                                    ret = textPane.getIndentManager().indentDoc(pos + 1, pos + 4);
                                    textPane.setCaretPosition(ret[0]);
                                }
                                break;
                            case ScilabLexerConstants.SKEYWORD :
                                kw = doc.getText(kwe.getStart(), kwe.getLength());
                                if ("elseif".equals(kw)) {
                                    doc.insertString(pos + 1, " then", null);
                                    textPane.setCaretPosition(pos + 1);
                                }
                                break;
                            case ScilabLexerConstants.FKEYWORD :
                                /* We have 'function' or 'endfunction' */
                                if ("f".equals(doc.getText(kwe.getStart(), 1))) {
                                    doc.insertString(pos + 1, "()\nendfunction", null);
                                    textPane.getIndentManager().indentDoc(pos + 3, pos + 14);
                                    textPane.setCaretPosition(pos + 1);
                                }
                                break;
                            default :
                        }
                    } catch (BadLocationException exc) {
                        System.err.println(exc);
                    }
                }
            } else if (openers) {
                try {
                    char ch = doc.getText(pos, 1).charAt(0);
                    if (c == ch && (c == ')' || c == ']' || c == '}' || c == '\"')) {
                        e.consume();
                        textPane.setCaretPosition(pos + 1);
                        return;
                    }
                } catch (BadLocationException exc) {
                    System.err.println(exc);
                }

                String str = null;
                switch (c) {
                    case '(' :
                        str = "()";
                        break;
                    case '[' :
                        str = "[]";
                        break;
                    case '{' :
                        str = "{}";
                        break;
                    case '\"' :
                        str = "\"\"";
                        break;
                    default :
                }

                if (str != null) {
                    try {
                        doc.insertString(pos, str, null);
                        e.consume();
                        textPane.setCaretPosition(pos + 1);
                    } catch (BadLocationException exc) {
                        System.err.println(exc);
                    }
                }
            }
        }
    }
}
