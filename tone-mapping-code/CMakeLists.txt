cmake_minimum_required(VERSION 3.8 FATAL_ERROR)

project (ToneMapping LANGUAGES CUDA CXX)

if(NOT DEFINED CMAKE_CUDA_STANDARD)
    set(CMAKE_CUDA_STANDARD 11)
    set(CMAKE_CUDA_STANDARD_REQUIRED ON)
endif()

function(CUDA_CONVERT_FLAGS EXISTING_TARGET)
    get_property(old_flags TARGET ${EXISTING_TARGET} PROPERTY INTERFACE_COMPILE_OPTIONS)
    if(NOT "${old_flags}" STREQUAL "")
        string(REPLACE ";" "," CUDA_flags "${old_flags}")
        set_property(TARGET ${EXISTING_TARGET} PROPERTY INTERFACE_COMPILE_OPTIONS
            "$<$<BUILD_INTERFACE:$<COMPILE_LANGUAGE:CXX>>:${old_flags}>$<$<BUILD_INTERFACE:$<COMPILE_LANGUAGE:CUDA>>:-Xcompiler=${CUDA_flags}>"
            )
    endif()
endfunction()

#Remove extra default configurations
set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)

#Moves All_build and Zero_check(rebuild cmkae files) to separate folder
set_property(GLOBAL PROPERTY USE_FOLDERS ON)


### Libraries ###
#find_package(OpenGL REQUIRED)
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})


### Projects ###
include_directories(${CMAKE_SOURCE_DIR})

SET(Convolution_SOURCE
	main.cpp
	loadSaveImage.h
	loadSaveImage.cpp
	funcHDR.cu
	tonemapping.cu
	timer.h
)

add_executable(ToneMapping ${Convolution_SOURCE})

target_link_libraries(ToneMapping
	${OpenCV_LIBS}
)

#Sets the default project for VisualStudio
set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ToneMapping)


### Testing ###
#Enable unit test
#enable_testing()
#add_subdirectory(test)