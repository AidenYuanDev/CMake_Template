if(BUILD_TESTING)
    add_executable(integration_test integration_test.cpp)

    target_link_libraries(integration_test PRIVATE
        GTest::gtest_main
        add
        sub)

    gtest_discover_tests(integration_test)
endif()
