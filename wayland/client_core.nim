import util

type
  Proxy* = ptr object
  Display* = ptr object
  EventQueue* = ptr object

proc destroy*(queue: EventQueue) {.importc: "wl_event_queue_destroy".}
  
proc marshal*(p: Proxy, opcode: uint32) {.importc: "wl_proxy_marshal", varargs.}

proc marshalArray*(p: Proxy, opcode: uint32, args: ptr Argument) {.importc: "wl_proxy_marshal_array", varargs.}

proc create*(factory: Proxy, iface: ptr Interface): Proxy {.importc: "wl_proxy_create".}
proc createWrapper*(proxy: Proxy): Proxy {.importc: "wl_proxy_create_wrapper".}
proc wrapperDestroy*(proxy_wrapper: Proxy): Proxy {.importc: "wl_proxy_wrapper_destroy".}

proc marshalConstructor*(proxy: Proxy, opcode: uint32, iface: ptr Interface): Proxy {.importc: "wl_proxy_marshal_constructor", varargs.}
proc marshalConstructorVersioned*(proxy: Proxy, opcode: uint32, iface: ptr Interface, version: uint32): Proxy {.importc: "wl_proxy_marshal_constructor_versioned", varargs.}
proc marshalConstructor*(proxy: Proxy, opcode: uint32, args: ptr Argument, iface: ptr Interface): Proxy {.importc: "wl_proxy_marshal_array_constructor".}
proc marshalConstructorVersioned*(proxy: Proxy, opcode: uint32, args: ptr Argument, iface: ptr Interface, version: uint32): Proxy {.importc: "wl_proxy_marshal_array_constructor_versioned".}

proc destroy*(proxy: Proxy) {.importc: "wl_proxy_destroy".}

proc addListener*(proxy: Proxy, implementation: pointer, data: pointer): cint {.importc: "wl_proxy_add_listener", discardable.}
proc getListener*(proxy: Proxy): pointer {.importc: "wl_proxy_get_listener".}

proc addDispatcher*(proxy: Proxy, f: DispatcherFunc, dispData, data: pointer): cint {.importc: "wl_proxy_add_dispatcher", discardable.}

proc setUserData*(proxy: Proxy, data: pointer) {.importc: "wl_proxy_set_user_data".}
proc getUserData*(proxy: Proxy): pointer {.importc: "wl_proxy_get_user_data".}

proc getVersion*(proxy: Proxy): uint32 {.importc: "wl_proxy_get_version".}
proc getId*(proxy: Proxy): uint32 {.importc: "wl_proxy_get_id".}
proc getClass*(proxy: Proxy): cstring {.importc: "wl_proxy_get_class".}

proc setQueue*(proxy: Proxy, queue: EventQueue): cstring {.importc: "wl_proxy_set_queue".}


proc displayConnect*(name: cstring = nil): Display {.importc: "wl_display_connect".}
proc displayConnect*(fd: cint): Display {.importc: "wl_display_connect_to_fd".}
proc disconnect*(d: Display) {.importc: "wl_display_disconnect".}
proc getFd*(d: Display): cint {.importc: "wl_display_get_fd", discardable.}
proc dispatch*(d: Display): cint {.importc: "wl_display_dispatch", discardable.}
proc dispatchQueue*(d: Display, q: EventQueue): cint {.importc: "wl_display_dispatch_queue", discardable.}
proc dispatchQueuePending*(d: Display, q: EventQueue): cint {.importc: "wl_display_dispatch_queue_pending", discardable.}
proc dispatchPending*(d: Display): cint {.importc: "wl_display_dispatch_pending", discardable.}
proc getError*(d: Display): cint {.importc: "wl_display_get_error".}

proc getProtocolError*(d: Display, iface: ptr ptr Interface, id: ptr uint32): uint32 {.importc: "wl_display_get_protocol_error".}

proc flush*(d: Display): cint {.importc: "wl_display_flush", discardable.}

proc roundtripQueue*(d: Display, q: EventQueue): cint {.importc: "wl_display_roundtrip_queue", discardable.}
proc roundtrip*(d: Display): cint {.importc: "wl_display_roundtrip", discardable.}

proc createQueue*(d: Display): EventQueue {.importc: "wl_display_create_queue".}

proc prepareReadQueue*(d: Display, q: EventQueue): cint {.importc: "wl_display_prepare_read_queue", discardable.}

proc prepareRead*(d: Display): cint {.importc: "wl_display_prepare_read", discardable.}
proc cancelRead*(d: Display): cint {.importc: "wl_display_cancel_read", discardable.}
proc readEvents*(d: Display): cint {.importc: "wl_display_read_events", discardable.}

proc setLogHandler*(handler: pointer) {.importc: "wl_log_set_handler_client".}
