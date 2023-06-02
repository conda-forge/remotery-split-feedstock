@REM NOTE(jjerphan): those directories contain source of examples
@REM and of an application running in web browsers.
@REM
@REM We do not want to build those.

rmdir /Q /S sample
rmdir /Q /S vis

rmdir /Q /S build

copy %RECIPE_DIR%\CMakeLists.txt .
copy %RECIPE_DIR%\remoteryConfig.cmake.in

dir /s /b /o:gn

mkdir build
cd build

if /I "%PKG_NAME%" == "remotery" (
    cmake .. ^
        %CMAKE_ARGS% ^
        -GNinja ^
        -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
        -DCMAKE_PREFIX_PATH=%PREFIX% ^
        -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON ^
        -DREMOTERY_BUILD_SHARED_LIBS=ON ^
        -DREMOTERY_BUILD_STATIC_LIBS=OFF
)
if /I "%PKG_NAME%" == "remotery-static" (
    cmake .. ^
        %CMAKE_ARGS% ^
        -GNinja ^
        -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
        -DCMAKE_PREFIX_PATH=%PREFIX% ^
        -DREMOTERY_BUILD_SHARED_LIBS=OFF ^
        -DREMOTERY_BUILD_STATIC_LIBS=ON
)

if errorlevel 1 exit 1

ninja
if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1
