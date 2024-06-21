# CMake_Template

## 前言

CMake复杂项目目录模板，测试使用`google test`

项目结构如下：

~~~bash
.
├── CMakeLists.txt
├── README.md
├── libs
│   └── lib_add
│       ├── CMakeLists.txt
│       ├── include
│       │   └── add.h
│       └── src
│           └── add.cpp
├── src
│   └── main.cpp
└── test
    ├── CMakeLists.txt
    └── test_add.cpp
~~~

## 使用

~~~bash

mkdir build
cd build
cmake ..
cmake --build .
~~~



