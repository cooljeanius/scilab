/* ----------------------------------------------------------------------------
 * This file was automatically generated by SWIG (http://www.swig.org).
 * Version 3.0.5
 *
 * Do not make changes to this file unless you know what you are doing--modify
 * the SWIG interface file instead.
 * ----------------------------------------------------------------------------- */

package org.scilab.modules.xcos;

public class JavaControllerJNI {
    public final static native long new_View();
    public final static native void delete_View(long jarg1);
    public final static native void View_objectCreated(long jarg1, View jarg1_, long jarg2, int jarg3);
    public final static native void View_objectDeleted(long jarg1, View jarg1_, long jarg2, int jarg3);
    public final static native void View_objectUpdated(long jarg1, View jarg1_, long jarg2, int jarg3);
    public final static native void View_propertyUpdated__SWIG_0(long jarg1, View jarg1_, long jarg2, int jarg3, int jarg4);
    public final static native void View_propertyUpdated__SWIG_1(long jarg1, View jarg1_, long jarg2, int jarg3, int jarg4, int jarg5);
    public final static native void View_director_connect(View obj, long cptr, boolean mem_own, boolean weak_global);
    public final static native void View_change_ownership(View obj, long cptr, boolean take_or_release);
    public final static native long new_Controller();
    public final static native void delete_Controller(long jarg1);
    public final static native long Controller_createObject(long jarg1, Controller jarg1_, int jarg2);
    public final static native long Controller_referenceObject(long jarg1, Controller jarg1_, long jarg2);
    public final static native void Controller_deleteObject(long jarg1, Controller jarg1_, long jarg2);
    public final static native long Controller_cloneObject(long jarg1, Controller jarg1_, long jarg2, boolean jarg3);
    public final static native boolean Controller_getObjectProperty__SWIG_1(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, int[] jarg5);
    public final static native boolean Controller_getObjectProperty__SWIG_2(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, double[] jarg5);
    public final static native boolean Controller_getObjectProperty__SWIG_3(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, String[] jarg5);
    public final static native boolean Controller_getObjectProperty__SWIG_4(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, long[] jarg5);
    public final static native boolean Controller_getObjectProperty__SWIG_5(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, long jarg5, VectorOfInt jarg5_);
    public final static native boolean Controller_getObjectProperty__SWIG_6(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, long jarg5, VectorOfDouble jarg5_);
    public final static native boolean Controller_getObjectProperty__SWIG_7(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, long jarg5, VectorOfString jarg5_);
    public final static native boolean Controller_getObjectProperty__SWIG_8(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, long jarg5, VectorOfScicosID jarg5_);
    public final static native int Controller_setObjectProperty__SWIG_1(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, int jarg5);
    public final static native int Controller_setObjectProperty__SWIG_2(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, double jarg5);
    public final static native int Controller_setObjectProperty__SWIG_3(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, String jarg5);
    public final static native int Controller_setObjectProperty__SWIG_4(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, long jarg5);
    public final static native int Controller_setObjectProperty__SWIG_5(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, long jarg5, VectorOfInt jarg5_);
    public final static native int Controller_setObjectProperty__SWIG_6(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, long jarg5, VectorOfDouble jarg5_);
    public final static native int Controller_setObjectProperty__SWIG_7(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, long jarg5, VectorOfString jarg5_);
    public final static native int Controller_setObjectProperty__SWIG_8(long jarg1, Controller jarg1_, long jarg2, int jarg3, int jarg4, long jarg5, VectorOfScicosID jarg5_);
    public final static native long new_VectorOfDouble__SWIG_0();
    public final static native long new_VectorOfDouble__SWIG_1(long jarg1);
    public final static native long VectorOfDouble_size(long jarg1, VectorOfDouble jarg1_);
    public final static native long VectorOfDouble_capacity(long jarg1, VectorOfDouble jarg1_);
    public final static native void VectorOfDouble_reserve(long jarg1, VectorOfDouble jarg1_, long jarg2);
    public final static native boolean VectorOfDouble_isEmpty(long jarg1, VectorOfDouble jarg1_);
    public final static native void VectorOfDouble_clear(long jarg1, VectorOfDouble jarg1_);
    public final static native void VectorOfDouble_add(long jarg1, VectorOfDouble jarg1_, double jarg2);
    public final static native double VectorOfDouble_get(long jarg1, VectorOfDouble jarg1_, int jarg2);
    public final static native void VectorOfDouble_set(long jarg1, VectorOfDouble jarg1_, int jarg2, double jarg3);
    public final static native void delete_VectorOfDouble(long jarg1);
    public final static native long new_VectorOfInt__SWIG_0();
    public final static native long new_VectorOfInt__SWIG_1(long jarg1);
    public final static native long VectorOfInt_size(long jarg1, VectorOfInt jarg1_);
    public final static native long VectorOfInt_capacity(long jarg1, VectorOfInt jarg1_);
    public final static native void VectorOfInt_reserve(long jarg1, VectorOfInt jarg1_, long jarg2);
    public final static native boolean VectorOfInt_isEmpty(long jarg1, VectorOfInt jarg1_);
    public final static native void VectorOfInt_clear(long jarg1, VectorOfInt jarg1_);
    public final static native void VectorOfInt_add(long jarg1, VectorOfInt jarg1_, int jarg2);
    public final static native int VectorOfInt_get(long jarg1, VectorOfInt jarg1_, int jarg2);
    public final static native void VectorOfInt_set(long jarg1, VectorOfInt jarg1_, int jarg2, int jarg3);
    public final static native void delete_VectorOfInt(long jarg1);
    public final static native long new_VectorOfBool__SWIG_0();
    public final static native long new_VectorOfBool__SWIG_1(long jarg1);
    public final static native long VectorOfBool_size(long jarg1, VectorOfBool jarg1_);
    public final static native long VectorOfBool_capacity(long jarg1, VectorOfBool jarg1_);
    public final static native void VectorOfBool_reserve(long jarg1, VectorOfBool jarg1_, long jarg2);
    public final static native boolean VectorOfBool_isEmpty(long jarg1, VectorOfBool jarg1_);
    public final static native void VectorOfBool_clear(long jarg1, VectorOfBool jarg1_);
    public final static native void VectorOfBool_add(long jarg1, VectorOfBool jarg1_, boolean jarg2);
    public final static native boolean VectorOfBool_get(long jarg1, VectorOfBool jarg1_, int jarg2);
    public final static native void VectorOfBool_set(long jarg1, VectorOfBool jarg1_, int jarg2, boolean jarg3);
    public final static native void delete_VectorOfBool(long jarg1);
    public final static native long new_VectorOfString__SWIG_0();
    public final static native long new_VectorOfString__SWIG_1(long jarg1);
    public final static native long VectorOfString_size(long jarg1, VectorOfString jarg1_);
    public final static native long VectorOfString_capacity(long jarg1, VectorOfString jarg1_);
    public final static native void VectorOfString_reserve(long jarg1, VectorOfString jarg1_, long jarg2);
    public final static native boolean VectorOfString_isEmpty(long jarg1, VectorOfString jarg1_);
    public final static native void VectorOfString_clear(long jarg1, VectorOfString jarg1_);
    public final static native void VectorOfString_add(long jarg1, VectorOfString jarg1_, String jarg2);
    public final static native String VectorOfString_get(long jarg1, VectorOfString jarg1_, int jarg2);
    public final static native void VectorOfString_set(long jarg1, VectorOfString jarg1_, int jarg2, String jarg3);
    public final static native void delete_VectorOfString(long jarg1);
    public final static native long new_VectorOfScicosID__SWIG_0();
    public final static native long new_VectorOfScicosID__SWIG_1(long jarg1);
    public final static native long VectorOfScicosID_size(long jarg1, VectorOfScicosID jarg1_);
    public final static native long VectorOfScicosID_capacity(long jarg1, VectorOfScicosID jarg1_);
    public final static native void VectorOfScicosID_reserve(long jarg1, VectorOfScicosID jarg1_, long jarg2);
    public final static native boolean VectorOfScicosID_isEmpty(long jarg1, VectorOfScicosID jarg1_);
    public final static native void VectorOfScicosID_clear(long jarg1, VectorOfScicosID jarg1_);
    public final static native void VectorOfScicosID_add(long jarg1, VectorOfScicosID jarg1_, long jarg2);
    public final static native long VectorOfScicosID_get(long jarg1, VectorOfScicosID jarg1_, int jarg2);
    public final static native void VectorOfScicosID_set(long jarg1, VectorOfScicosID jarg1_, int jarg2, long jarg3);
    public final static native void delete_VectorOfScicosID(long jarg1);
    public final static native void register_view(String jarg1, long jarg2, View jarg2_);

