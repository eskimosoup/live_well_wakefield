class CreateContactDetails < ActiveRecord::Migration
  def change
    create_table :contact_details do |t|
      t.belongs_to :service, index: true, foreign_key: true
      t.text :details
      t.text :form_email_addresses, null: false
      t.boolean :display, default: true

      t.timestamps null: false
    end
  end
end
