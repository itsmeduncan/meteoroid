class Meteoroid::Parser

  attr_accessor :files

  def initialize *args
    @files = Meteoroid::File.from(args)
  end

end