/*
*  Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
*  Copyright (C) 2012 - Scilab Enterprises - Antoine ELIAS
*
*  This file must be used under the terms of the CeCILL.
*  This source file is licensed as described in the file COPYING, which
*  you should have received as part of this distribution.  The terms
*  are also available at
*  http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
*
*/

#define H5_USE_16_API

#ifndef _MSC_VER
#include <sys/time.h>
#else
#include <windows.h>
//#include <winbase.h>
#endif

#include <string.h>
#include <hdf5.h>
#include <stdlib.h>
#include "MALLOC.h"
#include "sci_types.h"
#include "stack3.h"
#include "h5_attributeConstants.h"
#include "h5_readDataFromFile.h"

//#define TIME_DEBUG

static herr_t find_attr_by_name(hid_t loc_id, const char *name, void *data)
{
    return !strcmp(name, (const char *)data);
}

/************************************************************

Operator function.  Prints the name and type of the object
being examined.

************************************************************/
static herr_t op_func(hid_t loc_id, const char *name, void *operator_data)
{
    H5G_stat_t statbuf;
    herr_t status = 0;
    int *pDataSetId = (int*)operator_data;

    /*
     * Get type of the object and return only datasetId
     * through operator_data.
     */
    status = H5Gget_objinfo(loc_id, name, 0, &statbuf);
    if (status < 0)
    {
        return -1;
    }

    switch (statbuf.type)
    {
        case H5G_GROUP:
            break;
        case H5G_DATASET:
            *pDataSetId = (int)H5Dopen(loc_id, name);
            break;
        case H5G_TYPE:
            break;
        default:
            break;
    }

    return 0;
}

static int readIntAttribute(int _iDatasetId, const char *_pstName)
{
    hid_t iAttributeId;
    herr_t status;
    int iVal = -1;

    if (H5Aiterate(_iDatasetId, NULL, find_attr_by_name, (void *)_pstName))
    {
        iAttributeId = H5Aopen_name(_iDatasetId, _pstName);
        if (iAttributeId < 0)
        {
            return -1;
        }

        status = H5Aread(iAttributeId, H5T_NATIVE_INT, &iVal);
        if (status < 0)
        {
            return -1;
        }

        status = H5Aclose(iAttributeId);
        if (status < 0)
        {
            return -1;
        }
    }
    return iVal;
}

/*
** WARNING : this function returns an allocated value that must be freed.
*/
static char* readAttribute(int _iDatasetId, const char *_pstName)
{
    hid_t iAttributeId;
    hid_t iFileType, memtype, iSpace;
    herr_t status;
    hsize_t dims[1];
    size_t iDim;

    char *pstValue = NULL;

    if (H5Aiterate(_iDatasetId, NULL, find_attr_by_name, (void *)_pstName))
    {
        iAttributeId = H5Aopen_name(_iDatasetId, _pstName);
        if (iAttributeId < 0)
        {
            return NULL;
        }
        /*
         * Get the datatype and its size.
         */
        iFileType = H5Aget_type(iAttributeId);
        iDim = H5Tget_size(iFileType);
        iDim++;                 /* Make room for null terminator */

        /*
         * Get dataspace and allocate memory for read buffer.  This is a
         * two dimensional attribute so the dynamic allocation must be done
         * in steps.
         */
        iSpace = H5Aget_space(iAttributeId);
        if (iSpace < 0)
        {
            return NULL;
        }

        status = H5Sget_simple_extent_dims(iSpace, dims, NULL);
        if (status < 0)
        {
            return NULL;
        }

        /*
         * Allocate space for string data.
         */
        pstValue = (char *)MALLOC((size_t) ((dims[0] * iDim + 1) * sizeof(char)));

        /*
         * Create the memory datatype.
         */
        memtype = H5Tcopy(H5T_C_S1);
        status = H5Tset_size(memtype, iDim);
        if (status < 0)
        {
            return NULL;
        }

        /*
         * Read the data.
         */
        status = H5Aread(iAttributeId, memtype, pstValue);
        if (status < 0)
        {
            FREE(pstValue);
            return NULL;
        }

        status = H5Tclose(memtype);
        if (status < 0)
        {
            FREE(pstValue);
            return NULL;
        }

        status = H5Sclose(iSpace);
        if (status < 0)
        {
            FREE(pstValue);
            return NULL;
        }

        status = H5Tclose(iFileType);
        if (status < 0)
        {
            FREE(pstValue);
            return NULL;
        }

        status = H5Aclose(iAttributeId);
        if (status < 0)
        {
            FREE(pstValue);
            return NULL;
        }
    }
    return pstValue;

}

