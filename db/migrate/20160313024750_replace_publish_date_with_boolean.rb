class ReplacePublishDateWithBoolean < ActiveRecord::Migration
  def change
    remove_column :pages, :published_on, :timestamp
    add_column :pages, :published, :boolean
  end
end
