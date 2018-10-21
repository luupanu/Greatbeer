json.array!(@ratings) do |rating|
  json.extract! rating, :id, :score, :beer_id, :user_id, :created_at, :updated_at
end
