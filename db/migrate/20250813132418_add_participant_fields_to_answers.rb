class AddParticipantFieldsToAnswers < ActiveRecord::Migration[8.0]
  def change
    add_column :answers, :participant_initials, :string
    add_column :answers, :participant_email, :string
  end
end
