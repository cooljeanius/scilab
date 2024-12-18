// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2012 - Scilab Enterprises - Sylvestre Ledru
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
x=[1 2 3 4; 5 6 7 8];
dim=1;
y=flipdim(x,dim);
assert_checkequal([5,6,7,8;1,2,3,4],y);

dim=2;
y=flipdim(x,dim);
assert_checkequal([4,3,2,1;8,7,6,5],y);

x=matrix(1:48,[3 2,4,2]);
dim=3;
ref=mlist(["hm","dims","entries"],int32([3,2,4,2]),[19;20;21;22;23;24;13;14;15;16;17;18;7;8;9;10;11;12;1;2;3;4;5;6;43;44;45;46;47;48;37;38;39;40;41;42;31;32;33;34;35;36;25;26;27;28;29;30]);
y=flipdim(x,dim);
assert_checkequal(y,ref);

x=[1+%i 2*%i 3 4; 5 6-%i 7 8*%pi*%i];
dim=1;
y=flipdim(x,dim);
ref=[ 5, 6-%i, 7,%i*25.132741;1+%i,%i*2, 3, 4];
assert_checkalmostequal(y,ref);
