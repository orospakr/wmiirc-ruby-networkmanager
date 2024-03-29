require 'dbus'

module NetworkManager
  # represents a NetworkManager network.  It could represent the network plugged in
  # via a wired ethernet controller, or a given 802.11 network available via the
  # wireless adapter.
  class Network
    def initialize(network_path, device)
      @host_device = device
      @nm_service = DBus::SystemBus.instance.service(NM_SERVICE)
      @network_object = @nm_service.object(network_path)
      @network_interface = DBus::ProxyObjectInterface.new(@network_object, NM_NETWORK_INTERFACE)
      @network_interface.define_method('getName', '')
    end

    def get_name
      @network_interface.getName[0]
    end

    def get_address
      @network_interface.getAddress[0]
    end

    def get_strength
      @network_interface.getStrength[0]
    end

    def get_frequency
      @network_interface.getFrequency[0]
    end

    def get_rate
      @network_interface.getRate[0]
    end

    def get_encrypted
      @network_interface.getEncrypted[0]
    end
  end
end
