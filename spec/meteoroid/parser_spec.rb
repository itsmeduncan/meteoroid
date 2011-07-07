require 'spec_helper'

describe Meteoroid::Parser do
  describe "files" do
    before :each do 
      @xml = File.read(File.join(File.dirname(__FILE__), %w[ .. fixtures example.jml ]))
    end

    it "should initialize a single Meteoroid::File" do
      File.expects(:open).times(1).returns(StringIO.new(@xml))
      files = Meteoroid::Parser.new('foo.jml').files

      files.should be_an(Array)
      files.first.should be_an(Meteoroid::File)
    end

    it "should initialize Meteoroid::Files" do
      File.expects(:open).times(2).returns(StringIO.new(@xml))
      files = Meteoroid::Parser.new('foo.jml', 'bar.jml').files

      files.should be_an(Array)
      files.first.should be_an(Meteoroid::File)
    end
  end
end