@echo off
FOR /L %%X IN (1,1,2) DO (

COPY %~dp0\global%%X.json %~dp0\global.json /y

dotnet --version >> %~dp0\results.txt
echo %CD% >> %~dp0\results.txt
echo %time% >> %~dp0\results.txt

FOR /L %%A IN (1,1,20) DO (
REM dotnet nuget locals all --clear
REM git clean -fxd
REM @echo "locals all --clear" >> %~dp0\results.txt
REM  call %~dp0\timeIt.cmd dotnet restore
)

FOR /L %%A IN (1,1,50) DO (
  git clean -fxd
  timeout /t 5
  @echo "clean -fxd" >> %~dp0\results.txt
  call %~dp0\timeIt.cmd dotnet restore
)

FOR /L %%A IN (1,1,20) DO (
REM   @echo "dotnet restore" >> %~dp0\results.txt
REM   call %~dp0\timeIt.cmd dotnet restore
)
)