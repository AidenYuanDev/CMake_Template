# 把警告选项做成 INTERFACE target，取代全局的 add_compile_options()：
#   1. 只作用于显式链接它的目标，不会波及 FetchContent 拉进来的第三方代码
#   2. 按编译器分发，MSVC 不再收到一堆 GNU 风格的未知选项
#
# 用法：target_link_libraries(<target> PRIVATE project_warnings)
# 警告是构建期的事，不是使用要求，所以永远用 PRIVATE 链接。

option(PROJECT_WARNINGS_AS_ERRORS "把编译警告当作错误" OFF)

add_library(project_warnings INTERFACE)

set(MSVC_WARNINGS
    /W4              # 合理的警告级别
    /permissive-     # 关闭 MSVC 的非标准扩展
)

set(CLANG_WARNINGS
    -Wall
    -Wextra
    -Wpedantic
    -Wshadow              # 变量遮蔽外层作用域
    -Wnon-virtual-dtor    # 有虚函数却没有虚析构
    -Wold-style-cast      # C 风格强制转换
    -Wcast-align          # 可能导致性能问题的对齐转换
    -Woverloaded-virtual  # 覆盖了基类虚函数的重载
    -Wconversion          # 可能丢失数据的隐式转换
    -Wsign-conversion     # 有符号/无符号隐式转换
    -Wnull-dereference    # 解引用空指针
    -Wdouble-promotion    # float 隐式提升为 double
    -Wformat=2            # printf 系列的格式串检查
    -Wimplicit-fallthrough
    -Wunused
)

# GCC 独有、Clang 不认识的
set(GCC_WARNINGS
    ${CLANG_WARNINGS}
    -Wmisleading-indentation
    -Wduplicated-cond
    -Wduplicated-branches
    -Wlogical-op          # 对位运算符使用了逻辑运算符
    -Wuseless-cast        # 转换到自身类型
)

if(PROJECT_WARNINGS_AS_ERRORS)
    list(APPEND MSVC_WARNINGS /WX)
    list(APPEND CLANG_WARNINGS -Werror)
    list(APPEND GCC_WARNINGS -Werror)
endif()

if(MSVC)
    set(PROJECT_WARNING_FLAGS ${MSVC_WARNINGS})
elseif(CMAKE_CXX_COMPILER_ID MATCHES ".*Clang")   # 同时覆盖 Clang 和 AppleClang
    set(PROJECT_WARNING_FLAGS ${CLANG_WARNINGS})
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    set(PROJECT_WARNING_FLAGS ${GCC_WARNINGS})
else()
    message(WARNING "未知的编译器 '${CMAKE_CXX_COMPILER_ID}'，未设置警告选项")
    set(PROJECT_WARNING_FLAGS "")
endif()

target_compile_options(project_warnings INTERFACE ${PROJECT_WARNING_FLAGS})
