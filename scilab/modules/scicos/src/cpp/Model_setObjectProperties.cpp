/*
 *  Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 *  Copyright (C) 2014-2014 - Scilab Enterprises - Clement DAVID
 *
 *  This file must be used under the terms of the CeCILL.
 *  This source file is licensed as described in the file COPYING, which
 *  you should have received as part of this distribution.  The terms
 *  are also available at
 *  http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

#include "Model.hxx"
#include "utilities.hxx"

#include "model/BaseObject.hxx"
#include "model/Annotation.hxx"
#include "model/Diagram.hxx"
#include "model/Block.hxx"
#include "model/Link.hxx"
#include "model/Port.hxx"

namespace org_scilab_modules_scicos
{

update_status_t Model::setObjectProperty(ScicosID uid, kind_t k, object_properties_t p, double v)
{

    if (k == ANNOTATION)
    {
        model::Annotation* o = static_cast<model::Annotation*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == BLOCK)
    {
        model::Block* o = static_cast<model::Block*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == DIAGRAM)
    {
        model::Diagram* o = static_cast<model::Diagram*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == LINK)
    {
        model::Link* o = static_cast<model::Link*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == PORT)
    {
        model::Port* o = static_cast<model::Port*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    return FAIL;
}

update_status_t Model::setObjectProperty(ScicosID uid, kind_t k, object_properties_t p, int v)
{

    if (k == ANNOTATION)
    {
        model::Annotation* o = static_cast<model::Annotation*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == BLOCK)
    {
        model::Block* o = static_cast<model::Block*>(getObject(uid));
        switch (p)
        {
            case SIM_FUNCTION_API:
            {
                return o->setSimFunctionApi(v);
            }
            default:
                break;
        }
    }
    else if (k == DIAGRAM)
    {
        model::Diagram* o = static_cast<model::Diagram*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == LINK)
    {
        model::Link* o = static_cast<model::Link*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == PORT)
    {
        model::Port* o = static_cast<model::Port*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    return FAIL;
}

update_status_t Model::setObjectProperty(ScicosID uid, kind_t k, object_properties_t p, bool v)
{

    if (k == ANNOTATION)
    {
        model::Annotation* o = static_cast<model::Annotation*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == BLOCK)
    {
        model::Block* o = static_cast<model::Block*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == DIAGRAM)
    {
        model::Diagram* o = static_cast<model::Diagram*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == LINK)
    {
        model::Link* o = static_cast<model::Link*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == PORT)
    {
        model::Port* o = static_cast<model::Port*>(getObject(uid));
        switch (p)
        {
            case IMPLICIT:
                return o->setImplicit(v);
            default:
                break;
        }
    }
    return FAIL;
}

update_status_t Model::setObjectProperty(ScicosID uid, kind_t k, object_properties_t p,
        ScicosID v)
{

    if (k == ANNOTATION)
    {
        model::Annotation* o = static_cast<model::Annotation*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == BLOCK)
    {
        model::Block* o = static_cast<model::Block*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == DIAGRAM)
    {
        model::Diagram* o = static_cast<model::Diagram*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == LINK)
    {
        model::Link* o = static_cast<model::Link*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == PORT)
    {
        model::Port* o = static_cast<model::Port*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    return FAIL;
}

update_status_t Model::setObjectProperty(ScicosID uid, kind_t k, object_properties_t p,
        std::string v)
{

    if (k == ANNOTATION)
    {
        model::Annotation* o = static_cast<model::Annotation*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == BLOCK)
    {
        model::Block* o = static_cast<model::Block*>(getObject(uid));
        switch (p)
        {
            case SIM_FUNCTION_NAME:
                return o->setSimFunctionName(v);
            case STYLE:
                return o->setStyle(v);
            case LABEL:
                return o->setLabel(v);
            default:
                break;
        }
    }
    else if (k == DIAGRAM)
    {
        model::Diagram* o = static_cast<model::Diagram*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == LINK)
    {
        model::Link* o = static_cast<model::Link*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == PORT)
    {
        model::Port* o = static_cast<model::Port*>(getObject(uid));
        switch (p)
        {
            case STYLE:
                return o->setStyle(v);
            case LABEL:
                return o->setLabel(v);
            default:
                break;
        }
    }
    return FAIL;
}

update_status_t Model::setObjectProperty(ScicosID uid, kind_t k, object_properties_t p, const std::vector<double>& v)
{

    if (k == ANNOTATION)
    {
        model::Annotation* o = static_cast<model::Annotation*>(getObject(uid));
        switch (p)
        {
            case GEOMETRY:
                return o->setGeometry(v);
            default:
                break;
        }
    }
    else if (k == BLOCK)
    {
        model::Block* o = static_cast<model::Block*>(getObject(uid));
        switch (p)
        {
            case GEOMETRY:
                return o->setGeometry(v);
            case ANGLE:
                return o->setAngle(v);
            default:
                break;
        }
    }
    else if (k == DIAGRAM)
    {
        model::Diagram* o = static_cast<model::Diagram*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == LINK)
    {
        model::Link* o = static_cast<model::Link*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == PORT)
    {
        model::Port* o = static_cast<model::Port*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    return FAIL;
}

update_status_t Model::setObjectProperty(ScicosID uid, kind_t k, object_properties_t p, const std::vector<int>& v)
{

    if (k == ANNOTATION)
    {
        model::Annotation* o = static_cast<model::Annotation*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == BLOCK)
    {
        model::Block* o = static_cast<model::Block*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == DIAGRAM)
    {
        model::Diagram* o = static_cast<model::Diagram*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == LINK)
    {
        model::Link* o = static_cast<model::Link*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == PORT)
    {
        model::Port* o = static_cast<model::Port*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    return FAIL;
}

update_status_t Model::setObjectProperty(ScicosID uid, kind_t k, object_properties_t p, const std::vector<std::string>& v)
{

    if (k == ANNOTATION)
    {
        model::Annotation* o = static_cast<model::Annotation*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == BLOCK)
    {
        model::Block* o = static_cast<model::Block*>(getObject(uid));
        switch (p)
        {
            case EXPRS:
                return o->setExprs(v);
            default:
                break;
        }
    }
    else if (k == DIAGRAM)
    {
        model::Diagram* o = static_cast<model::Diagram*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == LINK)
    {
        model::Link* o = static_cast<model::Link*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == PORT)
    {
        model::Port* o = static_cast<model::Port*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    return FAIL;
}

update_status_t Model::setObjectProperty(ScicosID uid, kind_t k, object_properties_t p, const std::vector<ScicosID>& v)
{

    if (k == ANNOTATION)
    {
        model::Annotation* o = static_cast<model::Annotation*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == BLOCK)
    {
        model::Block* o = static_cast<model::Block*>(getObject(uid));
        switch (p)
        {
            case INPUTS:
                return o->setIn(v);
            case OUTPUTS:
                return o->setOut(v);
            case EVENT_INPUTS:
                return o->setEin(v);
            case EVENT_OUTPUTS:
                return o->setEout(v);
            default:
                break;
        }
    }
    else if (k == DIAGRAM)
    {
        model::Diagram* o = static_cast<model::Diagram*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == LINK)
    {
        model::Link* o = static_cast<model::Link*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    else if (k == PORT)
    {
        model::Port* o = static_cast<model::Port*>(getObject(uid));
        switch (p)
        {
            default:
                break;
        }
    }
    return FAIL;
}

} /* namespace org_scilab_modules_scicos */

