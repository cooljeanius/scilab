// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2009 - DIGITEO
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================
// <-- CLI SHELL MODE -->


s=poly(0,'s');
h=1/(2*s);
if or(size(h)<>[1 1]) then pause,end
if h.num<>1|h.den<>2*s then pause,end
h=1./(2*s);
if h.num<>1|h.den<>2*s then pause,end

//basic operations with 2D matrices
H=[h h];
if or(H.num<>[1 1])|or(H.den<>[2*s 2*s]) then pause,end
H=[h;h];
if or(H.num<>[1;1])|or(H.den<>[2*s;2*s]) then pause,end

H=[h 3];
if or(H.num<>[1 3])|or(H.den<>[2*s 1]) then pause,end
H=[h;5];
if or(H.num<>[1;5])|or(H.den<>[2*s;1]) then pause,end

H=[3 h];
if or(H.num<>[3 1])|or(H.den<>[1 2*s]) then pause,end
H=[5;h];
if or(H.num<>[5;1])|or(H.den<>[1;2*s]) then pause,end

H=[3 h;s 2];
if H(1,1)<>3 then pause,end
if H(1,2)<>h then pause,end
if or(H(1,[2 1])<>[h 3]) then pause,end
if or(H(1,[2 2])<>[h h]) then pause,end

if or(H(1,:)<>[3 h]) then pause,end
if or(H(:,1)<>[3;s]) then pause,end
if or(H([2 1],:)<>[s 2;3 h]) then pause,end
if or(H([1 1],:)<>[3 h;3 h]) then pause,end

if or(matrix(H,-1,1)<>[3;s;h;2]) then pause,end

H=h;H(1,3)=1/s;
if or(H.num<>[1 0 1])|or(H.den<>[2*s 1 s]) then pause,end

H=h;H(3,1)=1/s;
if or(H.num<>[1 0 1]')|or(H.den<>[2*s 1 s]') then pause,end

H=h;H(1,3)=1.5;
if or(H.num<>[1 0 1.5])|or(H.den<>[2*s 1 1]) then pause,end

H=h;H(3,1)=1.5;
if or(H.num<>[1 0 1.5]')|or(H.den<>[2*s 1 1]') then pause,end

H=1.5;H(1,3)=1/s;
if or(H.num<>[1.5 0 1])|or(H.den<>[1 1 s]) then pause,end
H=1.5;H(3,1)=1/s;
if or(H.num<>[1.5 0 1]')|or(H.den<>[1 1 s]') then pause,end

H=[h s;1 h];H(:,1)=[];
if or(H<>[s;h]) then pause,end

H=[h s;1 h];H(2,:)=[];
if or(H<>[h s]) then pause,end


H=h+h;c=coeff(H.den,1);
if H.num/c<>1|H.den/c<>s then pause,end

H=h+1;
if H.num<>1+2*s|H.den<>2*s then pause,end

H=1+h;
if H.num<>1+2*s|H.den<>2*s then pause,end

H=h+[];
if H<>h then pause,end
H=[]+h;
if H<>h then pause,end

H=h+s;
if H.num<>1+2*s^2|H.den<>2*s then pause,end

H=s+h;
if H.num<>1+2*s^2|H.den<>2*s then pause,end


H=h-h;
if H.num<>0|H.den<>1 then pause,end

H=h-1;
if H.num<>1-2*s|H.den<>2*s then pause,end

H=1-h;
if H.num<>-1+2*s|H.den<>2*s then pause,end

H=[h h+1]-1;
if H(1,1)<>h-1 then pause,end
if H(1,2)<>h then pause,end

H=[h h+1]-2*h;
if or(H.num<>[-2 -2+4*s])|or(H.den<>[4*s 4*s]) then pause,end

H=-2*h+[h h+1];
if or(H.num<>[-2 -2+4*s])|or(H.den<>[4*s 4*s]) then pause,end

// *

H=h*h;
if or(H.num<>1)|or(H.den<>4*s^2) then pause,end

H=h*2;
if or(H.num<>2)|or(H.den<>2*s) then pause,end

