import dbus

bus = dbus.SystemBus()

manager = dbus.Interface(bus.get_object('org.bluez', '/'), 'org.bluez.Manager')

adapterPath = manager.DefaultAdapter()

adapter = dbus.Interface(bus.get_object('org.bluez', adapterPath), 'org.bluez.Adapter')

print("darn motherfucker")
for devicePath in adapter.ListDevices():
    device = dbus.Interface(bus.get_object('org.bluez', devicePath),'org.bluez.Device')
    deviceProperties = device.GetProperties()
    print(deviceProperties["Address"])