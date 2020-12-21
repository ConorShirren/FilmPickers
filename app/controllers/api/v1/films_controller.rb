# spec/integration/blogs_spec.rb
require 'swagger_helper'

module Api
    module V1
        class FilmsController < ApplicationController
            protect_from_forgery with: :null_session

            def index
                films = Film.all

                render json: FilmSerializer.new(films, options).serialized_json
            end

            def show
                film = Film.find_by(slug: params[:slug])

                render json: FilmSerializer.new(film, options).serialized_json
            end

            def create
                film = Film.new(film_params)
                
                if film.save
                    render json: FilmSerializer.new(film).serialized_json
                else
                    render json: {error: film.errors.full_messages}, status: 422
                end
            end

            def update
                film = Film.find_by(slug: params[:slug])
                
                if film.update(film_params)
                    render json: FilmSerializer.new(film, options).serialized_json
                else
                    render json: {error: film.errors.full_messages}, status: 422
                end
            end

            def destroy
                film = Film.find_by(slug: params[:slug])
                
                if film.destroy
                    head :no_content
                else
                    render json: {error: film.errors.full_messages}, status: 422
                end
            end


            private

            def film_params
                params.require(:film).permit(:name, :image_url)
            end

            def options
                @options ||= {include: %i[reviews]}
            end

        end
    end
end
