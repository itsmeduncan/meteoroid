class Meteoroid::Parser

  attr_accessor :files

  def initialize(*args)
    @files = Meteoroid::File.from(args.flatten)
  end

  def self.parse!(args)
    new(args).parse
  end

  def parse
    @parse ||= @files.map(&:samples).flatten
  end

end