H=2*h;
if or(H.num<>2)|or(H.den<>2*s) then pause,end

H=h*s;
if or(H.num<>1)|or(H.den<>2) then pause,end

H=s*h;
if or(H.num<>1)|or(H.den<>2) then pause,end

H=[h h+1]*h;
if or(H<>[h*h, (h+1)*h]) then pause,end

H=h*[h h+1];
if or(H<>[h*h, (h+1)*h]) then pause,end

H=[h h+1]*2;
if or(H<>[h*2, (h+1)*2]) then pause,end

H=2*[h h+1];
if or(H<>[h*2, (h+1)*2]) then pause,end


H=[h h+1]*s;
if or(H<>[h*s, (h+1)*s]) then pause,end

H=s*[h h+1];
if or(H<>[h*s, (h+1)*s]) then pause,end

H=[h 1;s 3]*[1;h];
if or(H<>[h+h;s+3*h]) then pause,end

H=[h 1]*[h 1;s 3];
if or(H<>[h*h+s,h+3]) then pause,end

H=[h 1;s 3]*[1;2];
if or(H<>[h+2;s+6]) then pause,end

H=[2 1]*[h 1;s 3];
if or(H<>[2*h+s,2+3]) then pause,end

// .*

H=h.*h;
if or(H.num<>1)|or(H.den<>4*s^2) then pause,end

H=h.*2;
if or(H.num<>2)|or(H.den<>2*s) then pause,end

H=2 .*h;
if or(H.num<>2)|or(H.den<>2*s) then pause,end

H=h.*s;
if or(H.num<>1)|or(H.den<>2) then pause,end

H=s.*h;
if or(H.num<>1)|or(H.den<>2) then pause,end

H=[h h+1].*h;
if or(H<>[h*h, (h+1)*h]) then pause,end

H=h.*[h h+1];
if or(H<>[h*h, (h+1)*h]) then pause,end

H=[h h+1].*2;
if or(H<>[h*2, (h+1)*2]) then pause,end

H=2 .*[h h+1];
if or(H<>[h*2, (h+1)*2]) then pause,end


H=[h h+1].*s;
if or(H<>[h*s, (h+1)*s]) then pause,end

H=s.*[h h+1];
if or(H<>[h*s, (h+1)*s]) then pause,end

H=[3 h;s 2].*[3 h;s 2];
if or(H<>[9 h*h;s*s 4]) then pause,end


// /

H=h/2;
if or(H.num<>0.5)|or(H.den<>2*s) then pause,end

H=h/s;
if or(H.num<>1)|or(H.den<>2*s^2) then pause,end


H=h/(h+1);
if or(H.num<>2)|or(H.den<>2+4*s) then pause,end

H=[h h-1]/2;
if or(H<>[h/2 (h-1)/2]) then pause,end

H=[h h-1]/s;
if or(H<>[h/s (h-1)/s]) then pause,end

H=1/h;
if or(H.num<>2*s)|or(H.den<>1) then pause,end

H=[1 2]/h;
if or(H<>[1/h 2/h]) then pause,end

H=[s+1 s-2]/h;
if or(H<>[(s+1)/h (s-2)/h]) then pause,end

H=[h+1 (h+1)*(h-1)]/h;
if or(H<>[(h+1)/h ((h+1)*(h-1))/h]) then pause,end

H=(eye(2,2)/[3 h;s 2])*[3 h;s 2];
if or(coeff(H.num)./coeff(H.den)<>eye(2,2)) then pause,end


// ./

H=h./2;
if or(H.num<>0.5)|or(H.den<>2*s) then pause,end

H=h./s;
if or(H.num<>1)|or(H.den<>2*s^2) then pause,end


H=h./(h+1);
if or(H.num<>2)|or(H.den<>2+4*s) then pause,end

H=[h h-1]./2;
if or(H<>[h/2 (h-1)/2]) then pause,end

H=[h h-1]./s;
if or(H<>[h/s (h-1)/s]) then pause,end

H=1 ./h;
if or(H.num<>2*s)|or(H.den<>1) then pause,end

