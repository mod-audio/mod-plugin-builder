When there is a problem with the ttl generators of the plugins due to wrong EXEC when cross compiling you can use the program "qemu" to execute the ttl generators. To executie the generators with qemu you need to change line 134 of all the Makefile.mk's in each plugin source folder to:  

qemu-arm ../lv2_ttl_generator ./$(NAME)_dsp$(LIB_EXT)

