class AddNameToQuestions < ActiveRecord::Migration[8.0]
  def change
    add_column :questions, :name, :string, null: false, default: ""
  end
end
