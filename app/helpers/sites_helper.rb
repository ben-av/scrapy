module SitesHelper
  def parse_rules(site)    
    JSON.parse(site.rules.present? ? site.rules : "{}")
  end

  def get_tester_url(site)
    scrape_test_path(url: site.test_url)
  end
end