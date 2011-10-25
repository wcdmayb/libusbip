/**
 * libusbip - client.c
 * Copyright (C) 2011 Manuel Gebele
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 **/

#include "client.h"
#include "proto.h"

libusbip_error_t client_usb_init(struct libusbip_connection_info *ci) {
    libusbip_error_t error;
    libusbip_rpc_t rpc = LIBUSBIP_RPC_USB_INIT;
    
    proto_send_rpc(&rpc, ci->server_sock);
    proto_recv_int(&error, ci->server_sock);
        
    return error;
}

void
client_usb_exit(struct libusbip_connection_info *ci) {
    libusbip_rpc_t rpc = LIBUSBIP_RPC_USB_EXIT;

    proto_send_rpc(&rpc, ci->server_sock);
}

void
client_usb_get_device_list(struct libusbip_connection_info *ci, struct libusbip_device_list *dl) {
    libusbip_rpc_t rpc = LIBUSBIP_RPC_USB_GET_DEVICE_LIST;
    
    proto_send_rpc(&rpc, ci->server_sock);
    proto_recv_struct_dev_list(dl, ci->server_sock);
}

libusbip_error_t client_usb_get_device_descriptor(struct libusbip_connection_info *ci,
                                                  struct libusbip_device *dev,
                                                  struct libusbip_device_descriptor *dd) {
    libusbip_error_t error;
    libusbip_rpc_t rpc = LIBUSBIP_RPC_USB_GET_DEVICE_DESCRIPTOR;
    
    proto_send_rpc(&rpc, ci->server_sock);
    proto_send_struct_dev(dev, ci->server_sock);
    proto_recv_struct_dev_desc(dd, ci->server_sock);
    proto_recv_int(&error, ci->server_sock);
    
    return error;
}