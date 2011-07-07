class Meteoroid::Parser

  attr_accessor :files

  def initialize(*args)
    @files = Meteoroid::File.from(args)
  end

  def parse
    @parse ||= @files.map(&:samples).flatten
  end

end