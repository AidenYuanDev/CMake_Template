# 添加静态库
add_library(module1
    src/module1.cpp
)

target_include_directories(module1
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# 测试
add_subdirectory(test)
