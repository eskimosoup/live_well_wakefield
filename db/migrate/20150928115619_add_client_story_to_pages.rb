class AddClientStoryToPages < ActiveRecord::Migration
  def change
    add_reference :pages, :client_story, index: true, foreign_key: true
  end
end
