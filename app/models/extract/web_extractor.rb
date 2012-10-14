require 'builder'

module Extract
  class WebExtractor
    include Logging

    def initialize(feed_metadata)
      @feed = feed_metadata
    end

    def extract(entry, feed_item)
      logger.info("Extracting image from entry: #{entry.inspect} using xpath: #{self.image_xpath}")
      url = entry_url(entry) or raise BadSyncEntryError.new("No URL in #{entry.inspect}")
      document = Nokogiri::HTML(RestClient.get(url))

      image = extract_image(document)
      feed_item.image_url = image
      feed_item.content = HtmlBuilder.build { |h|
        h.img(src: image, alt: feed_item.title)
      }
    end

    def extract_image(document)
      images = document.xpath(self.image_xpath)
      return images[0].to_s
    end

    def image_xpath
      @feed.meta.image_xpath
    end

  private
    def entry_url(entry)
      entry.link
    end
  end
end
