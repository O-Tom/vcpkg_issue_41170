cmake_minimum_required(VERSION 3.25)
include(./common.cmake)

project(pcre2_issue)

find_package(Poco CONFIG REQUIRED Net) # Poco::Net
find_package(Pcre2 REQUIRED) # Pcre2::Pcre2
find_package(Qt6 COMPONENTS Core REQUIRED) # Qt6::Core

add_executable(${PROJECT_NAME} main.cpp)
target_link_libraries(${PROJECT_NAME} Qt6::Core Poco::Net Pcre2::Pcre2)
