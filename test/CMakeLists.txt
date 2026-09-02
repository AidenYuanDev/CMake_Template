if(PROJECT_BUILD_TESTS)
    add_executable(${PROJECT_NAME}_integration_test integration_test.cpp)

    target_link_libraries(${PROJECT_NAME}_integration_test PRIVATE
        GTest::gtest_main
        ${PROJECT_NAME}::add
        ${PROJECT_NAME}::sub
        ${PROJECT_NAME}_warnings)

    gtest_discover_tests(${PROJECT_NAME}_integration_test)
endif()
