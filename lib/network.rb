require 'dbus'

module NetworkManager
  # represents a NetworkManager network.  It could represent the network plugged in
  # via a wired ethernet controller, or a given 802.11 network available via the
  # wireless adapter.
  class Network
    def initialize(network_path)
      @nm_service = DBus::SystemBus.instance.service(NM_SERVICE)
      @network_object = @nm_service.object(network_path)
      @network_interface = DBus::ProxyObjectInterface.new(@network_object, NM_NETWORK_INTERFACE)
      @network_interface.define_method('getName', '')
    end

    def get_name
      @network_interface.getName
    end

    def get_address
      @network_interface.getAddress
    end

    def get_strength
      @network_interface.getStrength
    end

    def get_frequency
      @network_interface.getFrequency
    end

    def get_rate
      @network_interface.getRate
    end

    def get_encrypted
      @network_interface.getEncrypted
    end
  end
end