H=[1 2]./h;
if or(H<>[1/h 2/h]) then pause,end

H=[s+1 s-2]./h;
if or(H<>[(s+1)/h (s-2)/h]) then pause,end

H=[h+1 (h+1)*(h-1)]./h;
if or(H<>[(h+1)/h ((h+1)*(h-1))/h]) then pause,end

H=[3 h;s 2]./[3 h;s 2];
if or(coeff(H.num)./coeff(H.den)<>ones(2,2)) then pause,end

// .\

H=2 .\h;
if or(H.num<>0.5)|or(H.den<>2*s) then pause,end

H=s.\h;
if or(H.num<>1)|or(H.den<>2*s^2) then pause,end


H=(h+1).\h;
if or(H.num<>2)|or(H.den<>2+4*s) then pause,end

H=2 .\[h h-1];
if or(H<>[h/2 (h-1)/2]) then pause,end

H=s.\[h h-1];
if or(H<>[h/s (h-1)/s]) then pause,end

H=1 ./h;
if or(H.num<>2*s)|or(H.den<>1) then pause,end

H=h.\[1 2];
if or(H<>[1/h 2/h]) then pause,end

H=h.\[s+1 s-2];
if or(H<>[(s+1)/h (s-2)/h]) then pause,end

H=h.\[h+1 (h+1)*(h-1)];
if or(H<>[(h+1)/h ((h+1)*(h-1))/h]) then pause,end

H=[3 h;s 2]./[3 h;s 2];
if or(coeff(H.num)./coeff(H.den)<>ones(2,2)) then pause,end

// hypermatrices of rationnals

clear H;H(1,1,2)=h;
if H(1,1,1)<>rlist(0,1,[]) |H(1,1,2)<>h then pause,end
H(2,1,2)=h+1;
if or(size(H)<>[2 1 2]) then pause,end

if or(H(:,1,1)<>[0;0]) then pause,end
if or(H([2 2],1,2)<>[h+1;h+1]) then pause,end

clear H;H(1,1,2)=h;H(2,1,1)=1;
if or(H(:,1,1)<>[0;1])|or(H(:,1,2)<>[h;0]) then pause,end

clear H;H(1,1,2)=h;H(1,1,:)=3;
if or(H(1,1,1)<>3)|or(H(1,1,2)<>3) then pause,end


clear H;H(1,1,2)=h;H(1:2,1,1)=%s;
if or(H(1:2,1,1)<>[%s;%s]) then pause,end

clear H;H(2,2,2)=s;H(2,1,1)=h;
if or(H(:,:,1)<>[0 0;h 0])|or(H(:,:,2)<>[0 0;0 s]) then pause,end

clear H;H(2,2,2)=8;H(2,1,1)=h;
if or(H(:,:,1)<>[0 0;h 0])|or(H(:,:,2)<>[0 0;0 8]) then pause,end

clear H;H(2,2,2)=8;H(2,1,1)=h;
H(:,:,1)=[];
if or(H<>[0 0;0 8]) then pause,end

clear H;H(2,2,2)=8;H(2,1,1)=h;
H2=H(2,:,:);H(1,:,:)=[];
if or(H<>H2) then pause,end

clear H;H(2,2,2)=8;H(2,1,1)=h;
H2=H(:,2,:);H(:,1,:)=[];
if or(H<>H2) then pause,end


clear H;H(2,2,2)=h;H=H+1;
if or(H(:,:,1)<>ones(2,2))|or(H(:,:,2)<>[1 1;1 h+1]) then pause,end

clear H;H(2,2,2)=h;H=1+H;
if or(H(:,:,1)<>ones(2,2))|or(H(:,:,2)<>[1 1;1 h+1]) then pause,end

clear H;H(2,2,2)=h;H=H+s;
if or(H(:,:,1)<>s*ones(2,2))|or(H(:,:,2)<>[s s;s h+s]) then pause,end

clear H;H(2,2,2)=h;H=s+H;
if or(H(:,:,1)<>s*ones(2,2))|or(H(:,:,2)<>[s s;s h+s]) then pause,end

