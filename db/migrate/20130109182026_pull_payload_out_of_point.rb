class PullPayloadOutOfPoint < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.references :point
      t.string :payload_type
      t.text :data
      t.timestamps
    end
    add_index :payloads, :point_id

    remove_column :points, :payload, :category
  end
end
