class AddServiceMainPageToPages < ActiveRecord::Migration
  def change
    add_column :pages, :service_main_page, :boolean
  end
end
