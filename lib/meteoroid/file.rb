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