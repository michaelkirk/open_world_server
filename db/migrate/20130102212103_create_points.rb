class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.string :category
      t.text :payload
      t.point :lonlat, :geographic => true

      t.timestamps
    end
  end
end