clear H;H(2,2,2)=h;H=H-1;
if or(H(:,:,1)<>-ones(2,2))|or(H(:,:,2)<>[-1 -1;-1 h-1]) then pause,end

clear H;H(2,2,2)=h;H=1-H;
if or(H(:,:,1)<>ones(2,2))|or(H(:,:,2)<>[1 1;1 1-h]) then pause,end

clear H;H(2,2,2)=h;H=H-s;
if or(H(:,:,1)<>-s*ones(2,2))|or(H(:,:,2)<>[-s -s;-s h-s]) then pause,end

clear H;H(2,2,2)=h;H=s-H;
if or(H(:,:,1)<>s*ones(2,2))|or(H(:,:,2)<>[s s;s -h+s]) then pause,end

clear H;H(2,2,2)=s;H(2,1,1)=h;H=H+H;
if or(H(:,:,1)<>[0 0;h+h 0])|or(H(:,:,2)<>[0 0;0 s+s]) then pause,end

clear H;H(2,2,2)=s;H(2,1,1)=h;H=H-H;
if or(H(:,:,1)<>[0 0;0 0])|or(H(:,:,2)<>[0 0;0 0]) then pause,end

// *
clear H;H(1,1,2)=h;H(1:2,1,1)=%s;H=H*h;
if or(H(:,:,1)<>[s*h;s*h])|or(H(:,:,2)<>[h*h;0]) then pause,end

clear H;H(1,1,2)=h;H(1:2,1,1)=%s;H=h*H;
if or(H(:,:,1)<>[s*h;s*h])|or(H(:,:,2)<>[h*h;0]) then pause,end

clear H;H(1,1,2)=h;H(1:2,1,1)=%s;H=H*2;
if or(H(:,:,1)<>[s*2;s*2])|or(H(:,:,2)<>[h*2;0]) then pause,end

clear H;H(1,1,2)=h;H(1:2,1,1)=%s;H=2*H;
if or(H(:,:,1)<>[s*2;s*2])|or(H(:,:,2)<>[h*2;0]) then pause,end


clear H;H(1,1,2)=h;H(1:2,1,1)=%s;H=H*s;
if or(H(:,:,1)<>[s*s;s*s])|or(H(:,:,2)<>[h*s;0]) then pause,end

clear H;H(1,1,2)=h;H(1:2,1,1)=%s;H=s*H;
if or(H(:,:,1)<>[s*s;s*s])|or(H(:,:,2)<>[h*s;0]) then pause,end


// .*
clear H;H(1,1,2)=h;H(1:2,1,1)=%s;H=H.*h;
if or(H(:,:,1)<>[s*h;s*h])|or(H(:,:,2)<>[h*h;0]) then pause,end

clear H;H(1,1,2)=h;H(1:2,1,1)=%s;H=h.*H;
if or(H(:,:,1)<>[s*h;s*h])|or(H(:,:,2)<>[h*h;0]) then pause,end

clear H;H(1,1,2)=h;H(1:2,1,1)=%s;H=H.*2;
if or(H(:,:,1)<>[s*2;s*2])|or(H(:,:,2)<>[h*2;0]) then pause,end

clear H;H(1,1,2)=h;H(1:2,1,1)=%s;H=2 .*H;
if or(H(:,:,1)<>[s*2;s*2])|or(H(:,:,2)<>[h*2;0]) then pause,end


clear H;H(1,1,2)=h;H(1:2,1,1)=%s;H=H.*s;
if or(H(:,:,1)<>[s*s;s*s])|or(H(:,:,2)<>[h*s;0]) then pause,end

clear H;H(1,1,2)=h;H(1:2,1,1)=%s;H=s.*H;
if or(H(:,:,1)<>[s*s;s*s])|or(H(:,:,2)<>[h*s;0]) then pause,end


clear H;H(1,1,2)=h;H(1:2,1,1)=%s;H=H.*H;
if or(H(:,:,1)<>[s*s;s*s])|or(H(:,:,2)<>[h*h;0]) then pause,end


