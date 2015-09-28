class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.integer :position
      t.string :name, null: false
      t.string :image
      t.string :facebook_page_url
      t.boolean :display, default: true
      t.string :suggested_url, unique: true
      t.string :slug, unique: true

      t.timestamps null: false
    end
  end
end
