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
    'by' => :bytes
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
  }

  attr_accessor *ATTRIBUTE_MAPPING.values

  def initialize attributes
    ATTRIBUTE_MAPPING.each do |key, value|
      instance_variable_set(:"@#{value}", convert(key, attributes[key]))
    end
  end

  private

    def convert(attribute, value)
      return value unless ATTRIBUTE_CONVERSION.key?(attribute.to_s)

      ATTRIBUTE_CONVERSION[attribute].call(value)
    end

end