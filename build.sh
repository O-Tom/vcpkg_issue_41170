export VCPKG_COMMIT_SHA=3508985146f1b1d248c67ead13f8f54be5b4f5da
export VCPKG_DEFAULT_TRIPLET=x64-linux

if [ ! -d "_vcpkg_" ]; then
  git clone https://github.com/microsoft/vcpkg.git ./_vcpkg_
  git -C ./_vcpkg_ checkout -b specific ${VCPKG_COMMIT_SHA}
  cd _vcpkg_
  ./bootstrap-vcpkg.sh -disableMetrics
  cd ..
fi

if [ ! -d "_build_" ]; then
  mkdir _build_
  cd _build_
  cmake -DCMAKE_BUILD_TYPE=Release ..
  cd ..
fi

cd _build_
cmake --build . -j 4
