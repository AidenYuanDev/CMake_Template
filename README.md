# 一、前言
本节所以代码均可在[CMake_Template](https://github.com/AidenYuanDev/CMake_Template)仓库中找到。
支持对不同模块进行`gtest`单元测试
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
├── CMakeLists.txt
├── README.md
├── cmake
│   ├── FindDependencies.cmake
│   └── ProjectSettings.cmake
├── include
│   └── project_name
│       ├── module1.h
│       └── module2.h
├── modules
│   └── modules1
│       ├── CMakeLists.txt
│       ├── include
│       │   └── internal.h
│       ├── src
│       │   └── module1.cpp
│       └── test
│           ├── CMakeLists.txt
│           └── module1_test.cpp
├── src
│   ├── CMakeLists.txt
│   └── main.cpp
└── test
    ├── CMakeLists.txt
    └── test_add.cpp
```

- **CMakeLists.txt:** CMake项目的核心配置文件，定义了项目的构建过程和规则。
- **cmake:** 实现对主`CMakeLists.txt`的解耦。
	
	- **FindDependencies.cmake:** 存放依赖
	- **ProjectSettings.cmake:**存放项目设置
- **modules:** 核心点，把原项目拆分为不同的子模块。
	
	- **include:** 模块头文件
	- **src:** 模块源文件
	- **test:** 模块单元测试
- **src:** 存放主函数
- **test:** 单元测试
- **include:** 放一些，模块外，`main`可能用到的头文件

> 具体的`CMakeLists.txt`的内容，大家可以自己进入我的仓库查看。
# 四、`CMake`的基础概念

## 1 用`CMake`管理项目分为两步

1. 生成构建系统文件
在根目录下创建`build`目录，运行`camke ..`
```bash
mkadir build
cmake ..
```
2. 对当前目录进行构建
~~~bash
cmake --build .
~~~

> 简单来说，如果你的项目结构发变化（`CMakeLists.txt`），那么你就要重新清空`build`目录，重新执行第一步。如果只是内容(`.cpp` or `.h`)变化，重新执行第二步就行。



