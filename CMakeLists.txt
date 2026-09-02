# 3.23 起提供 target_sources(FILE_SET HEADERS)，由 CMake 统一管理头文件的
# 构建期路径与安装期路径，不必手写 BUILD_INTERFACE / INSTALL_INTERFACE
cmake_minimum_required(VERSION 3.23)
project(YourProjectName VERSION 1.0.0 LANGUAGES CXX)

# 包含自定义 CMake 模块
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

# 提供 CMAKE_INSTALL_BINDIR / LIBDIR / INCLUDEDIR 等标准安装路径
include(GNUInstallDirs)

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

# 安装与导出规则。作为子项目被引入时不应该往上层项目里塞安装规则
if(PROJECT_IS_TOP_LEVEL)
  include(InstallRules)
endif()
