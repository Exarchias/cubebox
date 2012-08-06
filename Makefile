
INSTALL_PATH=/usr/games/cubebox
BIN_DIR = /usr/bin/
BUILD_DIR = ./build

CC = gcc
LD = ld
CP = cp
LN = ln
CHMOD = chmod
MKDIR = mkdir

CFLAGS= -lGL -lGLU -lglut -Wall -lportaudio -lm -lpthread -lrt -DSHM -lXext 

all: init client 

init:
	${MKDIR} ${BUILD_DIR} -p
	${CP} ./shared/etc/ ${BUILD_DIR}/etc -rf
	${CP} ./shared/media/ ${BUILD_DIR}/media -rf
	
client: libs ./client/init.o ./client/io/main.o ./client/main.o ./client/map/main.o ./client/com/thread/main.o ./client/com/server/main.o ./client/gl/main.o ./client/gl/glfuncs.o 
	$(CC) -g -o ${BUILD_DIR}/cb_cli ./shared/libs/parser/parser.o  ./client/init.o ./client/io/main.o ./client/main.o ./client/map/main.o ./client/com/thread/main.o ./client/com/server/main.o ./client/gl/main.o ./client/gl/glfuncs.o   $(CFLAGS)

server: libs 
	$(CC) -g -o ${BUILD_DIR}/cb_ser ./shared/libs/parser/parser.o    $(CFLAGS)

shared: libs 
	$(CC) -g -o ${BUILD_DIR}/cb_utils ./shared/libs/parser/parser.o    $(CFLAGS)

libs: ./shared/libs/parser/parser.o 

%.o:%.c
	$(CC) -g -o $@ -c $< $(CFLAGS)

rebuild:
	superclean
	all

clean:
	find ./ -name "*.o" -exec rm -rf {} \;

superclean: clean
	rm -rf ${BUILD_DIR}
	
new: superclean all

docs:
	robodoc --src ./ --doc shared/documentation --multidoc --html --index --sections --sectionnameonly --cmode --source_line_numbers --rc robodoc.rc