static int checkAttribute(int _iDatasetId, char *_pstAttribute, char *_pstValue)
{
    int iRet = 0;
    char *pstScilabClass = NULL;

    //status = H5Giterate (_iFile, "/", NULL, op_func, &iDatasetId);
    pstScilabClass = readAttribute(_iDatasetId, _pstAttribute);
    if (pstScilabClass != NULL && strcmp(pstScilabClass, _pstValue) == 0)
    {
        iRet = 1;
    }
    if (pstScilabClass)
    {
        FREE(pstScilabClass);
    }
    return iRet;
}

/*
** WARNING : this function returns an allocated value that must be freed.
*/
char* getScilabVersionAttribute(int _iFile)
{
    return readAttribute(_iFile, g_SCILAB_CLASS_SCI_VERSION);
}

int getSODFormatAttribute(int _iFile)
{
    return readIntAttribute(_iFile, g_SCILAB_CLASS_SOD_VERSION);
}

int getDatasetInfo(int _iDatasetId, int* _iComplex, int* _iDims, int* _piDims)
{
    int iSize = 1;
    hid_t data_type;
    H5T_class_t data_class;
    hid_t space = H5Dget_space(_iDatasetId);
    if (space < 0)
    {
        return -1;
    }

    data_type = H5Dget_type(_iDatasetId);
    data_class = H5Tget_class(data_type);
    if (data_class == H5T_COMPOUND)
    {
        *_iComplex = 1;
    }
    else if (data_class == H5T_REFERENCE)
    {
        *_iComplex = isComplexData(_iDatasetId);
    }
    else
    {
        *_iComplex = 0;
    }

    *_iDims = H5Sget_simple_extent_ndims(space);
    if (*_iDims < 0)
    {
        H5Sclose(space);
        return -1;
    }

    if (_piDims != 0)
    {
        int i = 0;
        hsize_t* dims = (hsize_t*)MALLOC(sizeof(hsize_t) * *_iDims);
        if (H5Sget_simple_extent_dims(space, dims, NULL) < 0)
        {
            return -1;
        }

        //reverse dimensions
        for (i = 0 ; i < *_iDims ; i++)
        {
            //reverse dimensions to improve rendering in external tools
            _piDims[i] = (int)dims[*_iDims - 1 - i];
            iSize *= _piDims[i];
        }

    }

    H5Sclose(space);
    return iSize;
}

int getSparseDimension(int _iDatasetId, int *_piRows, int *_piCols, int *_piNbItem)
{
    int iRet = 0;

    //get number of item in the sparse matrix
    getDatasetDims(_iDatasetId, _piRows, _piCols);
    *_piNbItem = readIntAttribute(_iDatasetId, g_SCILAB_CLASS_ITEMS);

    return iRet;
}

static int isEmptyDataset(int _iDatasetId)
{
    return checkAttribute(_iDatasetId, (char *)g_SCILAB_CLASS_EMPTY, "true");
}

int isComplexData(int _iDatasetId)
{
    return checkAttribute(_iDatasetId, (char *)g_SCILAB_CLASS_COMPLEX, "true");
}

