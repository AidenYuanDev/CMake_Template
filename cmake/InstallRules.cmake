include(CMakePackageConfigHelpers)

# 包配置文件的安装位置，find_package() 会到这里来找
set(PROJECT_CMAKE_DIR ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME})

# 导出目标集合。NAMESPACE 让使用方写 YourProjectName::add，
# 与本项目内部 ALIAS 的写法完全一致 —— 无论是 add_subdirectory 引入
# 还是 find_package 引入，使用方代码不用改一个字
install(EXPORT ${PROJECT_NAME}Targets
  FILE ${PROJECT_NAME}Targets.cmake
  NAMESPACE ${PROJECT_NAME}::
  DESTINATION ${PROJECT_CMAKE_DIR})

# 由模板生成 <Project>Config.cmake
configure_package_config_file(
  ${CMAKE_CURRENT_LIST_DIR}/Config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
  INSTALL_DESTINATION ${PROJECT_CMAKE_DIR})

# 版本文件，供 find_package(YourProjectName 1.0 REQUIRED) 做版本校验
write_basic_package_version_file(
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
  VERSION ${PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion)

install(FILES
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
  DESTINATION ${PROJECT_CMAKE_DIR})
