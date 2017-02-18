require 'net/http'
require 'nokogiri'

class Nevzorov
  # Generates podcast feed
  class Generator
    class << self
      def call(*args)
        new.call(*args)
      end
    end

    def call(url, image, categories, file)
      source = Net::HTTP.get(URI(url))
      xml = Nokogiri.XML(source)
      replace_image(xml, image)
      add_categories(xml, categories)

      IO.write(file, xml)
    end

    def add_categories(feed_xml, names)
      feed_xml.xpath('rss/channel/item/author').each do |item|
        names.each do |name|
          category = Nokogiri::XML::Node.new('itunes:category', feed_xml)
          category['text'] = name
          item.add_next_sibling(category)
        end
      end
    end

    private

    def replace_image(feed_xml, feed_image)
      image_url = feed_xml.at_xpath('rss/channel/image/url')
      image_url.content = feed_image
    end
  end
end