int getDatasetPrecision(int _iDatasetId, int *_piPrec)
{
    int iRet = 0;
    char *pstScilabClass = readAttribute(_iDatasetId, g_SCILAB_CLASS_PREC);

    if (pstScilabClass == NULL)
    {
        return -1;
    }
    else if (strcmp(pstScilabClass, "8") == 0)
    {
        *_piPrec = SCI_INT8;
    }
    else if (strcmp(pstScilabClass, "u8") == 0)
    {
        *_piPrec = SCI_UINT8;
    }
    else if (strcmp(pstScilabClass, "16") == 0)
    {
        *_piPrec = SCI_INT16;
    }
    else if (strcmp(pstScilabClass, "u16") == 0)
    {
        *_piPrec = SCI_UINT16;
    }
    else if (strcmp(pstScilabClass, "32") == 0)
    {
        *_piPrec = SCI_INT32;
    }
    else if (strcmp(pstScilabClass, "u32") == 0)
    {
        *_piPrec = SCI_UINT32;
    }
    else if (strcmp(pstScilabClass, "64") == 0)
    {
        *_piPrec = SCI_INT64;
    }
    else if (strcmp(pstScilabClass, "u64") == 0)
    {
        *_piPrec = SCI_UINT64;
    }
    else
    {
        iRet = 1;
    }

    FREE(pstScilabClass);
    return iRet;
}

int getVariableNames(int _iFile, char **pstNameList)
{
    hsize_t i = 0;
    hsize_t iCount = 0;
    herr_t status = 0;
    int iNbItem = 0;

    status = H5Gget_num_objs(_iFile, &iCount);
    if (status != 0)
    {
        return 0;
    }

    for (i = 0; i < iCount; i++)
    {
        if (H5Gget_objtype_by_idx(_iFile, i) == H5G_DATASET)
        {
            if (pstNameList != NULL)
            {
                int iLen = 0;

                iLen = (int)H5Gget_objname_by_idx(_iFile, i, NULL, iLen);
                pstNameList[iNbItem] = (char *)MALLOC(sizeof(char) * (iLen + 1));   //null terminated
                H5Gget_objname_by_idx(_iFile, i, pstNameList[iNbItem], iLen + 1);
            }
            iNbItem++;
        }
    }
    return iNbItem;
}

int getDataSetIdFromName(int _iFile, char *_pstName)
{
    return (int)H5Dopen(_iFile, _pstName);
}

