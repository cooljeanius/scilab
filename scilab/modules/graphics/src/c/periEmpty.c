/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2004-2006 - INRIA - Fabrice Leray
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

#include "machine.h"

#ifndef _MSC_VER

/* These DEFAULTNUMCOLORS colors come from Xfig */
unsigned short default_colors[] =
{
    0,   0,   0, /* Black: DEFAULTBLACK */
    0,   0, 255, /* Blue */
    0, 255,   0, /* Green */
    0, 255, 255, /* Cyan */
    255,   0,   0, /* Red */
    255,   0, 255, /* Magenta */
    255,   255,   0, /* Yellow */
    255, 255, 255, /* White: DEFAULTWHITE */
    0,   0, 144, /* Blue4 */
    0,   0, 176, /* Blue3 */
    0,   0, 208, /* Blue2 */
    135, 206, 255, /* LtBlue */
    0, 144,   0, /* Green4 */
    0, 176,   0, /* Green3 */
    0, 208,   0, /* Green2 */
    0, 144, 144, /* Cyan4 */
    0, 176, 176, /* Cyan3 */
    0, 208, 208, /* Cyan2 */
    144,   0,   0, /* Red4 */
    176,   0,   0, /* Red3 */
    208,   0,   0, /* Red2 */
    144,   0, 144, /* Magenta4 */
    176,   0, 176, /* Magenta3 */
    208,   0, 208, /* Magenta2 */
    128,  48,   0, /* Brown4 */
    160,  64,   0, /* Brown3 */
    192,  96,   0, /* Brown2 */
    255, 128, 128, /* Pink4 */
    255, 160, 160, /* Pink3 */
    255, 192, 192, /* Pink2 */
    255, 224, 224, /* Pink */
    255, 215,   0  /* Gold */
};

#endif

int WithBackingStore(void)
{
    return 0;
}


/*
 * Resize the Pixmap according to window size change
 * But only if there is a pixmap
 */
void CPixmapResize1(void)
{
    return;
}

void clip_line(int x1, int yy1, int x2, int y2, int *x1n, int *yy1n,  int *x2n,
               int *y2n, int *flag)
{
    return;
}

/*--------------------------------------------------------------------------*/
/* Clip the given line to drawing coords defined as xleft,xright,ybot,ytop.
 *   This routine uses the cohen & sutherland bit mapping for fast clipping -
 * see "Principles of Interactive Computer Graphics" Newman & Sproull page 65.
 return 0  : segment out
 1  : (x1,y1) changed
 2  : (x2,y2) changed
 3  : (x1,y1) and (x2,y2) changed
 4  : segment in
*/


void set_clip_box(int xxleft, int xxright, int yybot, int yytop)
{
    return;
}


void SetWinhdc(void)
{
    return;
}
/*--------------------------------------------------------------------------*/
int MaybeSetWinhdc(void)
{
    return (0);
}
/*--------------------------------------------------------------------------*/
void ReleaseWinHdc(void)
{
    return;
}
/*--------------------------------------------------------------------------*/
void wininfo(char *fmt, ...)
{
    return;
}
/*--------------------------------------------------------------------------*/
void C2F(xgetmouse)(char *str, int *ibutton, int *x1, int *yy1, int *iflag,
                    int *v6, int *v7, double *dv1, double *dv2, double *dv3,
                    double *dv4)
{
    return;
}
/*--------------------------------------------------------------------------*/
void SciMouseCapture(void)
{
    return;
}
/*--------------------------------------------------------------------------*/
void SciMouseRelease(void)
{
    return;
}
/*--------------------------------------------------------------------------*/
int C2F(sedeco)(int *flag)
{
    return (0);
}
/*--------------------------------------------------------------------------*/
/**************************************************
 * loadfamily Loads a font at size  08 10 12 14 18 24
 * for example TimR08 TimR10 TimR12 TimR14 TimR18 TimR24
 * name is a string
 *  ( X11 only : if it is a string containing the char %
 *    it is suposed to be a format for a generic font in X11 string style
 *    "-adobe-times-bold-i-normal--%s-*-75-75-p-*-iso8859-1" )
 * it is supposed to be an alias for a font name
 * Ex : TimR and we shall try to load TimR08 TimR10 TimR12 TimR14 TimR18 TimR24
 **************************************************/

void C2F(loadfamily)(char *name, int *j, int *v3, int *v4, int *v5, int *v6,
                     int *v7, double *dv1, double *dv2, double *dv3,
                     double *dv4)
{
    return;
}
/*--------------------------------------------------------------------------*/
void C2F(xclick)(char *str, int *ibutton, int *x1, int *yy1, int *iflag,
                 int *istr, int *v7, double *v1, double *dv2, double *dv3,
                 double *dv4)
{
    return;
}

