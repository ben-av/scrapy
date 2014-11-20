class Scraper
  def extract_properties(url = 'http://www.ebay.com/itm/KENWOOD-KDC-BT53U-BLUETOOTH-CAR-STEREO-IPOD-FULL-CONTROL-USB-AND-AUX-INPUT-/400810500934?&_trksid=p2056016.l4276')
    response = http.get(url).body

    doc = Nokogiri::HTML(response)
    site = Site.first
    data = {}

    JSON.parse(site.rules).each do |prop, rule|
      tag = doc.css(rule['rule']).first
      puts tag, rule
      if (tag.present?)
        data[prop] = (rule['attribute'].present?) ? tag[rule['attribute']] : tag.text 
      end
    end

    puts data
    data
  end

  private
  def http
    conn = Faraday.new(:url => 'http://sushi.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  :net_http_persistent     # Keeps HTTP connections open!
    end
  end
end