int getDataSetId(int _iFile)
{
    herr_t status = 0;
    int iDatasetId = 0;

    /*
     * Begin iteration.
     */
    status = H5Giterate(_iFile, "/", NULL, op_func, &iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return iDatasetId;
}

int getListDims(int _iDatasetId, int *_piItems)
{
    /*
     * Get dataspace and dimensions of the dataset. This is a
     * two dimensional dataset.
     */
    if (isEmptyDataset(_iDatasetId))
    {
        *_piItems = 0;
    }
    else
    {
        *_piItems = readIntAttribute(_iDatasetId, g_SCILAB_CLASS_ITEMS);
    }
    return 0;
}

int getDatasetDims(int _iDatasetId, int *_piRows, int *_piCols)
{
    /*
     * Get dataspace and dimensions of the dataset. This is a
     * two dimensional dataset.
     */
    if (isEmptyDataset(_iDatasetId))
    {
        *_piCols = 0;
        *_piRows = 0;
    }
    else
    {
        *_piRows = readIntAttribute(_iDatasetId, g_SCILAB_CLASS_ROWS);
        *_piCols = readIntAttribute(_iDatasetId, g_SCILAB_CLASS_COLS);
    }
    return 0;
}

int readDoubleMatrix(int _iDatasetId, double *_pdblData)
{
    herr_t status;

    //Read the data.
    status = H5Dread(_iDatasetId, H5T_NATIVE_DOUBLE, H5S_ALL, H5S_ALL, H5P_DEFAULT, _pdblData);
    if (status < 0)
    {
        return -1;
    }

    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}

int readDoubleComplexMatrix(int _iDatasetId, double *_pdblReal, double *_pdblImg)
{
    hid_t compoundId;
    herr_t status;
    int iDims = 0;
    int* piDims = NULL;
    int iComplex = 0;
    int iSize = 1;
    doublecomplex* pData = NULL;

    /*define compound dataset*/
    compoundId = H5Tcreate(H5T_COMPOUND, sizeof(doublecomplex));
    H5Tinsert(compoundId, "real", HOFFSET(doublecomplex, r), H5T_NATIVE_DOUBLE);
    H5Tinsert(compoundId, "imag", HOFFSET(doublecomplex, i), H5T_NATIVE_DOUBLE);

    //get dimension from dataset
    getDatasetInfo(_iDatasetId, &iComplex, &iDims, NULL);
    piDims = (int*)MALLOC(sizeof(int) * iDims);
    iSize = getDatasetInfo(_iDatasetId, &iComplex, &iDims, piDims);

    FREE(piDims);
    //alloc temp array
    pData = (doublecomplex*)MALLOC(sizeof(doublecomplex) * iSize);
    //Read the data.
    status = H5Dread(_iDatasetId, compoundId, H5S_ALL, H5S_ALL, H5P_DEFAULT, pData);
    if (status < 0)
    {
        return -1;
    }


    vGetPointerFromDoubleComplex(pData, iSize, _pdblReal, _pdblImg);
    FREE(pData);
    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}

int readEmptyMatrix(int _iDatasetId)
{
    //close dataset
    herr_t status;

    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}

int readBooleanMatrix(int _iDatasetId, int *_piData)
{
    herr_t status = 0;

    /*
     * Read the data.
     */
    status = H5Dread(_iDatasetId, H5T_NATIVE_INT, H5S_ALL, H5S_ALL, H5P_DEFAULT, _piData);
    if (status < 0)
    {
        return -1;
    }

    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}

int readStringMatrix(int _iDatasetId, char **_pstData)
{
    herr_t status;
    hid_t typeId;

    typeId = H5Tcopy(H5T_C_S1);
    status = H5Tset_size(typeId, H5T_VARIABLE);
    if (status < 0)
    {
        return -1;
    }

    //Read the data.
    status = H5Dread(_iDatasetId, typeId, H5S_ALL, H5S_ALL, H5P_DEFAULT, _pstData);
    if (status < 0)
    {
        return -1;
    }

    status = H5Tclose(typeId);
    if (status < 0)
    {
        return -1;
    }

    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}

static int readComplexPoly(int _iDatasetId, int *_piNbCoef, double **_pdblReal, double **_pdblImg)
{
    int iComplex = 0;
    int iSize = 0;
    int iDims = 0;
    //Get the datatype and its size.

    iSize = getDatasetInfo(_iDatasetId, &iComplex, &iDims, _piNbCoef);

    //Allocate space for string data.
    *_pdblReal = (double *)MALLOC(*_piNbCoef * sizeof(double));
    *_pdblImg = (double *)MALLOC(*_piNbCoef * sizeof(double));

    //Read the data and return result.
    return readDoubleComplexMatrix(_iDatasetId, *_pdblReal, *_pdblImg);
}

static int readPoly(int _iDatasetId, int *_piNbCoef, double **_pdblData)
{
    int iComplex = 0;
    int iSize = 0;
    int iDims = 0;
    //Get the datatype and its size.
    iSize = getDatasetInfo(_iDatasetId, &iComplex, &iDims, _piNbCoef);

    *_pdblData = (double *)MALLOC(*_piNbCoef * sizeof(double));

    //Read the data and return result.
    return readDoubleMatrix(_iDatasetId, *_pdblData);
}

int readCommonPolyMatrix(int _iDatasetId, char *_pstVarname, int _iComplex, int _iDims, int* _piDims, int *_piNbCoef, double **_pdblReal, double **_pdblImg)
{
    int i = 0;
    hid_t obj = 0;
    char *pstVarName = 0;
    hobj_ref_t *pData = NULL;
    herr_t status;
    int iSize = 1;

    for (i = 0 ; i < _iDims ; i++)
    {
        iSize *= _piDims[i];
    }

    pData = (hobj_ref_t *) MALLOC(iSize * sizeof(hobj_ref_t));

    /*
     * Read the data.
     */
    status = H5Dread(_iDatasetId, H5T_STD_REF_OBJ, H5S_ALL, H5S_ALL, H5P_DEFAULT, pData);
    if (status < 0)
    {
        FREE(pData);
        return -1;
    }

    for (i = 0; i < iSize; i++)
    {
        /*
         * Open the referenced object, get its name and type.
         */
        obj = H5Rdereference(_iDatasetId, H5R_OBJECT, &pData[i]);
        if (_iComplex)
        {
            status = readComplexPoly((int)obj, &_piNbCoef[i], &_pdblReal[i], &_pdblImg[i]);
        }
        else
        {
            status = readPoly((int)obj, &_piNbCoef[i], &_pdblReal[i]);
        }

        if (status < 0)
        {
            FREE(pData);
            return -1;
        }
    }

    pstVarName = readAttribute(_iDatasetId, g_SCILAB_CLASS_VARNAME);
    strcpy(_pstVarname, pstVarName);
    FREE(pstVarName);
    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        FREE(pData);
        return -1;
    }

    FREE(pData);

    return 0;
}

