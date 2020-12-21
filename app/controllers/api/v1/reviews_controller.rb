# spec/integration/blogs_spec.rb
require 'swagger_helper'

module Api
    module V1
        class ReviewsController < ApplicationController
            protect_from_forgery with: :null_session

            def create
                review = Review.new(review_params)

                if review.save
                    rendor json: ReviewSerializer.new(review).serialized_json
                else
                    rendor json: {error: review.errors.messages}, status: 422
                end 
            end

            def destroy
                review = Review.find(params[:id])

                if review.destroy
                    head :no_content
                else
                    rendor json: {error: review.errors.messages}, status: 422
                end 
            end


            private

            def review_params
                params.require(:review).permit(:title, :description, :score, :film_id)
    end
end
