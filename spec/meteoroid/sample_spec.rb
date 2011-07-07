require 'spec_helper'

describe Meteoroid::Sample do

  describe "attribute mappings" do
    Meteoroid::Sample::ATTRIBUTE_MAPPING.each do |key, value|
      it "should allow #{key} accessible through #{value}" do
        Meteoroid::Sample.new({}).should respond_to(value)
      end
    end
  end

  describe "convert" do

    describe "Strings" do
      { 'time' => 't', 'latency' => 'lt', 'response_code' => 'rc', 'bytes' => 'by' }.each do |method, attribute|
        it "#{method} should return a Integer" do
          Meteoroid::Sample.new({ attribute => '100' }).send(method.to_sym).should be_a(Integer)
        end
      end
    end

    describe "Strings" do
      { 'label' => 'lb', 'response_message' => 'rm', 'thread_name' => 'tn' }.each do |method, attribute|
        it "#{method} should return a String" do
          Meteoroid::Sample.new({ attribute => 'foo' }).send(method.to_sym).should be_a(String)
        end
      end
    end

    describe "Timestamps" do
      { 'timestamp' => 'tn' }.each do |method, attribute|
        it "#{method} should return a Time" do
          Meteoroid::Sample.new({ attribute => '1' }).send(method.to_sym).should be_a(Time)
        end
      end
    end

    describe "Boolean" do
      { 'success' => 's' }.each do |method, attribute|
        it "#{method} should return true" do
          Meteoroid::Sample.new({ attribute => 'true' }).send(method).should == true
        end
      end
    end

  end

  describe "from_xml" do
    it "should initialize a Sample from the attribute_nodes" do
      mock_node = [mock(:name => "lb", :value => "foo")]
      sample = Meteoroid::Sample.from_xml(mock_node)

      sample.label.should == "foo"
    end

    it "should initialize a Sample without a URL" do
      mock_node = [mock(:name => "lb", :value => "foo")]
      sample = Meteoroid::Sample.from_xml(mock_node)

      sample.url.should == ""
    end

    it "should initialize a Sample with a URL" do
      mock_node = [mock(:name => "lb", :value => "foo")]
      sample = Meteoroid::Sample.from_xml(mock_node, "foo.bar")

      sample.url.should == "foo.bar"
    end
  end

end