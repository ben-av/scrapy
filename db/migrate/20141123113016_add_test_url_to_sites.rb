class AddTestUrlToSites < ActiveRecord::Migration
  def change
    add_column :sites, :test_url, :string
  end
end