void C2F(getFontMaxSize)(char *str, int *sizeMin, int *sizeMax, int *v1,
                         int *v2, int *v3, int *v4, double *dx1, double *dx2,
                         double *dx3, double *dx4)
{
    return;
}

void C2F(queryfamily)(char *name, int *j, int *v3, int *v4, int *v5, int *v6,
                      int *v7, double *dv1, double *dv2, double *dv3,
                      double *dv4)
{
    return;
}

void C2F(xinfo)(char *message, int *v2, int *v3, int *v4, int *v5, int *v6,
                int *v7, double *dv1, double *dv2, double *dv3, double *dv4)
{
    return;
}

/** Draw a set of arrows **/
/** arrows are defined by (vx[i],vy[i])->(vx[i+1],vy[i+1]) **/
/** for i=0 step 2 **/
/** n is the size of vx and vy **/
/** as is 10*arsize (arsize) the size of the arrow head in pixels **/

void C2F(drawarrows)(char *str, int *vx, int *vy, int *n, int *as, int *style,
                     int *iflag, double *dv1, double *dv2, double *dv3,
                     double *dv4)
{
    return;
}

void C2F(xend)(char *v1, int *v2, int *v3, int *v4, int *v5, int *v6, int *v7,
               double *dv1, double *dv2, double *dv3, double *dv4)
{
    return; /** Nothing in Windows **/
}

/*----------------------
  \subsection{Circles and Ellipsis }
  ------------------------*/
/** Draw or fill a set of ellipsis or part of ellipsis **/
/** Each is defined by 6-parameters, **/
/** ellipsis i is specified by $vect[6*i+k]_{k=0,5}= x,y,width,height,angle1,angle2$ **/
/** <x,y,width,height> is the bounding box **/
/** angle1,angle2 specifies the portion of the ellipsis **/
/** caution : angle=degreangle*64          **/
/** if fillvect[i] is in [0,whitepattern] then  fill the ellipsis i **/
/** with pattern fillvect[i] **/
/** if fillvect[i] is > whitepattern  then only draw the ellipsis i **/
/** The drawing style is the current drawing **/

void C2F(fillarcs)(char *str, int *vects, int *fillvect, int *n, int *v5,
                   int *v6, int *v7, double *dv1, double *dv2, double *dv3,
                   double *dv4)
{
    return;
}

/** Fill a single elipsis or part of it with current pattern **/
void C2F(fillarc)(char *str, int *x, int *y, int *width, int *height,
                  int *angle1, int *angle2, double *dv1, double *dv2,
                  double *dv3, double *dv4)
{
    return;
}

/** Draw a set of (*n) polylines (each of which have (*p) points) **/
/** with lines or marks **/
/** drawvect[i] >= 0 use a mark for polyline i **/
/** drawvect[i] < 0 use a line style for  i **/

void C2F(drawpolylines)(char *str, int *vectsx, int *vectsy, int *drawvect,
                        int *n, int *p, int *v7, double *dv1, double *dv2,
                        double *dv3, double *dv4)
{
    return;
}


void C2F(drawpolyline)(char *str, int *n, int *vx, int *vy, int *closeflag,
                       int *v6, int *v7, double *dv1, double *dv2, double *dv3,
                       double *dv4)
{
    return;
}


/** fill a set of polygons each of which is defined by
    (*p) points (*n) is the number of polygons
    the polygon is closed by the routine
    fillvect[*n] :
    fillvect[*n] :
    if fillvect[i] == 0 draw the boundaries with current color
    if fillvect[i] > 0  draw the boundaries with current color
    then fill with pattern fillvect[i]
    if fillvect[i] < 0  fill with pattern - fillvect[i]
**/

void C2F(fillpolylines)(char *str, int *vectsx, int *vectsy, int *fillvect,
                        int *n, int *p, int *v7, double *dv1, double *dv2,
                        double *dv3, double *dv4)
{
    return;
}

/** Only draw one polygon  with current line style **/
/** according to *closeflag : it is a polyline or a polygon **/
/** n is the number of points of the polyline */
/** ths routine also perform clipping to avoid overflow */
void C2F(drawClippedPolyline)(char *str, int *n, int *vx, int *vy,
                              int *closeflag, int *v6, int *v7, double *dv1,
                              double *dv2, double *dv3, double *dv4)
{
    return;
}

void Setpopupname(char *string)
{
    return;
}

void C2F(xclick_any)(char *str, int *ibutton, int *x1, int *yy1, int *iwin,
                     int *iflag, int *istr, double *dv1, double *dv2,
                     double *dv3, double *dv4)
{
    return;
}

