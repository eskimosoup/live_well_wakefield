class AddColourToService < ActiveRecord::Migration
  def change
    add_column :services, :colour, :string
  end
end
