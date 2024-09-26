# Access to VCPKG resources
if (NOT COMMAND fetch_variable)
  macro (fetch_variable name)
    if (NOT DEFINED ${name} AND DEFINED ENV{${name}})
      set(${name} $ENV{${name}})
    endif()
  endmacro()
endif()

fetch_variable(VCPKG_TARGET_TRIPLET)
if (NOT DEFINED VCPKG_TARGET_TRIPLET)
  set(VCPKG_TARGET_TRIPLET x64-windows)
endif()
message(STATUS "Using vcpkg triplet: ${VCPKG_TARGET_TRIPLET}")

if (NOT DEFINED VCPKG_TOOLCHAIN_FILE AND NOT DEFINED VCPKG_CHAINLOAD_TOOLCHAIN_FILE)
  message(STATUS "No defined VCPKG toolchain file. Using local one if available.")
  get_filename_component(VCPKG_TOOLCHAIN_FILE "./_vcpkg_/scripts/buildsystems/vcpkg.cmake" ABSOLUTE)
  file(TO_CMAKE_PATH
	  ${VCPKG_TOOLCHAIN_FILE}
	  CMAKE_TOOLCHAIN_FILE
  )
endif()
message(STATUS "Using cmake toolchain files: ${CMAKE_TOOLCHAIN_FILE}")
message(STATUS "Using cmake prefix path: ${CMAKE_PREFIX_PATH}")

# Common C++ language settings
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