int readPolyMatrix(int _iDatasetId, char *_pstVarname, int _iDims, int* _piDims, int *_piNbCoef, double **_pdblData)
{
    return readCommonPolyMatrix(_iDatasetId, _pstVarname, 0, _iDims, _piDims, _piNbCoef, _pdblData, NULL);
}

int readPolyComplexMatrix(int _iDatasetId, char *_pstVarname, int _iDims, int* _piDims, int *_piNbCoef, double **_pdblReal, double **_pdblImg)
{
    return readCommonPolyMatrix(_iDatasetId, _pstVarname, 1, _iDims, _piDims, _piNbCoef, _pdblReal, _pdblImg);
}

int readInteger8Matrix(int _iDatasetId, char *_pcData)
{
    herr_t status = 0;

    /*
     * Read the data.
     */
    status = H5Dread(_iDatasetId, H5T_NATIVE_INT8, H5S_ALL, H5S_ALL, H5P_DEFAULT, _pcData);
    if (status < 0)
    {
        return -1;
    }

    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}

int readInteger16Matrix(int _iDatasetId, short *_psData)
{
    herr_t status = 0;

    /*
     * Read the data.
     */
    status = H5Dread(_iDatasetId, H5T_NATIVE_INT16, H5S_ALL, H5S_ALL, H5P_DEFAULT, _psData);
    if (status < 0)
    {
        return -1;
    }

    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}

int readInteger32Matrix(int _iDatasetId, int *_piData)
{
    herr_t status = 0;

    /*
     * Read the data.
     */
    status = H5Dread(_iDatasetId, H5T_NATIVE_INT32, H5S_ALL, H5S_ALL, H5P_DEFAULT, _piData);
    if (status < 0)
    {
        return -1;
    }

    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}

int readInteger64Matrix(int _iDatasetId, long long *_pllData)
{
    herr_t status = 0;

    /*
     * Read the data.
     */
    status = H5Dread(_iDatasetId, H5T_NATIVE_INT64, H5S_ALL, H5S_ALL, H5P_DEFAULT, _pllData);
    if (status < 0)
    {
        return -1;
    }

    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}

int readUnsignedInteger8Matrix(int _iDatasetId, unsigned char *_pucData)
{
    herr_t status = 0;

    /*
     * Read the data.
     */
    status = H5Dread(_iDatasetId, H5T_NATIVE_UINT8, H5S_ALL, H5S_ALL, H5P_DEFAULT, _pucData);
    if (status < 0)
    {
        return -1;
    }

    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}

