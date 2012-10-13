class FeedEntryFilter
  include Logging

  def self.filter(filterdef)
    self.new(filterdef)
  end

  def initialize(filterdef)
    @filter = filterdef || { }
  end

  def valid?(entry)
    @filter.each { |key, value|
      if entry[key.to_sym] !~ Regexp.new(value)
        logger.info("Field #{key} (#{entry[key]}) of #{entry.title} does not match #{value}")
        return false
      end
    }
    true
  end
end
