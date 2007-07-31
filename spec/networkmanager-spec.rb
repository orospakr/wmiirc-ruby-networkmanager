
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

    it "should return a list of all the network devices" do
      devices = @networkmanager.get_devices.should_not be_nil
      #print devices
    end

    it "should return the current network device" do
      active_device = @networkmanager.get_active_device
      active_device.should_not be_nil
    end
  end
end
