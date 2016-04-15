require File.expand_path '../spec_helper', __FILE__
require_relative '../lib/movie_quiz.rb'

class ImdbMovie
  attr_reader :id, :title, :poster, :year, :company
  def initialize(id, title, poster, year, company)
    @id = id
    @title = title
    @poster = poster
    @year = year
    @company = company
  end
end

describe 'MovieQuiz class' do
  let(:movie_quiz) { MovieQuiz.new }
  let(:movies) do
    [
      ImdbMovie.new('0371746', 'Iron Man', 'posterurl', 2000, 'Marvel'),
      ImdbMovie.new('0331746', 'Iron Man1', 'posterurl', 2000, 'Marvel'),
      ImdbMovie.new('0471746', 'Iron Man2', 'posterurl', 2000, 'Marvel'),
      ImdbMovie.new('0371746', 'Iron Man3', 'posterurl', 2000, 'Marvel'),
      ImdbMovie.new('0371446', 'Iron Man4', 'posterurl', 2000, 'Marvel'),
      ImdbMovie.new('0372746', 'Iron Man5', 'posterurl', 2000, 'Marvel'),
      ImdbMovie.new('0372746', 'Iron Man6', 'posterurl', 2000, 'Marvel'),
      ImdbMovie.new('0371746', 'Iron Man7', 'posterurl', 2000, 'Marvel'),
      ImdbMovie.new('0375746', 'Iron Man8', 'posterurl', 2000, 'Marvel')
    ]
  end
  let(:movies_diferent_year) do
    [
      ImdbMovie.new('0371746', 'Iron Man', 'posterurl', 1990, 'a'),
      ImdbMovie.new('0331746', 'Iron Man1', 'posterurl', 1991, 'b'),
      ImdbMovie.new('0471746', 'Iron Man2', 'posterurl', 1992, 'c'),
      ImdbMovie.new('0371746', 'Iron Man3', 'posterurl', 1993, 'd'),
      ImdbMovie.new('0371446', 'Iron Man4', 'posterurl', 1994, 'e'),
      ImdbMovie.new('0372746', 'Iron Man5', 'posterurl', 1995, 'f'),
      ImdbMovie.new('0372746', 'Iron Man6', 'posterurl', 1992, 'g'),
      ImdbMovie.new('0371746', 'Iron Man7', 'posterurl', 1997, 'h'),
      ImdbMovie.new('0375746', 'Iron Man8', 'posterurl', 1998, 'i')
    ]
  end
  let(:movie) { ImdbMovie.new('0371746', 'Iron Man', 'posterurl', 2000, 'a') }
  let(:question) { ['year', 'Which movie was released in #?'] }

  describe '#get_nine_movies_with_poster' do
    it 'get nine movies with poster' do
      movie_quiz.get_nine_movies_with_poster(movies)
      expect(movie_quiz.movies.size).to eq(9)
    end
  end

  describe '#add_movie' do
    it 'add one movie to array @movies' do
      expect(movie_quiz.add_movie(movie)).to eq([movie])
    end
  end

  describe '#random_question' do
    it 'return random question' do
      movie_quiz.questions = [question]
      expect(movie_quiz.random_question).to eq(question)
    end
  end

  describe '#get_question_result' do
    it 'return the random result of one question' do
      movie_quiz.movies = [movie]
      expect(movie_quiz.get_question_result(question)).to eq(2000)
    end
  end

  describe '#another_film_same_result?' do
    it 'return true if year is unique' do
      movie_quiz.get_nine_movies_with_poster(movies_diferent_year)
      expect(movie_quiz.another_film_same_result?(1992, question)).to eq(true)
    end

    it 'return true if year is unique' do
      movie_quiz.get_nine_movies_with_poster(movies_diferent_year)
      expect(movie_quiz.another_film_same_result?(1994, question)).to eq(false)
    end
  end
end
