# 目标名带项目前缀，避免与其他模块或上层项目的测试目标重名
add_executable(${PROJECT_NAME}_add_test add_test.cpp)

target_link_libraries(${PROJECT_NAME}_add_test PRIVATE
    GTest::gtest_main
    ${PROJECT_NAME}::add
    ${PROJECT_NAME}_warnings)

gtest_discover_tests(${PROJECT_NAME}_add_test)