    static {
        try {
            System.loadLibrary("scixcos");
        } catch (SecurityException e) {
            System.err.println("A security manager exists and does not allow the loading of the specified dynamic library.");
            System.err.println(e.getLocalizedMessage());
            System.exit(-1);
        } catch (UnsatisfiedLinkError e)    {
            System.err.println("The native library scicommons does not exist or cannot be found.");
            if (System.getenv("CONTINUE_ON_JNI_ERROR") == null) {
                System.err.println(e.getLocalizedMessage());
                System.err.println("Current java.library.path is : " + System.getProperty("java.library.path"));
                System.exit(-1);
            } else {
                System.err.println("Continuing anyway because of CONTINUE_ON_JNI_ERROR");
            }
        }
    }


    public static void SwigDirector_View_objectCreated(View jself, long uid, int k) {
        jself.objectCreated(uid, Kind.class.getEnumConstants()[k]);
    }
    public static void SwigDirector_View_objectDeleted(View jself, long uid, int k) {
        jself.objectDeleted(uid, Kind.class.getEnumConstants()[k]);
    }
    public static void SwigDirector_View_objectUpdated(View jself, long uid, int k) {
        jself.objectUpdated(uid, Kind.class.getEnumConstants()[k]);
    }
    public static void SwigDirector_View_propertyUpdated__SWIG_0(View jself, long uid, int k, int p) {
        jself.propertyUpdated(uid, Kind.class.getEnumConstants()[k], ObjectProperties.class.getEnumConstants()[p]);
    }

    private final static native void swig_module_init();
    static {
        swig_module_init();
    }
}