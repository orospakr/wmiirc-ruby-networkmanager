
require File.dirname(__FILE__) + '/spec_helper'

require 'networkmanager'

module NetworkManager
  describe Manager, " when first created" do
    before do
      @networkmanager = Manager.new
    end

    it "should have acquired DBus object handle for NetworkManager" do
      @networkmanager.nm_object.should_not be_nil
    end

    it "should return a list of all the network device paths" do
      devices = @networkmanager.get_device_paths.should_not be_nil
      #print devices
    end

    it "should return the active network device" do
      active_device = @networkmanager.get_active_device
      active_device.should_not be_nil
    end

    # this should of course be factored into network-test.rb
    # ... and I probably shouldn't be talking to the real NM daemon.
    it "'s active device should return a network list" do
      active_device = @networkmanager.get_active_device
      networks = active_device.get_networks
      networks.each do |network|
        print "#{network.get_name}\n"
      end
      networks.should_not be_nil
    end

    it "'s active device should return an active network" do
      active_device = @networkmanager.get_active_device
      network = active_device.get_active_network
      network.should_not be_nil
    end
  end
end
