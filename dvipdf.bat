@echo off
rem Convert DVI to PDF, using dvips and ghostscript.
rem Based on ps2pdf

setlocal
set DVIPS="C:\w32tex\bin\dvips.exe"
set GS_EXECUTABLE="C:\Program Files (x86)\gs\gs9.10\bin\gswin32c.exe"

::  while true
::  do
::    case "$1" in
::    -R*) DVIPSOPTIONS="$DVIPSOPTIONS $1";;
::    -?*) OPTIONS="$OPTIONS $1" ;;
::    *)  break ;;
::    esac
::    shift
::  done

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
