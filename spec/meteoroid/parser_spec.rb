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

  describe "parse" do
    it "should returns both samples from the file" do
      xml = File.read(File.join(File.dirname(__FILE__), %w[ .. fixtures example.jml ]))
      File.expects(:open).times(1).returns(StringIO.new(xml))

      parsed = Meteoroid::Parser.new('foo.jml').parse

      parsed.size.should == 2
    end

    it "should returns samples from both files" do
      foo = File.read(File.join(File.dirname(__FILE__), %w[ .. fixtures example.jml ]))
      bar = File.read(File.join(File.dirname(__FILE__), %w[ .. fixtures full.jml ]))

      File.expects(:open).with('foo.jml').times(1).returns(StringIO.new(foo))
      File.expects(:open).with('bar.jml').times(1).returns(StringIO.new(bar))

      parsed = Meteoroid::Parser.new('foo.jml', 'bar.jml').parse

      parsed.size.should == 562
    end
  end

  describe "self.parse!" do
    it "should parse the passed in files" do
      xml = File.read(File.join(File.dirname(__FILE__), %w[ .. fixtures example.jml ]))
      File.expects(:open).times(1).returns(StringIO.new(xml))

      parsed = Meteoroid::Parser.parse!('foo.jml')

      parsed.size.should == 2
    end
  end
end