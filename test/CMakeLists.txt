include(FetchContent)
FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG       main 
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
# gmock
set(BUILD_GMOCK OFF CACHE BOOL "" FORCE) 
# gtest
set(BUILD_GTEST ON CACHE BOOL "" FORCE)
FetchContent_MakeAvailable(googletest)

enable_testing()

add_executable(
    test_add
    test_add.cpp
)
target_link_libraries(
    test_add
    GTest::gtest_main
    my_add
)

include(GoogleTest)
gtest_discover_tests(test_add)
