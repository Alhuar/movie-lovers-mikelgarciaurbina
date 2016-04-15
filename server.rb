require 'sinatra'
require 'sinatra/reloader' if development?

require_relative './lib/movie_quiz.rb'

require 'imdb'
require 'pry'

set :haml, format: :html5
enable(:sessions)

movie_quiz = MovieQuiz.new

get '/' do
  erb(:index)
end

post '/search_word' do
  if movie_quiz.search_movies_in_imdb(params[:word]) != false
    redirect to(:show_movies)
  else
    redirect to(:" ")
  end
end

get '/show_movies' do
  @movies = movie_quiz.movies
  @question = movie_quiz.random_question
  @result = movie_quiz.get_question_result(@question)
  erb(:show_movies)
end
