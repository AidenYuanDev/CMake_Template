cmake_minimum_required(VERSION 3.14)
project(my_project VERSION 0.10 LANGUAGES C CXX)

# requires at least C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
enable_testing()

# 包含子目录
add_subdirectory(libs/lib_add)
add_subdirectory(test)

# 添加可执行文件
add_executable(${PROJECT_NAME} src/main.cpp)

# 链接库文件
target_link_libraries(
    ${PROJECT_NAME}
    my_add 
)

#生成ycm可识别的json文件，让源文件找到头文件
SET(CMAKE_EXPORT_COMPILE_COMMANDS ON )
