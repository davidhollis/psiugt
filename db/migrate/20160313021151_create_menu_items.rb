class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.integer :position
      t.references :page, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
