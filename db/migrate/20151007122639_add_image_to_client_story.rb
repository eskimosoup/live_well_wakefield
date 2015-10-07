class AddImageToClientStory < ActiveRecord::Migration
  def change
    add_column :client_stories, :image, :string
  end
end
