RSpec.describe Nevzorov::Generator do
  let(:categories) { Nevzorov.config.categories }
  let(:file) { Tempfile.new('feed') }
  let(:image) { Nevzorov.config.image }
  let(:url) { Nevzorov.config.url }

  def generate
    VCR.use_cassette('get feed') do
      described_class.call(url, image, categories, file)
    end
  end

  before { generate }

  context 'podcast image' do
    let(:feed) { Nokogiri.XML(IO.read(file)) }
    subject { feed.at_xpath('rss/channel/image/url').content }

    it 'replaces image' do
      is_expected.to eq(image)
    end
  end

  context 'podcast categories' do
    let(:feed) { Nokogiri.XML(IO.read(file)) }
    let(:items) { feed.xpath('rss/channel/item') }

    it 'adds categories' do
      items.each do |item|
        found_categories = item.xpath('itunes:category').map { |c| c['text'] }
        expect(found_categories).to contain_exactly(*categories)
      end
    end
  end
end
