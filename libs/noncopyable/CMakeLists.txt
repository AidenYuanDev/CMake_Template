# 纯头文件库，用 INTERFACE
add_library(noncopyable INTERFACE)

target_include_directories(noncopyable INTERFACE
  ${CMAKE_CURRENT_SOURCE_DIR}/include)

target_sources(noncopyable INTERFACE
  include/noncopyable.h)
