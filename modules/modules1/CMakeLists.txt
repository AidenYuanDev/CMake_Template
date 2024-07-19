# 添加静态库
add_library(module1 STATIC)

target_sources(module1
    PRIVATE
        src/module1.cpp
    PUBLIC
        include/module1.h
)

target_include_directories(module1
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# 测试
if(BUILD_TESTING)
    add_subdirectory(test)
endif()
