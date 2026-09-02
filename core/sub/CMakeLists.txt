add_library(sub STATIC)

target_include_directories(sub PUBLIC include/)

# 目标自己声明语言标准下限，这样即便被别的项目引入、
# ProjectSettings 里的 CMAKE_CXX_STANDARD 不生效，也仍然按 C++20 编译
target_compile_features(sub PUBLIC cxx_std_20)

target_sources(sub PRIVATE 
    src/sub.cpp)

target_link_libraries(sub
  PUBLIC
    noncopyable
  PRIVATE
    project_warnings)
