# 一、前言
本节所以代码均可在[CMake_Template](https://github.com/AidenYuanDev/CMake_Template)仓库中找到。
支持对不同模块进行`gtest`单元测试

## 项目构建
```c
mkdir build
cd build
cmake ..
cmake --build .
cd bin
./YourProjectName
```

# 二、为什么使用`CMake`?
## 1 跨平台
CMake能够生成适用于多种平台（如Windows、Linux、macOS等）的构建系统（例如Makefile、Visual Studio项目、Xcode项目等）。这意味着开发者只需编写一次CMake配置文件，就可以在不同的平台上构建项目，而不必为每个平台单独编写构建脚本。

## 2 解耦项目，提高项目的可维护性
CMake的模块化和配置管理特性使得项目的配置文件更容易理解和维护。

> 这里我只说我喜欢`CMake`的点。

# 三、作者喜欢的结构
如果有`CMake`基础，直接用就可以了。

```bash
.
├── cmake
│   ├── FindDependencies.cmake
│   └── ProjectSettings.cmake
├── CMakeLists.txt
├── core
│   ├── add
│   │   ├── CMakeLists.txt
│   │   ├── include
│   │   │   └── add.h
│   │   ├── src
│   │   │   └── add.cpp
│   │   └── test
│   │       ├── CMakeLists.txt
│   │       └── module1_test.cpp
│   ├── CMakeLists.txt
│   └── sub
│       ├── CMakeLists.txt
│       ├── include
│       │   └── sub.h
│       └── src
│           └── sub.cpp
├── libs
│   ├── CMakeLists.txt
│   └── noncopyable
│       ├── CMakeLists.txt
│       └── include
│           └── noncopyable.h
├── README.md
├── src
│   ├── CMakeLists.txt
│   └── main.cpp
└── test
    ├── CMakeLists.txt
    └── test_add.cpp

```

- **CMakeLists.txt:** CMake项目的核心配置文件，定义了项目的构建过程和规则。
- **cmake:** 实现对主`CMakeLists.txt`的解耦。
	
	- **FindDependencies.cmake:** 存放依赖
	- **ProjectSettings.cmake:**存放项目设置
- **core:** 核心模块，把原项目拆分为不同的子模块。
	- **include:** 模块头文件
	- **src:** 模块源文件
	- **test:** 模块单元测试、
- **libs:** 存放核心模块共同依赖的模块，或头文件
- **src:** 存放主函数
- **test:** 单元测试

> 具体的`CMakeLists.txt`的内容，大家可以自己进入我的仓库查看。
# 四、`CMake`的基础概念
# 项目基础配置
- [`cmake_minimum_required()`](https://cmake.org/cmake/help/latest/command/cmake_minimum_required.html#command:cmake_minimum_required "cmake_minimum_required") ：cmake版本
```c
cmake_minimum_required(VERSION <min>[...<policy_max>] [FATAL_ERROR])
```
- [`project()`](https://cmake.org/cmake/help/latest/command/project.html#command:project "project") ：项目相关信息
```c
project(<PROJECT-NAME> [<language-name>...])
project(<PROJECT-NAME>
        [VERSION <major>[.<minor>[.<patch>[.<tweak>]]]]
        [DESCRIPTION <project-description-string>]
        [HOMEPAGE_URL <url-string>]
        [LANGUAGES <language-name>...])
```
- [`add_subdirectory()`](https://cmake.org/cmake/help/latest/command/add_subdirectory.html#command:add_subdirectory "add_subdirectory") :添加子目录
```c
add_subdirectory(source_dir [binary_dir] [EXCLUDE_FROM_ALL] [SYSTEM])
```
- [`target_compile_options()`](https://cmake.org/cmake/help/latest/command/target_compile_options.html#command:target_compile_options "target_compile_options") :添加编译选项
```c
target_compile_options(<target> [BEFORE]
  <INTERFACE|PUBLIC|PRIVATE> [items1...]
  [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
```
- [`target_compile_definitions()`](https://cmake.org/cmake/help/latest/command/target_compile_definitions.html#command:target_compile_definitions "target_compile_definitions") ：向项目添宏定义
```c
target_compile_definitions(<target>
  <INTERFACE|PUBLIC|PRIVATE> [items1...]
  [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
```
# 配置可执行文件或库
- [`add_executable()`](https://cmake.org/cmake/help/latest/command/add_executable.html#command:add_executable "add_executable") ：添加可执行文件
```c
add_executable(<name> ALIAS <target>)
```
- [`add_library()`](https://cmake.org/cmake/help/latest/command/add_library.html#command:add_library "add_library") ：添加库
```c
add_library(<name> INTERFACE)
```
- [`target_include_directories()`](https://cmake.org/cmake/help/latest/command/target_include_directories.html#command:target_include_directories "target_include_directories") ：指定头文件
```c
target_include_directories(<target> [SYSTEM] [AFTER|BEFORE]
  <INTERFACE|PUBLIC|PRIVATE> [items1...]
  [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
```
- [`target_sources()`](https://cmake.org/cmake/help/latest/command/target_sources.html#command:target_sources "target_sources") :指定源文件
```c
target_sources(<target>
  <INTERFACE|PUBLIC|PRIVATE> [items1...]
  [<INTERFACE|PUBLIC|PRIVATE> [items2...] ...])
```
- [`target_precompile_headers()`](https://cmake.org/cmake/help/latest/command/target_precompile_headers.html#command:target_precompile_headers "target_precompile_headers") :指定预编译头文件
```c
target_precompile_headers(<target>
  <INTERFACE|PUBLIC|PRIVATE> [header1...]
  [<INTERFACE|PUBLIC|PRIVATE> [header2...] ...])
```
- [`target_link_libraries()`](https://cmake.org/cmake/help/latest/command/target_link_libraries.html#command:target_link_libraries "target_link_libraries") :添加库文件
```c
target_link_libraries(<target>
                      <PRIVATE|PUBLIC|INTERFACE> <item>...
                     [<PRIVATE|PUBLIC|INTERFACE> <item>...]...)
```

# 控制流
- [`if()`](https://cmake.org/cmake/help/latest/command/if.html#command:if "if") ：判断
```c
if(<condition>)
  <commands>
elseif(<condition>) # optional block, can be repeated
  <commands>
else()              # optional block
  <commands>
endif()
```
- [`option()`](https://cmake.org/cmake/help/latest/command/option.html#command:option "option") :相当于bool值
```c
option(<variable> "<help_text>" [value])
```
# 测试
- [`enable_testing()`](https://cmake.org/cmake/help/latest/command/enable_testing.html#command:enable_testing "enable_testing") ：启用测试

# 生成器表达式
- `<CONFIG:cfgs>` ：构建类型
	- Debug
	- Release
	- RelWithDebInfo
	- MinSizeRel
- `$<PLATFORM_ID:platform_ids>` :平台
	- **Windows**
	- **Linux**
	- **iOS**
# 编译选项
- 警告选项： `-Wall`, `-Wextra`
- 优化选项：`-O2`, `-O3`
- 调试选项：`-g`
# 常用弘
- **CMAKE_BUILD_TYPE** ：构建类型，例如 `Debug` 或 `Release`
- **CMAKE_CXX_STANDARD** ：C++版本
- **CMAKE_CXX_STANDARD_REQUIRED** ：如果没有当前C++版本会使用上一版本。
- **CMAKE_CXX_EXTENSIONS** ：设为OFF防止不小心用了GCC才有的特性
- **CMAKE_RUNTIME_OUTPUT_DIRECTORY** ：可执行文件输出路径
- **CMAKE_LIBRARY_OUTPUT_DIRECTORY** ：动态库输出路径
- **CMAKE_ARCHIVE_OUTPUT_DIRECTORY** ：静态库输出路径

# 查找依赖
- 使用`PkgConfig`
```c
// 安装 PkgConfig
sudo apt install PkgConfig -y
// 在cmake中添加
find_package(Pkg REQUIRED)
```
- 使用`FetchContent` 添加依赖(国外用户)
```c
// 这里以GTest为例子
include(FetchContent)

# 添加 Google Test
FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG       main 
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
# gmock
set(BUILD_GMOCK OFF CACHE BOOL "" FORCE) 
# gtest
set(BUILD_GTEST ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)
```