int readUnsignedInteger16Matrix(int _iDatasetId, unsigned short *_pusData)
{
    herr_t status = 0;

    /*
     * Read the data.
     */
    status = H5Dread(_iDatasetId, H5T_NATIVE_UINT16, H5S_ALL, H5S_ALL, H5P_DEFAULT, _pusData);
    if (status < 0)
    {
        return -1;
    }

    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}

int readUnsignedInteger32Matrix(int _iDatasetId, unsigned int *_puiData)
{
    herr_t status = 0;

    /*
     * Read the data.
     */
    status = H5Dread(_iDatasetId, H5T_NATIVE_UINT32, H5S_ALL, H5S_ALL, H5P_DEFAULT, _puiData);
    if (status < 0)
    {
        return -1;
    }

    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}

int readUnsignedInteger64Matrix(int _iDatasetId, unsigned long long *_pullData)
{
    herr_t status = 0;

    /*
     * Read the data.
     */
    status = H5Dread(_iDatasetId, H5T_NATIVE_UINT64, H5S_ALL, H5S_ALL, H5P_DEFAULT, _pullData);
    if (status < 0)
    {
        return -1;
    }

    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}

int readCommonSparseComplexMatrix(int _iDatasetId, int _iComplex, int _iRows, int _iCols, int _iNbItem, int *_piNbItemRow, int *_piColPos, double *_pdblReal, double *_pdblImg)
{
    hid_t obj = 0;
    hobj_ref_t pRef[3] = {0};
    herr_t status;

    /*
     * Read the data.
     */
    status = H5Dread(_iDatasetId, H5T_STD_REF_OBJ, H5S_ALL, H5S_ALL, H5P_DEFAULT, pRef);
    if (status < 0)
    {
        return -1;
    }

    //read Row data
    obj = H5Rdereference(_iDatasetId, H5R_OBJECT, &pRef[0]);
    status = readInteger32Matrix((int)obj, _piNbItemRow);
    if (status < 0)
    {
        return -1;
    }

    //read cols data
    obj = H5Rdereference(_iDatasetId, H5R_OBJECT, &pRef[1]);
    status = readInteger32Matrix((int)obj, _piColPos);
    if (status < 0)
    {
        return -1;
    }

    //read sparse data
    obj = H5Rdereference(_iDatasetId, H5R_OBJECT, &pRef[2]);

    if (_iComplex)
    {
        status = readDoubleComplexMatrix((int)obj, _pdblReal, _pdblImg);
    }
    else
    {
        status = readDoubleMatrix((int)obj, _pdblReal);
    }

    if (status < 0)
    {
        return -1;
    }

    return 0;
}

int readSparseMatrix(int _iDatasetId, int _iRows, int _iCols, int _iNbItem, int *_piNbItemRow, int *_piColPos, double *_pdblReal)
{
    return readCommonSparseComplexMatrix(_iDatasetId, 0, _iRows, _iCols, _iNbItem, _piNbItemRow, _piColPos, _pdblReal, NULL);
}

int readSparseComplexMatrix(int _iDatasetId, int _iRows, int _iCols, int _iNbItem, int *_piNbItemRow, int *_piColPos, double *_pdblReal, double *_pdblImg)
{
    return readCommonSparseComplexMatrix(_iDatasetId, 1, _iRows, _iCols, _iNbItem, _piNbItemRow, _piColPos, _pdblReal, _pdblImg);
}

int readBooleanSparseMatrix(int _iDatasetId, int _iRows, int _iCols, int _iNbItem, int *_piNbItemRow, int *_piColPos)
{
    hid_t obj = 0;
    hobj_ref_t pRef[2] = {0};
    herr_t status;

    /*
     * Read the data.
     */
    status = H5Dread(_iDatasetId, H5T_STD_REF_OBJ, H5S_ALL, H5S_ALL, H5P_DEFAULT, pRef);
    if (status < 0)
    {
        return -1;
    }

    //read Row data
    obj = H5Rdereference(_iDatasetId, H5R_OBJECT, &pRef[0]);
    status = readInteger32Matrix((int)obj, _piNbItemRow);
    if (status < 0)
    {
        return -1;
    }

    if (_iNbItem != 0)
    {
        //read cols data
        obj = H5Rdereference(_iDatasetId, H5R_OBJECT, &pRef[1]);
        status = readInteger32Matrix((int)obj, _piColPos);
        if (status < 0)
        {
            return -1;
        }
    }
    return 0;
}

