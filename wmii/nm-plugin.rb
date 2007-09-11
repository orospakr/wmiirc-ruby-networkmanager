require 'networkmanager'

Plugin.define("andrew@orospakr.ca") do
  author '"Andrew Clunis" <andrew@orospakr.ca>'

  network_manager = NetworkManager::Manager.new

  bar_applet("network-manager", 50) do |wmii, bar|
    # TODO How do I refresh the wmii bar applet?  I need to do so when
    #      the network is reconnected...
    #bar.on_click(MOUSE_BUTTON_LEFT){ wmii.view "foo" }
    #Thread.new{ loop{ bar.data = `somecmd` }; sleep 2 }
    active_device = network_manager.get_active_device
    #bar.data = "whee"
    #bar.data = network_manager.get_current_ssid
    if active_device.get_type == NetworkManager::TYPE_WIRELESS
      bar.data = active_device.get_active_network.get_name
    else
      bar.data = "Wired"
    end
  end
  binding("network-manager", "MODKEY-Shift-n") do |wmii, keyhandler|
    # keyhandler.key is the key that was pressed.
    # you can unregisted the keyhandler (remove the binding) with
    # wmii.unregister(keyhandler)
    wmii.write "/view/sel/mode", "max"
    active_device = network_manager.get_active_device
    human_names = {}
    network_manager.get_devices.each { |device|
      #human_names.append(device.get_networks.collect{ |network|
      #  [network,"#{network.get_name}:#{device.get_name}"]
      #})
      if device.get_type == NetworkManager::TYPE_WIRELESS
        for network in device.get_networks
          human_names["#{network.get_name}:#{device.get_name}"] = network
        end
      end
    }

    wmii.wmiimenu(human_names.keys) do |network|
      p "NetworkManager WMII frontend - user selected: #{human_names[network].get_name}"
    end
  end
end
