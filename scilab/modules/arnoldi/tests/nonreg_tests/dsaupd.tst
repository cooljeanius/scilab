// =============================================================================
// Scilab ( http://www.scilab.org/ ) - This file is part of Scilab
// Copyright (C) 2008 - INRIA - Vincent COUVERT <vincent.couvert@inria.fr>
//
//  This file is distributed under the same license as the Scilab package.
// =============================================================================

// Tests for function dsaupd (added after a bug in the gateway: PutLhsVar missing)

stacksize(300000);

N = 1000;

A = sprand(N, N, 0.01);

IDO   = 0;
BMAT  = 'I'; //standard eigenvalue problem
WHICH = "LM";
NEV   = 4; //NEVth eigen values are solved
TOL   = 1D-10;
RESID = zeros(N,1); //
NCV   = 10;

V = zeros(N, NCV);

ISHIFT = 1;
LEVEC  = 0;
MXITER = 100; //INPUT
NB     = 1;
NCONV  = 0;
IUPD   = 0;
MODE   = 1;
NP     = 100;
NUMOP  = 0;
NUMOPB = 0;
NUMREO = 0;

IPARAM = [ISHIFT, LEVEC,  MXITER, NB, NCONV, IUPD, MODE, NP, NUMOP, NUMOPB, NUMREO];

IPNTR = zeros(1,14);
WORKD = zeros(3, N);
WORKL = zeros(1, NCV**2 + 8 * NCV);

INFO = 0;

i = 0;
tic();

[IDO,RESID,V,IPARAM,IPNTR,WORKD,WORKL,INFO] = dsaupd(IDO,BMAT,N,WHICH,NEV,TOL,RESID,NCV,V,IPARAM,IPNTR,WORKD,WORKL,INFO);

while (IDO <> 99) & (IDO <> 3)
  [IDO,RESID,V,IPARAM,IPNTR,WORKD,WORKL,INFO] = dsaupd(IDO,BMAT,N,WHICH,NEV,TOL,RESID,NCV,V,IPARAM,IPNTR,WORKD,WORKL,INFO);
  if (IDO == 1) then
    WORKD(IPNTR(2):(IPNTR(2)+N - 1)) = A * WORKD(IPNTR(1):(IPNTR(1)+N - 1));
  elseif (IDO == 3) then
  end;

  i = i + 1;
end;
t1 = toc();
printf("loop %d",i);

b = rand(N,1);
tic();
for j = 1:i
  b = A * b;
end
toc();
