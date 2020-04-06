@echo off
SET buildFoldName=build
rmdir %buildFoldName% /s /q
mkdir %buildFoldName%
cd %buildFoldName%
cmake .. -G "Visual Studio 16 2019" -A x64
PAUSE