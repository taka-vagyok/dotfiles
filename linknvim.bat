set CUR=%cd%
set NVIMDIR=%LOCALAPPDATA%\nvim

IF NOT EXIST %NVIMDIR% (
    mkdir %NVIMDIR%
)

call :MKLIN %NVIMDIR%\init.vim %CUR%\.vimrc-dein
call :MKLIN %NVIMDIR%\ginit.vim %CUR%\.gvimrc-dein
call :MKLIN %USERPROFILE%\.vsvimrc %CUR%\.vsvimrc

exit /b

:MKLIN

IF EXIST %1 (
    del %1
)
mklink %1 %2


exit /b
