# 添加静态库
add_library(add STATIC)

target_include_directories(add PUBLIC include/)

# 目标自己声明语言标准下限，这样即便被别的项目引入、
# ProjectSettings 里的 CMAKE_CXX_STANDARD 不生效，也仍然按 C++20 编译
target_compile_features(add PUBLIC cxx_std_20)

target_sources(add PRIVATE 
    src/add.cpp)

target_link_libraries(add
  PUBLIC
    noncopyable
  PRIVATE
    project_warnings)

# 测试
if(PROJECT_BUILD_TESTS)
    add_subdirectory(test)
endif()
