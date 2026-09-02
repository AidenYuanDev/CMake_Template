include(FetchContent)

# 只有构建测试时才拉取 GTest，避免默认构建也要求联网
if(BUILD_TESTING)
  FetchContent_Declare(
    googletest
    GIT_REPOSITORY https://github.com/google/googletest.git
    # 固定到具体 tag，不要用 main：保证构建可复现
    GIT_TAG        v1.17.0
    GIT_SHALLOW    TRUE
  )

  # Windows: 防止 GTest 覆盖父项目的编译器/链接器设置
  set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
  # 只需要 gtest，不需要 gmock
  set(BUILD_GMOCK OFF CACHE BOOL "" FORCE)
  # 不要把 GTest 一起装到安装目录里
  set(INSTALL_GTEST OFF CACHE BOOL "" FORCE)

  FetchContent_MakeAvailable(googletest)

  # 把 GTest 的头文件目录标记为 SYSTEM，这样链接了 project_warnings 的测试目标
  # 不会因为第三方头文件里的写法而报警告（CMake 3.25+ 可直接用 FetchContent 的 SYSTEM 选项）
  foreach(gtest_target gtest gtest_main)
    get_target_property(gtest_incs ${gtest_target} INTERFACE_INCLUDE_DIRECTORIES)
    if(gtest_incs)
      set_target_properties(${gtest_target} PROPERTIES
        INTERFACE_SYSTEM_INCLUDE_DIRECTORIES "${gtest_incs}")
    endif()
  endforeach()

  # 提供 gtest_discover_tests()，各模块的 test/ 直接用
  include(GoogleTest)
endif()
