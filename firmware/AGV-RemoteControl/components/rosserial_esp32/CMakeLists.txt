set (srcs
    "duration.cpp"
    "time.cpp")

idf_component_register(SRCS "${srcs}"
                       INCLUDE_DIRS "include"
                       REQUIRES vfs nvs_flash)
