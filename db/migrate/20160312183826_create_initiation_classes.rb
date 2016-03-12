class CreateInitiationClasses < ActiveRecord::Migration
  def change
    create_table :initiation_classes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
