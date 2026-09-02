# 目标名带模块前缀，避免与其他模块的测试目标重名
add_executable(add_test add_test.cpp)

target_link_libraries(add_test PRIVATE
    GTest::gtest_main
    add)

gtest_discover_tests(add_test)
