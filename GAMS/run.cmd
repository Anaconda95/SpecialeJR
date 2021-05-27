:: Run fil til affaldssektor 


 :: Set paths to programs
call paths.cmd
IF %ERRORLEVEL% NEQ 0 GOTO pathsNotFound

:: gamY is a python script. We use the python installation that comes with GAMS.
set gamY=%python% gamY\gamY.py

goto start
:start

%gamY%  settings_AM.gms  s=Saved\settings_AM
IF %ERRORLEVEL% NEQ 0 GOTO errorHandling


rem %gamY%  lille_model.gms r=Saved\settings_AM s=Saved\lille_model
rem IF %ERRORLEVEL% NEQ 0 GOTO errorHandling

rem %gamY%  stone_geary_5h.gms r=Saved\settings_AM s=Saved\stone_geary_5h
rem IF %ERRORLEVEL% NEQ 0 GOTO errorHandling

rem %gamY%  gdxmerge.gms r=Saved\stone_geary_5h s=Saved\gdxmerge
rem IF %ERRORLEVEL% NEQ 0 GOTO errorHandling

rem %gamY%  Seminar.gms r=Saved\settings_AM s=Saved\Seminar
rem IF %ERRORLEVEL% NEQ 0 GOTO errorHandling

rem %gamY%  Seminar_uden_leis.gms r=Saved\settings_AM s=Saved\Seminar
rem IF %ERRORLEVEL% NEQ 0 GOTO errorHandling

rem %gamY%  Model_LES.gms r=Saved\settings_AM s=Saved\Seminar
rem IF %ERRORLEVEL% NEQ 0 GOTO errorHandling

%gamY%  Julie_LES.gms r=Saved\settings_AM s=Saved\Seminar
IF %ERRORLEVEL% NEQ 0 GOTO errorHandling


:pathsNotFound
ECHO ----------------------------------------------------------------------------------------------------
ECHO ERROR  -  paths.cmd not found
ECHO Run get_ini_and_paths_templates.cmd in main folder and adapt paths.cmd and gekko.ini to your local settings
ECHO ----------------------------------------------------------------------------------------------------

:errorHandling
pause
:end
:: Clean up temp files and folders
:: Del "tmp_gmx_*"