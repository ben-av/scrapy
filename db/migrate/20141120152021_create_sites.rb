class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.text :base_url
      t.text :rules

      t.timestamps
    end
  end
end
