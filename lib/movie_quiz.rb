# class MovieQuiz
class MovieQuiz
  attr_accessor :movies, :questions
  def initialize
    @movies = []
    @questions = [
      ['year', 'Which movie was released in #?'],
      ['company', 'Which movies were produced by #?']
    ]
  end

  def search_movies_in_imdb(movie)
    @movies = []
    search = Imdb::Search.new(movie)
    if search.movies.size > 9
      get_nine_movies_with_poster(search.movies)
    else
      false
    end
  end

  def get_nine_movies_with_poster(movies)
    i = 0
    while @movies.size < 9
      add_movie(movies[i]) unless movies[i].poster.nil?
      i += 1
    end
  end

  def add_movie(movie)
    @movies << movie
  end

  def random_question
    @questions.sample
  end

  def get_question_result(question)
    result = @movies.sample.send(question[0])
    result = get_question_result(question) if result.nil?
    if another_film_same_result?(result, question)
      result = get_question_result(question)
    end
    result
  end

  def another_film_same_result?(result, question)
    i = 0
    @movies.each do |movie|
      i += 1 if movie.send(question[0]) == result
    end
    i != 1
  end
end
