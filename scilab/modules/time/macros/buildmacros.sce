//------------------------------------
// Pierre MARECHAL
// Scilab team
// Copyright INRIA
// Date :  d�cembre 2005
//------------------------------------
if (isdef('genlib') == %f) then
  exec(SCI+'/modules/functions/scripts/buildmacros/loadgenlib.sce');
end
//------------------------------------
genlib('timelib','SCI/modules/time/macros',%f,%t);
//------------------------------------
