require 'uri'

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

      image = resolve_url(url, extract_image(document))
      feed_item.image_url = image
      feed_item.content = HtmlBuilder.build { |h|
        h.img(src: image, alt: feed_item.title)
      }
    end

    def resolve_url(ref, path)
      URI.join(ref, path)
    end

    def extract_image(document)
      images = document.xpath(self.image_xpath)
      images.map(&:to_s).find { |image| image_filter.call(image) }
    end

    def image_xpath
      @feed.meta.image_xpath
    end

    def image_filter
      @image_filter ||=
        if @feed.meta.image_filter
          regexp = Regexp.new(@feed.meta.image_filter)
          proc { |image| image =~ regexp }
        else
          proc { |image| true }
        end
    end

  private
    def entry_url(entry)
      entry.link
    end
  end
end
