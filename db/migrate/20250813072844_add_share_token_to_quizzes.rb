class AddShareTokenToQuizzes < ActiveRecord::Migration[8.0]
  def change
    add_column :quizzes, :share_token, :string
    add_index :quizzes, :share_token, unique: true
  end
end
