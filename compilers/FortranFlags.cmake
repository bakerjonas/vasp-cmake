if (NOT DEFINED DEFAULT_Fortran_FLAGS_SET)
if(CMAKE_Fortran_COMPILER_ID MATCHES GNU) # this is gfortran
    set(CMAKE_Fortran_FLAGS
        "-cpp -ffree-line-length-none -ff2c -fno-second-underscore")
    set(CMAKE_Fortran_FLAGS_DEBUG
        "-O0 -g -fbacktrace")
    set(CMAKE_Fortran_FLAGS_RELEASE
        "-w -O3 -ffast-math -funroll-loops -ftree-vectorize")
    if(ENABLE_BOUNDS_CHECK)
        set(CMAKE_Fortran_FLAGS
            "${CMAKE_Fortran_FLAGS} -fbounds-check"
            )
    endif()
    if(ENABLE_CODE_COVERAGE)
        set(CMAKE_Fortran_FLAGS
            "${CMAKE_Fortran_FLAGS} -ftest-coverage"
            )
    endif()
    add_definitions(-DHOST="gfortran" -DCACHE_SIZE=4096 -DMINLOOP=1)
elseif(CMAKE_Fortran_COMPILER_ID MATCHES Intel)
    set(CMAKE_Fortran_FLAGS
        "-w -fpp -Wp,-f_com=no -assume byterecl -traceback -lowercase")
    set(CMAKE_Fortran_FLAGS_DEBUG   "-O0 -g")
    set(CMAKE_Fortran_FLAGS_RELEASE "-O3 -xW -ip")
    if(ENABLE_BOUNDS_CHECK)
        set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS}
        -check bounds -fpstkchk -check pointers -check uninit -check output_conversion"
            )
    endif()
    add_definitions(-DHOST="LinuxIFC" -DCACHE_SIZE=12000 -DPGF90 -Davoidalloc)

elseif(CMAKE_Fortran_COMPILER_ID MATCHES G95)
    set(CMAKE_Fortran_FLAGS
        "-Wno=155 -fno-second-underscore -fsloppy-char")
    set(CMAKE_Fortran_FLAGS_DEBUG   "-O0 -g -ftrace=full")
    set(CMAKE_Fortran_FLAGS_RELEASE "-O3")
    if(ENABLE_BOUNDS_CHECK)
        set(CMAKE_Fortran_FLAGS
            "${CMAKE_Fortran_FLAGS} -Wall -fbounds-check"
            )
    endif()
    if(ENABLE_CODE_COVERAGE)
        set(CMAKE_Fortran_FLAGS
            "${CMAKE_Fortran_FLAGS}"
            )
    endif()

elseif(CMAKE_Fortran_COMPILER_ID MATCHES PGI)
    set(CMAKE_Fortran_FLAGS         "")
    set(CMAKE_Fortran_FLAGS_DEBUG   "-g -O0 -Mframe")
    set(CMAKE_Fortran_FLAGS_RELEASE "-O3 -mcmodel=medium -fast -Munroll")
    if(ENABLE_BOUNDS_CHECK)
        set(CMAKE_Fortran_FLAGS
            "${CMAKE_Fortran_FLAGS} "
            )
    endif()
    if(ENABLE_CODE_COVERAGE)
        set(CMAKE_Fortran_FLAGS
            "${CMAKE_Fortran_FLAGS} "
            )
    endif()
elseif(CMAKE_Fortran_COMPILER_ID MATCHES XL)
    set(CMAKE_Fortran_FLAGS         "-qzerosize -qextname")
    set(CMAKE_Fortran_FLAGS_DEBUG   "-g")
    set(CMAKE_Fortran_FLAGS_RELEASE "-O3")
    set_source_files_properties(${FREE_FORTRAN_SOURCES}
        PROPERTIES COMPILE_FLAGS
        "-qfree"
        )
    set_source_files_properties(${FIXED_FORTRAN_SOURCES}
        PROPERTIES COMPILE_FLAGS
        "-qfixed"
        )
endif()
save_compiler_flags(Fortran)
endif ()
