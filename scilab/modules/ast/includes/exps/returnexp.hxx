/*
 *  Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
 *  Copyright (C) 2008-2008 - DIGITEO - Bruno JOFRET
 *
 *  This file must be used under the terms of the CeCILL.
 *  This source file is licensed as described in the file COPYING, which
 *  you should have received as part of this distribution.  The terms
 *  are also available at
 *  http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
 *
 */

/**
 ** \file returnexp.hxx
 ** Define the Return Expression class.
 */

#ifndef AST_RETURNEXP_HXX
#define AST_RETURNEXP_HXX

#include "controlexp.hxx"

namespace ast
{
/** \brief Abstract a Return Expression node.
**
** \b Example: return or return plop */
class ReturnExp : public ControlExp
{
    /** \name Ctor & dtor.
    ** \{ */
public:
    /** \brief Construct a Return Expression node.
    ** \param location scanner position informations
    ** \param exp the returned exp
    */
    ReturnExp (const Location& location, Exp  *exp)
        : ControlExp (location),
          _exp (exp),
          _is_global(true)
    {
        if (exp)
        {
            _is_global = false;
        }
    }

    ReturnExp (const Location& location)
        : ControlExp (location),
          _exp (NULL),
          _is_global(true)
    {
    }

    virtual ~ReturnExp ()
    {
        if (_exp != NULL)
        {
            delete _exp;
        }
    }

    virtual ReturnExp* clone()
    {
        ReturnExp* cloned = NULL;
        if (isGlobal())
        {
            cloned = new ReturnExp(getLocation());
        }
        else
        {
            cloned = new ReturnExp(getLocation(), getExp().clone());
        }

        cloned->setVerbose(isVerbose());
        return cloned;
    }

    /** \name Visitors entry point.
    ** \{ */
public:
    /** \brief Accept a const visitor \a v. */
    virtual void accept (Visitor& v)
    {
        v.visit (*this);
    }
    /** \brief Accept a non-const visitor \a v. */
    virtual void accept (ConstVisitor& v) const
    {
        v.visit (*this);
    }
    /** \} */

    /** \name Accessors.
    ** \{ */
public:
    const Exp &	getExp() const
    {
        return *_exp;
    }

    Exp &	getExp()
    {
        return *_exp;
    }

    bool isGlobal() const
    {
        return _is_global;
    }

    virtual ExpType getType()
    {
        return RETURNEXP;
    }
    inline virtual bool isReturnExp() const
    {
        return true;
    }
protected:
    Exp		*_exp;
    bool	_is_global;
};

} // namespace ast

#endif // AST_RETURNEXP_HXX