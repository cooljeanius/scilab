               Changes between version 5.1.0 and 5.1.1 of Scilab
               =================================================


Improvements:
=============

* Catalan localization added (Thanks Oriol Gonzalez and others)

* German Localization added (Thanks Armin Mohring and others)

* Spanish Localization added (Thanks Federico Vera and others)

* Online Help translated into português do Brasil (pt_BR) added
  (Thanks Daniel de Souza Grilo)


Compilation:
============

* Defining the environment variable SCI_JAVA_ENABLE_HEADLESS disables the X11
  access when building the documentation (necessary when building the
  documentation in a chroot)

* ./configure && make all && make distclean == tarball (ie, make distclean is
  cleaning all the elements)

* In the source tree of Scilab, ant target "build-example" added in order to
  build only the javasci examples (cd modules/javasci && ant build-example)

Source reorganisation:
======================

* New module added call_scilab: the goal of this module is to highlight the
  possibility to call Scilab engine from other languages.

* "SCI/modules/output_stream/includes/error.h" renamed to "do_error_number.h"

Help & Tests:
=============

* Some equations in the documentation converted to the MathML format
  (bugs #4180 & #4182)

* Page "Compile and run with Javasci" added

* Examples in javasci translated into english

* Examples and unit tests added for the function find

* Examples provided in the help of the function argn

* Unit tests for the completion (GUI & NW/NWNI modes)

* Minor improvements in the documentation of the ilib_* functions and
  fprintf

* Unitary tests for isfield() function has been added


Enhancement:
============

* isfield() now accepts matrix of strings (fieldnames) as second input argument.
  Then, it returns a matrix of booleans.

* test_run() now accepts "skip_tests" as optionnal argument (3rd argument), if
  present, the second input argument of test_run is no more the list of tests to
  launch but the list of tests to skip.
  For example, test_run("time",["bug_1506" "bug_793"],"skip_tests");

* test_run() : The following tags have been added :
  - <-- WINDOWS ONLY --> If the operating system isn't Windows, the test is skipped.
  - <-- UNIX ONLY -->    If the operating system isn't an unix OS, the test is skipped.
  - <-- LINUX ONLY -->   If the operating system isn't Linux, the test is skipped.
  - <-- MACOSX ONLY -->  If the operating system isn't MacOSX, the test is skipped.

License:
========

* Examples in SCI/modules/javasci/examples/ are now released under the public
  domain


Internal API:
=============

* GetLengthStringMatrixByName function added in stack3.h (return length of strings)


Scilab / Scipad synchronisation bugs:
=====================================

A critical bug present in Scilab 5.0.X and 5.1.0 has been fixed.
It has been reported a numerous number of time:

* bug 2578 fixed - Calling input function within Scipad.

* bug 3345 fixed - From SciPad editor ending Scilab with exit is not correct.

* bug 3394 fixed - A malformed script originating from the editor window hangs
                   Scilab and the editor.

* bug 3553 fixed - System crash executing tk_getfile() from within scipad by
                   CTRL+L.

* bug 3643 fixed - Scilab spec function is the equivalent of Matlab function
                   (mtlb_eig is now obsolete).
                   
* bug 3839 fixed - strrev doesn't work correctly if the string to be reversed includes some accentuated characters.

* bug 3944 fixed - ilib_mex_build() wasn't using the content of the  

* bug 3705 fixed - During execution of any Scipad sequence, entering abort
                   after the prompt hang up both Scipad and Console.

* bug 3778 fixed - Calling TK gui from Scipad.

* bug 3799 fixed - Using xgetmouse from Scipad makes Scilab crash.

* bug 4149 fixed - Calling TCL functions within Scipad

* bug 4178 fixed - Scilab crash when using "legend" via Scipad.

* bug 4196 fixed - Scipad and Scilab crashing when using menu "Execute->load
                   into Scilab".

* bug 4204 fixed - Strange error message when using usecanvas(%F).

* bug 4331 fixed - Wrong result for gamma(13).

Bug fixes:
==========

* bug 3186 fixed - input is lost when graphics window is closed.

* bug 3240 fixed - msprintf error in plotprofile.

* bug 3587 fixed - gsort is not stable: It does not preserve the relative order
                   of equal values creates problem with function unique.

* bug 3852 fixed - Line wrapping problem in help browser

* bug 3666 fixed - 'input' with accentued character returns incorrect value

* bug 3944 fixed - ilib_mex_build() wasn't using the content of the
                   variable tables to compile other files

* bug 3945 fixed - Error with the help example of library()

* bug 3962 fixed - incorrect first left hand side argument of pca (one col instead of two)

* bug 4052 fixed - A wrong usage of xmlCleanupParser (libxml2) was causing
                   a seg fault on startup

* bug 4067 fixed - bug with completion and some paths

* bug 4073 fixed - mprintf does not display some special characters

* bug 4074 fixed - Scilab now uses native MacOSX menubar.

* bug 4088 fixed - When Tcl/Tk is disable, demos are now deactivated.

* bug 4099 fixed - Demos mixing gui and plots were not desactivated on plateforms
                   having usecanvas set to %T.

* bug 4120 fixed - amell returns wrong value on Scilab x64 (Windows)

* bug 4123 fixed - %i_prod crashs scilab (Windows release mode built with F2C
                   only)

* bug 4128 fixed - 'win' argument of the event_handler function did not work
                   (was always 0 instead of current figure ID).

* bug 4132 fixed - fullpath crashs

* bug 4134 fixed - In some cases, bad detection of a 64 bit arch was
                   causing a seg fault during the "make doc" process
                   
* bug 4141 fixed - ascii doesn't support extended ascii values in the range of [128-255].

* bug 4242 fixed - Copyright added (INRIA code)
                   on modules/linear_algebra/src/fortran/doldqr.f

* bug 4150 fixed - user startup executed twice if you change directory to
                   SCIHOME in this file.

* bug 4159 fixed - coshlt was defined twice on windows

* bug 4164 fixed - isinf is now defined in more recent versions of the Sun
                   Compiler. Detection and replacement of the function is now
                   done in the configure.

* bug 4166 fixed - test_run was broken

* bug 4179 fixed - The dec2hex "see also" part was missing in the help page.

* bug 4192 fixed - When doing a getd in a directory where there are no .sci
                   files, getd displayed a error message not clear at all.

* bug 4197 fixed - inaccurate floating point results computed by norm with
                   large/small vector matrices.

* bug 4197 fixed - When warning messages are disabled, a blank line is printed
                   out.

* bug 4199 fixed - Missing information in findobj help page + findobj did not
                   find figures.

* bug 4201 fixed - Confusing error message in datafit

* bug 4228 fixed - mclearerr with a false file descriptor crashs

* bug 4231 fixed - graphics exports functions crash (xs2png, xs2svg, ...)

* bug 4235 fixed - error.h renamed

* bug 4238 fixed - waitbar and progressionbar won't close when clicking on the X
                   in the upper-right corner of the window.

* bug 4245 fixed - The icon of the progressionbar is a java icon.
                   It should it be a Scilab one instead.

* bug 4249 fixed - filter dos not work with perfect all pass system

* bug 4250 fixed - The online help of intx function was badly located

* bug 4258 fixed - Configure script does not contain the correct detection
                   code for the JNI libraries under Solaris SPARC.

* bug 4266 fixed - ones, rand, zeros functions do not remove highest dimensions
                   equal to 1

* bug 4269 fixed - Fix a bashim in the macros of detection of swig (causing
                   problems with netbsd)

* bug 4270 fixed - The module tclsci wasn't really desactivated when using
                   the option --without-tk

* bug 4274 fixed - Open dialog invoked from Toolbar to select file to open with Scipad
                   has wrong "Scilab SCI files" filter instead of "All Scilab files"
                   like dialog invoked from File -> Open a file...

* bug 4282 fixed - When doing a symlink of scilab script, when calling this
                   script, it changes the PWD

* bug 4284 fixed - The online help of isfield() was missing.

* bug 4295 fixed - mdelete no more works with "*.extension" as input (wildcard).

* bug 4297 fixed - A spelling mistake was causing in some cases with the
                   pfss function

* bug 4299 fixed - getmemory is reporting bad total memory on system with
                   a lot of memory (> 3Go)

* bug 4301 fixed - Better reporting at the end of the configure

* bug 4302 fixed - Do not build the helptool module when --disable-build-help
                   is used

* bug 4309 fixed - Under Scilab5 the dashed lines are not well displayed. They
                   are reinitialized for each segment.

* bug 4311 fixed - rcond(eye()) returns 1 and not eye()

* bug 4312 fixed - Support for NetBSD in the memory detection (getmemory)

* bug 4316 fixed - mfprintf(0,'string') does not redirect stderr as fprintf(0,...)

* bug 4321 fixed - strcat with 3 input parameters crashs if input type
                   parameters are wrong.

* bug 4325 fixed - set("auto_clear","off") crashes Scilab.

* bug 4326 fixed - move called with an already deleted handle crashes Scilab.

* bug 4315 fixed - completion("",["commands","macros"]) will only returns "commands"

* bug 4332 fixed - completion copies selected item instead of completing according to this one.

* bug 4342 fixed - When the coutour function is called, an error message is printed.

* bug 4343 fixed - the plot3d demo doesn't seems to work.

* bug 4372 fixed - The graphics from the genetic_algorithms and simulated_annealing toolbox where not displayed

* bug 4386 fixed - link('show') with only one symbol writes 'librairies' and not 'library'.

* bug 4771 fixed - the configure did not stop when jhall (javahelp) or looks were not available on the system


               Changes between version 5.0.X and 5.1 of Scilab
               ===============================================

New Features:
=============

* Added elementary functions: acosd acot actod acoth asecd asech asec asind
  acsc acscd acsch csch atand cosd cotd cscd csc secd sech sec sind tand

* Scicos documentation in Docbook format.
  PDF, PS, JAR and other versions now available.

* Graphics available on all platforms and OS using function usecanvas
  See help page of usecanvas function for more details.

* New function dae (for Differential Algebraic Equations) added.
  This function is providing the same features as dassl with ode
  (ordinary differential equations) profile.
  For more information, see SEP #2.

* Request 564: completion add '\' or '/' at the end of a directory

* Added uigetfile (Functions xgetfile and tk_getfile are now obsolete).
  For more information, see SEP #8.

* Scilab is now supported natively under Mac OS X (See RELEASE_NOTES_5.1.X)

* Uses termios instead of termio in NW & NWNI modes

Enhancement:
============

* Graphics stabilty improved.

* Graphics speed improved.

* Menubar/toolbar update improved (particularly when (un)docking windows).

* Update of some output strings (standard, warning & error)

* Scilab uses Atlas 3.9.4 on Windows

* Directive FRENCH IMPOSED added to test_run() to force the test in french

* Errors occuring when getting or setting graphic/gui handles properties are
  now treated as any other Scilab errors.

* Now catch the exception when JOGL is crashing because native library
  gluegen-rt is not available in the java.library.path (LD_LIBRARY_PATH) and
  display a nice message

* Better error report in the documentation build process (docbook)

* Binary versions embed jre 1.6.0_11

* test_run() now accepts absolute paths as first input argument. It permits
  toolboxes to use this system.

* Under Linux/Unix, do not launch Scilab in background when called without argument

* icons are now installed into pkgdatadir/icons/

* Update of the example in the dynamic_link modules and in the toolbox skeleton
  (use the actual filename instead of the .o)

* The demos of the simulated_annealing module have been integrated into the demos menu

* The demos of the genetic_algorithms module have been integrated into the demos menu

Tests:
======

* Tests added for functions: umf_luget, taucs_chget, pcg, removedir, rmdir, ones

Internationalization:
=====================

* Almost all the i/o functions (isdir, mkdir, cd, chdir, mopen, fileinfo,
mclose, deletefile, findfiles, ls, listfiles, getshortpathname,
getlongpathname, removedir...) now handle file and directory names containing
UTF-8 characters. This is the work of Yung-Jang Lee. Many thanks!
(Unitary tests provided)

Misc:
=====

* Some dead code removed (SCI/scripts/,
                          SCI/bin/{dold,scilink,Blatdoc,Blatdocs,f77-linux,minfopr} )


Compilation:
============

* libmatio is now detected thanks to pkg-config

* More warnings in C/C++/Fortran during the compilation process.
See http://lists.scilab.org/cgi-bin/ezmlm-browse?list=dev&cmd=showmsg&msgnum=684

* --enable-build-help is now the default behaviour
  (--disable-build-help removes the check of the dependencies)

* --with-fftw, --with-pvm and --with-umfpack are now the default behaviour
  (--without-fftw, --without-pvm and --without-umfpack removes their builds)

* interpolation, signal_processing, statistics modules are loaded dynamically
  by Scilab.

* cc and cc-* are not longer consider as GNU C compiler when detecting the
  compiler (use gcc & gcc-*) because it was causing some issues under Solaris

* By default, under Linux/Unix/Macosx, static libraries are no longer built.

* Do not init TK when building the doc ("make doc")... in order to be able to
build Scilab through ssh

* Giws has lost it .py extension

* Force the build for the french documentation.


Bug fixes:
==========

* bug 1582 fixed - If parametric 3d curve values are out of given ebox of 3d
                   axes, this curve values are netherveless plotted.

* bug 1926 fixed - wavwrite doesn't manage single channel mode.

* bug 2175 fixed - "contour2d" prints level numbers partially outside the rect.

* bug 2255 fixed - plot function fails to verify that x and y data have the same
                   length in certain cases.

* bug 2265 fixed - Add a property to toggle grid position between background
                   and foreground.

* bug 2273 fixed - chdir didn't manage UNC path on Windows.

* bug 2357 fixed - The vertex-order of the plot3d2 and plor3d3 functions is
                   different from the one given in the manual.

* bug 2453, 3731, 3759, 3784, 3801 & 3802 fixed - Force all the numerical value
                                              to remain to the english notation.

* bug 2647 fixed - Bad display of some numbers in special cases due to a
                   gfortran bug.

* bug 2682 fixed - chart() is inconsistent in the second argument, angle.
                   It might be treated as degrees or radian.

* bug 2767 fixed - By default graphic windows are opened one above each others
				   whereas they should be tiled.

* bug 2814 fixed - Ticks graduation produce some unwanted decimals.

* bug 2959 fixed - functions on F1, F2, F12 keys are not mapped as scilab 4.x

* bug 3070 fixed - Could not use non-simple character like °, µ, ø ....

* bug 3080 fixed - When we click many times on a button of the Graphic window
                   the instruction will be done as much times we have clicked.

* bug 3089 fixed - chdir seems to have problems with directory names containing
                   nordic characters like æ ø and å.

* bug 3131 fixed - version 'GLIBC_2.4' not found with the binary version under
                   some GNU/Linux distro

* bug 3314 fixed - linspace primitive - rev 27707 - removed use of "ones" and
                   use colon (i.e. :) operator only

* bug 3322 fixed - trimmean primitive - rev 27627 - Added verbose option, added
                   unit tests, updated doc.

* bug 3326 fixed - ESC key clears the command line in the console.

* bug 3407 fixed - Line number where error is reported changed in Scilab may be
                   wrong.

* bug 3411 fixed - eye on a sparse is not explicit.

* bug 3462 fixed - The match string returned by regexp is not the right one if
                   the subject string contains backslashes.

* bug 3470 fixed - plot2d(), followed by legends produce an unexpected error.

* bug 3500 fixed - [pcre] match position but no character = no match

* bug 3512 fixed - regexp could return incorrect results

* bug 3515 fixed - Erroneous submenu numbering for setmenu() and unsetmenu() in
                   Scilab 5.0.1

* bug 3527 fixed - Graphic windows created by figure are unable to display plots.

* bug 3530 fixed - Check that X11/Xlib.h is available since the Tk header needs it.

* bug 3546 fixed - frmag is broken when called with hn given by a vector of
                   coefficients instead of a polynomial.

* bug 3549 fixed - machine.h was including PATH_MAX.h, BOOL.h and PARAMS.h
                   includes have been cleaned up.

* bug 3554 fixed - 'findobj' function does not find figures nor sub-menus and
                   the help example does not work.

* bug 3556 fixed - derivative was not supporting non compiled functions.

* bug 3559 fixed - paths in examples.bat in SCI/modules/javasci/examples were
                   wrong.

* bug 3561 fixed - 'call' crashs when we want to return a 'c' variable type.

* bug 3565 fixed - bad detection of the IBM JDK

* bug 3571 fixed - Only one message displayed when log(0) is computed with
                   ieee(1) mode.

* bug 3578 fixed - the definition of NewSparse and FreeSparse have been added.

* bug 3581 fixed - Legends do not appear correctly when axes are plotted in log
                   scale.

* bug 3590 fixed - Error message when we want to see a figure which has as
                   userdata a structure (struct).

* bug 3596 fixed - In the graphic export (bitmap) the exported file is stored in
                   vertical mirrored fashion.

* bug 3605 fixed - Better fix of the javasci freeze. A part of this bug was
                   caused by a dead lock in the TCL thread (we were trying to
                   get access to a TCL interpretor which was locked).

* bug 3608 fixed - Scilab freezes when executing a combination of
                   "eventhandler", "xchange" and "plot"

* bug 3624 fixed - Nan returned when multiplying large zero vector by its transpose.

* bug 3624, 3640 fixed - Atlas 3.8.0 have a bug causing wrong answer for
                         row-major gemm C=A*A' or A'A

* bug 3626 fixed - lcc-win32 library (.lib) not correctly generated.

* bug 3627 fixed - variance did not manage complex matrices of data

* bug 3628 fixed - Problem with cdouble type arguments in intersci.

* bug 3630 fixed - functions added by 'addinter' are not visible by 'what'.

* bug 3635 fixed - popupmenu objects created using uicontrol does not work as
                   expected (it is not possible to use the arrow keys on the
                   keyboard to browse through the various options).

* bug 3645 fixed - SCI/contrib/toolbox_skeleton package does not work out of the
                   box, and crashes on help.

* bug 3652 fixed - wrong computation of generalized eigenvalues.

* bug 3653 fixed - Figure menus were deleted when deleting current axis.

* bug 3661 fixed - cotg and coth do not work.

* bug 3664 fixed - an error occurs when a change directory operation implies a
                   directory name with french accent letter ('é' for example).

* bug 3667 fixed - Function input() now accepts a \n in the text to be printed
                   and colon is no more added.

* bug 3673 fixed - When using Scilab embedded in a Java application through
                   javasci, the first call to javasci API reset the look and
                   feel of the Java application.

* bug 3681 fixed - Disable automatic completion if there are only spaces in a line.

* bug 3687 fixed - 'format' doesn't check inputs arguments.

* bug 3697 fixed - setdefaultlanguage moved in localization module. (Windows)

* bug 3700 fixed - Problem when displaying accents in the help browser using the
                   fr language. (Windows)

* bug 3702 fixed - When I start scilex.exe (Windows) in a windows console, the
                   windows lost the focus.

* bug 3714 fixed - fprintfMat and fscanfMat cannot cope with directories with
                   accented characters.

* bug 3745 fixed - "make install" now install all <module>/demos/
                   and <module>/examples.

* bug 3749 fixed - Scilab error when building scilab help in HTML.

* bug 3753 fixed - drawaxis produces unreadable labels.

* bug 3755 fixed - print files on some Windows.

* bug 3756 fixed - undocumented input argument for prompt().

* bug 3757 fixed - completion works better on nw mode on Windows.

* bug 3767, 3827 fixed (windows) - Atlas 3.8.2 crashs scilab.

* bug 3769 fixed - Dynamic link doesn't detect intel fortran compiler version 11
                   on Windows.

* bug 3770 fixed - "qld" returns a error (qld: The constraints are inconsistent).

* bug 3775 fixed - get_absolute_file_path(input_file) returns a error if
                   input_file is not opened in Scilab.

* bug 3800 fixed - After using surf to plot giving a stacksize error, it is no
                   longer possible to plot in the same window.

* bug 3821 fixed - Problems with uicontrol scrolling when parent figure has
                   property auto_resize set to "off".

* bug 3822 fixed - When a figure handle is saved and reloaded the figure_size as
                   well as the viewport properties are not saved nor restored.

* bug 3833 fixed - Problems in cell insertion (loss of data).

* bug 3844 fixed - Axes with a very high y-bounds/x-bounds ratio do not appear.

* bug 3858 fixed - when trying to open a file from the GUI (Menu: File -> Open file), Scilab crashes (xgetfile error).

* bug 3860 fixed - Scilab was using the dev name of the fftw library (ie without
                   heading .3 in the lib name). Thanks to Andrea Florio for
                   providing the patch

* bug 3867 fixed - On the branch 5.0 nightly build 64 bits, the libmatio is
                   defined with the GLIBC_2.7 as mandatory. There is no reason
                   for this and it prevents Scilab binary to run under Redhat
                   and Centos.

* bug 3868 fixed - In the nightly 64 bits build of the branch 5.0, jogl & gluegen
                   dyn lib are 32bits (should be 64 bits).

* bug 3869 fixed - In the binaries, we have some useless files in thirdparty/tk8.5/demos/
                   which are causing some issues with the LSB.

* bug 3870 fixed - In the binaries, we incorporate checkstyle in thirdparty/checkstyle/
                   which are causing some issues with the LSB (btw, it is useless in the binary).

* bug 3873 fixed - While editing ticks'label on Axes, mouse click outside box or
                   double clicks or using Tab key, program terminates.

* bug 3874 fixed - When building the macros, only replaces the extension
                   (.sci => .bin).

* bug 3875 fixed - No images in PDF documentation.

* bug 3877 fixed - No use of interp->result any more in the Tcl interface.
                   Compatible with Tcl/Tk 8.6.

* bug 3878 fixed - Under mandriva, the javahelp package is not called jhall but javahelp2.

* bug 3879 fixed - Under mandriva, the batik package is not called batik but batik-all.

* bug 3880 fixed - Bug with p_margin and g_margin fixed.

* bug 3886 fixed - strsubst with regular expression was working only on the first
                   element of the vector.

* bug 3887 fixed - missing installation of scisparse.h and doublecomplex.h.

* bug 3891 fixed - strsubst() replaces wrong characters with the regexp mode and
                   when the subject contains backslahes.

* bug 3892 fixed - example about mfprintf added in help.

* bug 3894 fixed - missing information about status -2 returned by mkdir.

* bug 3895 fixed - example about mputl added in help.

* bug 3897 fixed - macros perturbs the behavior of mfprintf().

* bug 3898 fixed - There was no way to check if mputl() has done his job.
					mputl returns %t or %f to check if function has correctly
					written on the file.

* bug 3899 fixed - The help for "startup" was incorrect.

* bug 3903 fixed - "xdel" of a non existent window crashes Scilab

* bug 3905 fixed - fscanf supports filename and file descriptor as in scilab 4.x.

* bug 3906 fixed - debug(4);exit kills scilab.

* bug 3907 fixed - msprintf with a incorrect format can kill Scilab.

* bug 3912 fixed - strsubst() used with regular expression may return very
                   stange result.

* bug 3918 fixed - The french documentation fails to build when french locales are not available on the system

* bug 3919 fixed - scilab x64 doesn't display graphics from a remote desktop.

* bug 3924 fixed - I used uicontrol with bad parameters, but uicontrol makes Scilab hangs.

* bug 3931 fixed - fileparts returns invalid values with some special filenames.

* bug 3941 fixed - Error in function minreal when used with state-space linear system.

* bug 3947 fixed - format old syntax reintroduced.

* bug 3950 fixed - Invalid index in kpure function (Example in help page failed).

* bug 3951 fixed - krac2 did not work for rational input (Example in help page failed).

* bug 3967 fixed - When called with a tf, pfss should of course return a tf.

* bug 3987 fixed - The relation between the font_size property and the size in
                   point is not clearly given in the help pages.

* bug 3988 fixed - The title help page is not properly formatted.

* bug 3989 fixed - xlfont help updated.

* bug 3991 fixed - It is not possible to set a font_style greater than 10 even
                   if one has added a new font using xlfont.

* bug 3993 fixed - Scilab menu is not located in the "Apple menu bar" like other applications

* bug 3995 fixed - install -D does not work under Mac OS X
                   (used by the make install).

* bug 3996 fixed - tabulation included in a paste string may make scilab crash
                   in -nw or -nwni mode.

* bug 3999 fixed - xbasc() doesn't clear the current graphics window.

* bug 4005 fixed - Only localization system is used (only native now).

* bug 4006 fixed - xlfont does not return the right index.

* bug 4009 fixed - savematfile crashed when could not open the file for writing
                   (error message added).

* bug 4014 fixed - Wrong positioning in console after its clearing.

* bug 4015 fixed - "Flip left to right" no longer worked on hypermatrices.

* bug 4021 fixed - make distclean is cleaning also some temporary help files.

* bug 4022 fixed - Having the source tree and packaged version of Scilab on the
                   same system caused the system library to be loaded first
                   (should be the source tree first).

* bug 4026 fixed - With the "unix" command under Windows, it is not possible to
                   run an external program which has a long path name.

* bug 4027 fixed - Impossible to create hypermatrices under Linux x64
                   (actually a bug with int32 values).

* bug 4037 fixed - wavread detects broadcast file format and returns a error
                   (format not yet managed).

* bug 4046 fixed - core/includes/scisparse.h wasn't installed.

* bug 4052 fixed - Due to a bug in the libxml2 provided by Fedora/Redhat,
				   Scilab was crashing on startup. Scilab binaries under Linux
				   are now shipping libxml2 as a workaround to this bug.

* bug 4055 fixed - From time to time, when I plot a graphic, scilab displays a
                   blank graphic windows. (Windows)

* bug 4094 fixed - delete("all") does not refresh the graphic.

* bug 4106 fixed - bar and barh override drawlater/drawnow mode.

* bug 4108 fixed - Argument location of function caption has no effect.

* bug 4173 fixed - Graphic export : Style the text fonts is not respected when exporting to SVG.

* bug 4174 fixed - the xs2xxx (graphic export) functions don't support paths that start with a tild.

* bug 4186 fixed - uigetfile() uses a hardcoded path in SCI\modules\gui\src\java\org\scilab\modules\gui\filechooser\Juigetfile.java

* bug 4187 fixed - uigetdir() opens on "Desktop" and not on "Computer" on windows

* bug 4221 fixed - graypolarplot uses to much memory.

* bug 4272 fixed - Preconditionning in pcg was not taken into account.

* bug 4761 fixed - memory leak in grep and regexp.

* Side effect in the setenvc function.

* In the binary, the path to the fortran include directory was wrong.

* Some bashims in the starting script were causing startup issues.

* uimenus and uicontrols callbacks were executed two times when their "enable"
  property were set to "on" and they were already enabled.

* Docking bugs fixed (problems with menubar, toolbar, infobar updates).

* bug in the script in charge of the dispatch of localization files fixed
  (tools/localization/dispatchLocalizationFile.sh)

Obsolete functions removed :
============================

* mtlb_load()  (Please use loadmatfile() instead).

* mtlb_save()  (Please use savematfile() instead).

* xbasimp() (Please use toprint() for printing and by xs2ps() for the file export instead).

* xg2ps() (Please use xs2ps() instead).

* hidetoolbar() (Please use toolbar(,'off') instead).

* browsehelp() (Please use helpbrowser() instead).

* quapro() (Please use qpsolve() instead).

* %sp_eye() (Please use speye() instead).

* TCL_gcf() (Please use gcf() instead).

* TCL_scf() (Please use scf() instead).

* TK_EvalStr() (Please use TCL_EvalStr() instead).

* TK_GetVar() (Please use TCL_GetVar() instead).

* TK_SetVar() (Please use TCL_SetVar() instead).

* sciGUIhelp() (Please use help() instead).

* demoplay() (Please use scilab_demos() instead).

* buttondialog() (Please use messagebox() instead).

* tk_getvalue() (Please use getvalue() instead).
