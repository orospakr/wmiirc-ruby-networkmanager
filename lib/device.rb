
require "networkmanager"
require "ruby-debug"

module NetworkManager
  # Encapsulates a NetworkManager Device object.
  class Device
    attr_accessor :nm_service, :device_object, :device_interface
    def initialize(device_path, nm_service)
      #print "SAFADSF" if nm_service.nil?
      #@nm_service = DBus::SystemBus.instance.service(NM_SERVICE)
      #print "loool: " + device_path
      @device_object = nm_service.object(device_path)
      @device_interface = DBus::ProxyObjectInterface.new(@nm_manager, NM_DEVICE_INTERFACE)
      @device_interface.define_method("getName", "")
      #@device_interface.define_method("getType", "")
      #@device_interface.define_method("getHalUdi", "")
      #@device_interface.define_method("getIP4Address", "") # why is this even here?
      #@device_interface.define_method("getLinkActive", "")
      #@device_interface.define_method("getStrength", "")
      #@device_interface.define_method("getActiveNetwork", "")
      #@device_interface.define_method("getNetworks", "")
    end

    def get_name
      @device_interface.getName
    end

    def get_link_active
      @device_interface.getLinkActive
    end
  end
end
