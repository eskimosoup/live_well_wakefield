class AddPositionAndHomeHighlightToClientStories < ActiveRecord::Migration
  def change
    add_column :client_stories, :position, :integer
    add_column :client_stories, :home_highlight, :boolean
  end
end
