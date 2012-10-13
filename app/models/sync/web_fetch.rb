require 'rest-client'

module Sync
  class WebFetch
    def self.fetch(url)
      RestClient.get(url)
    end
  end
end
