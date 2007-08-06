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
  end
end
