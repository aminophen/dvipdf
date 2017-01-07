@echo off
rem Convert DVI to PDF, using dvips and ghostscript.
rem Based on ps2pdf

rem Note: this batch file "dvipdf.bat" is written by Hironobu YAMASHITA,
rem       inspired by "dvipdf" shell script in GPL Ghostscript distribution

setlocal enabledelayedexpansion

rem Following definitions should be changed on install to match the
rem executable name suitable for your environment
set DVIPS=dvips.exe
set GS_EXECUTABLE=rungs.exe

for %%f in (%*) do (
  set TEMPARG=%%~f
  if "!TEMPARG:~0,2!"=="-R" (
    set DVIPSOPTIONS=!DVIPSOPTIONS! !TEMPARG!
    shift
  ) else (
    if "!TEMPARG:~0,1!"=="-" (
      set OPTIONS=!OPTIONS! !TEMPARG!
      shift
    )
  )
)

if "%~n1"=="" (
  echo Usage: dvipdf [options...] input.dvi [output.pdf] 1>&2
  exit /B
)

set infile=%~n1.dvi
set outfile=%~n2.pdf
if "%outfile%"==".pdf" set outfile=%~n1.pdf

rem We have to include the options twice because -I only takes effect if it
rem appears before other options.
%DVIPS% -Ppdf %DVIPSOPTIONS% -f "%infile%" | %GS_EXECUTABLE% %OPTIONS% -P- -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile="%outfile%" %OPTIONS% -c .setpdfwrite -
