// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008 - INRIA - Michael Baudin
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// With x as a row vector and 1 argument
data = [10 20 30 40 50 60 70 80 90];
computed = variance(data);
expected = 750;
if abs(computed-expected)>%eps then pause,end
// With x as a column vector and 1 argument
data = [10; 20; 30; 40; 50; 60; 70; 80; 90];
computed = variance(data);
expected = 750;
if abs(computed-expected)>%eps then pause,end
// With x as a matrix
data = [10 20 30 40;50 60 70 90];
computed = variance(data);
expected = 712.5;
if abs(computed-expected)>%eps then pause,end
// With x as a row vector and specified orient
data = [10 20 30 40;50 60 70 90];
computed = variance(data,1);
expected = [800. 800. 800. 1250.];
if abs(computed-expected)>%eps then pause,end
// With x as a row vector and specified orient
data = [10 20 30 40;50 60 70 90];
computed = variance(data,"r");
expected = [800. 800. 800. 1250.];
if abs(computed-expected)>%eps then pause,end
// With x as a row vector and specified orient
data = [10 20 30 40;50 60 70 90];
computed = variance(data,2);
expected = [500.;875.]/3.;
if abs(computed-expected)>%eps then pause,end
// With x as a row vector and specified orient
data = [10 20 30 40;50 60 70 90];
computed = variance(data,"c");
expected = [500.;875.]/3.;
if abs(computed-expected)>%eps then pause,end

// With x as a complex row vector and 1 argument
a = [ 0.9, 0.7;
0.1, 0.1;
0.5, 0.4 ];
data = a + a * 2 * %i;
computed = variance(data);
expected = - 0.3089999999999999413802 + 0.4119999999999999218403 * %i;
if abs(computed-expected)>%eps then pause,end

// With x as a complex row vector and computation by column
a = [ 0.9, 0.7;
0.1, 0.1;
0.5, 0.4 ];
data = a + a * 2 * %i;
computed = variance(data,1);
expected = [0.8 0.45];
if abs(computed-expected)>%eps then pause,end
// With x as a complex row vector and computation by row
a = [ 0.9, 0.7;
0.1, 0.1;
0.5, 0.4 ];
data = a + a * 2 * %i;
computed = variance(data,2);
expected = [0.1    
    0.     
    0.025];
if abs(computed-expected)>%eps then pause,end

// Normalization with N-1
x = [0.9    0.7  
    0.1    0.1  
    0.5    0.4];
orien = 1;
w = 0;
computed = variance(x,orien,w);
expected = [0.16 0.09];
if abs(computed-expected)>%eps then pause,end
// Normalization with N
x = [0.9    0.7  
    0.1    0.1  
    0.5    0.4];
orien = 1;
w = 1;
computed = variance(x,orien,w);
expected = [0.32 0.18] / 3;
if abs(computed-expected)>%eps then pause,end

