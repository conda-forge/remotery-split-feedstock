#!/bin/bash


# NOTE(jjerphan): those directories contain source of examples
# and of an application running in web browsers.
#
# We do not want to build those.
rm -Rf sample
rm -Rf vis

cp $RECIPE_DIR/CMakeLists.txt .
cp $RECIPE_DIR/remoteryConfig.cmake.in .

rm -rf build
mkdir build
cd build

echo "Building $PKG_NAME"

if [[ $PKG_NAME == "remotery" ]]; then
    cmake .. ${CMAKE_ARGS}              \
        -DCMAKE_INSTALL_PREFIX=$PREFIX  \
        -DCMAKE_PREFIX_PATH=$PREFIX     \
        -DREMOTERY_BUILD_SHARED_LIBS=ON      \
        -DREMOTERY_BUILD_STATIC_LIBS=OFF
elif [[ $PKG_NAME == "remotery-static" ]]; then
    cmake .. ${CMAKE_ARGS}              \
        -DCMAKE_INSTALL_PREFIX=$PREFIX  \
        -DCMAKE_PREFIX_PATH=$PREFIX     \
        -DREMOTERY_BUILD_SHARED_LIBS=OFF     \
        -DREMOTERY_BUILD_STATIC_LIBS=ON
fi

make

make install
