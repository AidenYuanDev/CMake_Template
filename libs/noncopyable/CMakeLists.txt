# 纯头文件库，用 INTERFACE
add_library(${PROJECT_NAME}_noncopyable INTERFACE)
add_library(${PROJECT_NAME}::noncopyable ALIAS ${PROJECT_NAME}_noncopyable)

# FILE_SET HEADERS 一次声明，构建期的 include 路径和安装期的 include 路径
# 都由 CMake 推导，不必再写 target_include_directories
target_sources(${PROJECT_NAME}_noncopyable INTERFACE
  FILE_SET HEADERS
    BASE_DIRS include
    FILES include/noncopyable.h)

# install(EXPORT) 的 NAMESPACE 是拼在真实目标名前面的，ALIAS 对导出无效。
# 不设 EXPORT_NAME 的话使用方拿到的会是 ${PROJECT_NAME}::${PROJECT_NAME}_noncopyable，与 ALIAS 对不上
set_target_properties(${PROJECT_NAME}_noncopyable PROPERTIES EXPORT_NAME noncopyable)

if(PROJECT_IS_TOP_LEVEL)
  install(TARGETS ${PROJECT_NAME}_noncopyable
    EXPORT ${PROJECT_NAME}Targets
    FILE_SET HEADERS)
endif()
