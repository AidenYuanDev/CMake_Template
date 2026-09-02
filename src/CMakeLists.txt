add_executable(${PROJECT_NAME})

target_sources(${PROJECT_NAME} PRIVATE
    main.cpp)

target_link_libraries(${PROJECT_NAME} PRIVATE
    ${PROJECT_NAME}::add
    ${PROJECT_NAME}::sub
    ${PROJECT_NAME}_warnings)

if(PROJECT_IS_TOP_LEVEL)
  install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
endif()
