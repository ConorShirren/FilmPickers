class ReviewSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description, :score, :film_id
end
