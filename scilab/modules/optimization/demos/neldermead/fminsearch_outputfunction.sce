// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - 2011 - DIGITEO - Michael Baudin
// Copyright (C) 2010 - DIGITEO - Allan CORNET
// Copyright (C) 2012 - Scilab Enterprises - Adeline CARNIS
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt

function demo_outputfunction()

    mprintf(_("Running optimization ...\n"));

    function y = banana (x)
        y = 100*(x(2)-x(1)^2)^2 + (1-x(1))^2;
    endfunction

    function stop = outfun ( x , optimValues , state )
        fc = optimValues.funccount;
        fv = optimValues.fval;
        it = optimValues.iteration;
        pr = optimValues.procedure;
        mprintf ( "%d %e %d -%s-\n" , fc , fv , it , pr )
        stop = %f
    endfunction

    opt = optimset ( "OutputFcn" , outfun );
    [x,fval,exitflag,output ] = fminsearch ( banana , [-1.2 1] , opt );

    //
    // Display results
    //
    mprintf("x = %s\n",strcat(string(x)," "));
    mprintf("fval = %e\n",fval);

    mprintf("output.message:\n");

    for i =1:3
        mprintf(output.message(i));
        mprintf("\n");
    end

    mprintf("output.algorithm:%s\n",output.algorithm);
    mprintf("output.funcCount:%d\n",output.funcCount);
    mprintf("output.iterations:%d\n",output.iterations);

    //
    // Load this script into the editor
    //
    m = messagebox(_("View Code?"), "Question", "question", [_("Yes") _("No")], "modal")
    if(m == 1)
        filename = 'fminsearch_outputfunction.sce';
        dname = get_absolute_file_path(filename);
        editor ( dname + filename, "readonly" );
    end
endfunction

demo_outputfunction();
clear demo_outputfunction;







