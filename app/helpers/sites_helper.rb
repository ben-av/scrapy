module SitesHelper
  def parse_rules(site)    
    JSON.parse(site.rules.present? ? site.rules : "{}")
  end
end