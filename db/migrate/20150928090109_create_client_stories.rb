class CreateClientStories < ActiveRecord::Migration
  def change
    create_table :client_stories do |t|
      t.belongs_to :service, index: true, foreign_key: true
      t.string :title
      t.text :summary
      t.text :content
      t.date :date
      t.boolean :display
      t.string :suggested_url
      t.string :slug

      t.timestamps null: false
    end
  end
end
