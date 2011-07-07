require 'spec_helper'

describe Meteoroid::File do

  before :each do
    @xml = File.read(File.join(File.dirname(__FILE__), %w[ .. fixtures example.jml ]))
  end

  describe "self.from" do
    it "should create valid Meteoroid::File from args" do
      File.expects(:open).times(2).returns(StringIO.new(@xml))
      files = Meteoroid::File.from(["foo.jml", "bar.jml"])
      files.collect(&:valid).should_not include(false)
    end
    
    it "should not return invalid files" do
      Meteoroid::File.from(["foo.jml", "bar.jml"]).should be_empty
    end
    
    it "should always return array of Meteoroid::File" do
      File.expects(:open).times(1).returns(StringIO.new(@xml))
      files = Meteoroid::File.from(["foo.jml"])
      files.collect(&:valid).should_not include(false)
    end
  end

  describe "#samples" do
    it "should return stuff" do
      File.stubs(:open).with("foo.jml").times(1).returns(StringIO.new(@xml))
      file = Meteoroid::File.new("foo.jml")
      file.samples.should_not be_empty
    end

    it "should only parse the file once" do
      File.stubs(:open).with("foo.jml").times(1).returns(StringIO.new(@xml))
      file = Meteoroid::File.new("foo.jml")

      file.xml.expects(:xpath).times(1).returns([])

      2.times { file.samples }
    end

  end

  describe "#xml" do

    describe "valid file" do
      it "should return a Nokogiri XML document" do
        File.stubs(:open).with("foo.jml").returns(StringIO.new(@xml))
        file = Meteoroid::File.new("foo.jml")
        
        file.xml.should be_a(Nokogiri::XML::Document)
      end

      it "should mark the file as valid" do
        File.stubs(:open).with("foo.jml").returns(StringIO.new(@xml))
        file = Meteoroid::File.new("foo.jml")

        file.valid.should be_true
      end

      it "should only parse the document once" do
        File.expects(:open).times(1).with("foo.jml").returns(StringIO.new(@xml))
        file = Meteoroid::File.new("foo.jml")

        2.times { file.xml }
      end
    end

    describe "invalid file" do
      it "should swallow the exception" do
        file = Meteoroid::File.new("foo.jml")
        
        lambda {
          file.xml
        }.should_not raise_exception(Errno::ENOENT)
      end

      it "should flag the file as invalid" do
        file = Meteoroid::File.new("foo.jml")
        
        file.valid.should be_false
      end
    end

  end

end