class AddQuestionToService < ActiveRecord::Migration
  def change
    add_column :services, :question, :string
  end
end
