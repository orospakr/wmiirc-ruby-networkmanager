#!/usr/bin/env ruby

require 'dbus'

require 'device'

module NetworkManager
  NM_SERVICE = "org.freedesktop.NetworkManager"
  NM_INTERFACE = "org.freedesktop.NetworkManager"
  NM_DEVICE_INTERFACE = "org.freedesktop.NetworkManager.Devices"
  NM_NETWORK_INTERFACE = "org.freedesktop.NetworkManager.Networks"
  NM_OBJECT = "/org/freedesktop/NetworkManager"

  # Encapsulates the NetworkManager dbus service.
  # Implements the factory pattern for Device and Network.
  class Manager
    attr_accessor :nm_service, :nm_object, :nm_interface

    def initialize
      @nm_service = DBus::SystemBus.instance.service(NM_SERVICE)
      @nm_object = @nm_service.object(NM_OBJECT)
      @nm_interface = DBus::ProxyObjectInterface.new(@nm_object, NM_INTERFACE)
      @nm_interface.define_method("getDevices", "")
    end

    # returns an array of NetworkDevice objects
    def get_devices
      #p "calling get_devices"
      devices = @nm_interface.getDevices[0]
      #p devices
      device_objects = []
      devices.each do |device_path|
        device_objects << NetworkManager::Device.new(device_path)
      end
      #p device_objects
      device_objects
    end

    # returns a NetworkDevice object representing the currently active device.
    # now a convenience method because NM no longer has getActiveDevice.
    # Simply returns the first Device object set to active.
    # Note that NM now permits more than one object to be set Active, and as such
    # this convenience method only returns the first one.
    def get_active_device
      #p "calling get_active_device"
      #device_path = @nm_interface.getActiveDevice
      #return Device.new(device_path)
      devices = get_devices
      devices.each do |device|
        #return device if device.get_link_active
        #p device.methods.sort
        return device.get_name
      end
    end
  end
end

# silly test

# nm = NetworkManager::Manager.new()
# devices = nm.get_devices()
# #print(devices)
# print devices[0].get_name

