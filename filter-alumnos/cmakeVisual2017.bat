@echo off
SET buildFoldName=build
rmdir %buildFoldName% /s /q
mkdir %buildFoldName%
cd %buildFoldName%
cmake .. -G "Visual Studio 15 2017" -A x64
PAUSE