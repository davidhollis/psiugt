class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name
      t.integer :status
      t.references :initiation_class, index: true, foreign_key: true
      t.references :big_brother, index: true, foreign_key: true
      t.string :member_attributes

      t.timestamps null: false
    end
  end
end
