class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :base_url
      t.string :rules

      t.timestamps
    end
  end
end
