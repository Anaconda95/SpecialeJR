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

%gamY%  lille_model2.gms r=Saved\settings_AM s=Saved\lille_model2
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