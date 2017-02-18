# frozen_string_literal: true
require 'dry/configurable'
require 'thor'

# CLI interface for generation podcast feed
class Nevzorov < Thor
  extend Dry::Configurable
  autoload :Generator, 'nevzorov/generator'
  autoload :VERSION, 'nevzorov/version'

  setting :url, 'http://echo.msk.ru/guests/813104-echo/rss-audio.xml'
  setting :image, 'http://bm.img.com.ua/berlin/storage/news/orig/6/43/5845a212da3528b0897d488e9122a436.jpg'
  setting :categories, 'News & Politics,Religion & Spirituality,Society & Culture' do |categories|
    categories.split(',').map(&:strip)
  end

  desc 'podcast FILE', 'generate and write podcast RSS to the FILE'
  method_option :url, aliases: '-u', desc: 'Original podcast URL'
  method_option :image, aliases: '-i'
  method_option :categories, aliases: '-c', desc: 'Comma separated list of categories. See https://help.apple.com/itc/podcasts_connect/?lang=en#/itc9267a2f12'

  def podcast(file) # rubocop:disable Metrics/AbcSize
    url = options.fetch(:url, self.class.config.url)
    image = options.fetch(:image, self.class.config.image)
    categories = options.fetch(:categories, self.class.config.categories)
    Generator.call(url, image, categories, file)
  end
end
