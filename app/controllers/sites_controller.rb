require 'scraper'

class SitesController < ApplicationController
  respond_to :html, :xml, :json

  def index
    @sites = Site.all
    respond_with @sites
  end

  def new
    @site = Site.new
    respond_with @site
  end

  def edit
    @site = Site.find(params[:id])
    respond_with @site
  end

  def create
    Site.create!(site_params)
    flash[:notice] = "Site was created!"
    redirect_to sites_path
  end

  def update
    site = Site.find(params[:id])
    puts site_params[:rule]
    site.update!(site_params)

    flash[:notice] = "Site was saved!"
    redirect_to sites_path
  end

  def destroy
    Site.destroy(params[:id])
    flash[:notice] = "Site was deleted!"
    redirect_to sites_path
  end

  private
  def site_params
    site_params = params.require(:site).permit(:name, :base_url, :test_url, :rules)
    site_params[:base_url] = Scraper.instance.flatten_host(site_params[:base_url]) if site_params[:base_url]

    site_params
  end
end