/*
 * Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 * Copyright (C) 2007-2008 - INRIA - Allan CORNET
 * Copyright (C) 2010 - DIGITEO - Allan CORNET
 *
 * This file must be used under the terms of the CeCILL.
 * This source file is licensed as described in the file COPYING, which
 * you should have received as part of this distribution.  The terms
 * are also available at
 * http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

/*------------------------------------------------------------------------*/
#include <time.h>
#include <stdio.h>
#include <string.h>             /* strlen */
#include "getCommentDateSession.h"
#include "MALLOC.h"
#include "BOOL.h"
#include "localization.h"
#ifdef _MSC_VER
#include "strdup_windows.h"
#endif
#include "freeArrayOfString.h"
/*------------------------------------------------------------------------*/
#define STRING_BEGIN_SESSION _("Begin Session : ")
#define FORMAT_SESSION "%s%s%s"
#define LONG_FORMAT_SESSION "%s%s%s%s"
#define MAX_wday 7              /* number days in a week */
#define MAX_mon 12              /* number of month in a year */
/*------------------------------------------------------------------------*/
static char *ASCIItime(const struct tm *timeptr);
static char *ASCIItimeShort(const struct tm *timeptr);
static const char **getDays(void);
static const char **getMonths(void);

/*------------------------------------------------------------------------*/
char *getCommentDateSession(BOOL longFormat)
{
    char *line = NULL;
    char *time_str = NULL;
    time_t timer = time(NULL);

    if (longFormat)
    {
        time_str = ASCIItime(localtime(&timer));
    }
    else
    {
        time_str = ASCIItimeShort(localtime(&timer));
    }

    if (time_str)
    {
        size_t historyLineSize = (strlen(SESSION_PRAGMA_BEGIN)
                                  + strlen(time_str) + strlen(FORMAT_SESSION)
                                  + strlen(SESSION_PRAGMA_END) + 1UL);

        size_t lineSize;
        if (longFormat)
        {
            historyLineSize += strlen(STRING_BEGIN_SESSION);
        }

        lineSize = ((sizeof(char) * historyLineSize) * 2UL);
        line = (char *)MALLOC(lineSize);

        if (line)
        {
            if (longFormat)
            {
                snprintf(line, lineSize, LONG_FORMAT_SESSION,
                         SESSION_PRAGMA_BEGIN, STRING_BEGIN_SESSION, time_str,
                         SESSION_PRAGMA_END);
            }
            else
            {
                snprintf(line, lineSize, FORMAT_SESSION, SESSION_PRAGMA_BEGIN,
                         time_str, SESSION_PRAGMA_END);
            }
        }
        FREE(time_str);
        time_str = NULL;
    }

    return line;
}

/*------------------------------------------------------------------------*/
static char *ASCIItime(const struct tm *timeptr)
{
    const char **wday_name = getDays();
    const char **mon_name = getMonths();
    char *result = NULL;

    if ((wday_name) && (mon_name))
    {
#define FORMAT_TIME "%s %s%3d %.2d:%.2d:%.2d %d"
        const size_t len_result = (strlen(wday_name[timeptr->tm_wday])
                                   + strlen(mon_name[timeptr->tm_mon])
                                   + strlen(FORMAT_TIME));

        const size_t result_len = (sizeof(char) * (len_result + 2UL));
        result = (char *)MALLOC(result_len);
        if (result)
        {
            snprintf(result, result_len, FORMAT_TIME,
                     wday_name[timeptr->tm_wday], mon_name[timeptr->tm_mon],
                     timeptr->tm_mday, timeptr->tm_hour, timeptr->tm_min,
                     timeptr->tm_sec, (1900 + timeptr->tm_year));
        }
    }
    else
    {
        result = (char *)MALLOC(1UL);
        strcpy(result, "");
    }

    /* free pointers */
    freeArrayOfString((char **)wday_name, MAX_wday);
    freeArrayOfString((char **)mon_name, MAX_mon);

    return result;
}

/*------------------------------------------------------------------------*/
static const char **getDays(void)
{
    const char **days = NULL;

    days = (const char **)MALLOC(sizeof(const char *) * MAX_wday);
    if (days)
    {
        days[0] = strdup(_("Sun"));
        days[1] = strdup(_("Mon"));
        days[2] = strdup(_("Tue"));
        days[3] = strdup(_("Wed"));
        days[4] = strdup(_("Thu"));
        days[5] = strdup(_("Fri"));
        days[6] = strdup(_("Sat"));
    }
    return days;
}

/*------------------------------------------------------------------------*/
static const char **getMonths(void)
{
    const char **months = NULL;

    months = (const char **)MALLOC(sizeof(const char *) * MAX_mon);
    if (months)
    {
        /* initialize month */
        months[0] = strdup(_("Jan"));
        months[1] = strdup(_("Feb"));
        months[2] = strdup(_("Mar"));
        months[3] = strdup(_("Apr"));
        months[4] = strdup(_("May"));
        months[5] = strdup(_("Jun"));
        months[6] = strdup(_("Jul"));
        months[7] = strdup(_("Aug"));
        months[8] = strdup(_("Sep"));
        months[9] = strdup(_("Oct"));
        months[10] = strdup(_("Nov"));
        months[11] = strdup(_("Dec"));
    }
    return months;
}

/*------------------------------------------------------------------------*/
static char *ASCIItimeShort(const struct tm *timeptr)
{
#define FORMAT_TIME_SHORT "%.2d/%.2d/%.4d %.2d:%.2d:%.2d"
    const int len_result = max(21, (strlen("21/05/2011 14:11:04") + 1UL));
    const size_t result_len = (sizeof(char) * (len_result + 4UL));

    char *result = (char *)MALLOC(result_len);

    if (result)
    {
        snprintf(result, result_len, FORMAT_TIME_SHORT, timeptr->tm_mday,
                 (timeptr->tm_mon + 1), (1900 + timeptr->tm_year),
                 timeptr->tm_hour, timeptr->tm_min, timeptr->tm_sec);
    }

    return result;
}
/*------------------------------------------------------------------------*/
