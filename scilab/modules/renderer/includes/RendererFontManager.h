/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2008 - INRIA - Allan CORNET
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

#ifndef __RENDERERFONTMANAGER_H__
#define __RENDERERFONTMANAGER_H__

#ifndef GCC_VERSION
# define GCC_VERSION (__GNUC__ * 1000 + __GNUC_MINOR__)
#endif /* GCC_VERSION */

/* C++11 adds the ability to add "override" after an implementation of a
   virtual function in a subclass, to:
     (A) document that this is an override of a virtual function
     (B) allow the compiler to issue a warning if it isn't (e.g. a mismatch
         of the type signature).

   Similarly, it allows us to add a "final" to indicate that no subclass
   may subsequently override the vfunc.

   Provide OVERRIDE and FINAL as macros, allowing us to get these benefits
   when compiling with C++11 support, but without requiring C++11.

   For gcc, use "-std=c++11" to enable C++11 support; gcc 6 onwards enables
   this by default (actually GNU++14).  */

#if defined __cplusplus
# if (__cplusplus >= 201103)
/* C++11 claims to be available: use it.  Final/override were only
   implemented in 4.7, though.  */
#  if GCC_VERSION < 4007
#   define OVERRIDE
#   define FINAL
#  else
#   define OVERRIDE override
#   define FINAL final
#  endif
# elif GCC_VERSION >= 4007
/* G++ 4.7 supports __final in C++98.  */
#  define OVERRIDE
#  define FINAL __final
# else
/* No C++11 support; leave the macros empty.  */
#  define OVERRIDE
#  define FINAL
# endif
#else
/* No C++11 support; leave the macros empty.  */
# define OVERRIDE
# define FINAL
#endif

#ifdef __cplusplus
extern "C" {
#endif

#include "dynlib_renderer.h"
#include "BOOL.h"

/**
 * @return number of fonts installed (used) by scilab
 */
RENDERER_IMPEXP int getNbInstalledFonts(void);

/**
* returns fontnames installed (used) by scilab
* @param[out] size of array returned
* @return fonts name
*/
RENDERER_IMPEXP char **getInstalledFontsName(int *sizeArray);

/**
* returns fontnames available on your system
* @param[out] size of array returned
* @return fonts name
*/
RENDERER_IMPEXP char **getAvailableFontsName(int *sizeArray);

/**
* check if a font name is available
* @param[in] a font name
* @return TRUE or FALSE
*/
RENDERER_IMPEXP BOOL isAvailableFontsName(char *fontname);

/**
* Add a new font from its font name.
* @param fontName name of the font to add.
* @return index of the added font.
*/
RENDERER_IMPEXP int addFont(char *fontname);

/**
* Replace a font in the font list by a new one.
* @param[in] index index of the font to replace
* @param[in] fontName Name of the font.
* @return index of the added font or -1 if an error occurred.
*/
RENDERER_IMPEXP int changeFont(int index, char * fontName);

/**
* Replace a font in the font list by a new one.
* @param[in] index index of the font to replace
* @param[in] fontName Name of the font.
* @param[in] if it is Bold.
* @param[in] if it is Italic.
* @return index of the added font or -1 if an error occurred.
*/
RENDERER_IMPEXP int changeFontWithProperty(int index, char * fontName, BOOL isBold, BOOL isItalic);

/**
* reset xlfont with initiale values
*/
RENDERER_IMPEXP void resetFontManager(void);

/**
* Replace a font in the font list by a new one loaded by its filename.
* @param[in] index index of the font to replace
* @param[in] filename of font
* @return index of the added font or -1 if an error occurred.
*/
RENDERER_IMPEXP int changeFontFromFilename (int index, char * FontFilename);

/**
* Add a new font from its font filename.
* @param[in] filename of font
* @return index of the added font or -1 if an error occurred.
*/
RENDERER_IMPEXP int addFontFromFilename (char * FontFilename);

#ifdef __cplusplus
}
#endif

#endif /* __RENDERERFONTMANAGER_H__ */

