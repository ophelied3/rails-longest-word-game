class NumbersAndLettersController < ApplicationController
  def game
    @grid = []
    Random.rand(5..15).times { @grid << ("A".."Z").to_a.sample }
  end

  def score
    @time = Time.now - Time.parse(params[:start_time])
    @attempt = params[:attempt]
    @grid_game = params[:grid].scan(/\w/)
    @result = {}

    @result[:time] = @time
    @result[:score] = 0 unless letters_in_grid?(@grid_game, @attempt.upcase) == true && correct_english_word?(@attempt) == true

    if letters_in_grid?(@grid_game, @attempt.upcase) == true && correct_english_word?(@attempt) == true
      @result[:score] = @attempt.length * 10 - @time
      @result[:message] = "well done"
    elsif letters_in_grid?(@grid_game, @attempt.upcase) == true && correct_english_word?(@attempt) == false
      @result[:message] = "not an english word"
    elsif letters_in_grid?(@grid_game, @attempt.upcase) == false && correct_english_word?(@attempt) == true
      @result[:message] = "not in the grid"
    else
      @result[:message] = "error!"
    end

    @result

  end

  def correct_english_word?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    wagon_serialized = open(url).read
    wagon = JSON.parse(wagon_serialized)
    wagon["found"]
  end

  def letters_in_grid?(grid, attempt)
    attempt.chars.all? { |letter| attempt.count(letter) <= grid.count(letter) }
  end





end
