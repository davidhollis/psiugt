class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :slug, unique: true, null: false
      t.timestamp :published_on
      t.text :body
      t.text :sidebar
      t.references :parent, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
