AR := ar
CC := gcc

CFLAGS = -I./include/libusb -I./libusbip -I/usr/local/include -I/opt/local/include
LDFLAGS = -L/usr/lib -L/opt/local/lib 
LIBS = -lusb-1.0

LIBUSBIP_TARGET = libusbip/libusbip.a
LIBUSBIP_OBJECTS = libusbip/libusbip.o libusbip/proto.o libusbip/client.o libusbip/server.o libusbip/error.o libusbip/warning.o include/tpl/tpl.o
LIBUSBIP_CFLAGS = $(CFLAGS)
LIBUSBIP_LDFLAGS = $(LDFLAGS)
LIBUSBIP_LIBS = $(LIBS)

RPCSERVER_TARGET = examples/rpc_server
RPCSERVER_OBJECTS = examples/rpc_server.o libusbip/libusbip.a
RPCSERVER_CFLAGS = $(CFLAGS)
RPCSERVER_LDFLAGS = $(LDFLAGS)
RPCSERVER_LIBS = $(LIBS)

RPCCLIENT_TARGET = examples/rpc_client
RPCCLIENT_OBJECTS = examples/rpc_client.o libusbip/libusbip.a
RPCCLIENT_CFLAGS = $(CFLAGS)
RPCCLIENT_LDFLAGS = $(LDFLAGS)
RPCCLIENT_LIBS = $(LIBS)

TARGETS = $(LIBUSBIP_TARGET) $(RPCSERVER_TARGET) $(RPCCLIENT_TARGET)
OBJECTS = $(LIBUSBIP_OBJECTS) $(RPCSERVER_OBJECTS) $(RPCCLIENT_OBJECTS)

%.o: %.S
	$(CC) -c $(<) -o $(@) $(CFLAGS)

%.o: %.c
	$(CC) -c $(<) -o $(@) $(CFLAGS)
	
$(LIBUSBIP_TARGET): $(LIBUSBIP_OBJECTS)
	$(AR) rs $(LIBUSBIP_TARGET) $(LIBUSBIP_OBJECTS)

$(RPCSERVER_TARGET): $(RPCSERVER_OBJECTS)
	$(CC) -o $(RPCSERVER_TARGET) $(RPCSERVER_OBJECTS) $(RPCSERVER_CFLAGS) $(RPCSERVER_LDFLAGS) $(RPCSERVER_LIBS)

$(RPCCLIENT_TARGET): $(RPCCLIENT_OBJECTS)
	$(CC) -o $(RPCCLIENT_TARGET) $(RPCCLIENT_OBJECTS) $(RPCCLIENT_CFLAGS) $(RPCCLIENT_LDFLAGS) $(RPCCLIENT_LIBS)
	
all: $(TARGETS)

clean:
	$(RM) $(LIBUSBIP_TARGET) $(RPCSERVER_TARGET) $(RPCCLIENT_TARGET) libusbip/*.o examples/*.o include/tpl/*.o
