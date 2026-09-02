# 下面这些都是 CMAKE_* 全局变量，会影响整个构建树。
# 因此只在本项目作为顶层项目时才设置：被 add_subdirectory() 引入时，
# 我们没有资格去改上层项目的语言标准、输出目录和构建类型。
if(PROJECT_IS_TOP_LEVEL)
  # C++ 标准。各目标另外用 target_compile_features() 声明了自己的下限，
  # 所以即使作为子项目、这里不生效，库也照样以 C++20 编译。
  set(CMAKE_CXX_STANDARD 20)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)
  set(CMAKE_CXX_EXTENSIONS OFF)

  # 默认构建类型。只对单配置生成器有意义；多配置生成器
  # （Visual Studio、Ninja Multi-Config）在构建时用 --config 选，
  # 此时 CMAKE_BUILD_TYPE 是空的，强行设置反而会造成误导。
  get_property(is_multi_config GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
  if(NOT is_multi_config)
    if(NOT CMAKE_BUILD_TYPE)
      # 必须写 CACHE + FORCE：单配置生成器下 CMake 已经建好一个空的缓存条目，
      # 不 FORCE 是覆盖不掉的
      set(CMAKE_BUILD_TYPE Debug CACHE STRING "构建类型" FORCE)
    endif()
    # 让 cmake-gui / ccmake 里显示成下拉列表而不是自由文本框
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
      Debug Release RelWithDebInfo MinSizeRel)
  endif()

  # 输出目录
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

  # 生成 compile_commands.json，供 clangd / ycm 等 LSP 找到头文件
  set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
endif()

option(BUILD_TESTING "Build the testing tree." OFF)

# 真正决定要不要构建测试的开关。
# 上层项目为了自己的测试打开 BUILD_TESTING，不应该连带把我们的测试也构建出来。
if(PROJECT_IS_TOP_LEVEL AND BUILD_TESTING)
  set(PROJECT_BUILD_TESTS ON)
else()
  set(PROJECT_BUILD_TESTS OFF)
endif()
