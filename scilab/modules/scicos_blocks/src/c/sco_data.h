/*
 *  sco_data.h
 *  scilab-Xcode
 *
 *  Created by Eric Gallager on 4/11/19.
 *  Copyright 2019 George Washington University. All rights reserved.
 *
 */

#ifndef SCICOS_SCO_DATA_H
#define SCICOS_SCO_DATA_H 1

/**
 * Container structure
 */
typedef struct
{
    struct
    {
        int numberOfPoints;
        int maxNumberOfPoints;
        double ***data;
    } internal;

    struct
    {
        const char *cachedFigureUID;
        char *cachedAxeUID;
        char **cachedPolylinesUIDs;
    } scope;
} sco_data;

/**
 * Container structure
 */
typedef struct
{
    struct
    {
        double *ballsSize;
        double **data;
    } internal;

    struct
    {
        const char *cachedFigureUID;
        char *cachedAxeUID;
        char **cachedArcsUIDs;
    } scope;
} sco_data_bounce;

#endif /* !SCICOS_SCO_DATA_H */
