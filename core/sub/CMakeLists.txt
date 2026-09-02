add_library(${PROJECT_NAME}_sub STATIC)
# 使用方一律通过命名空间引用，与安装后 find_package 得到的名字完全一致
add_library(${PROJECT_NAME}::sub ALIAS ${PROJECT_NAME}_sub)

target_sources(${PROJECT_NAME}_sub
  PRIVATE
    src/sub.cpp
  PUBLIC
    FILE_SET HEADERS
      BASE_DIRS include
      FILES include/sub.h)

# 目标自己声明语言标准下限，不依赖全局的 CMAKE_CXX_STANDARD
target_compile_features(${PROJECT_NAME}_sub PUBLIC cxx_std_20)

target_link_libraries(${PROJECT_NAME}_sub
  PUBLIC
    # sub.h 里 include 并继承了它，属于使用要求，必须 PUBLIC
    ${PROJECT_NAME}::noncopyable
  PRIVATE
    # 包一层 BUILD_INTERFACE：静态库的 PRIVATE 依赖仍会以 $<LINK_ONLY:> 的形式
    # 留在导出接口里，不隔离的话 install(EXPORT) 会要求把警告目标也一并导出
    $<BUILD_INTERFACE:${PROJECT_NAME}_warnings>)

# install(EXPORT) 的 NAMESPACE 是拼在真实目标名前面的，ALIAS 对导出无效。
# 不设 EXPORT_NAME 的话使用方拿到的会是 ${PROJECT_NAME}::${PROJECT_NAME}_sub，与 ALIAS 对不上
set_target_properties(${PROJECT_NAME}_sub PROPERTIES EXPORT_NAME sub)

if(PROJECT_IS_TOP_LEVEL)
  install(TARGETS ${PROJECT_NAME}_sub
    EXPORT ${PROJECT_NAME}Targets
    FILE_SET HEADERS)
endif()