int getScilabTypeFromDataSet(int _iDatasetId)
{
    int iVarType = 0;
    char *pstScilabClass = readAttribute(_iDatasetId, g_SCILAB_CLASS);

    if (pstScilabClass == NULL)
    {
        return unknow_type;
    }
    /* HDF5 Float type + SCILAB_Class = double <=> double */
    if (strcmp(pstScilabClass, g_SCILAB_CLASS_DOUBLE) == 0)
    {
        iVarType = sci_matrix;
    }
    else if (strcmp(pstScilabClass, g_SCILAB_CLASS_STRING) == 0)
    {
        iVarType = sci_strings;
    }
    else if (strcmp(pstScilabClass, g_SCILAB_CLASS_BOOLEAN) == 0)
    {
        iVarType = sci_boolean;
    }
    else if (strcmp(pstScilabClass, g_SCILAB_CLASS_BOOLEAN) == 0)
    {
        iVarType = sci_boolean;
    }
    else if (strcmp(pstScilabClass, g_SCILAB_CLASS_POLY) == 0)
    {
        iVarType = sci_poly;
    }
    else if (strcmp(pstScilabClass, g_SCILAB_CLASS_INT) == 0)
    {
        iVarType = sci_ints;
    }
    else if (strcmp(pstScilabClass, g_SCILAB_CLASS_SPARSE) == 0)
    {
        iVarType = sci_sparse;
    }
    else if (strcmp(pstScilabClass, g_SCILAB_CLASS_BSPARSE) == 0)
    {
        iVarType = sci_boolean_sparse;
    }
    else if (strcmp(pstScilabClass, g_SCILAB_CLASS_LIST) == 0)
    {
        iVarType = sci_list;
    }
    else if (strcmp(pstScilabClass, g_SCILAB_CLASS_TLIST) == 0)
    {
        iVarType = sci_tlist;
    }
    else if (strcmp(pstScilabClass, g_SCILAB_CLASS_MLIST) == 0)
    {
        iVarType = sci_mlist;
    }
    else if (strcmp(pstScilabClass, g_SCILAB_CLASS_VOID) == 0)
    {
        iVarType = sci_void;
    }
    else if (strcmp(pstScilabClass, g_SCILAB_CLASS_UNDEFINED) == 0)
    {
        iVarType = sci_undefined;
    }

    FREE(pstScilabClass);
    return iVarType;
}

int getListItemReferences(int _iDatasetId, hobj_ref_t ** _piItemRef)
{
    int iItem = 0;
    herr_t status = 0;

    getListDims(_iDatasetId, &iItem);

    *_piItemRef = (hobj_ref_t *) MALLOC(iItem * sizeof(hobj_ref_t));

    status = H5Dread(_iDatasetId, H5T_STD_REF_OBJ, H5S_ALL, H5S_ALL, H5P_DEFAULT, *_piItemRef);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}

int getListItemDataset(int _iDatasetId, void *_piItemRef, int _iItemPos, int *_piItemDataset)
{
    hobj_ref_t poRef = ((hobj_ref_t *) _piItemRef)[_iItemPos];

    *_piItemDataset = (int)H5Rdereference(_iDatasetId, H5R_OBJECT, &poRef);

    if (*_piItemDataset == 0)
    {
        return -1;
    }

    return 0;
}

int deleteListItemReferences(int _iDatasetId, void *_piItemRef)
{
    herr_t status;

    if (_piItemRef)
    {
        hobj_ref_t *poRef = (hobj_ref_t *) _piItemRef;

        FREE(poRef);
    }

    status = H5Dclose(_iDatasetId);
    if (status < 0)
    {
        return -1;
    }

    return 0;
}
