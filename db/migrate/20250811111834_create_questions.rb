class CreateQuestions < ActiveRecord::Migration[8.0]
  def change
    create_table :questions do |t|
      t.references :quiz, null: false, foreign_key: true
      t.string :content

      t.timestamps
    end
  end
end