void C2F(xselgraphic)(char *v1, int *v2, int *v3, int *v4, int *v5, int *v6,
                      int *v7, double *dv1, double *dv2, double *dv3,
                      double *dv4)
{
    return;
}

void C2F(cleararea)(char *str, int *x, int *y, int *w, int *h, int *v6, int *v7,
                    double *dv1, double *dv2, double *dv3, double *dv4)
{
    return;
}

void C2F(boundingbox)(char *string, int *x, int *y, int *rect, int *v5, int *v6,
                      int *v7, double *dv1, double *dv2, double *dv3,
                      double *dv4)
{
    return;
}

void C2F(clearwindow)(char *v1, int *v2, int *v3, int *v4, int *v5, int *v6,
                      int *v7, double *dv1, double *dv2, double *dv3,
                      double *dv4)
{
    return;
}


void C2F(drawaxis)(char *str, int *alpha, int *nsteps, int *v2, int *initpoint,
                   int *v6, int *v7, double *size, double *dx2, double *dx3,
                   double *dx4)
{
    return;
}

void C2F(MissileGCGetorSet)(char *str, int flag, int *verbose, int *x1,
                            int *x2, int *x3, int *x4, int *x5, int *x6,
                            double  *dv1)
{
    return;
}

void C2F(initgraphic)(char *string, int *v2, int *v3, int *v4, int *v5, int *v6,
                      int *v7, double *dv1, double *dv2, double *dv3,
                      double *dv4)
{
    return;
}

void C2F(drawpolymark)(char *str, int *n, int *vx, int *vy, int *v5, int *v6,
                       int *v7, double *dv1, double *dv2, double *dv3,
                       double *dv4)
{
    return;
}

void C2F(drawsegments)(char *str, int *vx, int *vy, int *n, int *style,
                       int *iflag, int *v7, double *dv1, double *dv2,
                       double *dv3, double *dv4)
{
    return;
}

void C2F(MissileGCset)(char *str, int *x1, int *x2, int *x3, int *x4, int *x5,
                       int *x6, double *dv1, double *dv2, double *dv3,
                       double *dv4)
{
    return;
}

void C2F(drawrectangles)(char *str, int *vects, int *fillvect, int *n, int *v5,
                         int *v6, int *v7, double *dv1, double *dv2,
                         double *dv3, double *dv4)
{
    return;
}

void C2F(drawrectangle)(char *str, int *x, int *y, int *width, int *height,
                        int *v6, int *v7, double *dv1, double *dv2, double *dv3,
                        double *dv4)
{
    return;
}

void C2F(drawarcs)(char *str, int *vects, int *style, int *n, int *v5, int *v6,
                   int *v7, double *dv1, double *dv2, double *dv3, double *dv4)
{
    return;
}

void C2F(drawarc)(char *str, int *x, int *y, int *width, int *height,
                  int *angle1, int *angle2, double *dv1, double *dv2,
                  double *dv3, double *dv4)
{
    return;
}

int SwitchWindow(int *intnum)
{
    return (0);
}


int CheckScilabXgc(void)
{
    return (0);
}

void C2F(fillrectangle)(char *str, int *x, int *y, int *width, int *height,
                        int *v6, int *v7, double *dv1, double *dv2, double *dv3,
                        double *dv4)
{
    return;
}


void C2F(setpopupname)(char *x0, int *v2, int *v3, int *v4, int *v5, int *v6,
                       int *v7, double *dv1, double *dv2, double *dv3,
                       double *dv4)
{
    return;
}

void C2F(MissileGCget)(char *str, int *verbose, int *x1, int *x2, int *x3,
                       int *x4, int *x5, double *dv1, double *dv2, double *dv3,
                       double *dv4)
{
    return;
}


void C2F(displaystring)(char *string, int *x, int *y, int *v1, int *flag,
                        int *v6, int *v7, double *angle, double *dv2,
                        double *dv3, double *dv4)
{
    return;
}

void C2F(fillpolyline)(char *str, int *n, int *vx, int *vy, int *closeflag,
                       int *v6, int *v7, double *dv1, double *dv2, double *dv3,
                       double *dv4)
{
    return;
}

void C2F(displaynumbers)(char *str, int *x, int *y, int *v1, int *v2, int *n,
                         int *flag, double *z, double *alpha, double *dx3,
                         double *dx4)
{
    return;
}

struct BCG; /* FIXME: where is this actually supposed to be from? */

void SciViewportMove(struct BCG *ScilabGC, int x, int y)
{
    return;
}

int C2F(deletewin)(int *number)
{
    return 0;
}

/* EOF */
