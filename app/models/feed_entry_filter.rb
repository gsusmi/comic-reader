class FeedEntryFilter
  def self.filter(filterdef)
    self.new(filterdef)
  end

  def initialize(filterdef)
    @filter = filterdef || { }
  end

  def valid?(entry)
    @filter.each { |key, value|
      if entry[key] !~ Regexp.new(value)
        return false
      end
    }
    true
  end
end
