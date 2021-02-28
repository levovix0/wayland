import unittest

import wayland/client

test "":
  let disp = displayConnect()
  if disp.isNil:
    echo "Could not connect to wayland display"
  var reg = disp.getRegistry
  echo reg.isNil

  proc onGlobal(data: pointer, registry: Registry, name: uint32, iface: cstring, version: uint32) {.cdecl.} =
    echo "onGlobal ", iface
    
  proc onGlobalRemove(data: pointer, registry: Registry, name: uint32) {.cdecl.} =
    echo "global remove"

  var l = RegistryListener(global: onGlobal, globalRemove: onGlobalRemove)
  echo reg.addListener(addr l, nil)

  echo disp.roundtrip()
  echo disp.roundtrip()
  echo disp.roundtrip()


  echo "Another "
  reg = disp.getRegistry()
  var l2 = RegistryListener(global: onGlobal, globalRemove: onGlobalRemove)

  echo reg.addListener(addr l2, nil)
  echo disp.roundtrip()
