require "addressable/uri"

class Scraper
  include Singleton

  def extract_properties(url = 'http://www.ebay.com/itm/KENWOOD-KDC-BT53U-BLUETOOTH-CAR-STEREO-IPOD-FULL-CONTROL-USB-AND-AUX-INPUT-/400810500934?&_trksid=p2056016.l4276')
    url = "http://" + url if Addressable::URI.parse(url).scheme.blank?
    
    site = get_matching_site(url)
    data = {}

    if (site.present?)
      response = http.get(URI.parse(url)).body
      doc = Nokogiri::HTML(response)
    
      JSON.parse(site.rules).each do |prop, rule|
        tag = doc.css(rule['rule']).first
        puts tag, rule
        if (tag.present?)
          data[prop] = (rule['attribute'].present?) ? tag[rule['attribute']] : tag.text 
          data[prop].strip!
        end
      end
    else
      data[:error]  = "Site not found"
    end

    data
  end

  def flatten_host(url)
    url = "http://" + url if Addressable::URI.parse(url).scheme.blank?
    host = Addressable::URI.parse(url).host
    host = host.gsub("www.", '') if host.present?

    host
  end

  private

  def get_matching_site(url)
    host = flatten_host(url)
    Site.find_by_base_url(host)
  end

  def http
    conn = Faraday.new do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  :net_http_persistent     # Keeps HTTP connections open!
    end
  end
end