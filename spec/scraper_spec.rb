require 'rails_helper'
require 'scraper'

describe 'Scraper' do
  context 'flatten_host' do
    it 'returns result' do
      res = subject.flatten_host('http://google.co.uk')
      res.should == 'google.co.uk'
    end

    it 'removes www' do
      res = subject.flatten_host('http://www.google.com')
      res.should == 'google.com'
    end

    it 'handles nil' do
      res = subject.flatten_host(nil)
      res.should == ''
    end
  end

  context 'extract_properties' do
    def stub_site
      Site.new(name: 'ebay', rules: {product_name: {rule: 'h1[itemprop="name"]'}}.to_json)
    end

    it 'returns empty result when no matching site found' do
      subject.stub(:get_matching_site){nil}

      res = subject.extract_properties
      res.should == {error: "Site not found"}
    end

    it 'extract properties for existing site' do
      subject.stub(:get_matching_site){stub_site}

      #TODO: replace http calls with webmock
      res = subject.extract_properties
      res['product_name'].should == "Details about   KENWOOD KDC-BT53U BLUETOOTH CAR STEREO IPOD FULL CONTROL USB AND AUX INPUT"
    end
  end


  def subject
    Scraper.instance
  end
  
end