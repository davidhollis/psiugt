class CreateRemoteFiles < ActiveRecord::Migration
  def change
    create_table :remote_files do |t|
      t.integer :role
      t.string :url
      t.string :s3_key

      t.timestamps null: false
    end
  end
end
