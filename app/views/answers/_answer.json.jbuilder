json.extract! answer, :id, :question_id, :user_id, :content, :created_at, :updated_at
json.url answer_url(answer, format: :json)
