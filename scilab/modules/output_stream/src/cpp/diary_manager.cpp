/*
* Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
* Copyright (C) 2009 - DIGITEO - Allan CORNET
*
* This file must be used under the terms of the CeCILL.
* This source file is licensed as described in the file COPYING, which
* you should have received as part of this distribution.  The terms
* are also available at
* http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
*
*/
/*--------------------------------------------------------------------------*/
#include "diary_manager.hxx"
#include "DiaryList.hxx"
#include "diary.h"
#include "MALLOC.h"
/*--------------------------------------------------------------------------*/
static DiaryList *SCIDIARY = NULL;
/*--------------------------------------------------------------------------*/
static int createDiaryManager(void)
{
    if (SCIDIARY == NULL)
    {
        SCIDIARY = new DiaryList();
        return 0;
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
static int destroyDiaryManager(void)
{
    if (SCIDIARY)
    {
        delete SCIDIARY;
        SCIDIARY = NULL;
        return 0;
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
wchar_t *getDiaryFilename(int _Id)
{
    wchar_t *wcFilename = NULL;
    if (SCIDIARY)
    {
        if (SCIDIARY->getFilename(_Id).compare(L""))
        {
            wcFilename = (wchar_t*) MALLOC(sizeof(wchar_t) * (SCIDIARY->getFilename(_Id).length() + 1));
            if (wcFilename)
            {
                wcscpy(wcFilename, SCIDIARY->getFilename(_Id).c_str());
            }
        }
    }
    return wcFilename;
}
/*--------------------------------------------------------------------------*/
wchar_t **getDiaryFilenames(int *array_size)
{
    *array_size = 0;
    if (SCIDIARY)
    {
        std::wstring * wstringFilenames = SCIDIARY->getFilenames(array_size);
        /* all other uses of array_size include dereferences, so I assume
         * one was intended here, too: */
        if (*array_size > 0)
        {
            wchar_t **wcFilenames = (wchar_t **) MALLOC (sizeof(wchar_t*) * (*array_size));
            for (int i = 0; i < *array_size; i++)
            {
                wcFilenames[i] = (wchar_t*) MALLOC(sizeof(wchar_t) * (wstringFilenames[i].length() + 1));
                wcscpy(wcFilenames[i], wstringFilenames[i].c_str());
            }
            return wcFilenames;
        }
    }
    return NULL;
}
/*--------------------------------------------------------------------------*/
int *getDiaryIDs(int *array_size)
{
    *array_size = 0;
    if (SCIDIARY)
    {
        int *iIDs = SCIDIARY->getIDs(array_size);
        return iIDs;
    }
    return NULL;
}
/*--------------------------------------------------------------------------*/
double *getDiaryIDsAsDouble(int *array_size)
{
    int *iIDs = getDiaryIDs(array_size);
    if (*array_size > 0)
    {
        if (iIDs)
        {
            double *dIDs = new double[*array_size];
            for (int i = 0; i < *array_size; i++)
            {
                dIDs[i] = (double)iIDs[i];
            }
            delete [] iIDs;
            return dIDs;
        }
        else
        {
            *array_size = 0;
        }
    }
    return NULL;
}
/*--------------------------------------------------------------------------*/
int diaryCloseAll(void)
{
    destroyDiaryManager();
    return 0;
}
/*--------------------------------------------------------------------------*/
int diaryClose(int _iId)
{
    if (SCIDIARY)
    {
        if (_iId > 0)
        {
            if (SCIDIARY->closeDiary(_iId))
            {
                return 0;
            }
        }
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
int diaryClose(wchar_t *filename)
{
    if (SCIDIARY)
    {
        int iID = SCIDIARY->getID(filename);
        if (iID > 0)
        {
            if (SCIDIARY->closeDiary(iID))
            {
                return 0;
            }
        }
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
int diaryPauseAll(void)
{
    if (SCIDIARY)
    {
        SCIDIARY->setSuspendWrite(true);
        return 0;
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
int diaryPause(int _iId)
{
    if (SCIDIARY)
    {
        SCIDIARY->setSuspendWrite(_iId, true);
        return 0;
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
int diaryPause(wchar_t *filename)
{
    if (SCIDIARY)
    {
        int iID = SCIDIARY->getID(std::wstring(filename));
        if (iID != -1)
        {
            SCIDIARY->setSuspendWrite(iID, true);
            return 0;
        }
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
int diaryResumeAll(void)
{
    if (SCIDIARY)
    {
        SCIDIARY->setSuspendWrite(false);
        return 0;
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
int diaryResume(int _iId)
{
    if (SCIDIARY)
    {
        SCIDIARY->setSuspendWrite(_iId, false);
        return 0;
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
int diaryResume(wchar_t *filename)
{
    if (SCIDIARY)
    {
        int iID = SCIDIARY->getID(std::wstring(filename));
        if (iID != -1)
        {
            SCIDIARY->setSuspendWrite(iID, false);
            return 0;
        }
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
int diaryExists(int _iId)
{
    if (SCIDIARY)
    {
        if (SCIDIARY->exists(_iId))
        {
            return 0;
        }
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
int diaryExists(wchar_t *filename)
{
    if (SCIDIARY)
    {
        if (SCIDIARY->exists(std::wstring(filename)))
        {
            return 0;
        }
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
int diaryNew(wchar_t *filename, bool autorename)
{
    createDiaryManager();

    if (SCIDIARY)
    {
        return SCIDIARY->openDiary(std::wstring(filename), autorename);
    }

    return -1;
}
/*--------------------------------------------------------------------------*/
int diaryAppend(wchar_t *filename)
{
    createDiaryManager();
    if (SCIDIARY)
    {
        return SCIDIARY->openDiary(std::wstring(filename), 1, false);
    }
    return -1;
}
/*--------------------------------------------------------------------------*/
int diaryWrite(wchar_t *wstr, BOOL bInput)
{
    if (SCIDIARY)
    {
        if (bInput)
        {
            SCIDIARY->write(std::wstring(wstr), true);
        }
        else
        {
            SCIDIARY->write(std::wstring(wstr), false);
        }
        return 0;
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
int diaryWriteln(wchar_t *wstr, BOOL bInput)
{
    if (SCIDIARY)
    {
        if (bInput)
        {
            SCIDIARY->writeln(std::wstring(wstr), true);
        }
        else
        {
            SCIDIARY->writeln(std::wstring(wstr), false);
        }
        return 0;
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
int diarySetFilterMode(int _iId, diary_filter mode)
{
    if (SCIDIARY)
    {
        SCIDIARY->setFilterMode(_iId, mode);
        return 0;
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
int diarySetPrefixMode(int ID_diary, diary_prefix_time_format iPrefixMode)
{
    if (SCIDIARY)
    {
        SCIDIARY->setPrefixMode(ID_diary, iPrefixMode);
        return 0;
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
int diaryGetPrefixMode(int ID_diary)
{
    if (SCIDIARY)
    {
        return SCIDIARY->getPrefixMode(ID_diary);
    }
    return -1;
}
/*--------------------------------------------------------------------------*/
int diarySetPrefixIoModeFilter(int ID_diary, diary_prefix_time_filter mode)
{
    if (SCIDIARY)
    {
        SCIDIARY->setPrefixIoModeFilter(ID_diary, mode);
        return 0;
    }
    return 1;
}
/*--------------------------------------------------------------------------*/
diary_prefix_time_filter diaryGetPrefixIoModeFilter(int ID_diary)
{
    if (SCIDIARY)
    {
        return SCIDIARY->getPrefixIoModeFilter(ID_diary);
    }
    return PREFIX_FILTER_ERROR;
}
/*--------------------------------------------------------------------------*/
