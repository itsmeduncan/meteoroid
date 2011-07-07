class Meteoroid::File

  attr_reader :file, :valid, :xml

  def initialize(file)
    @file = file
    @xml  = parse_xml(file)
  end

  def self.from args
    args.collect do |arg| 
      file = new(arg)
      file.valid ? file : nil
    end.compact
  end

  def samples
    @samples ||= @xml.xpath('/testResults/httpSample').collect do |sample|
      Meteoroid::Sample.from_xml(sample.attribute_nodes, sample.at_xpath('java.net.URL').text)
    end
  end

  private

    def parse_xml(file)
      xml    = Nokogiri::XML(File.open(file))
      @valid = true

      xml
    rescue Exception => e
      # TODO: Logging
      @valid = false
    end

end