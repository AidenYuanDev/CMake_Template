cmake_minimum_required(VERSION 3.14)
project(YourProjectName VERSION 1.0.0 LANGUAGES CXX)

# 包含自定义 CMake 模块
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# 包含项目设置和依赖查找
include(ProjectSettings)
include(FindDependencies)

# 启用测试。必须在顶层调用，ctest 才能在构建根目录发现所有子目录的测试
if(BUILD_TESTING)
  enable_testing()
endif()

# 添加子目录
add_subdirectory(libs)
add_subdirectory(core)
add_subdirectory(src)
add_subdirectory(test)
