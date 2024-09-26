@echo off

set VCPKG_COMMIT_SHA=3508985146f1b1d248c67ead13f8f54be5b4f5da
set VCPKG_TARGET_TRIPLET=x64-windows

if not exist .\_vcpkg_ (
  git clone https://github.com/microsoft/vcpkg.git ./_vcpkg_
  git -C ./_vcpkg_ checkout -b specific %VCPKG_COMMIT_SHA%
  .\_vcpkg_\bootstrap-vcpkg.bat -disableMetrics
)

if not exist .\_build_ (
  mkdir _build_
  cd _build_
  cmake -G "Visual Studio 17 2022" -A x64 -S ..
  cd ..
)

cd _build_
cmake --build . --config Release --parallel --target pcre2_issue
