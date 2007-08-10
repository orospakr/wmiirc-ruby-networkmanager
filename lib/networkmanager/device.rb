
require 'dbus'
require 'networkmanager/network'

module NetworkManager
  # Encapsulates a NetworkManager Device object.
  class Device
    attr_accessor :nm_service, :device_object, :device_interface
    def initialize(device_path)
      @nm_service = DBus::SystemBus.instance.service(NM_SERVICE)
      # print "Initialising Device object with path #{device_path}\n"
      @device_object = @nm_service.object(device_path)
      @device_interface = DBus::ProxyObjectInterface.new(@device_object, NM_DEVICE_INTERFACE)
      @device_interface.define_method('getName', '')
      @device_interface.define_method('getType', '')
      @device_interface.define_method('getHalUdi', '')
      @device_interface.define_method('getIP4Address', '') # why is this even here?
      @device_interface.define_method('getLinkActive', '')
      @device_interface.define_method('getStrength', '')
      # @device_interface.define_method("getActiveNetwork", ')
      @device_interface.define_method('getNetworks', '')
    end

    def get_name
      @device_interface.getName[0]
    end

    def get_link_active
      @device_interface.getLinkActive[0]
    end

    def get_type
      @device_interface.getType[0]
    end

    def get_hal_udi
      @device_interface.getHalUdi[0]
    end

    def get_ipv4_address
      @device_interface.getIP4Address[0]
    end

    def get_strength
      @device_interface.getStrength[0]
    end

    # return
    def get_network_paths
      @device_interface.getNetworks[0]
    end

    def get_networks
      path_array = get_network_paths
      network_objects = []
      path_array.each do |network_path|
        network_objects << NetworkManager::Network.new(network_path)
      end
      network_objects
    end
  end
end
