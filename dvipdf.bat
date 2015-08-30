@echo off
rem Convert DVI to PDF, using dvips and ghostscript.
rem Based on ps2pdf

setlocal enabledelayedexpansion
set DVIPS="C:\w32tex\bin\dvips.exe"
set GS_EXECUTABLE="C:\Program Files (x86)\gs\gs9.10\bin\gswin32c.exe"

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
  echo Usage: %~n0 [options...] input.dvi [output.pdf] 1>&2
  exit /B
)

set infile=%~n1.dvi
set outfile=%~n2.pdf
if "%outfile%"==".pdf" set outfile=%~n1.pdf

rem We have to include the options twice because -I only takes effect if it
rem appears before other options.
%DVIPS% -Ppdf %DVIPSOPTIONS% -f "%infile%" | %GS_EXECUTABLE% %OPTIONS% -P- -dSAFER -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile="%outfile%" %OPTIONS% -c .setpdfwrite -
