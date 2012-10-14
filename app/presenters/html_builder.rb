class HtmlBuilder
  def self.build
    Nokogiri::HTML::Builder.new(encoding: 'UTF-8') { |h|
      yield h
    }.doc.children[1].to_html
  end
end
