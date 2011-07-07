class Meteoroid::Sample

  ATTRIBUTE_MAPPING = {
    't'  => :time,
    'lt' => :latency,
    'ts' => :timestamp,
    's'  => :success,
    'lb' => :label,
    'rc' => :response_code,
    'rm' => :response_message,
    'tn' => :thread_name,
    'by' => :bytes,
    'u'  => :url
  }

  ATTRIBUTE_CONVERSION = {
    't'  => lambda { |t|  t.to_i },
    'lt' => lambda { |lt| lt.to_i },
    'ts' => lambda { |ts| Time.at(ts.to_i / 1000) },
    's'  => lambda { |s|  s.to_s == 'true' },
    'lb' => lambda { |lb| lb.to_s },
    'rc' => lambda { |rc| rc.to_i },
    'rm' => lambda { |rm| rm.to_s },
    'tn' => lambda { |tn| tn.to_s },
    'by' => lambda { |by| by.to_i },
    'u'  => lambda { |u|  u.to_s }
  }

  attr_accessor *ATTRIBUTE_MAPPING.values
  attr_accessor :url

  def initialize attributes
    ATTRIBUTE_MAPPING.each do |key, value|
      instance_variable_set(:"@#{value}", convert(key, attributes[key]))
    end
  end

  def self.from_xml attribute_nodes, url = nil
    attributes = {}

    attribute_nodes.each do |node|
      attributes[node.name] = node.value
    end

    attributes.merge!({'u' => url}) if url

    new(attributes)
  end

  private

    def convert(attribute, value)
      return value unless ATTRIBUTE_CONVERSION.key?(attribute.to_s)

      ATTRIBUTE_CONVERSION[attribute].call(value)
    end

end