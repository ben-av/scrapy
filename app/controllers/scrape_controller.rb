require 'scraper'

class ScrapeController < ApplicationController
  respond_to :html, :xml, :json
  def index
    respond_with
  end

  def test
    url = params.fetch(:url)
    render json: JSON.pretty_generate(Scraper.instance.extract_properties(url))
  end
end