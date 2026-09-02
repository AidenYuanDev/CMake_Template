# 3.21 起提供 PROJECT_IS_TOP_LEVEL，用来区分顶层项目与被引入的子项目
cmake_minimum_required(VERSION 3.21)
project(YourProjectName VERSION 1.0.0 LANGUAGES CXX)

# 包含自定义 CMake 模块
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# 包含项目设置和依赖查找
include(ProjectSettings)
include(CompilerWarnings)
include(FindDependencies)

# 启用测试。必须在顶层调用，ctest 才能在构建根目录发现所有子目录的测试
if(PROJECT_BUILD_TESTS)
  enable_testing()
endif()

# 添加子目录
add_subdirectory(libs)
add_subdirectory(core)
add_subdirectory(src)
add_subdirectory(test)
