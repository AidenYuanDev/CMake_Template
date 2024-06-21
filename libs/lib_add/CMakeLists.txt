set(lib_name my_add)
file(GLOB SRCS "src/*.cpp")
file(GLOB INCLUDE "include/*.h")

add_library(
    ${lib_name}
    ${SRCS}
    ${INCLUDE}
)

target_include_directories(
    ${lib_name} PUBLIC
    include/
)

# 链接其他库
# target_link_libraries(
#     ${lib_name}
#     lib_other
# )
